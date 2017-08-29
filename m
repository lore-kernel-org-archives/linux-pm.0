From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] PM: i2c-designware-platdrv: System sleep handling rework
Date: Tue, 29 Aug 2017 18:40:27 +0200
Message-ID: <3516258.tZRHLsck48@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <6543072.R9SdZCE16v@aspire.rjw.lan> <2533904.WxKdIHdxQJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61298 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751684AbdH2QtI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 12:49:08 -0400
In-Reply-To: <2533904.WxKdIHdxQJ@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tuesday, August 29, 2017 6:38:11 PM CEST Rafael J. Wysocki wrote:
> On Tuesday, August 29, 2017 2:59:49 AM CEST Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Rework the power management part of the i2c-designware-platdrv driver
> > so that its ->suspend and ->resume callbacks do not point to the
> > callback routines used by it for runtime PM.  Instead, point its late
> > suspend and early resume callbacks to pm_runtime_force_suspend() and
> > pm_runtime_force_resume(), respectively, and make it set the
> > SAFE_SUSPEND driver flag (introduced earlier) to instruct the generic
> > ACPI PM domain code that the driver can cope with runtime suspended
> > devices in its system sleep callbacks.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/i2c/busses/i2c-designware-platdrv.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> > ===================================================================
> > --- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -358,6 +358,7 @@ static int dw_i2c_plat_probe(struct plat
> >  	if (dev->pm_disabled) {
> >  		pm_runtime_forbid(&pdev->dev);
> >  	} else {
> > +		dev->power.driver_flags = DPM_FLAG_SAFE_SUSPEND;
> >  		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> >  		pm_runtime_use_autosuspend(&pdev->dev);
> >  		pm_runtime_set_active(&pdev->dev);
> > @@ -455,7 +456,8 @@ static int dw_i2c_plat_resume(struct dev
> >  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
> >  	.prepare = dw_i2c_plat_prepare,
> >  	.complete = dw_i2c_plat_complete,
> > -	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +				     pm_runtime_force_resume)
> >  	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
> >  };
> 
> This isn't going to work, because pm_runtime_force_suspend() will invoke
> the bus type callback and not the driver's one.
> 
> So scratch this, please.

BTW, I don't think it is OK to mess up with bus type _runtime_suspend and
_runtime_resume and try to make them magically handle the system suspend
case as well.  There has to be a different way ...

Thanks,
Rafael
