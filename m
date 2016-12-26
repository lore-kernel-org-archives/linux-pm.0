From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 5/9] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Mon, 26 Dec 2016 14:55:15 +0900
Message-ID: <CA+Ln22HQPHF_Vj0kS834SH=4=hcNOpe_vL8P3fbS-jFhQLVyXA@mail.gmail.com>
References: <CGME20161223122531epcas1p4b8fad6664dad3408acb7a1b9f140884a@epcas1p4.samsung.com>
 <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com> <1482495889-6201-6-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36531 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbcLZFzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Dec 2016 00:55:16 -0500
In-Reply-To: <1482495889-6201-6-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi,

2016-12-23 21:24 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Pad retention control after suspend/resume cycle should be done from pin
> controller driver instead of PMU (power management unit) driver to avoid
> possible ordering and logical dependencies. Till now it worked fine only
> because PMU driver registered its sys_ops after pin controller.
>
> This patch moves pad retention control from PMU driver to Exynos pin
> controller driver. This is a preparation for adding new features to Exynos
> pin controller driver, like runtime power management and suspending
> individual pin controllers, which might be a part of some power domain.
>

It looks like this change will essentially break the compatibility
with DTBs that don't have the pmu syscon specified in pin controller
nodes.

On the other hand, moving this code to where it actually belongs
really makes sense, so maybe we could just avoid the need of having
this property, by looking up the PMU manually, by hardcoded string or
so, if the proper property is not present?

[...]

> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> index 1baf19eecabf..b7bd2e12a269 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> @@ -43,6 +43,10 @@ Required Properties:
>                 };
>         };
>
> +- samsung,pmu-syscon: Phandle to the PMU system controller, to let driver
> +  to control pad retention after system suspend/resume cycle (only for Exynos
> +  SoC series).
> +

Ah, here it is. I think adding relevant binding documentation at the
beginning of the series would make it much easier for reviewers to
understand the change.

>  - Pin banks as child nodes: Pin banks of the controller are represented by child
>    nodes of the controller node. Bank name is taken from name of the node. Each
>    bank node must contain following properties:

[...]

> +static void exynos_retention_audio_off(struct samsung_pinctrl_drv_data *drvdata)
> +{
> +       if (!IS_ERR(pmu_regs))

nit: Negated conditions make the code more difficult to read. Also it
would be consistent with exynos_retention_off() to just bail out if
(IS_ERR(pmu_regs)).

> +               regmap_write(pmu_regs, S5P_PAD_RET_MAUDIO_OPTION,
> +                            EXYNOS_WAKEUP_FROM_LOWPWR);
> +}

[...]

> @@ -1139,15 +1146,15 @@ static void samsung_pinctrl_suspend_dev(
>
>         if (drvdata->suspend)
>                 drvdata->suspend(drvdata);
> +       if (drvdata->retention_on)
> +               drvdata->retention_on(drvdata);
> +

nit: Unnecessary blank line.

Best regards,
Tomasz
