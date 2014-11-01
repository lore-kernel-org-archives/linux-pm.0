From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm_runtime_enable() in ->probe() (was: Re: [PATCH v3 0/9] PM /
 Domains: Fix race conditions during boot)
Date: Sat, 1 Nov 2014 11:15:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1411011106100.11162-100000@netrider.rowland.org>
References: <42875843.yieZ2al8Y2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:55235 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751626AbaKAPQA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Nov 2014 11:16:00 -0400
In-Reply-To: <42875843.yieZ2al8Y2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

[CC: list drastically trimmed]

On Sat, 1 Nov 2014, Rafael J. Wysocki wrote:

> All that said there is a logical error related to calling pm_runtime_enable()
> and its derivatives from ->probe() that I've been overlooking pretty much
> from the start.
> 
> Namely, really_probe() sets dev->driver to drv before calling ->probe()
> for either the bus type or the driver itself, so if the driver's probe
> calls pm_runtime_enable(), it will execute the driver's own runtime PM
> resume callback before the driver can check whether or not it wants to handle
> the device in the first place.  That doesn't sound quite right to me.
> 
> This means we need a different mechanism to ensure that the device will
> be accessible to the driver and/or the bus type in ->probe().
> 
> At one point we had pm_runtime_get_sync() before really_probe() in
> driver_proble_device() IIRC, but people complained about it, so we dropped it
> and put a barrier in there instead, but that's not sufficient.  We need to
> explicitly ensure that the device won't be powered off while ->probe() is
> in progress *but* we need to avoid calling the driver's runtime PM resume
> callback before ->probe() returns.
> 
> Alan, Kevin, ideas?

I suspect this cannot be handled solely the driver core or the PM core.  
The bus subsystem has to manage things properly.

For example, take a look at drivers/pci/pci-driver.c:local_pci_probe().  
That routine doesn't set pci_dev->driver until _after_ doing the
pm_runtime_get_sync().  Therefore, if a runtime_resume callback does
occur, the PCI core's runtime_resume handler will see that
pci_dev->driver isn't set and won't invoke the driver's runtime_resume
method.

Things become a little more complicated if the driver has to handle 
everything by itself and the subsystem doesn't support runtime PM.  In 
that case, the driver's runtime_resume routine would have to check and 
see whether the device has successfully been bound to the driver (for 
example, by checking whether dev_get_drvdata() returns a non-NULL 
pointer) before doing anything else.

Note that a mirror version of this problem exists during unbinding,
because dev->driver doesn't get cleared until _after_ the driver's
remove routine has been called.  A runtime suspend callback occurring 
in between could mistakenly get sent to the driver's runtime_suspend 
routine.

Alan Stern

