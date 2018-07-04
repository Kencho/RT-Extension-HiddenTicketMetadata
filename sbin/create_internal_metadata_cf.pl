use strict;
use warnings;

use RT -init;

use RT::CustomField;
use RT::Ticket;
use RT::Queues;

use Try::Tiny;

my $dbh = RT::DatabaseHandle();

try {
    my ($ok, $msg);

    $dbh->BeginTransaction();

    my $cf_name = 'InternalMetadata';

    my $cf = RT::CustomField->new(RT::SystemUser);
    ($ok, $msg) = $cf->LoadByName(
        Name => $cf_name, 
        LookupType => RT::Ticket->CustomFieldLookupType(), 
    );
    if (!$ok) {
        RT::Logger->info("Custom field $cf_name not found. Creating...");
        ($ok, $msg) = $cf->Create(
            Name => $cf_name, 
            Type => 'Hidden', 
            MaxValues => 1, 
            Pattern => q{}, 
            Description => 'Internal ticket metadata', 
            SortOrder => 0, 
            LookupType => RT::Ticket->CustomFieldLookupType(), 
            EntryHint => 'Enter one hidden value', 
            Disabled => 0, 
        );
        if ($ok) {
            RT::Logger->info("DONE");
        }
        else {
            die "Couldn't create the custom field $cf_name. Aborting...\n";
        }
    }

    my $queues = RT::Queues->new(RT::SystemUser);
    $queues->UnLimit();
    while (my $queue = $queues->Next()) {
        ($ok, $msg) = $cf->AddToObject($queue);
        RT::Logger->info($msg);
    }

    $dbh->Commit();
}
catch {
    RT::Logger->error("Fatal errors found: $_");
    $dbh->Rollback();
    exit 1;
};

exit 0;

1;
