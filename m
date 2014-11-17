From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 17:12:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411171708010.4838-100000@iolanthe.rowland.org>
References: <20141117220238.GE5258@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44401 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753023AbaKQWMh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 17:12:37 -0500
In-Reply-To: <20141117220238.GE5258@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On Mon, 17 Nov 2014, Dmitry Torokhov wrote:

> > >  Except buses
> > > usually call pm_generic_runtime_resume() which ends up fetching driver's
> > > callbacks. Maybe pm_generic_runtime_*() need be a bit smarter?
> > 
> > No, the bus subsystem needs to be smarter.  It shouldn't call 
> > pm_generic_runtime_resume() if the driver hasn't been probed yet, or if 
> > the driver has already been unbound from the device.
> 
> But that code wold be exactly the same for all buses, right? So why
> can't pm_generic_runtime_resume() be smarter?

It would not be the same for all buses.  Each bus will have its own way 
of recognizing whether or not a driver has been probed (i.e., by 
checking some field in the bus-specific part of the device structure).

> However, is it allowed to call pm_runtime_get_sync() on devices that
> didn't issue pm_runtime_enable()?

Yes.  But the bus has to issue pm_runtime_enable() before probing the 
driver, because the driver will expect runtime PM to work properly 
while its probe routine runs.  For example, the probe routine might 
want to leave the device in a runtime-suspended state.  It can't do 
that if the device isn't enabled for runtime PM.

Alan Stern

