From: Pavel Machek <pavel@ucw.cz>
Subject: Re: x32 suspend failuer in Re: linux-next: Tree for Apr 4
Date: Wed, 4 Apr 2018 10:49:05 +0200
Message-ID: <20180404084905.GA12303@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404075047.GB9342@amd>
 <CAJZ5v0hxyXtyKacJufivL9HWbQBsxTBYVipnHK4+QquTYjpc+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hxyXtyKacJufivL9HWbQBsxTBYVipnHK4+QquTYjpc+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-04 09:58:17, Rafael J. Wysocki wrote:
> On Wed, Apr 4, 2018 at 9:50 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> Please do not add any v4.18 destined stuff to your linux-next included
> >> trees until after v4.17-rc1 has been released.
> >
> > On thinkpad x60, suspend does not suspend at all with this -next
> > version. Previous versions suspended/resumed fine but broke networking.
> >
> > Any ideas? I guess bisecting on next would not be easy?
>=20
> Well, why would it be different from a bisect on any other git repo?

Well, v4.16-rc4 is parent of v4.16-rc6, but next-20180304 is not
parent of next-20180307.

But you are right that if I do bisect between -linus and -next, it
should work.

Anyway, does s2ram work for you in -next? Are you testing 32bit?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrEkYEACgkQMOfwapXb+vLG4QCgsFeKGFXML6N/TenjjVMvDLz5
eW0An2VftGX/HEQTmpKPKF9iGVJJD0Oo
=pdrV
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
