From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Tue, 18 Nov 2014 12:44:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411181234210.892-100000@iolanthe.rowland.org>
References: <20141118171831.GC3003@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:32976 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754010AbaKRRoY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 12:44:24 -0500
In-Reply-To: <20141118171831.GC3003@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On Tue, 18 Nov 2014, Dmitry Torokhov wrote:

> OK. Another question then: pm_runtime_get_noresume() does literally this:
> 
> 	atomic_inc(&dev->power.usage_count);
> 
> So who is responsible for actually waking up parent device and/or power
> domain? Is it simply missing because we did not really have PM domains
> before?

Ths bus is responsible for making sure that all the standard resources
are available -- that is, all the resources that would be needed by a
normal device on that bus.  Anything beyond that (such as
special-purpose clocks) has to be set up by the driver.

Thus the bus would insure that the device was powered, its parent was
resumed, and the usual clock inputs were enabled.  And of course, one
mechanism for doing this is to runtime-resume the power domain.

Often the bus doesn't have to do anything special to resume the
device's parent.  This is because the device gets probed when it is
registered, which happens when it is discovered, and the discovery is
done by the parent's driver as part of its normal activity.  Since the
parent has to be powered up to carry out this normal activity, nothing 
more is needed.

(Of course, devices can get probed at other times too, not just when
they are discovered.  For example, a device might get probed when a
driver module is loaded, and that can occur at any time.  So in general
it might indeed be necessary for the bus to wake up the parent before
calling the driver's probe routine.)

Alan Stern

