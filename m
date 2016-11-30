From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3
 thermal driver
Date: Tue, 29 Nov 2016 21:16:38 -0800
Message-ID: <20161130051637.GA27252@localhost.localdomain>
References: <20161128210924.2921-1-wsa+renesas@sang-engineering.com>
 <20161128210924.2921-3-wsa+renesas@sang-engineering.com>
 <20161129020652.GA3701@localhost.localdomain>
 <20161129083241.GA1458@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161129083241.GA1458@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org

Hey,

On Tue, Nov 29, 2016 at 09:32:42AM +0100, Wolfram Sang wrote:
> Hi Eduardo,
> 
> > No commit message ? :-( generally speaking here, it is a good practice
> > to describe what you are doing, what you have considered, and what you
> > have tested, just for the sake of code history/documentation.
> 
> OK, can do.

cool!

> 
> > > +	spin_lock_irqsave(&tsc->lock, flags);
> > 
> > Why do you need a full blown spin lock irqsave? Can this locking be
> > solved by a simple mutex?
> 
> Currently, it can be a mutex, yes. This is a "left-over" from the
> version which had interrupt support. I am not fully done with
> refactoring the irqs, but I thought it is likely we need this lock then
> again, so I chose to leave it. I can use a mutex for now if you prefer.

yes, yield the processor when possible, please. So, if your locking
don't really need to disable IRQs, then avoid doing it. If a mutex is
enough, use it.

> 
> > 
> > > +static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&tsc->lock, flags);
> > > +
> > > +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
> > > +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
> > > +
> > > +	udelay(1000);
> > 
> > Why do you disable irqs, then busyloop for 1ms?
> 
> Uh yes, this is ugly. I don't think we need to lock during init, but
> I'll double check later.
> 

OK. You could probably leave the (mutex) lock, if you think you need it.
But also consider using usleep_range(1000) instead. Have a look at:
Documentation/timers/timers-howto.txt

for a better explanation.


> > > +	/* default values if FUSEs are missing */
> > > +	int ptat[3] = { 2351, 1509, 435 };
> > > +	int thcode[TSC_MAX_NUM][3] = {
> > > +		{ 3248, 2800, 2221 },
> > > +		{ 3245, 2795, 2216 },
> > > +		{ 3250, 2805, 2237 },
> > > +	};
> > 
> > are these fuses valid for both? 7796 and 7797? or would you need a
> > different array for each version?
> 
> According to the information I have today, it is the same array. And all
> later versions are promised to have fuse registers. This is already
> documented, but such HW is not available to me currently.
> 

Ok. If you have the confirmation for that, then it is fine. I just asked
because cases I saw (different manufacturer of course) would have different values
to be programmed, depending on the chip version.

Anyways, just checking.

> Thanks for the quick review, very much appreciated!
> 
>    Wolfram
> 
