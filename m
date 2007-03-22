From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm	tree
Date: Thu, 22 Mar 2007 11:08:48 +0100
Message-ID: <1174558128.3944.78.camel@johannes.berg>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0377336903=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070322100355.GA6834@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============0377336903==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FlL2ViHsmZMwXXl24xWT"


--=-FlL2ViHsmZMwXXl24xWT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 11:03 +0100, Pavel Machek wrote:

> > So they shouldn't offer it in Kconfig?

I agree with that.

> Anyway, this patch is good, as it allows interested ARM machines to
> really disable suspend-to-disk. What they were doing previously was
> not effective.

I thought you just said you understood pm_ops now :->

No, once SOFTWARE_SUSPEND is configured there's *no way* to disable it
after the fact via pm_ops. Read valid_state() in kernel/power/main.c.

But that's a design decision, once the kernel config allows suspend to
disk runtime pm_ops have no say in it. And what they previously did by
nack'ing suspend to disk for platform mode is broken and just papers
over the problem in the default case, once the user puts shutdown
> /sys/power/disk the problem shows up again (if there is any).

johannes

--=-FlL2ViHsmZMwXXl24xWT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAlWw/ETPhpq3jKURAiweAJ9bY/L/GmRvnIT5/XvmCASaLPZI4wCdEhaz
hEu3iECKAiW1qYpoRNZH3is=
=TJY+
-----END PGP SIGNATURE-----

--=-FlL2ViHsmZMwXXl24xWT--


--===============0377336903==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0377336903==--
