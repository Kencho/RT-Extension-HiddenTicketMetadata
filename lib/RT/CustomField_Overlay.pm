=pod

=head1 NAME

RT::CustomField - Overlay of the RT::CustomField class, to add a new type of custom field.

=cut

package RT::CustomField;

use strict;
use warnings;

$FieldTypes{Hidden} = {
    sort_order => 1000, 
    selection_type => 0, 
    canonicalizes => 0, 
    labels => [
        'Enter multiple hidden values', 
        'Enter one hidden value', 
        'Enter up to [quant,_1,hidden value,hidden values]', 
    ], 
};

1;
