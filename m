From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 1/5] regulator: Extend the power-management APIs
Date: Tue, 7 Feb 2017 18:06:27 +0100
Message-ID: <20170207180627.29a079a2@bbrezillon>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
        <1480687036-5037-2-git-send-email-boris.brezillon@free-electrons.com>
        <20170109191758.7zzxeh45pvwiw3jo@sirena.org.uk>
        <20170110093355.700f8225@bbrezillon>
        <20170110121026.zstf7a6cflzk366l@sirena.org.uk>
        <20170110140556.172b3ec0@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52073 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754373AbdBGRGs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 12:06:48 -0500
In-Reply-To: <20170110140556.172b3ec0@bbrezillon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Rafael,

Can we have your opinion on this discussion?

To sum-up, we have a suspend ordering issue: we need to suspend a
regulator (by extension all critical regulators) as late as possible to
limit the amount of time the system is running with regulators put in
their suspend state. OTOH, some regulators part of PMICs which are
accessible through I2C, which means we need the I2C controller to be
running to enter the regulator suspend state.

This patch was just proposing to rely on the existing parent<->children
device dependency that controls suspend ordering. But, as noted by
Mark, this does not guarantee that regulator devices enter suspend as
late as possible, thus potentially increasing the amount of time the
system spend in an 'unstable state'.

The question is, how should we handle this case? Can we add some kind
of 'late-suspend' mechanism, and make use of it in the regulator
subsystem?

Any advice would be greatly appreciated.

Thanks,

Boris

P.S.: keeping the existing discussion for the context.

On Tue, 10 Jan 2017 14:05:56 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Tue, 10 Jan 2017 12:10:26 +0000
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Tue, Jan 10, 2017 at 09:33:55AM +0100, Boris Brezillon wrote:  
> > > Mark Brown <broonie@kernel.org> wrote:    
> >   
> > > > However it
> > > > *is* a bit more than just making sure that the device suspend ordering
> > > > is good (though that's definitely part of it), there will be things
> > > > kicked off by hardware signalling without software knowing about it.    
> >   
> > > Do you have an example, so that I can understand the use case?    
> > 
> > Think about how a CPU suspends and signals the PMIC to go into suspend
> > mode - things signalled by hardware state changes that the hardware does
> > autonomously.  
> 
> Got it.
> 
> >   
> > > > Anything that doesn't affect a hardware supported runtime state probably
> > > > needs to be split off and handled separately as that's the much more
> > > > risky bit    
> >   
> > > Just to be sure, you mean regulator devices that do not support the    
> > > ->set_suspend_xx() hooks, right?    
> > 
> > Yes.
> >   
> > > >, moving changing of suspend mode earlier isn't going to cause
> > > > too much grief, that patch should just be split out and can probably
> > > > just go straight in.    
> >   
> > > Yes, I just thought it would be clearer to have everything implemented
> > > in the same function. Since calling ->set_suspend_xx() does not have
> > > any impact on the runtime state, it can be called whenever we want
> > > (assuming we can still communicate with the regulator device to
> > > configure this suspend state).
> > > But if you prefer to have it split out in 2 different function, with the
> > > 'set suspend mode' bits called from the regulator_suspend_begin(), I'm
> > > fine with that.    
> > 
> > No, I'm mainly saying that these things should be done in two separate
> > patches rather than talking about how the end code looks.  To a large
> > extent it does't matter when we apply the hardware supported suspend
> > modes, they won't take effect while software is running anyway.  
> 
> Okay, that shouldn't be a problem then.
> 
> >   
> > > > Requring these functions to be called from every single driver seems
> > > > like we're doing something wrong - if we're going to do this we should
> > > > find some way to loop over all regulators and apply any unapplied
> > > > changes.    
> >   
> > > I agree. Actually, I forgot that we had PM ops at the device class
> > > level. Maybe we could just move these generic ->suspend()/->resume()
> > > implementation here.    
> > 
> > Yeah, I need to check if those class level operations always get run.
> >   
> > > > Batching things up at the end of suspend would also mean that
> > > > we'd be able to minimise the chances that we get the ordering wrong.    
> >   
> > > Unfortunately that's not possible, for the exact same reason calling
> > > regulator_suspend_prepare() from the platform ->prepare() hook did not
> > > work for me: at that point, all devices have been suspended, and this
> > > includes the i2c controller which we're using to communicate with the
> > > PMIC exposing those regulators.    
> > 
> > Do those devices actually get meaningfully suspended on your system,  
> 
> I think so.
> 
> > and
> > even on systems where we do if we are going to use the dependency graphs
> > we should be able to arrange to do something with that to reorder both
> > them and the regulators to as near the end of the queue as we can get
> > tehm - that way we minimise the chances of being bitten by any
> > unexpressed depdencies (which I expect we have a lot of given how
> > resistant people are to writing proper DTs).  
> 
> Yes, maybe we'll need a mechanism to mark some devices for
> late-suspend. I currently don't need it because the runtime changes I'm
> applying are not preventing the system from running correctly:
> increasing the voltage output and moving into low-power mode (the
> reason behind voltage change is probably related to the poor precision
> of the low-power mode, which forces us to take an higher margin to
> prevent voltage from crossing the min constraint of the DDR memory).
> 
> Of course, we should not only take my specific case into account, but
> I'd except people to properly define the dependencies if they really
> need to.
> 
> >   
> > > 2/ Rely on the device model dependency graph, and enter the suspend
> > >    state when the regulator device is being suspended (this is the
> > >    solution I'm proposing in this patch).    
> > 
> > That's future work though (which is happening but still), right now we
> > know the graph doesn't work properly.  It also leaves us more open to
> > unexpressed dependencies which are  
> 
> I miss the end of the story :-).
> 
> One last comment: between solution #1 and solution #2, #2 will always
> suspend the regulator later than #1. Now, if we add
> 
> 3/ Make sure the i2c controller driving the bus the PMIC is connected
> to is kept enabled, and enter regulators suspend state after all
> devices have been suspended.
> 
> of course #3 will suspend things later than #2, but at the expense of
> driver/DT specialization, and we're not guaranteed to not face another
> weird dependency constraint like "suspend dev X" -> "suspend reg Y" ->
> "suspend dev Z" in the future.
> 
> Also note that the 'suspend dev connected on a bus before the bus
> controller' dependencies are already well supported thanks to the
> device model dev->parent relationship. Actually, this is what I'm
> relying on for my "suspend PMIC's regulators before the i2c controller"
> constraint.

