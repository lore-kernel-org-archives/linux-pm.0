From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 09/12] pinctrl: samsung: Add infrastructure for pin-bank
 retention control
Date: Tue, 17 Jan 2017 13:51:15 +0900
Message-ID: <CA+Ln22GY+RSX3WKvsmAvARxqvYitKq=7TWpy9zn7PbRiKyxeWQ@mail.gmail.com>
References: <CGME20170116064527eucas1p1f0f78e9420e7d9d60d94b6e7381caeb1@eucas1p1.samsung.com>
 <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com> <1484549107-5957-10-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35481 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdAQEvQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 23:51:16 -0500
In-Reply-To: <1484549107-5957-10-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Marek,

2017-01-16 15:45 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Pad retention control after suspend/resume cycle should be done from pin
> controller driver instead of PMU (power management unit) driver to avoid
> possible ordering and logical dependencies. Till now it worked fine only
> because PMU driver registered its sys_ops after pin controller.
>
> This patch adds infrastructure to handle pad retention during pin control
> driver resume.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 12 ++++++---
>  drivers/pinctrl/samsung/pinctrl-samsung.h | 42 +++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 3 deletions(-)

Please see my comments inline.

> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 86f23842f681..95a84086a2e9 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1075,6 +1075,9 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>                 ctrl->eint_gpio_init(drvdata);
>         if (ctrl->eint_wkup_init)
>                 ctrl->eint_wkup_init(drvdata);
> +       if (ctrl->retention_data && ctrl->retention_data->init)
> +               drvdata->retention_ctrl = ctrl->retention_data->init(drvdata,
> +                                                         ctrl->retention_data);

Is there really a use case for init being optional? Also maybe it
could make sense to add a pr_debug() in case retention_data is not
present (maybe even a warning would make sense, since the old code
should be deprecated...).

>
>         platform_set_drvdata(pdev, drvdata);
>
> @@ -1127,15 +1130,15 @@ static void samsung_pinctrl_suspend_dev(
>
>         if (drvdata->suspend)
>                 drvdata->suspend(drvdata);
> +       if (drvdata->retention_ctrl && drvdata->retention_ctrl->on)
> +               drvdata->retention_ctrl->on(drvdata);
> +

nit: Stray blank line.

>  }
>
>  /**
>   * samsung_pinctrl_resume_dev - restore pinctrl state from suspend for a device
>   *
>   * Restore one of the banks that was saved during suspend.
> - *
> - * We don't bother doing anything complicated to avoid glitching lines since
> - * we're called before pad retention is turned off.

I think the comment is still valid. Just could be adjusted to take
into account that now we are in charge of turning off the retention
after restoring the registers.

>   */
>  static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
>  {
> @@ -1174,6 +1177,9 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
>                         if (widths[type])
>                                 writel(bank->pm_save[type], reg + offs[type]);
>         }
> +
> +       if (drvdata->retention_ctrl && drvdata->retention_ctrl->off)
> +               drvdata->retention_ctrl->off(drvdata);
>  }
>
>  /**
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
> index 6f7ce7539a00..6079142422f8 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
> @@ -185,10 +185,48 @@ struct samsung_pin_bank {
>  };
>
>  /**
> + * struct samsung_retention_data: runtime pin-bank retention control data.
> + * @regs: array of PMU registers to control pad retention.
> + * @nr_regs: number of registers in @regs array.
> + * @value: value to store to registers to turn off retention.
> + * @refcnt: atomic counter if retention control affects more than one bank.
> + * @priv: retention control code private data
> + * @on: platform specific callback to enter retention mode.
> + * @off: platform specific callback to exit retention mode.
> + **/
> +struct samsung_retention_ctrl {
> +       const u32       *regs;
> +       int             nr_regs;
> +       u32             value;
> +       atomic_t        *refcnt;
> +       void            *priv;
> +       void            (*on)(struct samsung_pinctrl_drv_data *);
> +       void            (*off)(struct samsung_pinctrl_drv_data *);

bikeshed: I think enable/disable is more commonly used for this kind
of operations.

Best regards,
Tomasz
