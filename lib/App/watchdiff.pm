package App::watchdiff;

##
## watchdiff: watch difference
##
## Copyright 2014- Kazumasa Utashiro
##
## Original version on Feb 15 2014
##

use v5.14;
use warnings;

use open ":std" => ":encoding(utf8)";
use Fcntl;
use Pod::Usage;
use Data::Dumper;

use List::Util qw(pairmap);

use App::sdif;
my $version = $App::sdif::VERSION;

use Getopt::EX::Hashed 'has'; {

    Getopt::EX::Hashed->configure(DEFAULT => [ is => 'rw' ]);

    has help     => ' h      ' ;
    has version  => ' v      ' ;
    has debug    => ' d      ' ;
    has unit     => ' by :s  ' ;
    has diff     => '    =s  ' ;
    has exec     => ' e  =s@ ' , default => [] ;
    has refresh  => ' r  :1  ' , default => 1 ;
    has interval => ' i  =i  ' , default => 2 ;
    has count    => ' c  =i  ' , default => 1000 ;
    has clear    => '    !   ' , default => 1 ;
    has silent   => ' s  !   ' , default => 0 ;
    has mark     => ' M  !   ' , default => 0 ;
    has verbose  => ' V  !   ' , default => undef ;
    has old      => ' O  !   ' , default => 0 ;
    has date     => ' D  !   ' , default => 1 ;
    has newline  => ' N  !   ' , default => 1 ;
    has context  => ' C  :2  ' , default => 999, alias => 'U';
    has scroll   => ' S      ' , default => 1 ;
    has colormap => ' cm =s@ ' , default => [] ;
    has plain    => ' p      ' ,
	action   => sub {
	    $_->date = $_->newline = 0;
	};

    has '+help' => action => sub {
	pod2usage
	    -verbose  => 99,
	    -sections => [ qw(SYNOPSIS VERSION) ];
    };

    has '+version' => action  => sub {
	print "Version: $version\n";
	exit;
    };

} no Getopt::EX::Hashed;

my %colormap = qw(
    APPEND	K/544
    DELETE	K/544
    OCHANGE	K/445
    NCHANGE	K/445
    OTEXT	K/455E
    NTEXT	K/554E
    );

use Term::ANSIColor::Concise qw(ansi_code csi_code);
my %termcap = pairmap { $a => ansi_code($b) }
    qw(
	  home  {CUP}
	  clear {CUP}{ED2}
	  el    {EL}
	  ed    {ED}
	  decsc {DECSC}
	  decrc {DECRC}
     );

sub run {
    our $app = my $opt = shift;
    local @ARGV = @_;

    use Getopt::EX::Long;
    Getopt::Long::Configure(qw(bundling require_order));
    $opt->getopt or usage({status => 1});

    if ($opt->context and $opt->context < 100) {
	$opt->verbose //= 1;
    }

    use Getopt::EX::Colormap;
    my $cm = Getopt::EX::Colormap
	->new(HASH => \%colormap)
	->load_params(@{$opt->colormap});

    if (@ARGV) {
	push @{$opt->exec}, [ @ARGV ];
    } else {
	@{$opt->exec} or pod2usage();
    }

    setup_terminal();
    $SIG{INT} = sub { exit };
    $opt->do_loop();
}

END {
    reset_terminal();
}

sub control_scroll {
    my $opt = shift;
    $opt->scroll && $opt->date && $opt->refresh == 1;
}

sub setup_terminal {
    if ((our $app)->control_scroll) {
	STDOUT->printflush(csi_code(STBM => 3, 999));
    }
}

sub reset_terminal {
    if ((our $app)->control_scroll) {
	STDOUT->printflush($termcap{decsc},
			   csi_code(STBM =>),
			   $termcap{decrc});
    }
}

sub do_loop {
    my $opt = shift;

    use App::cdif::Command;
    my $old = App::cdif::Command->new(@{$opt->exec});
    my $new = App::cdif::Command->new(@{$opt->exec});

    my @default_diff = (
			qw(cdif --no-unknown),
			map { ('--cm', "$_=$colormap{$_}") } sort keys %colormap
		       );

    my @diffcmd = do {
	if ($opt->diff) {
	    use Text::ParseWords;
	    shellwords $opt->diff;
	} else {
	    ( @default_diff,
	      map  { ref $_->[1] eq 'CODE' ? $_->[1]->() : $_->[1] }
	      grep { $_->[0] }
	      [ defined $opt->unit    => sub { '--unit=' . $opt->unit } ],
	      [ defined $opt->context => sub { '-U' . $opt->context } ],
	      [ ! $opt->verbose       => '--no-command' ],
	      [ ! $opt->mark          => '--no-mark' ],
	      [ ! $opt->old           => '--no-old' ],
	    );
	}
    };

    print $termcap{clear} if $opt->refresh;
    my $count = 0;
    my $refresh_count = 0;
    while (1) {
	$old->rewind;
	$new->update;
	my $data = execute(@diffcmd, $old->path, $new->path) // die "diff: $!\n";
	if ($data eq '') {
	    if ($opt->silent) {
		flush($new->date, "\r");
		next;
	    }
	    $data = $new->data;
	    $data =~ s/^/ /mg if $opt->mark;
	}
	$data .= "\n" if $opt->newline;
	if ($opt->refresh) {
	    $data =~ s/^/$termcap{el}/mg;
	    if ($refresh_count++ % $opt->refresh == 0) {
		print $termcap{clear};
	    }
	}
	print $new->date, "\n\n" if $opt->date;
	print $data;
	if ($opt->refresh and $opt->clear) {
	    flush($termcap{ed});
	}
    } continue {
	last if ++$count == $opt->count;
	($old, $new) = ($new, $old);
	sleep $opt->interval;
    }

    flush($termcap{el}) if $opt->refresh;
    return 0;
}

sub flush {
    use IO::Handle;
    state $stdout = IO::Handle->new->fdopen(fileno(STDOUT), "w") or die;
    $stdout->printflush(@_);
}

sub execute {
    use IO::File;
    my $pid = (my $fh = IO::File->new)->open('-|') // die "open: $@\n";
    if ($pid == 0) {
	open STDERR, ">&STDOUT" or die "dup: $!";
	close STDIN;
	exec @_ or warn "$_[0]: $!\n";
	exit 3;
    }
    binmode $fh, ':encoding(utf8)';
    my $result = do { local $/; <$fh> };
    for my $child (wait) {
	$child != $pid and die "child = $child, pid = $pid";
    }
    ($? >> 8) == 3 ? undef : $result;
}

######################################################################

=pod

=head1 NAME

watchdiff - repeat command and watch differences

=head1 VERSION

Version 4.35

=head1 DESCRIPTION

Document is included in the executable.  Use `man watchdiff` or
`perldoc watchdiff`.

=head1 AUTHOR

Kazumasa Utashiro

L<https://github.com/kaz-utashiro/sdif-tools>

=head1 LICENSE

Copyright 2014- Kazumasa Utashiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<diff(1)>, L<cdif(1)>, L<sdif(1)>

=cut
