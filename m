From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v8 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
Date: Tue, 29 Jul 2014 14:08:51 +0200
Message-ID: <53D78ED3.9090703@suse.de>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com> <1406611711-25112-4-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43304 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaG2MIz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Jul 2014 08:08:55 -0400
In-Reply-To: <1406611711-25112-4-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com, Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hi Thomas,

Am 29.07.2014 07:28, schrieb Thomas Abraham:
> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm=
/boot/dts/exynos5250-cros-common.dtsi
> index 89ac90f..34bb31c 100644
> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> @@ -19,6 +19,12 @@
>  	chosen {
>  	};
> =20
> +	cpus {
> +		cpu@0 {
> +			cpu0-supply =3D <&buck2_reg>;
> +		};
> +	};
> +
>  	pinctrl@11400000 {
>  		/*
>  		 * Disabled pullups since external part has its own pullups and

I've been instructed to dismantle this .dtsi file, so please place this
into exynos5250-snow.dts. It's probably wrong here anyway, since Spring
doesn't use the max77686 but an s5m6787 PMIC.

How do I find out which -supply to specify here for Spring?

Also, wouldn't it make sense to assign a cpu0 label in exynos????.dtsi
to override it via &cpu0 { ... };?

Regards,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
