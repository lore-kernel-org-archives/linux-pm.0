From: Pavel Machek <pavel@ucw.cz>
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Date: Wed, 24 Apr 2019 12:48:50 +0200
Message-ID: <20190424104850.GC32457@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
 <20190424095431.GA32457@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424095431.GA32457@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-24 11:54:31, Pavel Machek wrote:
> On Tue 2019-04-23 07:55:05, Jens Axboe wrote:
> > On 4/23/19 4:22 AM, Pavel Machek wrote:
> > > Hi!
> > >=20
> > >>> It boots ok (unlike mainline -- I'm debugging that), and I can susp=
end
> > >>> and resume... but then cursor in X is moving and I can talk to
> > >>> applications cached in memory, but any access to disk hangs.
> > >>
> > >> Mainline problem was identified.
> > >>
> > >> But resume is still broken. I took advantage of fact that I can still
> > >> do cached commands, and got complete dmesg. I'm attaching it.
> > >=20
> > > Still broken in 0418. Ideas would be welcome at this point.
> >=20
> > Bisect it?
>=20
> commit fdbbda7b3a0622fcfe630238d0bf6c57c4ba3663
> Merge: 3c442d5 6c88d73
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Apr 22 13:57:36 2019 -0600
>=20
> Works ok. So... block is not responsible.
>=20
> Let me check
>=20
> commit 91b112cf3b599f06f1e810cfedf37023f25d5588
> Merge: fb2c4a8 e32d939
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon Apr 22 01:52:48 2019 +0200

Suspend/resume ok, so pm not responsible. Let me check next-20190423.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAPxIACgkQMOfwapXb+vI1uQCgvej4szRBNmj2+c0bvr6nbSwS
bK8AnRJ6UoIYC5FNDBPHXMoYdG+b7Xp8
=mYGZ
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
