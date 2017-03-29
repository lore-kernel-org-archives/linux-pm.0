From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v6 1/4] clk: Add support for runtime PM
Date: Wed, 29 Mar 2017 13:22:54 -0700
Message-ID: <149081897388.31513.7062843004022908296@resonance>
References: <1490182543-28550-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170322113554eucas1p27471f0de278c55d5dce7fdf120395e09@eucas1p2.samsung.com>
 <1490182543-28550-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1490182543-28550-2-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Marek,

Quoting Marek Szyprowski (2017-03-22 04:35:40)
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
> clk_unprepare() will do pm_runtime_put_sync() at the end.
> 
> Additional calls to pm_runtime_get/put functions are required to ensure that any
> register access (like calculating/changing clock rates and unpreparing/disabling
> unused clocks on boot) will be done with clock controller in runtime resumend
> state.

The above is a bit confusing. Is clk_prepare really special? It seems to
me that every single clk_ops callback will need this?

That leads to my second question: why put this in the clk core? Can the
clk provider driver simply add pm_runtime_{get,put} calls into its
clk_ops callbacks instead? The clk core does not directly touch hardware
(e.g. reading registers) so putting the pm runtime calls into the
provider callbacks should be sufficient.

> 
> When one wants to register clock controller, which make use of this feature, he
> has to:
> 1. Provide a struct device to the core when registering the provider.
> 2. Ensure to enable runtime PM for that device before registering clocks.
> 3. Make sure that the runtime PM status of the controller device reflects
>    the HW state.

Third question: is there a case where more than one device is required?
Is is possible that a single pm_runtime_get call against a single device
will not be enough for some clk provider drivers? If so then this
solution does not scale very well and the clk provider driver will have
to implement this in the clk_ops callbacks (as I mentioned above in my
second question).

Fourth & final question: I'm under the impression that pm runtime calls
be be nested and re-enter, but I want to make sure (Ulf?). For instance
it is highly likely that this new feature would cause something like:

pm_runtime_get()              - called by random driver
-> clk_prepare_enable()       - genpd enables functioal clocks
   -> pm_runtime_get()        - called by clk_pm_runtime_get in clk core
      -> clk_prepare_enable() - genpd enables interface or bus clocks

I guess this is safe from the pm_runtime_get/genpd perspective, but want
to make sure first.

