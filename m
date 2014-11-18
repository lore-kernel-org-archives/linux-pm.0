From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Tue, 18 Nov 2014 21:14:56 +0100
Message-ID: <4282972.midaRTeXMU@vostro.rjw.lan>
References: <20141118171831.GC3003@dtor-ws> <Pine.LNX.4.44L0.1411181234210.892-100000@iolanthe.rowland.org> <20141118175515.GD3003@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141118175515.GD3003@dtor-ws>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 18, 2014 09:55:15 AM Dmitry Torokhov wrote:
> On Tue, Nov 18, 2014 at 12:44:22PM -0500, Alan Stern wrote:
> > On Tue, 18 Nov 2014, Dmitry Torokhov wrote:
> > 
> > > OK. Another question then: pm_runtime_get_noresume() does literally this:
> > > 
> > > 	atomic_inc(&dev->power.usage_count);
> > > 
> > > So who is responsible for actually waking up parent device and/or power
> > > domain? Is it simply missing because we did not really have PM domains
> > > before?
> > 
> > Ths bus is responsible for making sure that all the standard resources
> > are available -- that is, all the resources that would be needed by a
> > normal device on that bus.  Anything beyond that (such as
> > special-purpose clocks) has to be set up by the driver.
> > 
> > Thus the bus would insure that the device was powered, its parent was
> > resumed, and the usual clock inputs were enabled.  And of course, one
> > mechanism for doing this is to runtime-resume the power domain.
> 
> This does not sound like anything bus-specific. Can we move powering on
> the domain before probing into the driver core, similarly to the default
> pin selection by pinctrl?

We could do that for genpd if devices were added to domains before registering
(those devices).  Otherwise, there's no guarantee that all has been set up yet.

Note that this would only be the case for genpd, not for the ACPI PM domain
in particular, for example.  The reason why is that the ACPI PM domain cannot
be used along with bus types that provide non-trivial PM callbacks, so pretty
much the bus type's ->probe needs to decide whether or not to use it.

> I do not see why we want to have every
> individual bus to implement this. I guess right now we can't because we
> assign the domain to device in individual bus's probe function, but I do
> not think this is proper place for that either: bus and pm domain are
> orthogonal concepts IMO.

For genpd, yes.  Not necessarily for other types of PM domains.  [A "PM domain"
is just an override for bus type PM callbacks in general, genpd is only one
use case here.]

I think that the the general DT bindings for genpd are the source of the whole
complication here.  Before, devices were added to domains in the board-specific
code before registration, but now that can be done automatically if the
appropriate bindings are present in the DT.

> > Often the bus doesn't have to do anything special to resume the
> > device's parent.  This is because the device gets probed when it is
> > registered, which happens when it is discovered, and the discovery is
> > done by the parent's driver as part of its normal activity.  Since the
> > parent has to be powered up to carry out this normal activity, nothing 
> > more is needed.
> 
> I think this only true for buses that support discovery.

It may not be the case for the platform bus type or other "root kind" bus
types where devices may not have a functional parent.  Otherwise it usually
is the case.

Anyway, that really depends on the bus type.

Rafael
