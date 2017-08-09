From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] i2c: designware: Fix system suspend
Date: Wed, 09 Aug 2017 22:43:22 +0200
Message-ID: <1776600.GWYGTRKWSN@aspire.rjw.lan>
References: <1502285302-21552-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49659 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752339AbdHIUvk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 16:51:40 -0400
In-Reply-To: <1502285302-21552-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "# v4 . 4+" <stable@vger.kernel.org>

On Wednesday, August 9, 2017 3:28:22 PM CEST Ulf Hansson wrote:
> The commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming
> during system suspend"), may suggest to the PM core to try out the so
> called direct_complete path for system sleep. In this path, the PM core
> treats a runtime suspended device as it's already in a proper low power
> state for system sleep, which makes it skip calling the system sleep
> callbacks for the device, except for the ->prepare() and the ->complete()
> callbacks.
> 
> However, the PM core may unset the direct_complete flag for a parent
> device, in case its child device are being system suspended before. In this
> scenario, the PM core invokes the system sleep callbacks, no matter if the
> device is runtime suspended or not.
> 
> Particularly in cases of an existing i2c slave device, the above path is
> triggered, which breaks the assumption that the i2c device is always
> runtime resumed whenever the dw_i2c_plat_suspend() is being called.
> 
> More precisely, dw_i2c_plat_suspend() calls clk_core_disable() and
> clk_core_unprepare(), for an already disabled/unprepared clock, leading to
> a splat in the log about clocks calls being wrongly balanced and breaking
> system sleep.
> 
> To still allow the direct_complete path in cases when it's possible, but
> also to keep the fix simple, let's runtime resume the i2c device in the
> ->suspend() callback, before continuing to put the device into low power
> state.
> 
> Note, in cases when the i2c device is attached to the ACPI PM domain, this
> problem doesn't occur, because ACPI's ->suspend() callback, assigned to
> acpi_subsys_suspend(), already calls pm_runtime_resume() for the device.
> 
> It should also be noted that this change does not fix commit 8503ff166504
> ("i2c: designware: Avoid unnecessary resuming during system suspend").
> Because for the non-ACPI case, the system sleep support was already broken
> prior that point.
> 
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks OK to me.

> ---
> 
> I decided to post this as a separate change, instead of as earlier folding it
> in the series that extends the ACPI PM domain to cope with the runtime PM
> centric path for system sleep.
> 
> This change applies on a fresh v4.4+. If someone wants it's applied for earlier
> version, please send a backport yourself.
> 
> It's based on 4.13 rc4 and I assume it should go as a fix via the i2c tree.
> 
> Changes in v2:
> 	- Updated changelog.
> 	- Runtime resume the device in ->suspend() instead of in ->prepare().
> 
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 2ea6d0d..bb3b8c8 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -426,7 +426,7 @@ static void dw_i2c_plat_complete(struct device *dev)
>  #endif
>  
>  #ifdef CONFIG_PM
> -static int dw_i2c_plat_suspend(struct device *dev)
> +static int dw_i2c_plat_runtime_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
> @@ -448,11 +448,21 @@ static int dw_i2c_plat_resume(struct device *dev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int dw_i2c_plat_suspend(struct device *dev)
> +{
> +	pm_runtime_resume(dev);
> +	return dw_i2c_plat_runtime_suspend(dev);
> +}
> +#endif
> +
>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>  	.prepare = dw_i2c_plat_prepare,
>  	.complete = dw_i2c_plat_complete,
>  	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> -	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
> +	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
> +			   dw_i2c_plat_resume,
> +			   NULL)
>  };
>  
>  #define DW_I2C_DEV_PMOPS (&dw_i2c_dev_pm_ops)
> 
