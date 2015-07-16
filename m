From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/3] PM / sleep: Allow devices without runtime PM to do direct-complete
Date: Thu, 16 Jul 2015 02:39:44 +0200
Message-ID: <2783936.xIzIf5IF0n@vostro.rjw.lan>
References: <1436964008-15151-1-git-send-email-tomeu.vizoso@collabora.com> <1436964008-15151-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63127 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754117AbbGPANH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 20:13:07 -0400
In-Reply-To: <1436964008-15151-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

On Wednesday, July 15, 2015 02:40:06 PM Tomeu Vizoso wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> Don't unset the direct_complete flag on devices that have runtime PM
> disabled, if they are runtime suspended.
> 
> This is needed because otherwise ancestor devices wouldn't be able to
> do direct_complete without adding runtime PM support to all its
> descendants.
> 
> Also removes pm_runtime_suspended_if_enabled() because it's now unused.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Applied, thanks!


> ---
> 
>  Documentation/power/devices.txt    | 7 +++++++
>  Documentation/power/runtime_pm.txt | 4 ----
>  drivers/base/power/main.c          | 2 +-
>  include/linux/pm_runtime.h         | 6 ------
>  4 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> index d172bce0fd49..8ba6625fdd63 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -341,6 +341,13 @@ the phases are:
>  	and is entirely responsible for bringing the device back to the
>  	functional state as appropriate.
>  
> +	Note that this direct-complete procedure applies even if the device is
> +	disabled for runtime PM; only the runtime-PM status matters.  It follows
> +	that if a device has system-sleep callbacks but does not support runtime
> +	PM, then its prepare callback must never return a positive value.  This
> +	is because all devices are initially set to runtime-suspended with
> +	runtime PM disabled.
> +
>      2.	The suspend methods should quiesce the device to stop it from performing
>  	I/O.  They also may save the device registers and put it into the
>  	appropriate low-power state, depending on the bus type the device is on,
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index e76dc0ad4d2b..0784bc3a2ab5 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -445,10 +445,6 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>    bool pm_runtime_status_suspended(struct device *dev);
>      - return true if the device's runtime PM status is 'suspended'
>  
> -  bool pm_runtime_suspended_if_enabled(struct device *dev);
> -    - return true if the device's runtime PM status is 'suspended' and its
> -      'power.disable_depth' field is equal to 1
> -
>    void pm_runtime_allow(struct device *dev);
>      - set the power.runtime_auto flag for the device and decrease its usage
>        counter (used by the /sys/devices/.../power/control interface to
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 30b7bbfdc558..1710c26ba097 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1377,7 +1377,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  	if (dev->power.direct_complete) {
>  		if (pm_runtime_status_suspended(dev)) {
>  			pm_runtime_disable(dev);
> -			if (pm_runtime_suspended_if_enabled(dev))
> +			if (pm_runtime_status_suspended(dev))
>  				goto Complete;
>  
>  			pm_runtime_enable(dev);
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 30e84d48bfea..3bdbb4189780 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -98,11 +98,6 @@ static inline bool pm_runtime_status_suspended(struct device *dev)
>  	return dev->power.runtime_status == RPM_SUSPENDED;
>  }
>  
> -static inline bool pm_runtime_suspended_if_enabled(struct device *dev)
> -{
> -	return pm_runtime_status_suspended(dev) && dev->power.disable_depth == 1;
> -}
> -
>  static inline bool pm_runtime_enabled(struct device *dev)
>  {
>  	return !dev->power.disable_depth;
> @@ -164,7 +159,6 @@ static inline void device_set_run_wake(struct device *dev, bool enable) {}
>  static inline bool pm_runtime_suspended(struct device *dev) { return false; }
>  static inline bool pm_runtime_active(struct device *dev) { return true; }
>  static inline bool pm_runtime_status_suspended(struct device *dev) { return false; }
> -static inline bool pm_runtime_suspended_if_enabled(struct device *dev) { return false; }
>  static inline bool pm_runtime_enabled(struct device *dev) { return false; }
>  
>  static inline void pm_runtime_no_callbacks(struct device *dev) {}
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
