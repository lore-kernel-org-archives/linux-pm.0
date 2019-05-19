From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL 4.14 06/16] power: supply: cpcap-battery: Fix
 division by zero
Date: Sun, 19 May 2019 23:31:24 +0200
Message-ID: <20190519213124.GE31403@amd>
References: <20190516114107.8963-1-sashal@kernel.org>
 <20190516114107.8963-6-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190516114107.8963-6-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-16 07:40:57, Sasha Levin wrote:
> From: Tony Lindgren <tony@atomide.com>
>=20
> [ Upstream commit dbe7208c6c4aec083571f2ec742870a0d0edbea3 ]
>=20
> If called fast enough so samples do not increment, we can get
> division by zero in kernel:
>=20
> __div0
> cpcap_battery_cc_raw_div
> cpcap_battery_get_property
> power_supply_get_property.part.1
> power_supply_get_property
> power_supply_show_property
> power_supply_uevent
>=20
> Fixes: 874b2adbed12 ("power: supply: cpcap-battery: Add a battery driver")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Yup, this one makes sense for stable

 Acked-for-stable-by: Pavel Machek <pavel@ucw.cz>

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzhyywACgkQMOfwapXb+vI0cgCgqDdY05iCOme5tsF19qlUHEJ/
kHAAnRDH7KmcqMhj3Z7HyS8NRGoTAv1L
=NXfl
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
