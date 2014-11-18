From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Tue, 18 Nov 2014 12:04:38 -0800
Message-ID: <20141118200438.GG3003@dtor-ws>
References: <20141118171831.GC3003@dtor-ws>
 <Pine.LNX.4.44L0.1411181234210.892-100000@iolanthe.rowland.org>
 <20141118175515.GD3003@dtor-ws>
 <4282972.midaRTeXMU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4282972.midaRTeXMU@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 18, 2014 at 09:14:56PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 18, 2014 09:55:15 AM Dmitry Torokhov wrote:
> > On Tue, Nov 18, 2014 at 12:44:22PM -0500, Alan Stern wrote:
> > > On Tue, 18 Nov 2014, Dmitry Torokhov wrote:
> > > 
> > > > OK. Another question then: pm_runtime_get_noresume() does literally this:
> > > > 
> > > > 	atomic_inc(&dev->power.usage_count);
> > > > 
> > > > So who is responsible for actually waking up parent device and/or power
> > > > domain? Is it simply missing because we did not really have PM domains
> > > > before?
> > > 
> > > Ths bus is responsible for making sure that all the standard resources
> > > are available -- that is, all the resources that would be needed by a
> > > normal device on that bus.  Anything beyond that (such as
> > > special-purpose clocks) has to be set up by the driver.
> > > 
> > > Thus the bus would insure that the device was powered, its parent was
> > > resumed, and the usual clock inputs were enabled.  And of course, one
> > > mechanism for doing this is to runtime-resume the power domain.
> > 
> > This does not sound like anything bus-specific. Can we move powering on
> > the domain before probing into the driver core, similarly to the default
> > pin selection by pinctrl?
> 
> We could do that for genpd if devices were added to domains before registering
> (those devices).  Otherwise, there's no guarantee that all has been set up yet.
> 
> Note that this would only be the case for genpd, not for the ACPI PM domain
> in particular, for example.  The reason why is that the ACPI PM domain cannot
> be used along with bus types that provide non-trivial PM callbacks, so pretty
> much the bus type's ->probe needs to decide whether or not to use it.

In genpd code there is a notion of providers that match devices and
domains. Can we do the same for ACPI and stuff all that knowledge into
it's "provider"?

IOW why ACPI is that special?

-- 
Dmitry
