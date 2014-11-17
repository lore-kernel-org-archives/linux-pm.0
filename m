From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Tue, 18 Nov 2014 00:28:26 +0100
Message-ID: <9731926.0Og5ZNPBtE@vostro.rjw.lan>
References: <20141117220238.GE5258@dtor-ws> <Pine.LNX.4.44L0.1411171708010.4838-100000@iolanthe.rowland.org> <20141117221700.GA2049@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141117221700.GA2049@dtor-ws>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, November 17, 2014 02:17:00 PM Dmitry Torokhov wrote:
> On Mon, Nov 17, 2014 at 05:12:35PM -0500, Alan Stern wrote:
> > On Mon, 17 Nov 2014, Dmitry Torokhov wrote:
> > 
> > > > >  Except buses
> > > > > usually call pm_generic_runtime_resume() which ends up fetching driver's
> > > > > callbacks. Maybe pm_generic_runtime_*() need be a bit smarter?
> > > > 
> > > > No, the bus subsystem needs to be smarter.  It shouldn't call 
> > > > pm_generic_runtime_resume() if the driver hasn't been probed yet, or if 
> > > > the driver has already been unbound from the device.
> > > 
> > > But that code wold be exactly the same for all buses, right? So why
> > > can't pm_generic_runtime_resume() be smarter?
> > 
> > It would not be the same for all buses.  Each bus will have its own way 
> > of recognizing whether or not a driver has been probed (i.e., by 
> > checking some field in the bus-specific part of the device structure).
> > 
> > > However, is it allowed to call pm_runtime_get_sync() on devices that
> > > didn't issue pm_runtime_enable()?
> > 
> > Yes.  But the bus has to issue pm_runtime_enable() before probing the 
> > driver, because the driver will expect runtime PM to work properly 
> > while its probe routine runs.  For example, the probe routine might 
> > want to leave the device in a runtime-suspended state.  It can't do 
> > that if the device isn't enabled for runtime PM.
> 
> That means that runtime PM will be enabled for all devices on given bus
> while up till now drivers were deciding if their devices should be
> runtime-pm-managed or not.

That's not the case for PCI drivers.

> I do not think we are quite ready for this.

We have to do that if power domains are in use, however, because if at least
one device in a power domain in enabled for runtime PM, that will affect the
other devices in that domain.

We could make a rule to keep a domail always up if at least one device in it
has runtime PM disabled, but that is equivalent to enabling runtime PM for
that device, powering the domain up and bumping up the device's usage counter.

Rafael
