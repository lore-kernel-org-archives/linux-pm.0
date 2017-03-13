From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 1/4] clk: Add support for runtime PM
Date: Mon, 13 Mar 2017 13:20:14 +0100
Message-ID: <CAPDyKFpe1ujO+ZMJ=pYG+NupxSAgY6WjgDkybkUhD1g6YpEfkg@mail.gmail.com>
References: <CGME20170125115328eucas1p1d97fac29286805b58039f8aec2b9bfe6@eucas1p1.samsung.com>
 <1485345194-3196-1-git-send-email-m.szyprowski@samsung.com> <1485345194-3196-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33563 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdCMMUQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 08:20:16 -0400
Received: by mail-vk0-f44.google.com with SMTP id d188so33879373vka.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 05:20:15 -0700 (PDT)
In-Reply-To: <1485345194-3196-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 25 January 2017 at 12:53, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Registers for some clocks might be located in the SOC area, which are under the
> power domain. To enable access to those registers respective domain has to be
> turned on. Additionally, registers for such clocks will usually loose its
> contents when power domain is turned off, so additional saving and restoring of
> them might be needed in the clock controller driver.
>
> This patch adds basic infrastructure in the clocks core to allow implementing
> driver for such clocks under power domains. Clock provider can supply a
> struct device pointer, which is the used by clock core for tracking and managing
> clock's controller runtime pm state. Each clk_prepare() operation
> will first call pm_runtime_get_sync() on the supplied device, while
> clk_unprepare() will do pm_runtime_put() at the end.
>
> Additional calls to pm_runtime_get/put functions are required to ensure that any
> register access (like calculating/changing clock rates and unpreparing/disabling
> unused clocks on boot) will be done with clock controller in runtime resumend
> state.
>
> When one wants to register clock controller, which make use of this feature, he
> has to:
> 1. Provide a struct device to the core when registering the provider.
> 2. Ensure to enable runtime PM for that device before registering clocks.
> 3. Make sure that the runtime PM status of the controller device reflects
>    the HW state.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clk/clk.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 117 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 0fb39fe217d1..5b9d52c8185b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -21,6 +21,7 @@
>  #include <linux/of.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/sched.h>
>  #include <linux/clkdev.h>
>
> @@ -46,6 +47,7 @@ struct clk_core {
>         const struct clk_ops    *ops;
>         struct clk_hw           *hw;
>         struct module           *owner;
> +       struct device           *dev;
>         struct clk_core         *parent;
>         const char              **parent_names;
>         struct clk_core         **parents;
> @@ -87,6 +89,26 @@ struct clk {
>         struct hlist_node clks_node;
>  };
>
> +/***           runtime pm          ***/
> +static int clk_pm_runtime_get(struct clk_core *core)
> +{
> +       int ret = 0;
> +
> +       if (!core->dev)
> +               return 0;
> +
> +       ret = pm_runtime_get_sync(core->dev);
> +       return ret < 0 ? ret : 0;
> +}
> +
> +static void clk_pm_runtime_put(struct clk_core *core)
> +{
> +       if (!core->dev)
> +               return;
> +
> +       pm_runtime_put(core->dev);

I would rather change this to a pm_runtime_put_sync().

The reason is that users of clocks (drivers being clock consumers),
which has runtime PM support deployed, often performs clock
gating/ungating from their runtime PM callbacks.

In other words, using async or sync runtime PM APIs, is better decided
by the user of the clock itself.


> +}
> +
>  /***           locking             ***/
>  static void clk_prepare_lock(void)
>  {
> @@ -150,6 +172,8 @@ static void clk_enable_unlock(unsigned long flags)
>
>  static bool clk_core_is_prepared(struct clk_core *core)
>  {
> +       bool status;
> +
>         /*
>          * .is_prepared is optional for clocks that can prepare
>          * fall back to software usage counter if it is missing
> @@ -157,11 +181,20 @@ static bool clk_core_is_prepared(struct clk_core *core)
>         if (!core->ops->is_prepared)
>                 return core->prepare_count;
>
> -       return core->ops->is_prepared(core->hw);
> +       if (clk_pm_runtime_get(core) == 0) {
> +               status = core->ops->is_prepared(core->hw);
> +               clk_pm_runtime_put(core);
> +       } else {
> +               status = false;

To simplify this, you could assign status to false when defining it.
Perhaps also rename it from "status" to "ret", as that name is more
commonly used, I think.

> +       }
> +
> +       return status;
>  }
>
>  static bool clk_core_is_enabled(struct clk_core *core)
>  {
> +       bool status;

Maybe name the variable ret instead, to be more consistent.

> +
>         /*
>          * .is_enabled is only mandatory for clocks that gate
>          * fall back to software usage counter if .is_enabled is missing
> @@ -169,7 +202,30 @@ static bool clk_core_is_enabled(struct clk_core *core)
>         if (!core->ops->is_enabled)
>                 return core->enable_count;
>
> -       return core->ops->is_enabled(core->hw);
> +       /*
> +        * Check if clock controller's device is runtime active before
> +        * calling .is_enabled callback. If not, assume that clock is
> +        * disabled, because we might be called from atomic context, from
> +        * which pm_runtime_get() is not allowed.
> +        * This function is called mainly from clk_disable_unused_subtree,
> +        * which ensures proper runtime pm activation of controller before
> +        * taking enable spinlock, but the below check is needed if one tries
> +        * to call it from other places.
> +        */
> +       if (core->dev) {
> +               pm_runtime_get_noresume(core->dev);
> +               if (!pm_runtime_active(core->dev)) {
> +                       status = false;
> +                       goto done;
> +               }
> +       }
> +
> +       status = core->ops->is_enabled(core->hw);
> +done:
> +       if (core->dev)
> +               pm_runtime_put(core->dev);

Let's use clk_pm_runtime_put() here instead.

> +
> +       return status;
>  }
>

[...]

> @@ -1036,9 +1111,13 @@ long clk_get_accuracy(struct clk *clk)
>  static unsigned long clk_recalc(struct clk_core *core,
>                                 unsigned long parent_rate)
>  {
> -       if (core->ops->recalc_rate)
> -               return core->ops->recalc_rate(core->hw, parent_rate);
> -       return parent_rate;
> +       unsigned long rate = parent_rate;
> +
> +       if (core->ops->recalc_rate && clk_pm_runtime_get(core) == 0) {

To be consistent, let's not check against "== 0", but instead just use
a "!" before the expression.

> +               rate = core->ops->recalc_rate(core->hw, parent_rate);
> +               clk_pm_runtime_put(core);
> +       }
> +       return rate;
>  }
>

[...]

Overall, this looks good to me. So with the minor changes suggested
above, feel free to add my reviewed-by tag.

Kind regards
Uffe
