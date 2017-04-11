From: Pavel Machek <pavel@ucw.cz>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Tue, 11 Apr 2017 19:31:18 +0200
Message-ID: <20170411173118.GA17251@amd>
References: <20160212085157.GA16326@amd>
 <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com>
 <20160215115304.GA5014@amd>
 <20160221200653.GD15242@earth>
 <0BD7A329-A8BE-4B3E-B98F-CAB7A25F643F@goldelico.com>
 <20160221211257.GA26418@amd>
 <7720041C-DFEC-4592-A5AE-0C2BEEFB6049@goldelico.com>
 <20160222172009.GA7393@earth>
 <20161024123404.GA24185@amd>
 <3F9199B6-233E-4260-9362-498FB1AA3FB7@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38966 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdDKRbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 13:31:21 -0400
Content-Disposition: inline
In-Reply-To: <3F9199B6-233E-4260-9362-498FB1AA3FB7@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, Belisko Marek <marek.belisko@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-24 15:09:26, H. Nikolaus Schaller wrote:
> Hi Pavel,
>=20
> > Am 24.10.2016 um 14:34 schrieb Pavel Machek <pavel@ucw.cz>:
> >=20
> > Hi!
> >=20
> >> On Mon, Feb 22, 2016 at 06:58:13AM +0100, H. Nikolaus Schaller wrote:
> >>>>> static inline int fuel_level_LiIon(int mV, int mA, int mOhm) {
> >>>>> ...
> >>>>> }
> >>>=20
> >>> To which header file should this go?
> >>=20
> >> I think it should get its own header file in include/linux/power/.
> >> Maybe something like "generic-fuel-gauge.h". I'm open to other
> >> solutions, though.
> >=20
> > I'd like to use use this formula in my own code. Is it somewhere in
> > the kernel already?
>=20
> Not that I am aware of. Marek is still working on the generic-adc-battery
> driver augmented by DT + iio-ADC + formula before publication.
>=20
> Here is the latest draft so you can cherry-pick it into your work:
>=20
> 	http://git.goldelico.com/?p=3Dgta04-kernel.git;a=3Dpatch;h=3D22ab047ae29=
6e998379c1aa29fe1210043cfa040
>=20
> But beware: I think it is quite wrong using the sqrt() function above 19.=
66%
> and doing linear interpolation below.
>=20
> By using the sqrt() function it has a steepness that goes to infinity whe=
n reaching
> 19.66% from above. This makes a quite non-realistic curve with a sharp be=
nd at 19.66%
> (which is equivalent to 3.756 V).
>=20
> No real battery I have seen and measured with a coulomb counter has such =
a strange
> bend at 3.756 V...
>=20
> IMHO it would be a better approximation to adjust the factors so that e.g=
=2E a realistic
> voltage for "empty" (e.g. 3.3 V) is taken as the 0% point where steepness=
 goes through
> the roof.
>=20
> It should then be something like:
>=20
> 	SOC =3D sqrt((Volt - 3.3 V) / (4.2 V - 3.3 V))
>=20
> This goes more smoothly between 100% and 0%.
>=20
> Or we could even use an exponential function with an exponent different f=
rom 1/2
> (1 being linear interpolation):
>=20
> 	SOC =3D pow((Volt - 3.3 V) / (4.2 V - 3.3 V), factor)
>=20
> But this would probably need floating point arithmetic in the kernel or s=
ome numeric
> approximation algorithm.

Thanks!
									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljtEuYACgkQMOfwapXb+vLwIwCbBcPcEg6JbevXEauDpjJxjfZ0
I6gAnR7q28E5xVrNvwgcuP1aBl75T5Ar
=YgTn
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
