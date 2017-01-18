From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 10/13] pinctrl: samsung: Add infrastructure for
 pin-bank retention control
Date: Wed, 18 Jan 2017 17:36:44 +0900
Message-ID: <CA+Ln22FyDQ00cxNNxzthkxUwxcPRkJxGEC6g7m9rO2U4dNirKA@mail.gmail.com>
References: <CGME20170117124501eucas1p2ab3ec2a1dee18486878733826037d071@eucas1p2.samsung.com>
 <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com> <1484657084-26227-11-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1484657084-26227-11-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Marek,

2017-01-17 21:44 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Pad retention control after suspend/resume cycle should be done from pin
> controller driver instead of PMU (power management unit) driver to avoid
> possible ordering and logical dependencies. Till now it worked fine only
> because PMU driver registered its sys_ops after pin controller.
>
> This patch adds infrastructure to handle pad retention during pin control
> driver resume.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 12 +++++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.h | 42 +++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 59f99ea7e65b..021abd7221f8 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1060,6 +1060,13 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>         if (res)
>                 drvdata->irq = res->start;
>
> +       if (ctrl->retention_data) {
> +               drvdata->retention_ctrl = ctrl->retention_data->init(drvdata,
> +                                                         ctrl->retention_data);
> +               if (IS_ERR(drvdata->retention_ctrl))
> +                       return PTR_ERR(drvdata->retention_ctrl);
> +       }
> +
>         ret = samsung_gpiolib_register(pdev, drvdata);
>         if (ret)
>                 return ret;
> @@ -1126,6 +1133,8 @@ static void samsung_pinctrl_suspend_dev(
>
>         if (drvdata->suspend)
>                 drvdata->suspend(drvdata);
> +       if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
> +               drvdata->retention_ctrl->enable(drvdata);

Do we need to check presence of ->enable? I think it doesn't make much
sense to provide retention_ctrl with NULL enable or disable.

>  }
>
>  /**
> @@ -1173,6 +1182,9 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
>                         if (widths[type])
>                                 writel(bank->pm_save[type], reg + offs[type]);
>         }
> +
> +       if (drvdata->retention_ctrl && drvdata->retention_ctrl->disable)
> +               drvdata->retention_ctrl->disable(drvdata);

Ditto.

>  }
>
>  /**
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
> index 6f7ce7539a00..5ebbf4137a06 100644
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

s/on/enable/ and s/off/disable/ in comments too. Thanks for taking my
bikeshedding into account, though. :)

> + **/
> +struct samsung_retention_ctrl {
> +       const u32       *regs;
> +       int             nr_regs;
> +       u32             value;
> +       atomic_t        *refcnt;
> +       void            *priv;
> +       void            (*enable)(struct samsung_pinctrl_drv_data *);
> +       void            (*disable)(struct samsung_pinctrl_drv_data *);

^^

Best regards,
Tomasz
