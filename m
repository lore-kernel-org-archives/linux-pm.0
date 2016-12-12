From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Mon, 12 Dec 2016 23:22:16 +0100
Message-ID: <20161212222216.GA18201@amd>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
 <20161212085620.GA738@amd>
 <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
 <1481567955.1764.28.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44063 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbcLLWWT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 17:22:19 -0500
Content-Disposition: inline
In-Reply-To: <1481567955.1764.28.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>, rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-12-12 10:39:15, Joe Perches wrote:
> On Mon, 2016-12-12 at 09:56 -0800, Nick Desaulniers wrote:
> > A quick cleanup that passes scripts/checkpatch.pl -f <file>.
>=20
> You might use the --strict option for acpi files.

Please... don't encourage people more, we have enough cleanup patches
as is.

> > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstat=
e.c
> []
> > @@ -103,9 +103,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(voi=
d *_cx)
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0if (!mwait_supported[cstate_type]) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mwait_supported[cstate_=
type] =3D 1;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_DEBUG
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"=
Monitor-Mwait will be used to enter C-%d "
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"=
state\n", cx->type);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_debug("Monitor-Mwait w=
ill be used to enter C-%d state\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0cx->type);
>=20
> It's generally better not to convert
> these printk(KERN_DEBUG uses.
>=20
> There are behavior differences between
> 	printk(KERN_DEBUG ...);
> and
> 	pr_debug(...);
>=20
> The first will always be emitted as long
> as the console level is appropriate.
>=20
> The second depends on a #define DEBUG
> before it gets emitted or a kernel
> with CONFIG_DYNAMIC_DEBUG enabled and
> this entry specifically enabled in the
> control file.

Hmm. Perhaps pr_debug should be called pr_c_debug() or something? This
is rather nice trap.

Anyway with that fixed,

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhPIxgACgkQMOfwapXb+vKkrQCgpde2Go/XZuQnTWZkhiNHUczq
FaUAn3qsHp3x03dbSYro114/CwrK9Dlo
=sD+F
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
