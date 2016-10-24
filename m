From: Pavel Machek <pavel@ucw.cz>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Mon, 24 Oct 2016 14:34:05 +0200
Message-ID: <20161024123404.GA24185@amd>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com>
 <20160212085157.GA16326@amd>
 <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com>
 <20160215115304.GA5014@amd>
 <20160221200653.GD15242@earth>
 <0BD7A329-A8BE-4B3E-B98F-CAB7A25F643F@goldelico.com>
 <20160221211257.GA26418@amd>
 <7720041C-DFEC-4592-A5AE-0C2BEEFB6049@goldelico.com>
 <20160222172009.GA7393@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51349 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933808AbcJXMeI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 08:34:08 -0400
Content-Disposition: inline
In-Reply-To: <20160222172009.GA7393@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Belisko Marek <marek.belisko@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Mon, Feb 22, 2016 at 06:58:13AM +0100, H. Nikolaus Schaller wrote:
> > >> static inline int fuel_level_LiIon(int mV, int mA, int mOhm) {
> > >> ...
> > >> }
> >=20
> > To which header file should this go?
>=20
> I think it should get its own header file in include/linux/power/.
> Maybe something like "generic-fuel-gauge.h". I'm open to other
> solutions, though.

I'd like to use use this formula in my own code. Is it somewhere in
the kernel already?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgN/7wACgkQMOfwapXb+vKtSgCfRHF4frGpBdIsauA1FS1b+P5L
ENYAniJaXPGMlWSIRzgIKGbbZsAXCxAc
=5Ter
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
