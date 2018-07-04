# RT-Extension-HiddenTicketMetadata

An RT extension to add ticket metadata that isn't displayed nor can be modified through the web interface.

## Installation and usage

To install this extension, run the following commands:

```bash
perl Makefile.PL
make
make install
```

This will install the extension in your RT plugins directory.

At this point you can create your own CFs using a new type "hidden". However, this will only hide their value and input box (`ShowCustomFieldHidden` and `EditCustomFieldHidden` respectively), but their label and group will still be visible. You can hide them by adding them to a special group `q{}` (an empty string as the key).

For convenience, a script `sbin/create_internal_metadata_cf.pl` script is distributed, that creates a custom field `InternalMetadata` that can be used to store a single value (it may stil be a complex structure serialized as JSON). The provided `etc/CustomFieldGroupings_Config.pm` configuration file already adds it to the "hidden" grouping, but in the (most likely) scenario where a complex grouping is required, you'd have to add the rules to your grouping manually to completely hide the field(s).