Thanks,
Mike

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/clk/clk.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 114 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 0fb39fe217d1..a6001b6e49a7 100644
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
> +       pm_runtime_put_sync(core->dev);
> +}
> +
>  /***           locking             ***/
>  static void clk_prepare_lock(void)
>  {
> @@ -150,6 +172,8 @@ static void clk_enable_unlock(unsigned long flags)
>  
>  static bool clk_core_is_prepared(struct clk_core *core)
>  {
> +       bool ret = false;
> +
>         /*
>          * .is_prepared is optional for clocks that can prepare
>          * fall back to software usage counter if it is missing
> @@ -157,11 +181,18 @@ static bool clk_core_is_prepared(struct clk_core *core)
>         if (!core->ops->is_prepared)
>                 return core->prepare_count;
>  
> -       return core->ops->is_prepared(core->hw);
> +       if (!clk_pm_runtime_get(core)) {
> +               ret = core->ops->is_prepared(core->hw);
> +               clk_pm_runtime_put(core);
> +       }
> +
> +       return ret;
>  }
>  
>  static bool clk_core_is_enabled(struct clk_core *core)
>  {
> +       bool ret = false;
> +
>         /*
>          * .is_enabled is only mandatory for clocks that gate
>          * fall back to software usage counter if .is_enabled is missing
> @@ -169,7 +200,29 @@ static bool clk_core_is_enabled(struct clk_core *core)
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
> +                       ret = false;
> +                       goto done;
> +               }
> +       }
> +
> +       ret = core->ops->is_enabled(core->hw);
> +done:
> +       clk_pm_runtime_put(core);
> +
> +       return ret;
>  }
>  
>  /***    helper functions   ***/
> @@ -489,6 +542,8 @@ static void clk_core_unprepare(struct clk_core *core)
>         if (core->ops->unprepare)
>                 core->ops->unprepare(core->hw);
>  
> +       clk_pm_runtime_put(core);
> +
>         trace_clk_unprepare_complete(core);
>         clk_core_unprepare(core->parent);
>  }
> @@ -530,10 +585,14 @@ static int clk_core_prepare(struct clk_core *core)
>                 return 0;
>  
>         if (core->prepare_count == 0) {
> -               ret = clk_core_prepare(core->parent);
> +               ret = clk_pm_runtime_get(core);
>                 if (ret)
>                         return ret;
>  
> +               ret = clk_core_prepare(core->parent);
> +               if (ret)
> +                       goto runtime_put;
> +
>                 trace_clk_prepare(core);
>  
>                 if (core->ops->prepare)
> @@ -541,15 +600,18 @@ static int clk_core_prepare(struct clk_core *core)
>  
>                 trace_clk_prepare_complete(core);
>  
> -               if (ret) {
> -                       clk_core_unprepare(core->parent);
> -                       return ret;
> -               }
> +               if (ret)
> +                       goto unprepare;
>         }
>  
>         core->prepare_count++;
>  
>         return 0;
> +unprepare:
> +       clk_core_unprepare(core->parent);
> +runtime_put:
> +       clk_pm_runtime_put(core);
> +       return ret;
>  }
>  
>  static int clk_core_prepare_lock(struct clk_core *core)
> @@ -745,6 +807,9 @@ static void clk_unprepare_unused_subtree(struct clk_core *core)
>         if (core->flags & CLK_IGNORE_UNUSED)
>                 return;
>  
> +       if (clk_pm_runtime_get(core))
> +               return;
> +
>         if (clk_core_is_prepared(core)) {
>                 trace_clk_unprepare(core);
>                 if (core->ops->unprepare_unused)
> @@ -753,6 +818,8 @@ static void clk_unprepare_unused_subtree(struct clk_core *core)
>                         core->ops->unprepare(core->hw);
>                 trace_clk_unprepare_complete(core);
>         }
> +
> +       clk_pm_runtime_put(core);
>  }
>  
>  static void clk_disable_unused_subtree(struct clk_core *core)
> @@ -768,6 +835,9 @@ static void clk_disable_unused_subtree(struct clk_core *core)
>         if (core->flags & CLK_OPS_PARENT_ENABLE)
>                 clk_core_prepare_enable(core->parent);
>  
> +       if (clk_pm_runtime_get(core))
> +               goto unprepare_out;
> +
>         flags = clk_enable_lock();
>  
>         if (core->enable_count)
> @@ -792,6 +862,8 @@ static void clk_disable_unused_subtree(struct clk_core *core)
>  
>  unlock_out:
>         clk_enable_unlock(flags);
> +       clk_pm_runtime_put(core);
> +unprepare_out:
>         if (core->flags & CLK_OPS_PARENT_ENABLE)
>                 clk_core_disable_unprepare(core->parent);
>  }
> @@ -1036,9 +1108,13 @@ long clk_get_accuracy(struct clk *clk)
>  static unsigned long clk_recalc(struct clk_core *core,
>                                 unsigned long parent_rate)
>  {
> -       if (core->ops->recalc_rate)
> -               return core->ops->recalc_rate(core->hw, parent_rate);
> -       return parent_rate;
> +       unsigned long rate = parent_rate;
> +
> +       if (core->ops->recalc_rate && !clk_pm_runtime_get(core)) {
> +               rate = core->ops->recalc_rate(core->hw, parent_rate);
> +               clk_pm_runtime_put(core);
> +       }
> +       return rate;
>  }
>  
>  /**
> @@ -1563,6 +1639,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>  {
>         struct clk_core *top, *fail_clk;
>         unsigned long rate = req_rate;
> +       int ret = 0;
>  
>         if (!core)
>                 return 0;
> @@ -1579,21 +1656,28 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>         if (!top)
>                 return -EINVAL;
>  
> +       ret = clk_pm_runtime_get(core);
> +       if (ret)
> +               return ret;
> +
>         /* notify that we are about to change rates */
>         fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
>         if (fail_clk) {
>                 pr_debug("%s: failed to set %s rate\n", __func__,
>                                 fail_clk->name);
>                 clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
> -               return -EBUSY;
> +               ret = -EBUSY;
> +               goto err;
>         }
>  
>         /* change the rates */
>         clk_change_rate(top);
>  
>         core->req_rate = req_rate;
> +err:
> +       clk_pm_runtime_put(core);
>  
> -       return 0;
> +       return ret;
>  }
>  
>  /**
> @@ -1824,12 +1908,16 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
>                 p_rate = parent->rate;
>         }
>  
> +       ret = clk_pm_runtime_get(core);
> +       if (ret)
> +               goto out;
> +
>         /* propagate PRE_RATE_CHANGE notifications */
>         ret = __clk_speculate_rates(core, p_rate);
>  
>         /* abort if a driver objects */
>         if (ret & NOTIFY_STOP_MASK)
> -               goto out;
> +               goto runtime_put;
>  
>         /* do the re-parent */
>         ret = __clk_set_parent(core, parent, p_index);
> @@ -1842,6 +1930,8 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
>                 __clk_recalc_accuracies(core);
>         }
>  
> +runtime_put:
> +       clk_pm_runtime_put(core);
>  out:
>         clk_prepare_unlock();
>  
> @@ -2549,6 +2639,12 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>                 goto fail_name;
>         }
>         core->ops = hw->init->ops;
> +       if (dev && pm_runtime_enabled(dev)) {
> +               core->dev = dev;
> +               ret = clk_pm_runtime_get(core);
> +               if (ret)
> +                       goto fail_pm;
> +       }
>         if (dev && dev->driver)
>                 core->owner = dev->driver->owner;
>         core->hw = hw;
> @@ -2595,12 +2691,13 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>         }
>  
>         ret = __clk_core_init(core);
> -       if (!ret)
> +       if (!ret) {
> +               clk_pm_runtime_put(core);
>                 return hw->clk;
> +       }
>  
>         __clk_free_clk(hw->clk);
>         hw->clk = NULL;
> -
>  fail_parents:
>         kfree(core->parents);
>  fail_parent_names_copy:
> @@ -2608,6 +2705,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>                 kfree_const(core->parent_names[i]);
>         kfree(core->parent_names);
>  fail_parent_names:
> +       clk_pm_runtime_put(core);
> +fail_pm:
>         kfree_const(core->name);
>  fail_name:
>         kfree(core);
> -- 
> 1.9.1
> 
