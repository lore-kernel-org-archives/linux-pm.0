From: Pavel Machek <pavel@ucw.cz>
Subject: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Date: Tue, 23 Apr 2019 12:22:40 +0200
Message-ID: <20190423102239.GA15531@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190412102812.GA24977@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > It boots ok (unlike mainline -- I'm debugging that), and I can suspend
> > and resume... but then cursor in X is moving and I can talk to
> > applications cached in memory, but any access to disk hangs.
>=20
> Mainline problem was identified.
>=20
> But resume is still broken. I took advantage of fact that I can still
> do cached commands, and got complete dmesg. I'm attaching it.

Still broken in 0418. Ideas would be welcome at this point.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly+528ACgkQMOfwapXb+vJUIQCfdlG+O8D9R0SH0VcyH9uQ1lq9
WQsAoJsscMPfrfcXZTCqYo29RRWKli+K
=Z66R
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
