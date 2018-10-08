From: Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: allwinner: axp803: add AC and battery
 power supplies
Date: Mon, 8 Oct 2018 09:28:58 +0200
Message-ID: <20181008072858.kwhht67idbmevxyv@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-4-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nien25lswmkt5zkw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181006211836.28253-4-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--nien25lswmkt5zkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:33AM +0300, Oskari Lemmela wrote:
> AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
> AC and battery power supplies.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/=
dts/allwinner/axp803.dtsi
> index e5eae8bafc42..533987b2fe7a 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -49,6 +49,37 @@
>  	interrupt-controller;
>  	#interrupt-cells =3D <1>;
> =20
> +	axp_adc: adc {
> +		compatible =3D "x-powers,axp813-adc";
> +		#io-channel-cells =3D <1>;
> +	};
> +
> +	axp_gpio: gpio {
> +		compatible =3D "x-powers,axp813-gpio";
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio0_ldo: gpio0-ldo {
> +			pins =3D "GPIO0";
> +			function =3D "ldo";
> +		};
> +
> +		gpio1_ldo: gpio1-ldo {
> +			pins =3D "GPIO1";
> +			function =3D "ldo";
> +		};
> +	};
> +
> +	ac_power_supply: ac-power-supply {
> +		compatible =3D "x-powers,axp813-ac-power-supply";
> +		status =3D "disabled";
> +	};
> +

Same as the patch before, I'd put it before axp_adc.

Thanks,
Quentin

--nien25lswmkt5zkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7BzkACgkQhLiadT7g
8aMKChAAmCqckD3HLafXfq8eWXLc6uiJjUHK42ONv78dbf9Wn7Bc06xGV9gLNCk1
swJ62e8mYD63/7BAoEl+9z1ocTWRm+RUyAZUpWh7r6PJbjmisNvrtqYjW4JYcvN+
18vHD7KTK0PstqHoULlYOLGvZpNHJ8TE7/qFuLUHXW5MymGVAgTUB21aocjRXAsn
R7wZrhIEPHr3ghEEM+K85V70jiVvXs91rcO2ctEqd5z1ZA7W3SBSfC6BK6HaNUzn
deSUoBnOsLQwwlsOY/72yALUN6jQR8EzorK0VAUEZXMJkn0x5tdy9F+ZJGlg0fpi
45ygdlyw/kG1bbTGNNHKWRqsz778b6DoEbBadMdRDd/ZCwcWm1fRvDYATgJTBvht
9i7/R80Fdf7s8ix2zLn/8ZIQi2t74w+RksoxMHej67uOlOyGug67MAV27Q2RPMJk
TFzylNi0tKq9HENdWKIOHtWwp6qtSDYJZxU52kmEJLxMY8oCujxeWRflBZApYbh1
3m7GV8JTfQs/heDaz3E4npG6DJpMXArrXKz7Q/3Ys2ft9fezk4esUMnCPedyzgIH
WijPr+etjSg2WGEKIq76/K+wEQc4NN0rHeLgm162xP5MFp/cOWCpyVb5ZwVRPsf8
gmwqNvnJXY9ADm8XrQl34av5RAxt+ssceffN09iV3DAcSSR3p50=
=wwHW
-----END PGP SIGNATURE-----

--nien25lswmkt5zkw--
