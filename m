From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq27x00_battery: add bq27510 support
Date: Sat, 28 Feb 2015 17:12:15 +0100
Message-ID: <20150228161215.GB886@earth>
References: <1424614111-28613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150225221747.GP13695@earth>
 <20150228132223.GE4094@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60724 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238AbbB1QM1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 28 Feb 2015 11:12:27 -0500
Content-Disposition: inline
In-Reply-To: <20150228132223.GE4094@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Sat, Feb 28, 2015 at 02:22:23PM +0100, Alexandre Belloni wrote:
> Hi,
>=20
> On 25/02/2015 at 23:17:48 +0100, Sebastian Reichel wrote :
> > > @@ -350,6 +378,9 @@ static int bq27x00_battery_read_cyct(struct bq27x=
00_device_info *di)
> > >  {
> > >  	int cyct;
> > > =20
> > > +
> >=20
> > spurious newline.
> >=20
> > > +	if (di->chip =3D=3D BQ27510)
> > > +		cyct =3D bq27x00_read(di, BQ27510_REG_CYCT, false);
> > >  	cyct =3D bq27x00_read(di, BQ27x00_REG_CYCT, false);
> >=20
> > missing else?
> >=20
>=20
> Indeed, I just sent v2. However, I'm not too happy with all that if/else
> layering in this driver. I'll try to rework it so that it scales better.

Thanks, that would be nice.

-- Sebastian

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU8ejfAAoJENju1/PIO/qam1gP/07CRRwN13BwTI2/8hQ6Po5o
LQs41BhgStRkWcIAlq/DUQRSi63r5Ya1b+16j1UeOniEALSCDnhV8GApm9GKedp0
swZxPPa29DKdfs+CzEjWMQwatiYM8dxNoTqjf7kL/f2QJxVp2vhpVYaY8+RhAvFJ
UZhnTXwcjyKDs5QZqWCZRt3/SURUJ+/EpKYVClCK4m8G/pBJDZZF82i69+nNm8pq
6nD5LqVvMnS16jqdzGg6hvhi1SLJ30oqog+rFJQyXeCyOxqHYRhpA49Vv5CSf1KP
/LaLIFB7nqwfNsi4K1nfx2MtKnEh745NK4qtZiDLehW11dQmSkV/s3B+RqdWYriJ
36pQ6BskBlku/T7SYCaeHw4C38SGFJpNH0HUeT//8WN6UwQOrMOEr2BKqM4INEoo
/eUHcAG+exiwAHk61tjfAxqs4dz6iDVi3G5zgKD/Dt5bSM2XQkb3H6kwQQfj5U4/
BKxrKXqDEvxZotUulQFcfQiRQgEmjf/eO2PqTmUIEv/vSmd5RLR11JCMh2YGPztA
43s67i699//7DmiwwAgwuiGy6/SXFMGwuKP5h1MbAhcSwW0Eq25wf7a19XvVRxR5
acTEEB5jFMPYvFdYA14CEJs2yF/XM65c6oznS+UQ4vUVltXZvn+QJtnoCz0aN0w3
EctlLrn1BtRe1iIKMVpn
=PDTi
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
