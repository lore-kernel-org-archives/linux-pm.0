From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 4/8] irqchip/gic-v3: add ability to save/restore GIC/ITS
 state
Date: Thu, 18 Jan 2018 15:33:05 -0800
Message-ID: <20180118233243.GA209323@google.com>
References: <20180112212422.148625-1-dbasehore@chromium.org>
 <20180112212422.148625-5-dbasehore@chromium.org>
 <86fu79fx3n.wl-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37568 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbeARXdJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jan 2018 18:33:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id p1so15929738pfh.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2018 15:33:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <86fu79fx3n.wl-marc.zyngier@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, Sudeep Holla <sudeep.holla@arm.com>

Hi,

On Sat, Jan 13, 2018 at 06:10:52PM +0000, Marc Zyngier wrote:
> On Fri, 12 Jan 2018 21:24:18 +0000,
> Derek Basehore wrote:
> > 
> > Some platforms power off GIC logic in S3, so we need to save/restore
> 
> S3 is a not a GIC concept, and is only vaguely mentioned in terms of
> the rk3399 silicon, if grep serves me right. Please expand on what
> state this is exactly.
> 
> > state. This adds a DT-binding to save/restore the GICD/GICR/GITS
> > states using the new CPU_PM_SYSTEM_ENTER/EXIT CPU PM states.
> 
> DT binding? I can't see any in this patch.
> 
> > 
> > Change-Id: I1fb2117296373fa67397fdd4a8960077b241462e
> 
> It's been mentioned somewhere else in the thread: these tags have no
> purpose in the kernel. Please sanitise your patches before posting them.
> 
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> Who is the author of this patch? If that's a joined authorship, please
> use the Co-Developed-by: tag.

I only did some minimal code shuffling when rebasing and working with
this code in our downstream tree. I probably didn't actually need to
apply my Signed-off-by at the time, but Derek carried it along anyway.

Derek is the author, and I'd be perfectly fine dropping my S-o-b from
these patches.

> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 9a7a15049903..95d37fb6f458 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c

...

