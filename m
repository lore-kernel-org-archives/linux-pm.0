From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Tue, 18 Nov 2014 09:18:31 -0800
Message-ID: <20141118171831.GC3003@dtor-ws>
References: <20141117221700.GA2049@dtor-ws>
 <Pine.LNX.4.44L0.1411181110500.1500-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411181110500.1500-100000@iolanthe.rowland.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 18, 2014 at 11:13:28AM -0500, Alan Stern wrote:
> On Mon, 17 Nov 2014, Dmitry Torokhov wrote:
> 
> > > > However, is it allowed to call pm_runtime_get_sync() on devices that
> > > > didn't issue pm_runtime_enable()?
> > > 
> > > Yes.  But the bus has to issue pm_runtime_enable() before probing the 
> > > driver, because the driver will expect runtime PM to work properly 
> > > while its probe routine runs.  For example, the probe routine might 
> > > want to leave the device in a runtime-suspended state.  It can't do 
> > > that if the device isn't enabled for runtime PM.
> > 
> > That means that runtime PM will be enabled for all devices on given bus
> > while up till now drivers were deciding if their devices should be
> > runtime-pm-managed or not. I do not think we are quite ready for this.
> 
> It's up to both the bus _and_ the driver to make this decision.
> 
> If a driver is completely runtime-PM-unaware then it will never
> decrement the device's usage counter (which was incremented when the
> bus called _get_noresume()), and therefore the device will never be
> runtime-suspended.

OK. Another question then: pm_runtime_get_noresume() does literally this:

	atomic_inc(&dev->power.usage_count);

So who is responsible for actually waking up parent device and/or power
domain? Is it simply missing because we did not really have PM domains
before?

Thanks.

-- 
Dmitry
