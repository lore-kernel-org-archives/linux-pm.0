From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 3/6] dt-bindings: power: Introduce properties to
 present the battery OCV capacity table
Date: Sun, 21 Oct 2018 18:24:30 +0200
Message-ID: <20181021162430.qfz2teauewdy5jva@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
 <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1539915051.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgjqzksp5zzrqfpo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1539915051.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org


--lgjqzksp5zzrqfpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 06:53:12PM +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsi=
us.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values.
>=20
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Looks good to me.

-- Sebastian

> Changes from v4:
>  - Improve the description of ocv-capacity-table-n to make the order clea=
r.
>=20
> Changes from v3:
>  - Split binding into one separate patch.
>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>  - Add some words to specify the OCV's unit.
>=20
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
>=20
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> index 938d027..89871ab 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -23,6 +23,17 @@ Optional Properties:
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>   - factory-internal-resistance-micro-ohms: battery factory internal resi=
stance
> + - ocv-capacity-table-0: An array providing the open circuit voltage (OC=
V)
> +   of the battery and corresponding battery capacity percent, which is u=
sed
> +   to look up battery capacity according to current OCV value. And the o=
pen
> +   circuit voltage unit is microvolt.
> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
> + ......
> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
> + - ocv-capacity-celsius: An array containing the temperature in degree C=
elsius,
> +   for each of the battery capacity lookup table. The first temperature =
value
> +   specifies the OCV table 0, and the second temperature value specifies=
 the
> +   OCV table 1, and so on.
> =20
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -44,6 +55,10 @@ Example:
>  		constant-charge-current-max-microamp =3D <900000>;
>  		constant-charge-voltage-max-microvolt =3D <4200000>;
>  		factory-internal-resistance-micro-ohms =3D <250000>;
> +		ocv-capacity-celsius =3D <(-10) 0 10>;
> +		ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, ..=
=2E;
> +		ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, ..=
=2E;
> +		ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, ..=
=2E;
>  	};
> =20
>  	charger: charger@11 {
> --=20
> 1.7.9.5
>=20

--lgjqzksp5zzrqfpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvMqD4ACgkQ2O7X88g7
+po+qA//YPKLr1a2+dJGER6QU5BNbQLcQW98aYF04eTnq5R+sGX9+zCgH/uvQVJ7
BS98J+pMSi/Bpq3AHIrfPnTrjdROGk9BG3RjdRqSd8eFLgEI9i9yUEXnwdY/RxCH
WTXai4lBLeN7vvcTRu6s2FYIzA1m84B/BzEU4Dy5KjLVIKqQzUSZSB6WDW7P6DSF
YOa/9Vh7bjKfijaCnmJk4SQM8rFyxFzAiWHnfe+sbNv/jLEU6LK5D0rbJnD5Cr2M
oIn0JY6m/BfydAanAvlsD9hG7lhRsciePXtGw9XP5EVBuMgb2VSMJZmp0Qs51UhR
oO6P2io2tJpyi9RxO1yHFGCm0+k+J7h6Wwy+IW/MSDtT6m4PSmfKQwmHKGA5g5dz
AlOUNfsSy/GbNmmpnM7M+lEGZNNgo2ue6neCRaJ7V6NhpuptwW6gE0OOUT9zg94x
9Hya3Of0HTdiIBFchfFyUbxI7zTBlsiqLU93jOMe/Ggsh4AO8kZDhTCfa0BvHSAx
Ixt+34Yl6lpP1PT5exMPVFk7YkgjOR2K44YnsDe4cKB5FGIEQw7zoCIiD1yydbmJ
BvGDnp62TAI/LKrVbUy5JeM9kb/6g2Gnn8o0nMUWJbsePL07GatWThvkOJOnxTqZ
ZDAOW/y5/J6/mTzw9ik1Jig/8iHd6KPp0MVUVHTlUWJe0/f9wZo=
=Rlqe
-----END PGP SIGNATURE-----

--lgjqzksp5zzrqfpo--
