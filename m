From: "dbasehore ." <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4 2/5] irqchip/gic-v3-its: add ability to save/restore
 ITS state
Date: Mon, 5 Feb 2018 13:33:50 -0800
Message-ID: <CAGAzgsp8M-t7k+pj4G9Lo_+NkeXQ9DeqH_r=-JcErO_+HuoJqA@mail.gmail.com>
References: <20180203012450.18378-1-dbasehore@chromium.org>
 <20180203012450.18378-3-dbasehore@chromium.org> <a1b81cab-8e73-2c6f-13e6-612ffc668923@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a1b81cab-8e73-2c6f-13e6-612ffc668923-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Soby Mathew <Soby.Mathew-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-pm mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 5, 2018 at 7:56 AM, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org> wrote:
> On 03/02/18 01:24, Derek Basehore wrote:
>> Some platforms power off GIC logic in suspend, so we need to
>> save/restore state. The distributor and redistributor registers need
>> to be handled in platform code due to access permissions on those
>> registers, but the ITS registers can be restored in the kernel.
>>
>> Signed-off-by: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 101 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 06f025fd5726..e13515cdb68f 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -33,6 +33,7 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/percpu.h>
>>  #include <linux/slab.h>
>> +#include <linux/syscore_ops.h>
>>
>>  #include <linux/irqchip.h>
>>  #include <linux/irqchip/arm-gic-v3.h>
>> @@ -46,6 +47,7 @@
>>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING                (1ULL << 0)
>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375    (1ULL << 1)
>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144    (1ULL << 2)
>> +#define ITS_FLAGS_SAVE_SUSPEND_STATE         (1ULL << 3)
>>
>>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING  (1 << 0)
>>
>> @@ -83,6 +85,15 @@ struct its_baser {
>>       u32             psz;
>>  };
>>
>> +/*
>> + * Saved ITS state - this is where saved state for the ITS is stored
>> + * when it's disabled during system suspend.
>> + */
>> +struct its_ctx {
>> +     u64                     cbaser;
>> +     u32                     ctlr;
>> +};
>
> Nit: This is pretty small for the ITS context. Given that its_node is
> the context, you can safely expand this in the its_node structure.

Sounds reasonable. I think I just have it this way because I used to
have more in here.

>
>> +
>>  struct its_device;
>>
>>  /*
>> @@ -101,6 +112,7 @@ struct its_node {
>>       struct its_collection   *collections;
>>       struct fwnode_handle    *fwnode_handle;
>>       u64                     (*get_msi_base)(struct its_device *its_dev);
>> +     struct its_ctx          its_ctx;
>>       struct list_head        its_device_list;
>>       u64                     flags;
>>       unsigned long           list_nr;
>> @@ -3042,6 +3054,90 @@ static void its_enable_quirks(struct its_node *its)
>>       gic_enable_quirks(iidr, its_quirks, its);
>>  }
>>
>> +static int its_save_disable(void)
>> +{
>> +     struct its_node *its;
>> +     int err = 0;
>> +
>> +     spin_lock(&its_lock);
>> +     list_for_each_entry(its, &its_nodes, entry) {
>> +             struct its_ctx *ctx;
>> +             void __iomem *base;
>> +
>> +             if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
>> +                     continue;
>> +
>> +             ctx = &its->its_ctx;
>> +             base = its->base;
>> +             ctx->ctlr = readl_relaxed(base + GITS_CTLR);
>> +             err = its_force_quiescent(base);
>> +             if (err) {
>> +                     pr_err("ITS failed to quiesce\n");
>> +                     writel_relaxed(ctx->ctlr, base + GITS_CTLR);
>> +                     goto err;
>> +             }
>> +
>> +             ctx->cbaser = gits_read_cbaser(base + GITS_CBASER);
>> +     }
>> +
>> +err:
>> +     if (err) {
>> +             list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
>> +                     if (its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE) {
>> +                             struct its_ctx *ctx = &its->its_ctx;
>> +                             void __iomem *base = its->base;
>> +
>> +                             writel_relaxed(ctx->ctlr, base + GITS_CTLR);
>> +                     }
>> +             }
>> +     }
>> +
>> +     spin_unlock(&its_lock);
>> +
>> +     return err;
>> +}
>> +
>> +static void its_restore_enable(void)
>> +{
>> +     struct its_node *its;
>> +
>> +     spin_lock(&its_lock);
>> +     list_for_each_entry(its, &its_nodes, entry) {
>> +             if (its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE) {
>> +                     struct its_ctx *ctx = &its->its_ctx;
>> +                     void __iomem *base = its->base;
>> +                     /*
>> +                      * Only the lower 32 bits matter here since the upper 32
>> +                      * don't include any of the offset.
>> +                      */
>> +                     u32 creader = readl_relaxed(base + GITS_CREADR);
>
> Accessor matching gits_write_cwriter and co?
>
>> +                     int i;
>> +
>> +                     /*
>> +                      * Reset the write location to where the ITS is
>> +                      * currently at.
>> +                      */
>> +                     gits_write_cbaser(ctx->cbaser, base + GITS_CBASER);
>> +                     gits_write_cwriter(creader, base + GITS_CWRITER);
>> +                     its->cmd_write = &its->cmd_base[
>> +                             creader / sizeof(struct its_cmd_block)];
>
> Nit: please do not split lines like this, this is unreadable. We both
> have screens that are wide enough for this to fit on a single line.
>
> More importantly: Why isn't it sufficient to reset both CREADR and
> CWRITER to zero? Is there any case where you can suspend whilst having
> anything in flight?

CREADR is RO and we need to handle the non-zero case. I was planning
on getting rid of the write to CWRITER since it shouldn't be needed.
Either CREADR and CWRITER have the prior values, or both are reset to
0.

>
>> +                     /* Restore GITS_BASER from the value cache. */
>> +                     for (i = 0; i < GITS_BASER_NR_REGS; i++) {
>> +                             struct its_baser *baser = &its->tables[i];
>> +
>> +                             its_write_baser(its, baser, baser->val);
>
> You may want to first test that this BASER register is actually
> requiring something before writing to it. Yes, this is normally safe.
> But HW is also normally broken.
>
>> +                     }
>> +                     writel_relaxed(ctx->ctlr, base + GITS_CTLR);
>
> Before restoring all of this, shouldn't you first test that the ITS is
> actually in a disabled state?

The save_disable code put it in a disabled state. The reset state is
also disabled. I don't expect PSCI to change the GITS_CTLR register at
all. Are you expecting something on the other side of the PSCI layer
to poke this register? We'd probably want to force disable at the
start of restore_enable if so.

>
>> +             }
>> +     }
>> +     spin_unlock(&its_lock);
>> +}
>> +
>> +static struct syscore_ops its_syscore_ops = {
>> +     .suspend = its_save_disable,
>> +     .resume = its_restore_enable,
>> +};
>> +
>>  static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>>  {
>>       struct irq_domain *inner_domain;
>> @@ -3261,6 +3357,9 @@ static int __init its_probe_one(struct resource *res,
>>               ctlr |= GITS_CTLR_ImDe;
>>       writel_relaxed(ctlr, its->base + GITS_CTLR);
>>
>> +     if (fwnode_property_present(handle, "reset-on-suspend"))
>> +             its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
>> +
>>       err = its_init_domain(handle, its);
>>       if (err)
>>               goto out_free_tables;
>> @@ -3515,5 +3614,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>>               }
>>       }
>>
>> +     register_syscore_ops(&its_syscore_ops);
>> +
>>       return 0;
>>  }
>>
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

Thanks for the review.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
