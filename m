From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 8/8] power: bq27xxx_battery: Cleanup health checking
Date: Fri, 24 Jul 2015 22:53:37 +0200
Message-ID: <201507242253.37997@pali>
References: <1437601920-13045-1-git-send-email-afd@ti.com> <20150723162212.GI29125@pali> <55B29FBB.8080500@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1490877.vom1oeGrgu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B29FBB.8080500@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--nextPart1490877.vom1oeGrgu
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 24 July 2015 22:27:39 Andrew F. Davis wrote:
> On 07/23/2015 11:22 AM, Pali Roh=C3=A1r wrote:
> > On Wednesday 22 July 2015 16:52:00 Andrew F. Davis wrote:
> >> +	/* Unlikely but important to return first */
> >> +	if (bq27xxx_battery_overtemp(di, flags))
> >> +		return POWER_SUPPLY_HEALTH_OVERHEAT;
> >> +	if (bq27xxx_battery_undertemp(di, flags))
> >> +		return POWER_SUPPLY_HEALTH_COLD;
> >> +	if (bq27xxx_battery_dead(di, flags))
> >> +		return POWER_SUPPLY_HEALTH_DEAD;
> >=20
> > Good candidates for "if (unlikely(...))" ?
>=20
> I wasn't sure, but I don't see why not. Added.
>=20

You wrote "Unlikely" in comment, so I thought that unlikely macro sounds=20
reasonable here...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1490877.vom1oeGrgu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWypdEACgkQi/DJPQPkQ1LhdwCbBxfM9HbmGr5+YWQFjkhuJ9R9
Hl4An3YzXUxF6QNw0Al5HwARJ3uyXhC7
=TBaX
-----END PGP SIGNATURE-----

--nextPart1490877.vom1oeGrgu--
