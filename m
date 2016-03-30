From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] sbs-battery: fix power status when battery is dry
Date: Wed, 30 Mar 2016 17:09:20 +0200
Message-ID: <20160330150919.GA21068@earth>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
 <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
 <1458801832.16645.7.camel@mtksdaap41>
 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
 <1459132330.16645.14.camel@mtksdaap41>
 <CAGS+omBVStB3mfXtDHdbsOK+y2UesGYtZBtYm=ctcpBfm88VEg@mail.gmail.com>
 <56F95451.5040607@nvidia.com>
 <1459216353.16645.20.camel@mtksdaap41>
 <56FA99D0.1010004@nvidia.com>
 <1459328310.29450.24.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459328310.29450.24.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Rhyland Klein <rklein@nvidia.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 30, 2016 at 04:58:30PM +0800, YH Huang wrote:
> If I revise the description in this way(using your clear explanation):
> ------------------------------------------------------------------------
> The battery capacity changing course is like this:
>=20
> full: BATTERY_FULLY_CHARGED =3D> POWER_SUPPLY_STATUS_FULL
> <unplug AC>
> high->low: BATTERY_DISCHARGING =3D> POWER_SUPPLY_STATUS_DISCHARGING
> ~0%: DISCHARGING & FULLY_DISCHARGED =3D> POWER_SUPPLY_STATUS_NOT_CHARGING
> <plug in AC>
> 0%~20%: FULLY_DISCHARGED =3D> POWER_SUPPLY_STATUS_CHARGING
> 20%~: No flag =3D> POWER_SUPPLY_STATUS_CHARGING
>=20
> For now, it is not exactly right to show the status as
> POWER_SUPPLY_STATUS_NOT_CHARGING when the battery is dry
> (FULLY_DISCHARGED) and AC is plugged in.
> Although the battery is in a low level, system works fine with the AC
> charging.
> It is better to say that the battery is charging.
> ------------------------------------------------------------------------
>=20
> How about this?
> By the way, should I also revise the title?

POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
battery not charging (e.g. because battery temperature is out
of acceptable range). If you are discharging use
POWER_SUPPLY_STATUS_DISCHARGING.

You should just ignore the FULLY_DISCHARGED bit in the status
property. If you don't want to loose the information about fully
discharged battery add POWER_SUPPLY_PROP_CAPACITY_LEVEL, which maps:

BATTERY_FULLY_CHARGED =3D> POWER_SUPPLY_CAPACITY_LEVEL_FULL
FULLY_DISCHARGED =3D> POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL
otherwise =3D> POWER_SUPPLY_CAPACITY_LEVEL_NORMAL

-- Sebastian

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW++wdAAoJENju1/PIO/qaIjEP/j8re+1OJVnHhRXff/Gv7XtE
yzhq1oJ4FiZ8Z2C7vB4SAoC4JfViY8uq1LUV9Eo/wprTkyR/i+izPELGW3Ix3Z9c
GlbvhIPJUWC1Jlj5O+U9SsGO3aKO5Zhneq9crRUbs3d/2PFR0kG35oLOOeYeIUjm
8ri8zNgtK//cV1qgdW9EWox0bSSF3tY0Va/hsRD6DpgRmdsypRpvngiYUz674wem
XJ/R0CItmQQzCD/dYcQK4DMYb7G3hT1aT7QqgQgqDVJvgKqejdWQ1YTcMqbQQPdQ
b+whwioQ03Lw7moUdG+pCcZhGFzFc+ItbunUpjEp4QL2y2fBVSk2VN1Bk3cCh1Qk
YEGYO/B2LnGwU8vmEBJlCa0mWssm4uKbsx4vH3SFwStwuUeDWS7zreDQCEqmC4Ww
qNqg4YXfetnsY3Olb8s17pAXSve9BEgfQc0JjmJ3VWeyeRiQZ7lJYnIMikm6LgDk
mi64cpkv6nH3BEQnXdJnCaYSBxqaXvrWUqPheUO89XkE0kFdjATRWq6k+ADeMHSi
iMTR0lFZHkUxd9DbsJ88VwtMHfsdEwSBh8DpKKAkj9M6wvS0am6hqnKW1zkHexX2
Wl932rH9V8WfhUkX+IXS74pZ7uJEpYb00gr9FRQnuWWhzuar9KvcnNq01uQ4uNcI
x40c2M+Qcv8UCEVQvK4Z
=vIGk
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
