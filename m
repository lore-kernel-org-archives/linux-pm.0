From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] gpio: rcar: Use WAKEUP_PATH driver PM flag
Date: Tue, 2 Jan 2018 11:48:55 +0100
Message-ID: <CAJZ5v0j7r_-TJA=n6ohC_iFc_0Tei9nfVZUN5rjB0n0CxYkMgQ@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
 <1514554304-18989-4-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0gWtr1bwi7WVeEbTJPu3KC8YfPvfUh5XDmomiK8TFmfyg@mail.gmail.com> <CAMuHMdVmqM+WA_EaCRHNojpV6NYmS0-V18MoixyV5UdC3cq+2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVmqM+WA_EaCRHNojpV6NYmS0-V18MoixyV5UdC3cq+2g@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 2, 2018 at 11:44 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rafael,
>
> On Tue, Jan 2, 2018 at 11:32 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Fri, Dec 29, 2017 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>> Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
>>> when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO block's
>>> module clock (if exists) is manually kept running during system suspend, to
>>> make sure the device stays active.
>>>
>>> However, this explicit clock handling is merely a workaround for a failure
>>> to properly communicate wakeup information to the PM core. Instead, set the
>>> WAKEUP_PATH driver PM flag to indicate that the device is part of the
>>> wakeup path, which further also enables middle-layers and PM domains (like
>>> genpd) to act on this.
>>>
>>> In case the device is attached to genpd and depending on if it has an
>>> active wakeup configuration, genpd will keep the device active (the clock
>>> running) during system suspend when needed. This enables us to remove all
>>> explicit clock handling code from the driver, so let's do that as well.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> [Ulf: Converted to use the WAKEUP_PATH driver PM flag]
>
> Ulf: + killing the DEV_PM_OPS define, increasing kernel size if PM_SUSPEND=n?
>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
>>> --- a/drivers/gpio/gpio-rcar.c
>>> +++ b/drivers/gpio/gpio-rcar.c
>
>>> @@ -415,6 +402,18 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
>>>         return 0;
>>>  }
>>>
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int gpio_rcar_suspend(struct device *dev)
>>> +{
>>> +       struct gpio_rcar_priv *p = dev_get_drvdata(dev);
>>> +
>>> +       dev_pm_set_driver_flags(dev, p->wakeup_path ? DPM_FLAG_WAKEUP_PATH : 0);
>>
>> Why don't you simply set dev->power.wakeup_path here?
>
> That's what my v1 did (https://patchwork.kernel.org/patch/10050995/).

I very much prefer this one. :-)

What's wrong with it?

Thanks,
Rafael
