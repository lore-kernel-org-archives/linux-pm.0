From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / Runtime: Extend the scope for pm_runtime_remove()
Date: Tue, 17 Nov 2015 14:58:26 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1511171455390.1680-100000@iolanthe.rowland.org>
References: <1447770929-16652-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43610 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751822AbbKQT61 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 14:58:27 -0500
In-Reply-To: <1447770929-16652-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eduardo Valentin <edubezval@gmail.com>

On Tue, 17 Nov 2015, Ulf Hansson wrote:

> There are additional execution paths besides the device removal, which
> needs to be able to restore initial states of runtime PM.
> 
> To prepare for these changes, provide a parameter to pm_runtime_remove()
> to allow optional disabling of runtime PM and reset the irq_safe flag.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/main.c    |  2 +-
>  drivers/base/power/power.h   |  6 +++---
>  drivers/base/power/runtime.c | 21 +++++++++++++--------
>  3 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 1710c26..6b6c79b 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -146,7 +146,7 @@ void device_pm_remove(struct device *dev)
>  	list_del_init(&dev->power.entry);
>  	mutex_unlock(&dpm_list_mtx);
>  	device_wakeup_disable(dev);
> -	pm_runtime_remove(dev);
> +	pm_runtime_remove(dev, true);
>  }
>  
>  /**
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 998fa6b..5057a21 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -18,7 +18,7 @@ static inline void pm_runtime_early_init(struct device *dev)
>  }
>  
>  extern void pm_runtime_init(struct device *dev);
> -extern void pm_runtime_remove(struct device *dev);
> +extern void pm_runtime_remove(struct device *dev, bool disable);

Instead of adding a flag, how about adding a new routine?
pm_runtime_reinit(), for example?  I think that would be a little
clearer.

Then pm_runtime_remove could be refactored to do its disable and call
pm_runtime_reinit.

> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1393,15 +1393,20 @@ void pm_runtime_init(struct device *dev)
>   * pm_runtime_remove - Prepare for removing a device from device hierarchy.
>   * @dev: Device object being removed from device hierarchy.
>   */
> -void pm_runtime_remove(struct device *dev)
> +void pm_runtime_remove(struct device *dev, bool disable)
>  {
> -	__pm_runtime_disable(dev, false);
> -
> -	/* Change the status back to 'suspended' to match the initial status. */
> -	if (dev->power.runtime_status == RPM_ACTIVE)
> -		pm_runtime_set_suspended(dev);
> -	if (dev->power.irq_safe && dev->parent)
> -		pm_runtime_put(dev->parent);
> +	if (disable)
> +		__pm_runtime_disable(dev, false);
> +
> +	if (!pm_runtime_enabled(dev)) {
> +		/* Restore initial runtime PM states. */
> +		if (dev->power.runtime_status == RPM_ACTIVE)
> +			pm_runtime_set_suspended(dev);
> +		if (dev->power.irq_safe && dev->parent) {
> +			pm_runtime_put(dev->parent);
> +			dev->power.irq_safe = 0;

This flag should be protected by the dev->power.lock spinlock, just 
like in pm_runtime_irq_safe().

Alan Stern

