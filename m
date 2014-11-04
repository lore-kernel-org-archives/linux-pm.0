From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: pm_runtime_enable() in ->probe() (was: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot)
Date: Tue, 04 Nov 2014 02:23:56 +0100
Message-ID: <2246869.HSiIHB4qkX@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1411011106100.11162-100000@netrider.rowland.org> <2009519.T9tcIKzfle@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51344 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750819AbaKDBDM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 20:03:12 -0500
In-Reply-To: <2009519.T9tcIKzfle@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, November 04, 2014 01:09:44 AM Rafael J. Wysocki wrote:
> On Saturday, November 01, 2014 11:15:59 AM Alan Stern wrote:
> > [CC: list drastically trimmed]
> > 
> > On Sat, 1 Nov 2014, Rafael J. Wysocki wrote:
> > 
> > > All that said there is a logical error related to calling pm_runtime_enable()
> > > and its derivatives from ->probe() that I've been overlooking pretty much
> > > from the start.
> > > 
> > > Namely, really_probe() sets dev->driver to drv before calling ->probe()
> > > for either the bus type or the driver itself, so if the driver's probe
> > > calls pm_runtime_enable(), it will execute the driver's own runtime PM
> > > resume callback before the driver can check whether or not it wants to handle
> > > the device in the first place.  That doesn't sound quite right to me.
> > > 
> > > This means we need a different mechanism to ensure that the device will
> > > be accessible to the driver and/or the bus type in ->probe().
> > > 
> > > At one point we had pm_runtime_get_sync() before really_probe() in
> > > driver_proble_device() IIRC, but people complained about it, so we dropped it
> > > and put a barrier in there instead, but that's not sufficient.  We need to
> > > explicitly ensure that the device won't be powered off while ->probe() is
> > > in progress *but* we need to avoid calling the driver's runtime PM resume
> > > callback before ->probe() returns.
> > > 
> > > Alan, Kevin, ideas?
> > 
> > I suspect this cannot be handled solely the driver core or the PM core.  
> > The bus subsystem has to manage things properly.
> > 
> > For example, take a look at drivers/pci/pci-driver.c:local_pci_probe().  
> > That routine doesn't set pci_dev->driver until _after_ doing the
> > pm_runtime_get_sync().  Therefore, if a runtime_resume callback does
> > occur, the PCI core's runtime_resume handler will see that
> > pci_dev->driver isn't set and won't invoke the driver's runtime_resume
> > method.
> 
> Which means that the PCI bus type wouldn't be affected by the change I'm
> talking about to my eyes.
> 
> > Things become a little more complicated if the driver has to handle 
> > everything by itself and the subsystem doesn't support runtime PM.  In 
> > that case, the driver's runtime_resume routine would have to check and 
> > see whether the device has successfully been bound to the driver (for 
> > example, by checking whether dev_get_drvdata() returns a non-NULL 
> > pointer) before doing anything else.
> 
> Well, I'd rather say that the driver has to initialize runtime PM
> properly in that case before trying to use it. :-)

And this is important and it looks like I haven't described the problem clearly
enough.

Suppose that the device is in a power domain that was turned off before
probing the driver, whatever the reason.  It needs to but turned on for
the driver to be able to access the device in ->probe() and now the question
is how to do that.

The natural way would be to call pm_runtime_get_sync(dev) at the beginning
of ->probe(), but that would trigger the driver's own ->runtime_resume() to
run and it would require the driver to do some extra checks in that routine.
Those checks wouldn't be necessary at any other time.

However, if the core does pm_runtime_get_sync(dev) before calling
really_probe(), it may turn on the power domain without invoking runtime
PM callbacks from the driver.

Rafael

