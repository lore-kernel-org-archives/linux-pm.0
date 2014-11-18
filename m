From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Tue, 18 Nov 2014 21:29:14 +0100
Message-ID: <3492523.qBADTmdTqo@vostro.rjw.lan>
References: <20141117220238.GE5258@dtor-ws> <1787068.2MCH8czsD4@vostro.rjw.lan> <CAPDyKFoMftvKs8tyBaYCu1zTK_JYiXeXMiq86OrwAAHZoRO_Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoMftvKs8tyBaYCu1zTK_JYiXeXMiq86OrwAAHZoRO_Pw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 18, 2014 03:05:08 PM Ulf Hansson wrote:
> [...]
> 
> >> > > > >
> >> > > > > It would not be the same for all buses.  Each bus will have its own way
> >> > > > > of recognizing whether or not a driver has been probed (i.e., by
> >> > > > > checking some field in the bus-specific part of the device structure).
> >> > > > >
> >> > > > > > However, is it allowed to call pm_runtime_get_sync() on devices that
> >> > > > > > didn't issue pm_runtime_enable()?
> >> > > > >
> >> > > > > Yes.  But the bus has to issue pm_runtime_enable() before probing the
> >> > > > > driver, because the driver will expect runtime PM to work properly
> >> > > > > while its probe routine runs.  For example, the probe routine might
> >> > > > > want to leave the device in a runtime-suspended state.  It can't do
> >> > > > > that if the device isn't enabled for runtime PM.
> >> > > >
> >> > > > That means that runtime PM will be enabled for all devices on given bus
> >> > > > while up till now drivers were deciding if their devices should be
> >> > > > runtime-pm-managed or not.
> >> > >
> >> > > That's not the case for PCI drivers.
> >> > >
> >> > > > I do not think we are quite ready for this.
> >> > >
> >> > > We have to do that if power domains are in use, however, because if at least
> >> > > one device in a power domain in enabled for runtime PM, that will affect the
> >> > > other devices in that domain.
> >> > >
> >> > > We could make a rule to keep a domail always up if at least one device in it
> >> > > has runtime PM disabled, but that is equivalent to enabling runtime PM for
> >> > > that device, powering the domain up and bumping up the device's usage counter.
> >> >
> >> > What will driver will see if it tries to check pm_runtime_active()?
> >> > Would not it get unexpected result if the driver did not call
> >> > pm_runtime_enable() on it's device?
> >>
> >> Well, that part was supposed to depend on the bus type.  For example, it
> >> won't be unexpected for PCI drivers, because runtime PM is always enabled
> >> for PCI devices (although it may be blocked as I described).
> >>
> >> A problem arises if a power domain is used along with a bus type that doesn't
> >> enable runtime PM for devices by default and drivers are expected to do that.
> >> That could be addressed by powering up a PM domain (and bumping up its usage
> >> counter) when adding a device to it and keeping it up until all of the devices
> >> in it are runtime suspended, but then it also should be turned off eventually
> >> if there are no drivers for any of those devices.
> >
> > In other words, I agree with the Ulf's approach in the $subject patch, although
> > the changelog needs to be updated.
> >
> 
> I am having second thoughts here! The reason to why, are because of
> the scenario 5) below, which I forgot about when writing/testing
> $subject patch.
> 
> As you know, I have been thinking over and over about how to address
> the issues $subject patch is trying to solve.
> 
> From the discussions we have had around this topic, I would like to
> summarize the situation describing the current existing scenarios that
> I know about. It would be nice to reach a consensus on how to cope
> with them, especially since we keep forgetting to consider at least
> one of them during our discussions.
> 
> Note that some minor variations may exist for each scenario, but let's
> focus on the concepts of how runtime PM is managed during ->probe().
> The scenarios applies to those drivers/buses for which devices may
> have an attached generic PM domain.
> 
> Scenario 1), a platform driver without runtime PM callbacks.
> ->probe()
> - do some initialization
> - pm_runtime_enable()
> - pm_runtime_get_sync()
> - probe the device
> - pm_runtime_put()
> 
> Scenario 2), platform driver with runtime PM callbacks.
> ->probe()
> - do some initialization
> - fetch handles to runtime PM resources
> - pm_runtime_enable()
> - pm_runtime_get_sync()
> - enable its runtime PM resources, in some cases it's done by also
> requiring its runtime PM resume callback to be invoked
> - probe the device
> - pm_runtime_put()
> 
> Scenario 3), platform driver with runtime PM callbacks.
> ->probe()
> - do some initialization
> - fetch handles to runtime PM resources
> - enable its runtime PM resources
> - pm_runtime_get_noresume()
> - pm_runtime_set_active()
> - pm_runtime_enable()
> - probe the device
> - pm_runtime_put()
> 
> Scenario 4), amba bus and amba driver, both have runtime PM callbacks.
> ->amba bus probe()
> - fetch handles to runtime PM resources
> - enable its runtime PM resources
> - pm_runtime_get_noresume()
> - pm_runtime_set_active()
> - pm_runtime_enable()
>   ->amba driver probe()
>   - do some initialization
>   - fetch handles to runtime PM resources
>   - enable its runtime PM resources
>   - probe the device
>   - pm_runtime_put()
> 
> Scenario 5), a platform driver with/without runtime PM callbacks.
> ->probe()
> - do some initialization
> - may fetch handles to runtime PM resources
> - pm_runtime_enable()

