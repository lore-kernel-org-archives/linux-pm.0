From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH 2/2] PM / i2c: designware: Clean up system sleep handling without ACPI
Date: Mon, 04 Sep 2017 12:07:21 +0200
Message-ID: <3349581.Lv4bLKTrbL@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <6044272.h4jTMoqRfC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <6044272.h4jTMoqRfC@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, September 4, 2017 1:14:44 AM CEST Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit a23318feeff6 (i2c: designware: Fix system suspend)
> the i2c-designware-platdrv driver always resumes the device in its
> system sleep ->suspend callback which isn't particularly nice,
> even though it is technically correct.
> 
> A better approach would be to make the driver track the PM state of
> the device so that it doesn't need to resume it in ->suspend and
> to drop its ->prepare and ->complete callbacks which would only be
> marginally useful then, so implement it.
> 
> First, drop dw_i2c_plat_suspend() added by commit a23318feeff6 and
> rename dw_i2c_plat_runtime_suspend() back to dw_i2c_plat_suspend().
> 
> Second, point the driver's ->late_suspend and ->early_resume
> callbacks, rather than its ->suspend and ->resume callbacks,
> to dw_i2c_plat_suspend() and dw_i2c_plat_resume(), respectively,
> so that they are not executed in parallel with each other, for
> example if runtime resume of the device takes place during system
> suspend.  Also, since the driver enables runtime PM unconditionally
> in dw_i2c_plat_probe(), this change allows the
> pm_runtime_status_suspended() check to be used in the PM callbacks
> to determine whether or not the device needs to be either suspended
> or resumed (moving the callbacks into the late/early stages of
> system suspend/resume, respectively, guarantees the stability
> of the runtime PM status at the time when they are invoked).
> 
> Next, add a "skip_resume" flag to struct dw_i2c_dev and make
> dw_i2c_plat_suspend() and dw_i2c_plat_resume() use it to avoid
> resuming a previously runtime-suspended device during system resume.
> 
> Finally, drop the driver's ->prepare and ->complete PM callbacks,
> because returning "true" from ->prepare for runtime-suspended
> devices is marginally useful (the PM core may still ignore that
> return value and invoke the driver's ->suspend callback anyway)
> and ->complete is only needed because of what ->prepare does.
> 
> Overrides: a23318feeff6 (i2c: designware: Fix system suspend)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.h    |    1 
>  drivers/i2c/busses/i2c-designware-platdrv.c |   47 +++++++++-------------------
>  2 files changed, 17 insertions(+), 31 deletions(-)
> 
> Index: linux-pm/drivers/i2c/busses/i2c-designware-core.h
> ===================================================================
> --- linux-pm.orig/drivers/i2c/busses/i2c-designware-core.h
> +++ linux-pm/drivers/i2c/busses/i2c-designware-core.h
> @@ -280,6 +280,7 @@ struct dw_i2c_dev {
>  	int			(*acquire_lock)(struct dw_i2c_dev *dev);
>  	void			(*release_lock)(struct dw_i2c_dev *dev);
>  	bool			pm_disabled;
> +	bool			skip_resume;
>  	void			(*disable)(struct dw_i2c_dev *dev);
>  	void			(*disable_int)(struct dw_i2c_dev *dev);
>  	int			(*init)(struct dw_i2c_dev *dev);
> Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> ===================================================================
> --- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -434,28 +434,17 @@ static const struct of_device_id dw_i2c_
>  MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
>  #endif
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int dw_i2c_plat_prepare(struct device *dev)
> -{
> -	return pm_runtime_suspended(dev);
> -}
> -
> -static void dw_i2c_plat_complete(struct device *dev)
> -{
> -	if (dev->power.direct_complete)
> -		pm_request_resume(dev);
> -}
> -#else
> -#define dw_i2c_plat_prepare	NULL
> -#define dw_i2c_plat_complete	NULL
> -#endif
> -
>  #ifdef CONFIG_PM
> -static int dw_i2c_plat_runtime_suspend(struct device *dev)
> +static int dw_i2c_plat_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>  
> +	if (pm_runtime_status_suspended(dev)) {
> +		i_dev->skip_resume = true;
> +		return 0;
> +	}
> +
>  	i_dev->disable(i_dev);
>  	i2c_dw_plat_prepare_clk(i_dev, false);
>  
> @@ -467,27 +456,23 @@ static int dw_i2c_plat_resume(struct dev
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>  
> +	if (!pm_runtime_status_suspended(dev))

This check is incorrect, I've just sent a v2 of the patch.

Sorry about this.

> +		return 0;
> +
> +	if (i_dev->skip_resume) {
> +		i_dev->skip_resume = false;
> +		return 0;
> +	}
> +
>  	i2c_dw_plat_prepare_clk(i_dev, true);
>  	i_dev->init(i_dev);
>  
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int dw_i2c_plat_suspend(struct device *dev)
> -{
> -	pm_runtime_resume(dev);
> -	return dw_i2c_plat_runtime_suspend(dev);
> -}
> -#endif
> -
>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
> -	.prepare = dw_i2c_plat_prepare,
> -	.complete = dw_i2c_plat_complete,
> -	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> -	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
> -			   dw_i2c_plat_resume,
> -			   NULL)
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> +	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
>  };
>  
>  #define DW_I2C_DEV_PMOPS (&dw_i2c_dev_pm_ops)
