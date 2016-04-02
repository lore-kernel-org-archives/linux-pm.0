From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] sbs-battery: fix power status when battery is dry
Date: Sat, 2 Apr 2016 05:46:50 +0200
Message-ID: <20160402034649.GA11414@earth>
References: <1458801832.16645.7.camel@mtksdaap41>
 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
 <1459132330.16645.14.camel@mtksdaap41>
 <CAGS+omBVStB3mfXtDHdbsOK+y2UesGYtZBtYm=ctcpBfm88VEg@mail.gmail.com>
 <56F95451.5040607@nvidia.com>
 <1459216353.16645.20.camel@mtksdaap41>
 <56FA99D0.1010004@nvidia.com>
 <1459328310.29450.24.camel@mtksdaap41>
 <20160330150919.GA21068@earth>
 <1459392151.29450.44.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48827 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813AbcDBDqz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Apr 2016 23:46:55 -0400
Content-Disposition: inline
In-Reply-To: <1459392151.29450.44.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Rhyland Klein <rklein@nvidia.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 31, 2016 at 10:42:31AM +0800, YH Huang wrote:
> On Wed, 2016-03-30 at 17:09 +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Wed, Mar 30, 2016 at 04:58:30PM +0800, YH Huang wrote:
> > > If I revise the description in this way(using your clear explanation):
> > > ---------------------------------------------------------------------=
---
> > > The battery capacity changing course is like this:
> > >=20
> > > full: BATTERY_FULLY_CHARGED =3D> POWER_SUPPLY_STATUS_FULL
> > > <unplug AC>
> > > high->low: BATTERY_DISCHARGING =3D> POWER_SUPPLY_STATUS_DISCHARGING
> > > ~0%: DISCHARGING & FULLY_DISCHARGED =3D> POWER_SUPPLY_STATUS_NOT_CHAR=
GING
> > > <plug in AC>
> > > 0%~20%: FULLY_DISCHARGED =3D> POWER_SUPPLY_STATUS_CHARGING
> > > 20%~: No flag =3D> POWER_SUPPLY_STATUS_CHARGING
> > >=20
> > > For now, it is not exactly right to show the status as
> > > POWER_SUPPLY_STATUS_NOT_CHARGING when the battery is dry
> > > (FULLY_DISCHARGED) and AC is plugged in.
> > > Although the battery is in a low level, system works fine with the AC
> > > charging.
> > > It is better to say that the battery is charging.
> > > ---------------------------------------------------------------------=
---
> > >=20
> > > How about this?
> > > By the way, should I also revise the title?
> >=20
> > POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
> > battery not charging (e.g. because battery temperature is out
> > of acceptable range). If you are discharging use
> > POWER_SUPPLY_STATUS_DISCHARGING.
> >=20
> > You should just ignore the FULLY_DISCHARGED bit in the status
> > property. If you don't want to loose the information about fully
> > discharged battery add POWER_SUPPLY_PROP_CAPACITY_LEVEL, which maps:
> >=20
> > BATTERY_FULLY_CHARGED =3D> POWER_SUPPLY_CAPACITY_LEVEL_FULL
> > FULLY_DISCHARGED =3D> POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL
> > otherwise =3D> POWER_SUPPLY_CAPACITY_LEVEL_NORMAL
>=20
> Oops.
> It looks like I misunderstand POWER_SUPPLY_STATUS_NOT_CHARGING.
> As Daniel said before, we could just ignore FULLY_DISCHARGED.
>=20
> So change like the
>=20
> sbs-battery: fix power status when battery charging near
> dry
>=20
> POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
> battery not charging (e.g. because battery temperature is out
> of acceptable range).
>=20
> When battery is charging near dry and BATTERY_FULL_DISCHARGED is set,
> it is wrong to set as POWER_SUPPLY_STATUS_NOT_CHARGING.
> Just use BATTERY_DISCHARGING to decide the power supply status is
> discharging or charging.
>=20
>                 if (ret & BATTERY_FULL_CHARGED)
>                         val->intval =3D POWER_SUPPLY_STATUS_FULL;
> -               else if (ret & BATTERY_FULL_DISCHARGED)
> -                       val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else if (ret & BATTERY_DISCHARGING)
>                         val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
>=20

Yes, that looks fine. Can you send this correctly formated for git?

-- Sebastian

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW/0ClAAoJENju1/PIO/qawhQP/j+m1cLWzxZj28tbpzB+00yE
OXk6UHNrdan3NMvdHvdvDbvb3sKaJGVwWYJxwWraYE8GB8LGZl1hGNzn9nGu5zld
S+u2gnmOmYIjvU13Bvivtn2r2elnIpAncyyhwMCriuzW9FytcZv65Zm1yH4t257a
79fKElNSWvO9SU7loQDrfXylDMPz7Zbu1Xp7feAdAEupsID6+FAAG68tQXZ2j3pK
RwC6v+Dee6CVqL6uiAa4xe5JWkjBWxAe2+/rQ0WTrJgY88tdNZLZ7cOpRVL1oLcP
hvGpj/KjH6vs1xl6bfz8Uij34N6sEmwtYKAN+telO1llRpZvtU4xG6jaRGVHSx8Q
sPeq3naVs3hzCoy/RjwbJp1eAM57k2vd3VAx4SEtxD8mkGbiSsQNELrOsjW8YUE+
oe+KdNeHeSxqRg7aBq2ib11TlshkqQ5DDanBFp7TLazemAoqaAaGZyLJE91/viHS
r0eCWBYStwGTIGdlc2uExZd/B5lcdkYUoCYLvamyVORu0/t0oPKJCQAL+PhB9Qd3
RnSx9keZ6ZXFdDlkT3UNO7OIspmnBFvJFC3F2AxQw5Wj1euVlqDvRIwR2K7QEiH8
TusKqt4UiuytSnhQFxXRQ6DrJ59Zr38RKqDDQ25L57U6+fyQ7imPHj7oB9gwv6nK
sk/4px5O4MWyZmt8yDhH
=Z+2v
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
