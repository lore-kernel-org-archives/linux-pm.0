From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFT/RFC][PATCH] driver core: Fix PM-runtime for links added
 during consumer probe
Date: Tue, 19 Feb 2019 13:10:19 +0100
Message-ID: <CAPDyKFrZ8Miy9A2wFksJLxePk+O05NtEmf58Q-8BqDdZ7kL7AQ@mail.gmail.com>
References: <14371356.imFjPFOrCi@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14371356.imFjPFOrCi@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jon Hunter <jonathanh@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Feb 2019 at 23:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
> counter imbalance") introduced a regression that causes suppliers
> to be suspended prematurely for device links added during consumer
> driver probe if the initial PM-runtime status of the consumer is
> "suspended" and the consumer is resumed after adding the link and
> before pm_runtime_put_suppliers() is called.  In that case,
> pm_runtime_put_suppliers() will drop the rpm_active refcount for
> the link by one and (since rpm_active is equal to two after the
> preceding consumer resume) the supplier's PM-runtime usage counter
> will be decremented, which may cause the supplier to suspend even
> though the consumer's PM-runtime status is "active".

Just to confirm, this is the behavior that I see as well.

However, I am a bit a surprised on my side, that I did not run this
particular test sequence earlier. Sorry about that!

>
> For this reason, partially revert commit 4c06c4e6cf63 as the problem
> it tried to fix needs to be addressed somewhat differently, and
> change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
> that the latter only drops rpm_active references acquired by the
> former.  [This requires adding a new field to struct device_link,
> but I coulnd't find a cleaner way to address the issue that would
> work in all cases.]
>
> Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Besides validating the fix, I can confirm device link add/removal
during probe works fine, as before.

I also tested the runtime PM autosuspend (several seconds timeout)
together with DL_FLAG_RPM_ACTIVE - it's working fine! During this
test, the rpm_active count reaches 3 after probe and the supplier's
usage count reaches 2. When the consumer becomes runtime suspended,
after the timeout, these "counts" becomes decremented to 1 and 0, so
the supplier also becomes runtime suspended.

Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks and kind regards
Uffe

> ---
>
> On top of driver-core/driver-core-next.
>
> Jon, Ulf, please test!
>
> ---
>  drivers/base/core.c          |    4 ++--
>  drivers/base/power/runtime.c |   29 ++++++-----------------------
>  include/linux/device.h       |    1 +
>  include/linux/pm_runtime.h   |    4 ----
>  4 files changed, 9 insertions(+), 29 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -277,7 +277,7 @@ struct device_link *device_link_add(stru
>                                 link->flags |= DL_FLAG_PM_RUNTIME;
>                         }
>                         if (flags & DL_FLAG_RPM_ACTIVE)
> -                               pm_runtime_active_link(link, supplier);
> +                               refcount_inc(&link->rpm_active);
>                 }
>
>                 if (flags & DL_FLAG_STATELESS) {
> @@ -310,7 +310,7 @@ struct device_link *device_link_add(stru
>
>         if (flags & DL_FLAG_PM_RUNTIME) {
>                 if (flags & DL_FLAG_RPM_ACTIVE)
> -                       pm_runtime_active_link(link, supplier);
> +                       refcount_inc(&link->rpm_active);
>
>                 pm_runtime_new_link(consumer);
>         }
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1656,6 +1656,7 @@ void pm_runtime_get_suppliers(struct dev
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
>                 if (link->flags & DL_FLAG_PM_RUNTIME) {
> +                       link->supplier_preactivated = true;
>                         refcount_inc(&link->rpm_active);
>                         pm_runtime_get_sync(link->supplier);
>                 }
> @@ -1675,9 +1676,11 @@ void pm_runtime_put_suppliers(struct dev
>         idx = device_links_read_lock();
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> -               if (link->flags & DL_FLAG_PM_RUNTIME &&
> -                   refcount_dec_not_one(&link->rpm_active))
> -                       pm_runtime_put(link->supplier);
> +               if (link->supplier_preactivated) {
> +                       link->supplier_preactivated = false;
> +                       if (refcount_dec_not_one(&link->rpm_active))
> +                               pm_runtime_put(link->supplier);
> +               }
>
>         device_links_read_unlock(idx);
>  }
> @@ -1689,26 +1692,6 @@ void pm_runtime_new_link(struct device *
>         spin_unlock_irq(&dev->power.lock);
>  }
>
> -/**
> - * pm_runtime_active_link - Set up new device link as active for PM-runtime.
> - * @link: Device link to be set up as active.
> - * @supplier: Supplier end of the link.
> - *
> - * Add 2 to the rpm_active refcount of @link and increment the PM-runtime
> - * usage counter of @supplier once more in case the link is being added while
> - * the consumer driver is probing and pm_runtime_put_suppliers() will be called
> - * subsequently.
> - *
> - * Note that this doesn't prevent rpm_put_suppliers() from decreasing the link's
> - * rpm_active refcount down to one, so runtime suspend of the consumer end of
> - * @link is not affected.
> - */
> -void pm_runtime_active_link(struct device_link *link, struct device *supplier)
> -{
> -       refcount_add(2, &link->rpm_active);
> -       pm_runtime_get_noresume(supplier);
> -}
> -
>  void pm_runtime_drop_link(struct device *dev)
>  {
>         spin_lock_irq(&dev->power.lock);
> Index: linux-pm/include/linux/device.h
> ===================================================================
> --- linux-pm.orig/include/linux/device.h
> +++ linux-pm/include/linux/device.h
> @@ -861,6 +861,7 @@ struct device_link {
>  #ifdef CONFIG_SRCU
>         struct rcu_head rcu_head;
>  #endif
> +       bool supplier_preactivated; /* Owned by consumer probe. */
>  };
>
>  /**
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -59,8 +59,6 @@ extern void pm_runtime_clean_up_links(st
>  extern void pm_runtime_get_suppliers(struct device *dev);
>  extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
> -extern void pm_runtime_active_link(struct device_link *link,
> -                                  struct device *supplier);
>  extern void pm_runtime_drop_link(struct device *dev);
>
>  static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
> @@ -180,8 +178,6 @@ static inline void pm_runtime_clean_up_l
>  static inline void pm_runtime_get_suppliers(struct device *dev) {}
>  static inline void pm_runtime_put_suppliers(struct device *dev) {}
>  static inline void pm_runtime_new_link(struct device *dev) {}
> -static inline void pm_runtime_active_link(struct device_link *link,
> -                                         struct device *supplier) {}
>  static inline void pm_runtime_drop_link(struct device *dev) {}
>
>  #endif /* !CONFIG_PM */
>
