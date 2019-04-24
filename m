From: Pavel Machek <pavel@ucw.cz>
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Date: Wed, 24 Apr 2019 10:26:19 +0200
Message-ID: <20190424082618.GA6699@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-23 07:55:05, Jens Axboe wrote:
> On 4/23/19 4:22 AM, Pavel Machek wrote:
> > Hi!
> >=20
> >>> It boots ok (unlike mainline -- I'm debugging that), and I can suspend
> >>> and resume... but then cursor in X is moving and I can talk to
> >>> applications cached in memory, but any access to disk hangs.
> >>
> >> Mainline problem was identified.
> >>
> >> But resume is still broken. I took advantage of fact that I can still
> >> do cached commands, and got complete dmesg. I'm attaching it.
> >=20
> > Still broken in 0418. Ideas would be welcome at this point.
>=20
> Bisect it?

Before I start heavy debugging, it would be interesting to
know... does suspend/resume work for you in -next?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAHaoACgkQMOfwapXb+vJTVQCeL08UyO+MXoIE7+XqHb1+5toc
VTEAnR63BS4swj7ABf8xe1WLhTf+W+rZ
=crwR
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
