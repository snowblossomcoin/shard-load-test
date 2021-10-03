This directory contains a Snowblossom Wallet.

If backing this up, save the entire directory including all .wallet files in it.
It is safe to access a wallet directory from multiple clients on the same computer
or on multiple computers with real-time or eventual synchronization.

Wallet data safety is ensured by the snowblossom client always writing the wallet
out to a new file with a random file name and only then deleting the old file(s).
This way, if multiple clients are making changes there will simple be multiple files.
The next client to update the wallet will merge those and make a new single file.

In addition, each file has a proto version.  If a client sees a higher version it will
assume there are new fields that it does not know how to correctly merge and won't remove
the higher versioned files.  So it will always be safe to open a wallet with an older
snowblossom client.
