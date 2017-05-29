From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: uniphier: add nodes of thermal monitor and
 thermal zone for PXs2
Date: Mon, 29 May 2017 09:30:09 -0700
Message-ID: <20170529163007.GA14413@localhost.localdomain>
References: <1496049345-14649-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1496049345-14649-4-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33248 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdE2QaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2017 12:30:14 -0400
Content-Disposition: inline
In-Reply-To: <1496049345-14649-4-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 06:15:44PM +0900, Kunihiko Hayashi wrote:
> Add nodes of thermal monitor and thermal zone for UniPhier PXs2 SoC.
> The thermal monitor is included in sysctrl.
>=20
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/uniphier-pxs2-vodka.dts  | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/uniphier-pxs2.dtsi       |  6 ++++++
>  3 files changed, 48 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/d=
ts/uniphier-pxs2-gentil.dts
> index 373818a..89ccb88 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
> +++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
> @@ -70,6 +70,27 @@
>  		i2c5 =3D &i2c5;
>  		i2c6 =3D &i2c6;
>  	};
> +
> +	thermal-zones {
> +		cpu_thermal {
> +			polling-delay-passive =3D <250>;	/* 250ms */
> +			polling-delay =3D <1000>;		/* 1000ms */
> +			thermal-sensors =3D <&pvtctl>;
> +
> +			trips {
> +				cpu_crit: cpu_crit {
> +					temperature =3D <95000>;	/* 95C */
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +				cpu_alert: cpu_alert {
> +					temperature =3D <85000>;	/* 85C */
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +			};
These are missing cooling-maps section.


> +		};
> +	};
>  };
> =20
>  &serial2 {
> diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dt=
s/uniphier-pxs2-vodka.dts
> index 51a3eac..0201584 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
> +++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
> @@ -68,6 +68,27 @@
>  		i2c5 =3D &i2c5;
>  		i2c6 =3D &i2c6;
>  	};
> +
> +	thermal-zones {
> +		cpu_thermal {
> +			polling-delay-passive =3D <250>;	/* 250ms */
> +			polling-delay =3D <1000>;		/* 1000ms */
> +			thermal-sensors =3D <&pvtctl>;
> +
> +			trips {
> +				cpu_crit: cpu_crit {
> +					temperature =3D <95000>;	/* 95C */
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +				cpu_alert: cpu_alert {
> +					temperature =3D <85000>;	/* 85C */
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +			};

same

> +		};
> +	};
>  };
> =20
>  &serial2 {
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uni=
phier-pxs2.dtsi
> index e9e031d..072e3b4 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -387,6 +387,12 @@
>  				compatible =3D "socionext,uniphier-pxs2-reset";
>  				#reset-cells =3D <1>;
>  			};
> +
> +			pvtctl: pvtctl {
> +				compatible =3D "socionext,uniphier-pxs2-thermal";
> +				interrupts =3D <0 3 1>;
> +				#thermal-sensor-cells =3D <0>;
> +			};
>  		};
>  	};
>  };
> --=20
> 2.7.4
>=20

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLEyGAAoJEA6VkvSQfF5T0UYP/307EAjUQJpswj6RC4ZfjT4O
gb5fI5Thi/bqfJ5qeBiPzfkBM5IvIwcq8naMv0EQPAK4ARqEi9wL0I+ygXL5p5He
/HC4bc/Z4fZxroxLwqGQevLSXSNBefk2L3RaK1XdMySvo5zNYon0bmB4Ox31yMZd
LlWLp0LvNZf2dD5u0XdxF6WJ4eUKOpdbcgACbsVYxiuzKMI9e4XuKsDw1vEJ+Enq
9+6iD8v62ldwKXv730j4J5uYNvtBs19Id9rO6M88mnKOCRYXuxKe28XKXvHNugux
On72EwqdJvUhnviVxYtz4EMvAWQUGFuO2FrDMkEiZg2Tq+UH8aK0TccqhULFCL4x
DQpdYAQL5n5mPddGyel4fbBcsD1KC1HMoEimoYw8kGygapRAdMv9/rawN7hVTkAo
2mN1FP1yU1buJ+uP1bEnSZZRJYGcgC0dcHyXX2pcgL7Qa47+w5Qa1cr+iWoXnBy5
cfnSAH1X9hM/5kQ0MWyc04LKbpabIrWCwWJ+TV/5OhUPwImLXiV6nzEDBvxMf+LL
yY95NKwAn1Fxlad9LaP01FUijeS3ofwcsJYJxDeC0mZaopSHGZHoLzMWZTZ03a+C
VGsX015ahEf+hdMXLlAx6D5okg5/Uun3uTZd/dTmVBcxBdXZmLR+XpHqZey0gFTa
e7T9QbQEq/uPRaE+o2Ju
=pWlu
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
