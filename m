From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH 1/2] i2c: designware: Clean up PM handling in dw_i2c_plat_probe()
Date: Tue, 05 Sep 2017 16:41:34 +0200
Message-ID: <3992663.3QJSSQ4alv@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <57866801.UnLEtqmHq8@aspire.rjw.lan> <f740420f-b740-3562-f849-ac8af6685f19@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <f740420f-b740-3562-f849-ac8af6685f19@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 5, 2017 4:40:22 PM CEST Jarkko Nikula wrote:
> Hi
> 
> On 09/04/2017 02:08 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The power management handling in dw_i2c_plat_probe() is somewhat
> > messy and it is rather hard to figure out the code intention for
> > the case when pm_disabled is set.  In that case, the driver doesn't
> > enable runtime PM at all, but in addition to that it calls
> > pm_runtime_forbid() as though it wasn't sure if runtime PM might
> > be enabled for the device later by someone else.
> > 
> > Although that concern doesn't seem to be actually valid, the
> > device is clearly still expected to be PM-capable even in the
> > pm_disabled set case, so a better approach would be to enable
> > runtime PM for it unconditionally and then prevent it from
> > being runtime suspended by using pm_runtime_forbid().
> > 
> > Make the driver do that as that will help to clean up its system
> > sleep handling in a relatively straightforward way.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/i2c/busses/i2c-designware-platdrv.c |   36 +++++++++++++++++++---------
> >   1 file changed, 25 insertions(+), 11 deletions(-)
> > 
> > Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> > ===================================================================
> > --- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -249,6 +249,16 @@ static void dw_i2c_set_fifo_size(struct
> >   	}
> >   }
> >   
> > +static void dw_i2c_plat_pm_cleanup(struct dw_i2c_dev *dev)
> > +{
> > +	pm_runtime_get_noresume(dev->dev);
> > +	if (dev->pm_disabled)
> > +		pm_runtime_allow(dev->dev);
> > +
> > +	pm_runtime_disable(dev->dev);
> > +	pm_runtime_put_noidle(dev->dev);
> > +}
> > +
> >   static int dw_i2c_plat_probe(struct platform_device *pdev)
> >   {
> >   	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > @@ -362,14 +372,19 @@ static int dw_i2c_plat_probe(struct plat
> >   	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
> >   	adap->dev.of_node = pdev->dev.of_node;
> >   
> > -	if (dev->pm_disabled) {
> > +	/* The code below assumes runtime PM to be disabled. */
> > +	WARN_ON(pm_runtime_enabled(&pdev->dev));
> > +
> > +	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +	pm_runtime_set_active(&pdev->dev);
> > +
> > +	pm_runtime_get_noresume(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	if (dev->pm_disabled)
> >   		pm_runtime_forbid(&pdev->dev);
> > -	} else {
> > -		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> > -		pm_runtime_use_autosuspend(&pdev->dev);
> > -		pm_runtime_set_active(&pdev->dev);
> > -		pm_runtime_enable(&pdev->dev);
> > -	}
> > +
> > +	pm_runtime_put_noidle(&pdev->dev);
> >   
> Is pm_runtime_get_noresume()/pm_runtime_put_noidle() cycle needed here? 
> My vague memory tells platform device won't power off instantly because 
> of plain pm_runtime_enable() even if dev->power.usage_count is zero.

Not by itself, but as a result of something running in parallel with the
probe it may in theory.

> I guess it was the pm_request_idle() in driver_probe_device() that 
> triggered the power transition after probe.
> 
> drivers/base/dd.c: driver_probe_device():
> 	pm_runtime_barrier(dev);
> 	ret = really_probe(dev, drv);
> 	pm_request_idle(dev);

This doesn't prevent runtime PM transitions from occurring in parallel
with really_probe() and the extra counter incrementation/decrementation
doesn't hurt. :-)

To me, the rule of thumb for runtime PM should be quite analogous to the one
for interrupts: expect it to happen immediately after you have enabled it
unless you know for a fact that there are protections in place.

Thanks,
Rafael

