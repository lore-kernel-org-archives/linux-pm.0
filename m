From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Document rules on using pm_runtime_resume() in system
 suspend callbacks
Date: Thu, 21 Sep 2017 10:36:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709211031120.1423-100000@iolanthe.rowland.org>
References: <20170921092713.tqnclpljoraesene@sig21.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170921092713.tqnclpljoraesene@sig21.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Sep 2017, Johannes Stezenbach wrote:

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
> 2. optimization: if pm_runtime_suspended(), the driver's ->suspend()
>    can possibly do nothing if conditions permit, otherwise it calls
>    pm_runtime_resume() and then suspends
> 3. optimization: tell pm core to skip ->suspend() via return value
>    from ->prepare() which sets direct_complete
> 
> ...and your patch only deals with 1 and 2.
> 
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
> 
> > set that flag depends on some conditions that may change between
> > consecutive system suspend-resume cycles in general and need to be
> > checked in advance before setting it.
> > 
> > HTH
> 
> It does, however the question remains *why* it needs to check
> it in ->prepare() and not right before calling ->suspend().
> Using ->prepare() for the purpose seems wrong since it traverses
> the hierarchy in the "wrong" order.

No, it is the _right_ order.  If a device's ->prepare() says that
direct_complete is okay, but one of its descendants disallows
direct_complete, we then want to clear the direct_complete flag in the
original device structure.  We couldn't do this if we checked the 
descendant's driver first.

>  Only right before
> calling ->suspend() the driver knows if its current state
> allows it to skip any further actions for suspend, because
> suspending children or other users may cause pm_runtime_resume()
> for it.

If the device gets runtime-resumed before ->suspend() would be called 
then the direct_complete setting doesn't matter.  The PM core follows 
the direct_complete path only if the device is already in runtime 
suspend when the ->suspend() callback would normally be invoked.

And if the device does get runtime-resumed like this, it can't be 
runtime-suspended again.  The PM core makes sure of that.

Alan Stern

>  (In the back of my head I have the scenario of
> bug #196861, some completely different driver uses
> i2c via ACPI OpRegion during its suspend.)
> 
> 
> Thanks,
> Johannes
