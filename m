From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] PM / clk: Add support for obtaining clocks from device-tree
Date: Wed, 9 Mar 2016 15:04:56 +0100
Message-ID: <CAJZ5v0iEo=jj+T-0bQypxs8VTb7kPpczSRu+8-+F7oyRMk9nSA@mail.gmail.com>
References: <1457529213-2581-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34623 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbcCIOE6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 09:04:58 -0500
In-Reply-To: <1457529213-2581-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org

On Wed, Mar 9, 2016 at 2:13 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> The PM clocks framework requires clients to pass either a con-id or a
> valid clk pointer in order to add a clock to a device. Add a new
> function of_pm_clk_add_clks() to allows device clocks to be retrieved
> from device-tree and populated for a given device. Note that
> of_clk_get_from_provider() is not defined if CONFIG_OF and
> CONFIG_COMMON_CLK are not selected. Therefore, make of_pm_clk_add_clks()
> dependent on these options.
>
> An optional function pointer may be passed to of_pm_clk_add_clks() that
> can be used to filter the clocks that are added for a device when
> calling of_pm_clk_add_clks().
>
> In order to handle errors encountered when adding clocks from
> device-tree, add a function pm_clk_remove_clk() to remove any clocks
> (using a pointer to the clk structure) that have been added
> successfully before the error occurred.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>
> Changes v1-v2:
> - Added support for optional filter function as suggested by Geert U.

I'd like to get an ACK on this from someone more familiar with the DT
stuff than I am.

Thanks,
Rafael


>  drivers/base/power/clock_ops.c | 109 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_clock.h       |  16 ++++++
>  2 files changed, 125 insertions(+)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 272a52ebafc0..0c2213145b4a 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -137,6 +137,82 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
>         return __pm_clk_add(dev, NULL, clk);
>  }
>
> +
> +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> +/**
> + * of_pm_clk_add_clks - Start using device clock(s) for power management.
> + * @dev: Device whose clock(s) is going to be used for power management.
> + * @of_pm_clk_filter: Optional function for filtering clocks
> + *
> + * Add a series of clocks described in the 'clocks' device-tree node for
> + * a device to the list of clocks used for the power management of @dev.
> + * If 'of_pm_clk_filter' is specified, then this filter function will be
> + * called for each clock found and the clock will be added to the list
> + * of clocks if this function returns true. Return success if clocks are
> + * added successfully and return a negative error code if adding a clock
> + * fails or there are no clocks that match with the filter function.
> + */
> +int of_pm_clk_add_clks(struct device *dev,
> +                      bool (*of_pm_clk_filter)(struct of_phandle_args *args))
> +{
> +       struct of_phandle_args clkspec;
> +       struct clk **clks;
> +       unsigned int i, count, added = 0;
> +       int ret;
> +
> +       if (!dev || !dev->of_node)
> +               return -EINVAL;
> +
> +       count = of_count_phandle_with_args(dev->of_node, "clocks",
> +                                          "#clock-cells");
> +       if (count == 0)
> +               return -ENODEV;
> +
> +       clks = kcalloc(count, sizeof(*clks), GFP_KERNEL);
> +       if (!clks)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < count; i++) {
> +               if (of_parse_phandle_with_args(dev->of_node, "clocks",
> +                                              "#clock-cells", i, &clkspec))
> +                       goto error;
> +
> +               if (of_pm_clk_filter && !of_pm_clk_filter(&clkspec)) {
> +                       of_node_put(clkspec.np);
> +                       continue;
> +               }
> +
> +               clks[added] = of_clk_get_from_provider(&clkspec);
> +               of_node_put(clkspec.np);
> +
> +               if (IS_ERR(clks[added])) {
> +                       ret = PTR_ERR(clks[added]);
> +                       goto error;
> +               }
> +
> +               ret = pm_clk_add_clk(dev, clks[added]);
> +               if (ret) {
> +                       clk_put(clks[added]);
> +                       goto error;
> +               }
> +
> +               added++;
> +       }
> +
> +       kfree(clks);
> +
> +       return added ? 0 : -ENODEV;
> +
> +error:
> +       while (added--)
> +               pm_clk_remove_clk(dev, clks[added]);
> +
> +       kfree(clks);
> +
> +       return ret;
> +}
> +#endif /* CONFIG_OF && CONFIG_COMMON_CLK */
> +
>  /**
>   * __pm_clk_remove - Destroy PM clock entry.
>   * @ce: PM clock entry to destroy.
> @@ -198,6 +274,39 @@ void pm_clk_remove(struct device *dev, const char *con_id)
>  }
>
>  /**
> + * pm_clk_remove_clk - Stop using a device clock for power management.
> + * @dev: Device whose clock should not be used for PM any more.
> + * @clk: Clock pointer
> + *
> + * Remove the clock pointed to by @clk from the list of clocks used for
> + * the power management of @dev.
> + */
> +void pm_clk_remove_clk(struct device *dev, struct clk *clk)
> +{
> +       struct pm_subsys_data *psd = dev_to_psd(dev);
> +       struct pm_clock_entry *ce;
> +
> +       if (!psd || !clk)
> +               return;
> +
> +       spin_lock_irq(&psd->lock);
> +
> +       list_for_each_entry(ce, &psd->clock_list, node) {
> +               if (clk == ce->clk)
> +                       goto remove;
> +       }
> +
> +       spin_unlock_irq(&psd->lock);
> +       return;
> +
> + remove:
> +       list_del(&ce->node);
> +       spin_unlock_irq(&psd->lock);
> +
> +       __pm_clk_remove(ce);
> +}
> +
> +/**
>   * pm_clk_init - Initialize a device's list of power management clocks.
>   * @dev: Device to initialize the list of PM clocks for.
>   *
> diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
> index 25266c600021..3aa5ad57067a 100644
> --- a/include/linux/pm_clock.h
> +++ b/include/linux/pm_clock.h
> @@ -11,6 +11,7 @@
>
>  #include <linux/device.h>
>  #include <linux/notifier.h>
> +#include <linux/of.h>
>
>  struct pm_clk_notifier_block {
>         struct notifier_block nb;
> @@ -43,6 +44,7 @@ extern void pm_clk_destroy(struct device *dev);
>  extern int pm_clk_add(struct device *dev, const char *con_id);
>  extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
>  extern void pm_clk_remove(struct device *dev, const char *con_id);
> +extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
>  extern int pm_clk_suspend(struct device *dev);
>  extern int pm_clk_resume(struct device *dev);
>  #else
> @@ -74,6 +76,9 @@ static inline void pm_clk_remove(struct device *dev, const char *con_id)
>  }
>  #define pm_clk_suspend NULL
>  #define pm_clk_resume  NULL
> +static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk)
> +{
> +}
>  #endif
>
>  #ifdef CONFIG_HAVE_CLK
> @@ -86,4 +91,15 @@ static inline void pm_clk_add_notifier(struct bus_type *bus,
>  }
>  #endif
>
> +#if defined(CONFIG_PM_CLK) && defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> +extern int of_pm_clk_add_clks(struct device *dev,
> +               bool (*of_pm_clk_filter)(struct of_phandle_args *args));
> +#else
> +static inline int of_pm_clk_add_clks(struct device *dev,
> +               bool (*of_pm_clk_filter)(struct of_phandle_args *args))
> +{
> +       return -EINVAL;
> +}
> +#endif
> +
>  #endif
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
