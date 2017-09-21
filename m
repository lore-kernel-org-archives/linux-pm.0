From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: Document rules on using pm_runtime_resume() in system suspend callbacks
Date: Thu, 21 Sep 2017 16:30:08 +0200
Message-ID: <3127503.Fvko33OoIn@aspire.rjw.lan>
References: <1849600.vI30ccvhCD@aspire.rjw.lan> <CAJZ5v0h6Fv=myGM8hxbyXedcaz8EvmQss528g=yDtK0nSTydew@mail.gmail.com> <20170921092713.tqnclpljoraesene@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49051 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751669AbdIUOjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2017 10:39:15 -0400
In-Reply-To: <20170921092713.tqnclpljoraesene@sig21.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thursday, September 21, 2017 11:27:13 AM CEST Johannes Stezenbach wrote:
> On Thu, Sep 21, 2017 at 02:39:30AM +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 20, 2017 at 6:27 PM, Johannes Stezenbach <js@sig21.net> wrote:
> > >
> > >  E.g. an audio codec could keep running
> > > while the i2c bus used to program its registers can be runtime suspended.
> > > If this is correct I think it would be useful to spell it out explicitly
> > > in the documentation.
> > 
> > That's because the i2c bus uses the ignore_children flag that allows
> > it to override the general rules. :-)
> 
> Ah!  I was looking at Documentation/driver-api/pm only (which is
> changed by your patch), but this is documented in Documentation/power
> (and obviously I hadn't checked the code, shame on me).
> 
> > direct_complete has nothing to do with this.
> 
> Oh?  Reading again, do I get this right:
> 
> 1. simple method: always call pm_runtime_resume() in ->suspend(),
>    then suspend the driver again

Right.

> 2. optimization: if pm_runtime_suspended(), the driver's ->suspend()
>    can possibly do nothing if conditions permit, otherwise it calls
>    pm_runtime_resume() and then suspends

Well, that may work in some cases. :-)

> 3. optimization: tell pm core to skip ->suspend() via return value
>    from ->prepare() which sets direct_complete

Yup.

> ...and your patch only deals with 1 and 2.

Yes, basically.

> Sorry to hijack your thread for side discussion, it was
> inadvertant due to my lack of understanding.
> 
> 
> > First off, the PM core does check the direct_complete flag in
> > __device_suspend() and does more-or-less what you are saying.
> > 
> > However, that flag is initialized in device_prepare() with the help of
> > the ->suspend() return value, because whether or not it makes sense to
> 
> you mean ->prepare(), right?

Right (sorry).

> > set that flag depends on some conditions that may change between
> > consecutive system suspend-resume cycles in general and need to be
> > checked in advance before setting it.
> > 
> > HTH
> 
> It does, however the question remains *why* it needs to check
> it in ->prepare() and not right before calling ->suspend().

Becuase the core needs input from middle layers in some cases before
it decides to call ->suspend().

> Using ->prepare() for the purpose seems wrong since it traverses
> the hierarchy in the "wrong" order.

That doesn't matter.  What matters is whether or not the device's
state is "compatible" with system sleep at the ->prepare() time (which is
checked by some middle layers in ->prepare()).

BTW, did you notice the pm_runtime_status_suspended() checks in
__device_suspend()?  They are in there in case the device has been
resumed from runtime suspend after ->prepare().

> Only right before calling ->suspend() the driver knows if its current
> state allows it to skip any further actions for suspend, because
> suspending children or other users may cause pm_runtime_resume()
> for it.  (In the back of my head I have the scenario of
> bug #196861, some completely different driver uses
> i2c via ACPI OpRegion during its suspend.)

Yes, that's a special case (again, because of the way i2c handles
runtime PM overall).

Thanks,
Rafael
