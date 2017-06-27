From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM / Domains: Call driver's noirq callbacks
Date: Wed, 28 Jun 2017 00:46:33 +0200
Message-ID: <2563367.LhaMUqlW8y@aspire.rjw.lan>
References: <CAPDyKFr-e3rJ0XU8snbLVgz3vh=mtL787e4fyb=2GqnPa7rYfA@mail.gmail.com> <1498115913-8785-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53730 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753461AbdF0WyA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 18:54:00 -0400
In-Reply-To: <1498115913-8785-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>, ulf.hansson@linaro.org
Cc: khilman@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cyndis@kapsi.fi

On Thursday, June 22, 2017 10:18:33 AM Mikko Perttunen wrote:
> Currently genpd installs its own noirq callbacks, but never calls down
> to the driver's corresponding callbacks. Add these calls.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Ulf?

> ---
> v3:
> - Factored out common code in pm_genpd_{suspend,poweroff}_noirq
> - Added pm_generic_* calls to rest of callbacks
> 
>  drivers/base/power/domain.c | 68 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index d3f1d96f75e9..248c5f79f588 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -899,19 +899,19 @@ static int pm_genpd_prepare(struct device *dev)
>  }
>  
>  /**
> - * pm_genpd_suspend_noirq - Completion of suspend of device in an I/O PM domain.
> + * genpd_finish_suspend - Completion of suspend or hibernation of device in an
> + *   I/O pm domain.
>   * @dev: Device to suspend.
> + * @poweroff: Specifies if this is a poweroff_noirq or suspend_noirq callback.
>   *
>   * Stop the device and remove power from the domain if all devices in it have
>   * been stopped.
>   */
> -static int pm_genpd_suspend_noirq(struct device *dev)
> +static int genpd_finish_suspend(struct device *dev, bool poweroff)
>  {
>  	struct generic_pm_domain *genpd;
>  	int ret;
>  
> -	dev_dbg(dev, "%s()\n", __func__);
> -
>  	genpd = dev_to_genpd(dev);
>  	if (IS_ERR(genpd))
>  		return -EINVAL;
> @@ -919,6 +919,13 @@ static int pm_genpd_suspend_noirq(struct device *dev)
>  	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
>  		return 0;
>  
> +	if (poweroff)
> +		ret = pm_generic_poweroff_noirq(dev);
> +	else
> +		ret = pm_generic_suspend_noirq(dev);
> +	if (ret)
> +		return ret;
> +
>  	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
>  		ret = pm_runtime_force_suspend(dev);
>  		if (ret)
> @@ -934,6 +941,20 @@ static int pm_genpd_suspend_noirq(struct device *dev)
>  }
>  
>  /**
> + * pm_genpd_suspend_noirq - Completion of suspend of device in an I/O PM domain.
> + * @dev: Device to suspend.
> + *
> + * Stop the device and remove power from the domain if all devices in it have
> + * been stopped.
> + */
> +static int pm_genpd_suspend_noirq(struct device *dev)
> +{
> +	dev_dbg(dev, "%s()\n", __func__);
> +
> +	return genpd_finish_suspend(dev, false);
> +}
> +
> +/**
>   * pm_genpd_resume_noirq - Start of resume of device in an I/O PM domain.
>   * @dev: Device to resume.
>   *
> @@ -961,6 +982,10 @@ static int pm_genpd_resume_noirq(struct device *dev)
>  	if (genpd->dev_ops.stop && genpd->dev_ops.start)
>  		ret = pm_runtime_force_resume(dev);
>  
> +	ret = pm_generic_resume_noirq(dev);
> +	if (ret)
> +		return ret;
> +
>  	return ret;
>  }
>  
> @@ -984,6 +1009,10 @@ static int pm_genpd_freeze_noirq(struct device *dev)
>  	if (IS_ERR(genpd))
>  		return -EINVAL;
>  
> +	ret = pm_generic_freeze_noirq(dev);
> +	if (ret)
> +		return ret;
> +
>  	if (genpd->dev_ops.stop && genpd->dev_ops.start)
>  		ret = pm_runtime_force_suspend(dev);
>  
> @@ -1008,10 +1037,28 @@ static int pm_genpd_thaw_noirq(struct device *dev)
>  	if (IS_ERR(genpd))
>  		return -EINVAL;
>  
> -	if (genpd->dev_ops.stop && genpd->dev_ops.start)
> +	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
>  		ret = pm_runtime_force_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return ret;
> +	return pm_generic_thaw_noirq(dev);
> +}
> +
> +/**
> + * pm_genpd_poweroff_noirq - Completion of hibernation of device in an
> + *   I/O PM domain.
> + * @dev: Device to poweroff.
> + *
> + * Stop the device and remove power from the domain if all devices in it have
> + * been stopped.
> + */
> +static int pm_genpd_poweroff_noirq(struct device *dev)
> +{
> +	dev_dbg(dev, "%s()\n", __func__);
> +
> +	return genpd_finish_suspend(dev, true);
>  }
>  
>  /**
> @@ -1048,10 +1095,13 @@ static int pm_genpd_restore_noirq(struct device *dev)
>  	genpd_sync_power_on(genpd, true, 0);
>  	genpd_unlock(genpd);
>  
> -	if (genpd->dev_ops.stop && genpd->dev_ops.start)
> +	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
>  		ret = pm_runtime_force_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return ret;
> +	return pm_generic_restore_noirq(dev);
>  }
>  
>  /**
> @@ -1493,7 +1543,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  	genpd->domain.ops.resume_noirq = pm_genpd_resume_noirq;
>  	genpd->domain.ops.freeze_noirq = pm_genpd_freeze_noirq;
>  	genpd->domain.ops.thaw_noirq = pm_genpd_thaw_noirq;
> -	genpd->domain.ops.poweroff_noirq = pm_genpd_suspend_noirq;
> +	genpd->domain.ops.poweroff_noirq = pm_genpd_poweroff_noirq;
>  	genpd->domain.ops.restore_noirq = pm_genpd_restore_noirq;
>  	genpd->domain.ops.complete = pm_genpd_complete;
>  
> 
