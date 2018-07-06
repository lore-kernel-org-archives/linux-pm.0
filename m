From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
Date: Fri, 6 Jul 2018 13:28:54 +0200
Message-ID: <20180706112854.nj762elcad625idr@earth.universe>
References: <20180612202042.107603-1-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jtmcc4vnohl3fhu5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612202042.107603-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>, Alexandru Stan <amstan@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Doug Anderson <dianders@chromium.org>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org


--jtmcc4vnohl3fhu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 12, 2018 at 01:20:41PM -0700, Brian Norris wrote:
> This driver was originally submitted for the TI BQ20Z75 battery IC
> (commit a7640bfa10c5 ("power_supply: Add driver for TI BQ20Z75 gas gauge
> IC")) and later renamed to express generic SBS support. While it's
> mostly true that this driver implemented a standard SBS command set, it
> takes liberties with the REG_MANUFACTURER_DATA register. This register
> is specified in the SBS spec, but it doesn't make any mention of what
> its actual contents are.
>=20
> We've sort of noticed this optionality previously, with commit
> 17c6d3979e5b ("sbs-battery: make writes to ManufacturerAccess
> optional"), where we found that some batteries NAK writes to this
> register.
>=20
> What this really means is that so far, we've just been lucky that most
> batteries have either been compatible with the TI chip, or else at least
> haven't reported highly-unexpected values.
>=20
> For instance, one battery I have here seems to report either 0x0000 or
> 0x0100 to the MANUFACTURER_ACCESS_STATUS command -- while this seems to
> match either Wake Up (bits[11:8] =3D 0000b) or Normal Discharge
> (bits[11:8] =3D 0001b) status for the TI part [1], they don't seem to
> actually correspond to real states (for instance, I never see 0101b =3D
> Charge, even when charging).
>=20
> On other batteries, I'm getting apparently random data in return, which
> means that occasionally, we interpret this as "battery not present" or
> "battery is not healthy".
>=20
> All in all, it seems to be a really bad idea to make assumptions about
> REG_MANUFACTURER_DATA, unless we already know what battery we're using.
> Therefore, this patch reimplements the "present" and "health" checks to
> the following on most SBS batteries:
>=20
> 1. HEALTH: report "unknown" -- I couldn't find a standard SBS command
>    that gives us much useful here
> 2. PRESENT: just send a REG_STATUS command; if it succeeds, then the
>    battery is present
>=20
> Also, we stop sending MANUFACTURER_ACCESS_SLEEP to non-TI parts. I have
> no proof that this is useful and supported.
>=20
> If someone explicitly provided a 'ti,bq20z75' compatible property, then
> we continue to use the existing TI command behaviors, and we effectively
> revert commit 17c6d3979e5b ("sbs-battery: make writes to
> ManufacturerAccess optional") to again make these commands required.
>=20
> [1] http://www.ti.com/lit/er/sluu265a/sluu265a.pdf
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Rhyland Klein <rklein@nvidia.com>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

--jtmcc4vnohl3fhu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/UnMACgkQ2O7X88g7
+pqqmg//UX9RaDVdAkgZp3giJO980qsFcKMtlu6xA4peVtgKvi50+66tCntSH5W6
zLrjW3h+Ltry4MKDnRCEjzkin7UD/fzqk4xaL8ru6zOZot9Jd+FgB4LIF5O185W1
xNRhY4/Un0HheUZoynDOmsB+LxTgfoZ+ery2369XPqBzb65qb7Qp5nvucAZGIlUv
kzwUd2oN4G9+nh7pxWCnGvDpIHTwsOc9fRkWrJA158gVCKzbpQMU48TeCdLI1LMn
MULmncBld/MvVdVNQY+kM0aa2F7sji2Mw9P6jI2ENNdZ6CbEhx0sECXpaoRgJLVW
cQFcEIKvGf/tqdmGUcuDkqtWTHJZwZ5pGi9vczC9jc1WavBAnaQIAiVZjOxCHllT
JaCr/h3Qh3/0Vre4Zc7JtsS9g0uHa/002ryoShcEpUY+oBylt6gYTyBu5iAlrV7M
qrmpMXijCH23txe8L80RwLGN2KameQZ1Ipk8HSRI68LWw0iakgz3RbhJWxHv4u4h
1xgrEVl85sKQlj/sBuMCJXQnRpoUhJ5TMVpSXI+d6XXZM7WKx6d30r7/WyGLhvRO
mbKIUC1mO1yNfNkdSm/g1EGuAZ/1z+QmqD1IwwUYv07NTD/J1w2PRRQqlFubOvy+
BRhFjOWT0dGRVndOt9hDIjPfCkKxktAAujR2CUsL/pnu5gLi1cM=
=Z+c7
-----END PGP SIGNATURE-----

--jtmcc4vnohl3fhu5--