Well, and now how the driver knows if the device is "on" before accessing it?

> Note 1)
> Scenario 1) and 2), both relies on the approach to power on the PM
> domain by using pm_runtime_get_sync(). That approach didn't work when
> CONFIG_PM_RUNTIME was unset, but we recently decided to fixed that by
> the below patch, so that's good!
> "[PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when genpd enabled"
> 
> Note 2)
> Scenario 3) and 4) use the same principles for managing runtime PM.
> These scenarios needs a way to power on the generic PM domain prior
> probing the device. The call to pm_runtime_set_active(), prevents an
> already powered PM domain from power off until after probe, but that's
> not enough.
> 
> Note 3)
> The $subject patch, tried to address the issues for scenario 3) and
> 4). It does so, but will affect scenario 5) which was working nicely
> before. In scenario 5), the $subject patch will cause the generic PM
> domain to potentially stay powered after ->probe() even if the device
> is runtime PM suspended.

Why would it?  If the device is runtime-suspended, the domain will know
that, because its callbacks will be used for that.  At least, that's
what I'd expect to happen, so is there a problem here?

> I see three options going forward.
> 
> Option 1)
> Convert scenario 3) and 4) into using the pm_runtime_get_sync()
> approach. There are no theoretical obstacles to do this, but pure
> practical. There are a lot of drivers that needs to be converted and
> we also need to teach driver authors future wise to not use
> pm_runtime_set_active() in this manner.

I'd say we need to do something like this anyway.  That is, standardize on
*one* approach.  I'm actually not sure what approach is the most useful,
but the pm_runtime_get_sync() one seems to be the most popular to me.

> Option 2)
> Add some kind of get/put API for PM domains. The buses invokes it to
> control the power to the PM domain. From what I understand, that's
> also what Dmitry think is needed!?
> Anyway, that somehow means to proceed with the approach I took in the
> below patchset.
> [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
> http://marc.info/?t=141320907000003&r=1&w=2

I don't like that.  The API is already quite complicated in my view and
adding even more complexity to it is not going to help in the long run.

> Option 3)
> Live we the limitation this $subject patch introduces for scenario 5).

I'd say, 3) for now and 1) going forward.

> Is there maybe any additional options, that I didn't think of?
> 
> Apologize for the long email, I hope I didn't bored you too much.

That's fine, thanks for taking the time to lay out all of the cases, that's
always helpful.

Rafael
