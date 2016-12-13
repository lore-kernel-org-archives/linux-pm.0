From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Tue, 13 Dec 2016 20:00:01 +0100
Message-ID: <20161213190001.GA8676@amd>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
 <20161212085620.GA738@amd>
 <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
 <1481567955.1764.28.camel@perches.com>
 <20161212222216.GA18201@amd>
 <20161212232043.vc5alwqzvspg2ade@lostoracle.net>
 <1481584942.29291.9.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44777 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbcLMTAH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2016 14:00:07 -0500
Content-Disposition: inline
In-Reply-To: <1481584942.29291.9.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>, rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-12-12 15:22:22, Joe Perches wrote:
> On Mon, 2016-12-12 at 15:20 -0800, Nick Desaulniers wrote:
> > > Please... don't encourage people more, we have enough cleanup patches
> > > as is.
> >=20
> > I recognize that this patch is relatively inconsequential, but it is my
> > first patch to the Linux kernel, and is teaching me how to wrangle my
> > email client and about the development work flow.  I plan to write a
> > blog post about my experience to help encourage more people to
> > contribute. So I do really appreciate all of the feedback and patience
> > for a relatively small patch.  Thanks for your time.  v3 incoming (will
> > start a new thread).
>=20
> Please create your first patch against something in drivers/staging/
>=20
> Use the kernel newbies list and resources too
> https://kernelnewbies.org/FirstKernelPatch
> .

Actually.. the ACPI cleanup is fine. You did well :-).
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlhQRTEACgkQMOfwapXb+vLy3wCVEhF9f9H1/8HP2sVYQV2b3ORf
WwCeKVC40KKPYcaPcNibJzL3Hr5ie7Q=
=+6K4
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
