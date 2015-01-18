From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Maxim PMIC-s on Samsung boards
Date: Sun, 18 Jan 2015 10:17:44 +0000
Message-ID: <20150118101744.GF3574@x1>
References: <1421407190-6771-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:42090 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbARKRv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jan 2015 05:17:51 -0500
Received: by mail-ig0-f175.google.com with SMTP id r2so9542686igi.2
        for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2015 02:17:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421407190-6771-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>

On Fri, 16 Jan 2015, Krzysztof Kozlowski wrote:

> Add myself as supporter for Maxim 77686 PMIC and Maxim 14577/77693 MU=
IC
> drivers:
>  - mfd (all of them),
>  - extcon (extcon-max14577, extcon-max77693)
>  - power (max14577_charger.c, 77693 on LKML [1]),
>  - regulator (all of them),
>  - clock (clk-max77686.c)
>  - RTC (rtc-max77686.c).
>=20
> Lately I am the author of major contributors to them. These
> drivers are used on Exynos-based boards (Trats 2, Gear 1 and Gear 2).
>=20
> [1] https://lkml.org/lkml/2015/1/5/139
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> ---
>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f017a30eb280..b033fb499186 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6143,6 +6143,21 @@ F:	Documentation/devicetree/bindings/i2c/max66=
97.txt
>  F:	drivers/hwmon/max6697.c
>  F:	include/linux/platform_data/max6697.h
> =20
> +MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
> +M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Supported
> +F:	drivers/*/*max14577*.c
> +F:	drivers/*/*max77686*.c
> +F:	drivers/*/*max77693*.c
> +F:	Documentation/devicetree/bindings/mfd/max14577.txt
> +F:	Documentation/devicetree/bindings/mfd/max77686.txt
> +F:	Documentation/devicetree/bindings/mfd/max77693.txt
> +F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
> +F:	include/linux/mfd/max14577*.h
> +F:	include/linux/mfd/max77686*.h
> +F:	include/linux/mfd/max77693*.h

Acked-by: Lee Jones <lee.jones@linaro.org>

>  MAXIRADIO FM RADIO RECEIVER DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
