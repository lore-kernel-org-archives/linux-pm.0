From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] trace_device_pm_callback coverage in dpm_prepare/dpm_complete
Date: Tue, 16 Jun 2015 01:38:34 +0200
Message-ID: <3051263.zCQIuDcxsO@vostro.rjw.lan>
References: <1432842953-2391-1-git-send-email-todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43986 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751202AbbFOXMh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:12:37 -0400
In-Reply-To: <1432842953-2391-1-git-send-email-todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com

On Thursday, May 28, 2015 12:55:53 PM Todd Brandt wrote:
> Moved the trace_device_pm_callback locations for dpm_prepare and dpm_complete
> to encompass the attempt to capture the device mutex prior to callback. This
> is needed by analyze_suspend to identify gaps in the trace output caused by
> the delay in locking the mutex for a device.
> 
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>

Queued up for 4.2, thanks!


> ---
>  drivers/base/power/main.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3d874ec..5528e59 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -920,9 +920,7 @@ static void device_complete(struct device *dev, pm_message_t state)
>  
>  	if (callback) {
>  		pm_dev_dbg(dev, state, info);
> -		trace_device_pm_callback_start(dev, info, state.event);
>  		callback(dev);
> -		trace_device_pm_callback_end(dev, 0);
>  	}
>  
>  	device_unlock(dev);
> @@ -954,7 +952,9 @@ void dpm_complete(pm_message_t state)
>  		list_move(&dev->power.entry, &list);
>  		mutex_unlock(&dpm_list_mtx);
>  
> +		trace_device_pm_callback_start(dev, "", state.event);
>  		device_complete(dev, state);
> +		trace_device_pm_callback_end(dev, 0);
>  
>  		mutex_lock(&dpm_list_mtx);
>  		put_device(dev);
> @@ -1585,11 +1585,8 @@ static int device_prepare(struct device *dev, pm_message_t state)
>  		callback = dev->driver->pm->prepare;
>  	}
>  
> -	if (callback) {
> -		trace_device_pm_callback_start(dev, info, state.event);
> +	if (callback)
>  		ret = callback(dev);
> -		trace_device_pm_callback_end(dev, ret);
> -	}
>  
>  	device_unlock(dev);
>  
> @@ -1631,7 +1628,9 @@ int dpm_prepare(pm_message_t state)
>  		get_device(dev);
>  		mutex_unlock(&dpm_list_mtx);
>  
> +		trace_device_pm_callback_start(dev, "", state.event);
>  		error = device_prepare(dev, state);
> +		trace_device_pm_callback_end(dev, error);
>  
>  		mutex_lock(&dpm_list_mtx);
>  		if (error) {
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
