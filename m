From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] i2c: nomadik: move runtime suspend of hw to _noirq
Date: Wed, 25 May 2016 12:09:20 +0200
Message-ID: <CAPDyKFpvwQkqS9TRCj+JCOro-fdbkPKrXr6V7eEeSJLMah61Ng@mail.gmail.com>
References: <1464008356-21162-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1464008356-21162-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

+ linux-pm, Rafael, Kevin

On 23 May 2016 at 14:59, Linus Walleij <linus.walleij@linaro.org> wrote:
> The runtime suspend of the hardware (declocking and pin control
> resting) needs to happen in the *_noirq callbacks after all
> hardware interrupts are disabled and we know there will be no
> more I2C traffic in the system.

As you need this change, it means some other device requires the I2C
device to be runtime resumed, while a *_late callback tries to suspend
the other device. Right!?

Can you tell which these devices are?

Moving the suspend operations to the *_noirq callbacks could improve
the situation, but unfortunate it's comes with a limitation.
That's because runtime PM has been disabled (by genpd or the PM core)
before the *_late callbacks is invoked, which means the I2C device
needs to be runtime resumed in an earlier phase to make it
operational.

This is indeed a generic problem, as we don't have a way to describe
these kind of dependences between devices. In other words, we need to
control the order of how devices becomes suspended/resumed. If that
could be done, we could likely avoid runtime resuming devices
unnecessarily.

Kind regards
Uffe

>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index bcd17e8cbcb4..c96a3e331bed 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -877,7 +877,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> -static int nmk_i2c_suspend_late(struct device *dev)
> +static int nmk_i2c_suspend_noirq(struct device *dev)
>  {
>         int ret;
>
> @@ -889,7 +889,7 @@ static int nmk_i2c_suspend_late(struct device *dev)
>         return 0;
>  }
>
> -static int nmk_i2c_resume_early(struct device *dev)
> +static int nmk_i2c_resume_noirq(struct device *dev)
>  {
>         return pm_runtime_force_resume(dev);
>  }
> @@ -931,7 +931,8 @@ static int nmk_i2c_runtime_resume(struct device *dev)
>  #endif
>
>  static const struct dev_pm_ops nmk_i2c_pm = {
> -       SET_LATE_SYSTEM_SLEEP_PM_OPS(nmk_i2c_suspend_late, nmk_i2c_resume_early)
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(nmk_i2c_suspend_noirq,
> +                                     nmk_i2c_resume_noirq)
>         SET_RUNTIME_PM_OPS(nmk_i2c_runtime_suspend,
>                         nmk_i2c_runtime_resume,
>                         NULL)
> --
> 2.4.11
>
