From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Mon, 18 Jan 2016 15:47:56 +0100
Message-ID: <CAPDyKFqZK4HYWgXam63=eCKAWsjwCiQbT5jdmgjqid_er3Sg1g@mail.gmail.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
	<1450349309-8107-4-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450349309-8107-4-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

+linux-pm, Rafael

On 17 December 2015 at 11:48, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Some IRQ chips may be located in a power domain outside of the CPU
> subsystem and hence will require device specific runtime power management.
> In order to support such IRQ chips, add a pointer for a device structure
> to the irq_chip structure, and if this pointer is populated by the IRQ
> chip driver and the flag CHIP_HAS_RPM is set, then the pm_runtime_get/put
> APIs for this chip will be called when an IRQ is requested/freed,
> respectively.

Overall I like the idea of this patch(set), as it will allow us to
save power for "unused" irqchips.

>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  include/linux/irq.h    |  4 ++++
>  kernel/irq/internals.h | 24 ++++++++++++++++++++++++
>  kernel/irq/manage.c    |  7 +++++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 3c1c96786248..7a61a7f76177 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -307,6 +307,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>  /**
>   * struct irq_chip - hardware interrupt chip descriptor
>   *
> + * @dev:               pointer to associated device
>   * @name:              name for /proc/interrupts
>   * @irq_startup:       start up the interrupt (defaults to ->enable if NULL)
>   * @irq_shutdown:      shut down the interrupt (defaults to ->disable if NULL)
> @@ -344,6 +345,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>   * @flags:             chip specific flags
>   */
>  struct irq_chip {
> +       struct device   *dev;
>         const char      *name;
>         unsigned int    (*irq_startup)(struct irq_data *data);
>         void            (*irq_shutdown)(struct irq_data *data);
> @@ -399,6 +401,7 @@ struct irq_chip {
>   * IRQCHIP_SKIP_SET_WAKE:      Skip chip.irq_set_wake(), for this irq chip
>   * IRQCHIP_ONESHOT_SAFE:       One shot does not require mask/unmask
>   * IRQCHIP_EOI_THREADED:       Chip requires eoi() on unmask in threaded mode
> + * IRQCHIP_HAS_PM:             Chip requires runtime power management

Perhaps we don't need to add a specific flag for this, but instead
just check if the ->dev pointer has been assigned and then perform
runtime PM management?

>   */
>  enum {
>         IRQCHIP_SET_TYPE_MASKED         = (1 <<  0),
> @@ -408,6 +411,7 @@ enum {
>         IRQCHIP_SKIP_SET_WAKE           = (1 <<  4),
>         IRQCHIP_ONESHOT_SAFE            = (1 <<  5),
>         IRQCHIP_EOI_THREADED            = (1 <<  6),
> +       IRQCHIP_HAS_RPM                 = (1 <<  7),
>  };
>
>  #include <linux/irqdesc.h>
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index fcab63c66905..30a2add7cae6 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -7,6 +7,7 @@
>   */
>  #include <linux/irqdesc.h>
>  #include <linux/kernel_stat.h>
> +#include <linux/pm_runtime.h>
>
>  #ifdef CONFIG_SPARSE_IRQ
>  # define IRQ_BITMAP_BITS       (NR_IRQS + 8196)
> @@ -125,6 +126,29 @@ static inline void chip_bus_sync_unlock(struct irq_desc *desc)
>                 desc->irq_data.chip->irq_bus_sync_unlock(&desc->irq_data);
>  }
>
> +/* Inline functions for support of irq chips that require runtime pm */
> +static inline int chip_pm_get(struct irq_desc *desc)

Why does these new get/put functions need to be inline functions and
thus defined in the header file? Perhaps move them to manage.c are
better?

> +{
> +       int retval = 0;
> +
> +       if (desc->irq_data.chip->dev &&
> +           desc->irq_data.chip->flags & IRQCHIP_HAS_RPM)
> +               retval = pm_runtime_get_sync(desc->irq_data.chip->dev);
> +
> +       return (retval < 0) ? retval : 0;
> +}
> +
> +static inline int chip_pm_put(struct irq_desc *desc)
> +{
> +       int retval = 0;
> +
> +       if (desc->irq_data.chip->dev &&
> +           desc->irq_data.chip->flags & IRQCHIP_HAS_RPM)
> +               retval = pm_runtime_put(desc->irq_data.chip->dev);
> +
> +       return (retval < 0) ? retval : 0;

This won't play nicely when CONFIG_PM is unset, as pm_runtime_put()
would return -ENOSYS. In such cases I guess you would like to ignore
the error!?

> +}
> +
>  #define _IRQ_DESC_CHECK                (1 << 0)
>  #define _IRQ_DESC_PERCPU       (1 << 1)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2a429b061171..8a96e4f1e985 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1116,6 +1116,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>         if (!try_module_get(desc->owner))
>                 return -ENODEV;
>
> +       ret = chip_pm_get(desc);
> +       if (ret < 0)
> +               return ret;
> +
>         new->irq = irq;
>
>         /*
> @@ -1400,6 +1404,7 @@ out_thread:
>                 put_task_struct(t);
>         }
>  out_mput:
> +       chip_pm_put(desc);
>         module_put(desc->owner);
>         return ret;
>  }
> @@ -1513,6 +1518,7 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
>                 }
>         }

I don't think using __free_irq() is the correct place to decrease the
runtime PM usage count. It will keep the irqchip runtime resumed even
if there are no irqs enabled for it.

Instead I would rather allow the irqchip to be runtime suspended, when
there are no irqs enabled on it.

Therefore you should rather use __enable|disable_irq() from where you
increase/decrease the runtime PM usage count.

Although, I realize that may become a bit troublesome as in some of
the execution paths where these functions are invoked, are done while
holding a spinlock with irqs disabled. Invoking pm_runtime_get_sync()
thus leads to that the irqchip's runtime PM callbacks needs to be
irqsafe. Another option is to somehow make use the asynchronous API;
pm_runtime_get() instead.

>
> +       chip_pm_put(desc);
>         module_put(desc->owner);
>         kfree(action->secondary);
>         return action;
> @@ -1799,6 +1805,7 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
>
>         unregister_handler_proc(irq, action);
>
> +       chip_pm_put(desc);
>         module_put(desc->owner);
>         return action;

Kind regards
Uffe
