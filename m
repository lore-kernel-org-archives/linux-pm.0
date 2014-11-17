From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 14:06:02 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411171400540.885-100000@iolanthe.rowland.org>
References: <7hd28l3clz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58179 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751621AbaKQTGE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 14:06:04 -0500
In-Reply-To: <7hd28l3clz.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

On Mon, 17 Nov 2014, Kevin Hilman wrote:

> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > The amba bus, amba drivers and a vast amount of platform drivers which
> > enables runtime PM, don't invoke a pm_runtime_get_sync() while probing
> > their devices.
> >
> > Instead, once they have turned on their PM resourses during ->probe()
> > and are ready to handle I/O, these invokes pm_runtime_set_active() to
> > synchronize its state towards the runtime PM core.
> >
> > From a runtime PM point of view this behavior is perfectly acceptable,
> 
> In the context of PM domains that can be dynamically powered on/off, I'm
> not so sure it's perfectly acceptable anymore.
> 
> Why doesn't the bus do a _get_sync() instead of a _get_noresume()
> followed by a _set_active().  
> 
> By using the _get_noresume() you're bypassing the paths that would bring
> up your PM domain.

This probably comes about because devices that are part of a power
domain need special treatment.  Before the driver's probe routine gets
called, the bus ought to resume the entire power domain.  For that,
some sort of _get_sync() is needed.

For devices that aren't part of a power domain, things are simpler.  
The bus does _get_noresume() to make sure the device won't be runtime 
suspended while the probe routine is running.  It doesn't do 
_get_sync(), because that would end up calling the driver's 
runtime_resume routine before the driver was bound to the device.  (The 
bus could prevent that from happening by taking special precautions,
like PCI does, but in general it's a nuisance.)

Alan Stern

