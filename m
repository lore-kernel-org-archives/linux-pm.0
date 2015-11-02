From: Neil Brown <nfbrown@novell.com>
Subject: Re: [PATCH 1/3] power, vfs: move away from PF_KTHREAD freezing in favor of fs freezing
Date: Mon, 02 Nov 2015 14:01:06 +1100
Message-ID: <878u6hjea5.fsf@notabene.neil.brown.name>
References: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz> <alpine.LNX.2.00.1510301439080.17538@pobox.suse.cz> <1446281756.21651.7.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1446281756.21651.7.camel@suse.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat, Oct 31 2015, Oliver Neukum wrote:

> On Fri, 2015-10-30 at 14:47 +0100, Jiri Kosina wrote:
>> Basically the main argument why kthread freezer is not needed boils
>> down to
>> this: the only facility that is needed during suspend: "no persistent
>> fs
>> changes are allowed from now on".
>
> Is that true? Drivers of character devices also may assume
> that IO and suspend() wouldn't race (except in fairly clear exceptions)

Anything that is a device can hook in to the suspend using the standard
call back and make sure no problematic races happen.

Filesystems are different partly because the "know" in memory some
details of what is persisting on storage, and partly because they aren't
devices.

Maybe filesystems should be devices .... though that probably wouldn't
help much.


I would suggest that "the only facility that is needed during suspend"
is really "well defined states and well defined transitions".
Filesystems need them as well as devices, and frozen kthreads might have
been a kludge to try to provide them.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWNtHyAAoJEDnsnt1WYoG5F6IP/2Z7BlgpWuOm/npy0r13P+9F
X9wz7ElSYuN80mORzEyPef6tFyJ6auLi7RVcoVuuL7YSvUyKsGqXRMDMWoYBFQ4L
S2DTLhl8F2tbKG2zDf6NEQqOZ+F5m01OxeuSutdbhmGSMPoI+lc3MI1nuZqQVC0h
VWRt1sUQPqoJiguWaEs7wwQiGRIneYpKVlzsz3tEg9Il6soy79QYdcAYJhmW9BXL
FmMlpydwxyd/vJmaF1pxebE7hNhBqtmZb750hyRmpCiAYoi9eZ/r+vpx4QXjyB2b
vJ7warNwPy+4edflowUI8UPVbZVbmmnD+lpFS9E2LYNRlQ7Cz0ggT30lkcUkcoza
/BOUbeX0E9O+Kj1J5FDokWvfvF2Os9BoeSKC7Y7Qg17T5dZvJ1hN3q6NfZgh7NqF
NtxDSKD3gh0NQU64PM4cYpcVwVAdlLnhLMhbaeW1KlaAJmr4gqV591bXyM2yFKDn
w+PVbXg+Ew1sG3qMU/QUApM6QTNsvzpiwCMQPlG54HLOUosPwj1dOlMNa0vJaFGy
ouuqPOKphHZRq+g76NVaPy3XdWMKieLQ/+ier+95VEaiJS0gU8UGdCUIMuMn5rXQ
KccrpwtCxIRDvnUOcd+/S1c+0i+bhlhf0fImiT7lnbuDsn5LIt3M3jO1zKBPfstk
nlApnQMxqBWynj9PA3HZ
=VHSc
-----END PGP SIGNATURE-----
--=-=-=--
