requires 'perl', '5.014';

requires 'Getopt::EX', 'v1.2.1';
requires 'List::Util', '1.33';
requires 'Text::VisualWidth::PP', '0.05';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

