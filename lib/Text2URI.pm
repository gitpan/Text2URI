package Text2URI;
use Moose;
use Text::Iconv;

has iconv => (
    is   => 'rw',
    isa  => 'Text::IconvPtr',
    lazy => 1,
    default => sub {Text::Iconv->new('UTF-8', 'ASCII//TRANSLIT')}
);


sub translate {
    my ($self, $text, $sep) = @_;
    $sep ||= '-';

    $text = lc $self->iconv->convert(  $text );

    $text =~ s/^\s+//o;
    $text =~ s/\s+$//o;

    $text =~ s/\W+/$sep/go;
    $text =~ s/$sep+/$sep/go;
    $text =~ s/$sep$//o;
    $text =~ s/^$sep//o;

    return $text;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Text2URI

=head1 VERSION

version 0.1

=head1 SYNOPSIS

    use Text2URI;

    my $t = new Text2URI();

    print $t->translate("Atenção SomeText (0)2302-3234   otherthing    !!");
    # atencao-sometext-0-2302-3234-otherthing

    print $t->translate("Sell your house",'_');
    # sell_your_house

=head1 DESCRIPTION

Simple but effective transform text to a "url friendly" string! Just it

=head1 NAME

Text2URI - Transform text to a "url friendly" string

=head1 AUTHOR

Renato Cron <renato@aware.com.br>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Aware TI <http://www.aware.com.br>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


