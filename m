From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Tue, 13 Dec 2016 00:08:40 +0100
Message-ID: <20161212230840.GB18201@amd>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
 <20161212085620.GA738@amd>
 <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
 <1481567955.1764.28.camel@perches.com>
 <20161212222216.GA18201@amd>
 <1481581932.29291.6.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45746 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbcLLXIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 18:08:42 -0500
Content-Disposition: inline
In-Reply-To: <1481581932.29291.6.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>, rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-12-12 14:32:12, Joe Perches wrote:
> On Mon, 2016-12-12 at 23:22 +0100, Pavel Machek wrote:
> > On Mon 2016-12-12 10:39:15, Joe Perches wrote:
> > > On Mon, 2016-12-12 at 09:56 -0800, Nick Desaulniers wrote:
> > > > A quick cleanup that passes scripts/checkpatch.pl -f <file>.
> []
> > > > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/c=
state.c
> []
> > > It's generally better not to convert
> > > these printk(KERN_DEBUG uses.
> > >=20
> > > There are behavior differences between
> > > 	printk(KERN_DEBUG ...);
> > > and
> > > 	pr_debug(...);
> > >=20
> > > The first will always be emitted as long
> > > as the console level is appropriate.
> > >=20
> > > The second depends on a #define DEBUG
> > > before it gets emitted or a kernel=20
> > > with CONFIG_DYNAMIC_DEBUG enabled and
> > > this entry specifically enabled in the
> > > control file.
> >=20
> > Hmm. Perhaps pr_debug should be called pr_c_debug() or something? This
> > is rather nice trap.
>=20
> Yeah, I've suggested veriants like pr_always_debug (from 2009)
> http://lkml.iu.edu/hypermail/linux/kernel/0910.0/00399.html

I'd very much like to see it other way around.

pr_err is equivalent to printk(KERN_ERR)
pr_warn is equivalent to printk(KERN_WARN)

pr_debug _NOT_ beging equivalent to printk(KERN_DEBUG) is a trap :-(.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhPLfgACgkQMOfwapXb+vKE4gCghZIXk7KLx2lbPIVV9vYJSDU7
SpgAnjknNCLLYaA4OwGc/6OcYqkhZ1j6
=Ldlr
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
