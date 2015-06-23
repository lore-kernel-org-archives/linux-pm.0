From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Date: Tue, 23 Jun 2015 14:50:45 +0200
Message-ID: <CAPDyKFpRMrJZxZPv8w+jLEGAHu8U+AGSeG3LaJMXGW9zn__o+g@mail.gmail.com>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
	<1434958282-27376-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434958282-27376-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22 June 2015 at 09:31, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
> up with an infinite loop in genpd_dev_pm_{at,de}tach().
>
> This may happen due to a genpd.prepared_count imbalance.  This is a bug
> elsewhere, but it will result in a system lock up, possibly during
> reboot of an otherwise functioning system.
>
> To avoid this, put a limit on the maximum number of loop iterations,
> including a simple back-off mechanism.  If the limit is reached, the
> operation will just fail.  An error message is already printed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/power/domain.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cdd547bd67df8218..60e0309dd8dd0264 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -6,6 +6,7 @@
>   * This file is released under the GPLv2.
>   */
>
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> @@ -19,6 +20,9 @@
>  #include <linux/suspend.h>
>  #include <linux/export.h>
>
> +#define GENPD_RETRIES  20
> +#define GENPD_DELAY_US 10
> +
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)         \
>  ({                                                             \
>         type (*__routine)(struct device *__d);                  \
> @@ -2131,6 +2135,7 @@ EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
>  static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  {
>         struct generic_pm_domain *pd;
> +       unsigned int i;
>         int ret = 0;
>
>         pd = pm_genpd_lookup_dev(dev);
> @@ -2139,10 +2144,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>
>         dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>
> -       while (1) {
> +       for (i = 0; i < GENPD_RETRIES; i++) {
>                 ret = pm_genpd_remove_device(pd, dev);
>                 if (ret != -EAGAIN)
>                         break;
> +
> +               if (i > GENPD_RETRIES / 2)
> +                       udelay(GENPD_DELAY_US);
>                 cond_resched();
>         }
>
> @@ -2183,6 +2191,7 @@ int genpd_dev_pm_attach(struct device *dev)
>  {
>         struct of_phandle_args pd_args;
>         struct generic_pm_domain *pd;
> +       unsigned int i;
>         int ret;
>
>         if (!dev->of_node)
> @@ -2218,10 +2227,13 @@ int genpd_dev_pm_attach(struct device *dev)
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>
> -       while (1) {
> +       for (i = 0; i < GENPD_RETRIES; i++) {
>                 ret = pm_genpd_add_device(pd, dev);
>                 if (ret != -EAGAIN)
>                         break;
> +
> +               if (i > GENPD_RETRIES / 2)
> +                       udelay(GENPD_DELAY_US);

In this execution path, we retry when getting -EAGAIN while believing
the reason to the error are only *temporary* as we are soon waiting
for all devices in the genpd to be system PM resumed. At least that's
my understanding to why we want to deal with -EAGAIN here, but I might
be wrong.

In this regards, I wonder whether it could be better to re-try only a
few times but with a far longer interval time than a couple us. What
do you think?

However, what if the reason to why we get -EAGAIN isn't *temporary*,
because we are about to enter system PM suspend state. Then the caller
of this function which comes via some bus' ->probe(), will hang until
the a system PM resume is completed. Is that really going to work? So,
for this case your limited re-try approach will affect this scenario
as well, have you considered that?

>                 cond_resched();
>         }
>
> --
> 1.9.1
>

Kind regards
Uffe
