package Hubot::Scripts::help;
use strict;
use warnings;

sub load {
    my ( $class, $robot ) = @_;
    $robot->respond(
        qr/help\s*(.*)?$/i,
        sub {
            my $msg  = shift;              # Hubot::Response
            my @cmds = $robot->commands;

            my $robotName = $robot->name;
            unless ($robotName =~ m/^hubot$/) {
                map { s/hubot/$robotName/ig } @cmds;
            }

            if ( $msg->match->[0] ) {
                my $regex = $msg->match->[0];
                @cmds = grep { $_ =~ /$regex/i } @cmds;
            }

            map { s/^/\# / } @cmds;
            $msg->send(@cmds);
        }
    );
}

1;

=pod

=encoding utf-8

=head1 NAME

Hubot::Scripts::help

=head1 SYNOPSIS

    hubot help - Displays all of the help commands that Hubot knows about
    hubot help <query> - Displays all help commands that match <query>

=head1 DESCRIPTION

These commands are grabbed from pod at the C<SYNOPSIS> section each file.

=head1 AUTHOR

Hyungsuk Hong <hshong@perl.kr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Hyungsuk Hong.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
