#!/usr/bin/perl

# Po4a::Svg.pm
#
# extract and translate translatable strings from SVG documents.
#
# This code was more tested with documents coming from inkscape.
#
# Copyright (c) 2014 by Martin Quinson <Martin.Quinson@loria.fr>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
########################################################################

=encoding UTF-8

=head1 NAME

Locale::Po4a::Svg - convert SVG documents from/to PO files

=head1 DESCRIPTION

The po4a (PO for anything) project goal is to ease translations (and more
interestingly, the maintenance of translations) using gettext tools on
areas where they were not expected like documentation.

Locale::Po4a::Svg is a module to help the translation of (inkscape)
SVG documents into other [human] languages.

=head1 OPTIONS ACCEPTED BY THIS MODULE

These are this module's particular options:

=over 4

=item B<fontreplace>[B<=>I<original;font;specification|new;font;specification>]

Automatically change all font specification 
Include files specified by an include SSI (Server Side Includes) element
(e.g. <!--#include virtual="/foo/bar.html" -->).

B<Note:> You should use it only for static files.

An additional I<rootpath> parameter can be specified. It specifies the root
path to find files included by a B<virtual> attribute.

=back

=head1 STATUS OF THIS MODULE

This module is fully functional, as it relies in the L<Locale::Po4a::Xml>
module. This only defines the translatable tags and attributes.

=head1 SEE ALSO

L<Locale::Po4a::TransTractor(3pm)>, L<Locale::Po4a::Xml(3pm)>, L<po4a(7)|po4a.7>

=head1 AUTHORS

 Martin Quinson <Martin.Quinson@loria.fr>

=head1 COPYRIGHT AND LICENSE

 Copyright (c) 2014 by Martin Quinson <Martin.Quinson@loria.fr>

This program is free software; you may redistribute it and/or modify it
under the terms of GPL (see the COPYING file).

=cut

package Locale::Po4a::Svg;

use 5.006;
use strict;
use warnings;

use Locale::Po4a::Xml;
use Locale::Po4a::Common;
use Carp qw(croak);

use vars qw(@ISA);
@ISA = qw(Locale::Po4a::Xml);


# Attributes are much more simpler in SVG:
# - We want to change the <tspan>x attribute to "0" so that inkscape 
#   recompute the word's positions
#
sub treat_attributes {
    my ($self,@tag)=@_;
    my $res = $self->SUPER::treat_attributes(@tag);

    if ($self->get_path() =~ m/<tspan>$/) {
	$res =~ s/^(\s*)x="[.0-9 ]*"\s*$/$1x="0"/ms;
    }
    return $res;
}

sub initialize {
        my $self = shift;
        my %options = @_;

        $self->{options}{'includessi'}='';

        $self->SUPER::initialize(%options);

        $self->{options}{'wrap'}=1;
        $self->{options}{'doctype'}=$self->{options}{'doctype'} || 'html';

        # Default tags are translated (text rewrapped), and introduce a
        # break.
        # The following list indicates the list of tags which should be
        # translated without rewrapping.
        $self->{options}{'_default_translated'}.='
                W<pre>
        ';

        # The following list indicates the list of tags which should be
        # translated inside the current block, whithout introducing a
        # break.
        $self->{options}{'_default_inline'}.='';

        # Ignored tags: <img>
        # Technically, <img> is an inline tag, but setting it as such is
        # annoying, and not usually useful, unless you use images to
        # write text (in which case you have bigger problems than this
        # program not inlining img: you now have to translate all your
        # images. That'll teach you).
        # If you choose to translate images, you may also want to set
        # <map> as placeholder and <area> as inline.

        $self->{options}{'_default_attributes'}.='
                alt
                lang
                title
                ';
        $self->treat_options;

}
