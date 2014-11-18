From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Tue, 18 Nov 2014 09:55:15 -0800
Message-ID: <20141118175515.GD3003@dtor-ws>
References: <20141118171831.GC3003@dtor-ws>
 <Pine.LNX.4.44L0.1411181234210.892-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411181234210.892-100000@iolanthe.rowland.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 18, 2014 at 12:44:22PM -0500, Alan Stern wrote:
> On Tue, 18 Nov 2014, Dmitry Torokhov wrote:
> 
> > OK. Another question then: pm_runtime_get_noresume() does literally this:
> > 
> > 	atomic_inc(&dev->power.usage_count);
> > 
> > So who is responsible for actually waking up parent device and/or power
> > domain? Is it simply missing because we did not really have PM domains
> > before?
> 
> Ths bus is responsible for making sure that all the standard resources
> are available -- that is, all the resources that would be needed by a
> normal device on that bus.  Anything beyond that (such as
> special-purpose clocks) has to be set up by the driver.
> 
> Thus the bus would insure that the device was powered, its parent was
> resumed, and the usual clock inputs were enabled.  And of course, one
> mechanism for doing this is to runtime-resume the power domain.

This does not sound like anything bus-specific. Can we move powering on
the domain before probing into the driver core, similarly to the default
pin selection by pinctrl? I do not see why we want to have every
individual bus to implement this. I guess right now we can't because we
assign the domain to device in individual bus's probe function, but I do
not think this is proper place for that either: bus and pm domain are
orthogonal concepts IMO.

> 
> Often the bus doesn't have to do anything special to resume the
> device's parent.  This is because the device gets probed when it is
> registered, which happens when it is discovered, and the discovery is
> done by the parent's driver as part of its normal activity.  Since the
> parent has to be powered up to carry out this normal activity, nothing 
> more is needed.

I think this only true for buses that support discovery.

> 
> (Of course, devices can get probed at other times too, not just when
> they are discovered.  For example, a device might get probed when a
> driver module is loaded, and that can occur at any time.  So in general
> it might indeed be necessary for the bus to wake up the parent before
> calling the driver's probe routine.)
>

Thanks.

-- 
Dmitry
