From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm	tree
Date: Thu, 22 Mar 2007 16:05:45 +0100
Message-ID: <1174575945.3588.7.camel@johannes.berg>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
	<20070322142437.GB21954@linux-sh.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1869926935=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070322142437.GB21954@linux-sh.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============1869926935==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Q/758C8OfGg/8pjsQXpi"


--=-Q/758C8OfGg/8pjsQXpi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 23:24 +0900, Paul Mundt wrote:

> So then how exactly is this helping anything? It's pointless to have the
> sysfs file visible for platforms that are never going to support suspend
> to disk, and -EINVAL'ing out in another path is simply moving the
> problem.

Just another data point as Pavel has replied to all the points raised
already as far as I can tell...

If you have a platform that doesn't allow CONFIG_SOFTWARE_SUSPEND (which
is only suspend to disk) and doesn't have pm_ops either, then you end up
with an empty /sys/power/state file.

johannes

--=-Q/758C8OfGg/8pjsQXpi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAptJ/ETPhpq3jKURAl0AAKCVXA7AwLllF0tJWqXaCDKSasn3aACgjJDy
VzB1iFSL+lN1f8z8HkIV/UA=
=YYqK
-----END PGP SIGNATURE-----

--=-Q/758C8OfGg/8pjsQXpi--


--===============1869926935==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1869926935==--
