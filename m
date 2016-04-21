From: dawei chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [RESEND][PATCH 3/3] arm64: dts: mt8173: Add dynamic power node.
Date: Thu, 21 Apr 2016 12:12:51 +0800
Message-ID: <1461211971.16427.4.camel@mtksdaap41>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
	 <1458029437-12846-4-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458029437-12846-4-git-send-email-dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-03-15 at 16:10 +0800, Dawei Chien (=E9=8C=A2=E5=A4=A7=E8=A1=
=9B) wrote:
> This device node is for calculating dynamic power in mW.
> Since mt8173 has two clusters, there are two dynamic power
> coefficient as well.
>=20
> Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
> This patch is base on patchset:
> https://lkml.org/lkml/2015/11/17/251

Sorry for miss one dependence for this device node.
https://lkml.org/lkml/2015/7/9/206

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/bo=
ot/dts/mediatek/mt8173.dtsi
> index f9c44cc..5cb6b4e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -71,6 +71,7 @@
>                         #cooling-cells =3D <2>;
>                         #cooling-min-level =3D <0>;
>                         #cooling-max-level =3D <7>;
> +                       dynamic-power-coefficient =3D <263>;
>                 };
>=20
>                 cpu1: cpu@1 {
> @@ -95,6 +96,7 @@
>                         #cooling-cells =3D <2>;
>                         #cooling-min-level =3D <0>;
>                         #cooling-max-level =3D <7>;
> +                       dynamic-power-coefficient =3D <263>;
>                 };
>=20
>                 cpu2: cpu@100 {
> @@ -119,6 +121,7 @@
>                         #cooling-cells =3D <2>;
>                         #cooling-min-level =3D <0>;
>                         #cooling-max-level =3D <7>;
> +                       dynamic-power-coefficient =3D <530>;
>                 };
>=20
>                 cpu3: cpu@101 {
> @@ -143,6 +146,7 @@
>                         #cooling-cells =3D <2>;
>                         #cooling-min-level =3D <0>;
>                         #cooling-max-level =3D <7>;
> +                       dynamic-power-coefficient =3D <530>;
>                 };
>=20
>                 idle-states {
> --
> 1.7.9.5
>=20


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
