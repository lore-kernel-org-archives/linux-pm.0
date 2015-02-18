From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 4/8] ARM: dts: Add pwm-fan node to the Odroid-U3 board
Date: Wed, 18 Feb 2015 14:16:26 +0100
Message-ID: <54E490AA.3020301@suse.de>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com> <1424254056-5904-1-git-send-email-l.majewski@samsung.com> <1424254056-5904-5-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1424254056-5904-5-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-pm@vger.kernel.org

Am 18.02.2015 um 11:07 schrieb Lukasz Majewski:
> From: Kamil Debski <k.debski@samsung.com>
>=20
> Add pwm-fan node to the Odroid-U3 board file to enable PWM control of=
 the
> cooling fan. In addition, add the "pwm" label to the pwm@139D0000 nod=
e
> in the exynos4412.dtsi.
>=20
> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> [Rebased on the newest mainline by l.majewski@samsung.com]

You need to sign off patches you submit.

> ---
> Changes since v1:
> - added pwm label to the pwm@139D0000 node in exynos4.dtsi
> - use the pwm label in the exynos4412-odroidu3.dts
> - change order or properties in the pwn-fan node, to be sorted
>   in alphabetical order
>=20
> ---
>  arch/arm/boot/dts/exynos4.dtsi            |  2 +-
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exyno=
s4.dtsi
> index f18d746..75266e3 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -582,7 +582,7 @@
>  		status =3D "disabled";
>  	};
> =20
> -	pwm@139D0000 {
> +	pwm: pwm@139D0000 {
>  		compatible =3D "samsung,exynos4210-pwm";
>  		reg =3D <0x139D0000 0x1000>;
>  		interrupts =3D <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>, <0 41 0>;
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boo=
t/dts/exynos4412-odroidu3.dts
> index c8a64be..60bd1e4 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> @@ -31,6 +31,19 @@
>  			linux,default-trigger =3D "heartbeat";
>  		};
>  	};
> +
> +	pwm-fan {
> +		compatible =3D "pwm-fan";
> +		pwms =3D <&pwm 0 10000 0>;
> +		status =3D "okay";

Status "okay" is only needed for pre-existing nodes that would have
status "disabled" otherwise, such as below. Just drop it here.

Regards,
Andreas

> +	};
> +};
> +
> +&pwm {
> +	pinctrl-0 =3D <&pwm0_out>;
> +	pinctrl-names =3D "default";
> +	samsung,pwm-outputs =3D <0>;
> +	status =3D "okay";
>  };
> =20
>  &usb3503 {
>=20


--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N=FCrnberg)