> > @@ -991,11 +1188,99 @@ static const struct irq_domain_ops partition_domain_ops = {
> >  	.select = gic_irq_domain_select,
> >  };
> >  
> > +static int gic_populate_ctx(struct gic_dist_ctx *ctx, int irqs)
> 
> This isn't the GIC context. This is the save area. Please name the
> function accordingly.
> 
> > +{
> > +	int err;
> > +
> > +	ctx->irouter = kcalloc(GICD_NR_REGS(IROUTER, irqs),
> > +			       sizeof(*ctx->irouter), GFP_KERNEL);
> > +	if (IS_ERR(ctx->irouter))
> > +		return PTR_ERR(ctx->irouter);
> > +
> > +	ctx->igroupr = kcalloc(GICD_NR_REGS(IGROUPR, irqs),
> > +			       sizeof(*ctx->igroupr), GFP_KERNEL);
> > +	if (IS_ERR(ctx->igroupr)) {
> > +		err = PTR_ERR(ctx->igroupr);
> > +		goto out_irouter;
> > +	}
> > +
> > +	ctx->isenabler = kcalloc(GICD_NR_REGS(ISENABLER, irqs),
> > +				 sizeof(*ctx->isenabler), GFP_KERNEL);
> > +	if (IS_ERR(ctx->isenabler)) {
> > +		err = PTR_ERR(ctx->isenabler);
> > +		goto out_igroupr;
> > +	}
> > +
> > +	ctx->ispendr = kcalloc(GICD_NR_REGS(ISPENDR, irqs),
> > +			       sizeof(*ctx->ispendr), GFP_KERNEL);
> > +	if (IS_ERR(ctx->ispendr)) {
> > +		err = PTR_ERR(ctx->ispendr);
> > +		goto out_isenabler;
> > +	}
> > +
> > +	ctx->isactiver = kcalloc(GICD_NR_REGS(ISACTIVER, irqs),
> > +				 sizeof(*ctx->isactiver), GFP_KERNEL);
> > +	if (IS_ERR(ctx->isactiver)) {
> > +		err = PTR_ERR(ctx->isactiver);
> > +		goto out_ispendr;
> > +	}
> > +
> > +	ctx->ipriorityr = kcalloc(GICD_NR_REGS(IPRIORITYR, irqs),
> > +				  sizeof(*ctx->ipriorityr), GFP_KERNEL);
> > +	if (IS_ERR(ctx->ipriorityr)) {
> > +		err = PTR_ERR(ctx->ipriorityr);
> > +		goto out_isactiver;
> > +	}
> > +
> > +	ctx->icfgr = kcalloc(GICD_NR_REGS(ICFGR, irqs), sizeof(*ctx->icfgr),
> > +			     GFP_KERNEL);
> > +	if (IS_ERR(ctx->icfgr)) {
> > +		err = PTR_ERR(ctx->icfgr);
> > +		goto out_ipriorityr;
> > +	}
> > +
> > +	ctx->igrpmodr = kcalloc(GICD_NR_REGS(IGRPMODR, irqs),
> > +				sizeof(*ctx->igrpmodr), GFP_KERNEL);
> > +	if (IS_ERR(ctx->igrpmodr)) {
> > +		err = PTR_ERR(ctx->igrpmodr);
> > +		goto out_icfgr;
> > +	}
> > +
> > +	ctx->nsacr = kcalloc(GICD_NR_REGS(NSACR, irqs), sizeof(*ctx->nsacr),
> > +			     GFP_KERNEL);
> > +	if (IS_ERR(ctx->nsacr)) {
> > +		err = PTR_ERR(ctx->nsacr);
> > +		goto out_igrpmodr;
> > +	}
> > +
> > +	return 0;
> > +
> > +out_irouter:
> > +	kfree(ctx->irouter);
> > +out_igroupr:
> > +	kfree(ctx->igroupr);
> > +out_isenabler:
> > +	kfree(ctx->isenabler);
> > +out_ispendr:
> > +	kfree(ctx->ispendr);
> > +out_isactiver:
> > +	kfree(ctx->isactiver);
> > +out_ipriorityr:
> > +	kfree(ctx->ipriorityr);
> > +out_icfgr:
> > +	kfree(ctx->icfgr);
> > +out_igrpmodr:
> > +	kfree(ctx->igrpmodr);
> 
> WHy do you need all of these labels? Can't you just branch to an error
> one and free them all in one go?

If you assume that the memory was initially all zero (which it is --
kzalloc()), then you can get away with a single error label (kfree(0) is
a no-op). But otherwise, this is the right way to do error handling...

> In the end, what is the point of
> keeping almost all of them if the last allocation fails?

I didn't understand this question until I realized that the error
handling is all accidentally done in reverse. If we fail the last
allocation, we should be freeing all but the last one. But this code
actually only frees 1 bit of memory in that case (i.e., a memory leak).

> > +	return err;
> > +}
> > +
> >  static int __init gic_init_bases(void __iomem *dist_base,
> >  				 struct redist_region *rdist_regs,
> >  				 u32 nr_redist_regions,
> >  				 u64 redist_stride,
> > -				 struct fwnode_handle *handle)
> > +				 struct fwnode_handle *handle,
> > +				 struct gic_dist_ctx *gicd_ctx,
> > +				 struct gic_redist_ctx *gicr_ctx)
> >  {
> >  	u32 typer;
> >  	int gic_irqs;

...

> > @@ -1232,17 +1527,35 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
> >  	if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
> >  		redist_stride = 0;
> >  
> > +	if (of_property_read_bool(node, "save-suspend-state")) {
> > +		gicd_ctx = kzalloc(sizeof(*gicd_ctx), GFP_KERNEL);
> > +		if (IS_ERR(gicd_ctx)) {
> > +			err = PTR_ERR(gicd_ctx);
> > +			goto out_unmap_rdist;
> > +		}
> > +
> > +		gicr_ctx = kcalloc(num_possible_cpus(), sizeof(*gicr_ctx),
> > +				   GFP_KERNEL);
> 
> Since this is a per-cpu allocation, why isn't this a per-cpu
> allocation? In other words, why isn't the GICR save area allocated as
> CPUs get matched against their redistributors instead?
> 
> > +		if (IS_ERR(gicr_ctx)) {
> > +			err = PTR_ERR(gicr_ctx);
> > +			goto out_free_gicd_ctx;
> > +		}
> > +	}
> 
> You really want to kill the box because something went wrong in your
> save area allocation? It doesn't feel quite right.

Isn't that what all drivers (including irqchip drivers) do on failed
allocations? What else would we do? Pretend that we can limp along and
just b0rk the system when it suspends?

Brian
