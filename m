From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Wed, 3 Mar 2010 11:46:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003031140210.2821-100000@iolanthe.rowland.org>
References: <201003022351.39552.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003022351.39552.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2 Mar 2010, Rafael J. Wysocki wrote:

> +/**
> + * __pm_generic_call - Generic suspend/freeze/poweroff/thaw subsystem callback.
> + * @dev: Device to handle.
> + * @event: PM transition of the system under way.
> + *
> + * If the device has not been suspended at run time, execute the
> + * suspend/freeze/poweroff/thaw callback provided by its driver, if defined, and
> + * return the error code returned by it.  Otherwise, return zero.
> + */
> +static int __pm_generic_call(struct device *dev, int event)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int (*callback)(struct device *);
> +
> +	if (!pm || pm_runtime_suspended(dev))
> +		return 0;
> +
> +	switch (event) {
> +	case PM_EVENT_SUSPEND:
> +		callback = pm->suspend;
> +		break;
> +	case PM_EVENT_FREEZE:
> +		callback = pm->freeze;
> +		break;
> +	case PM_EVENT_HIBERNATE:
> +		callback = pm->poweroff;
> +		break;
> +	case PM_EVENT_THAW:
> +		callback = pm->thaw;
> +		break;
> +	default:
> +		callback = NULL;
> +		break;
> +	}
> +
> +	return callback ? callback(dev) : 0;
> +}

Are you sure you want to avoid calling pm->thaw if the device is 
runtime-suspended?  Maybe it would be better to treat thaw like resume 
or restore.

> --- linux-2.6.orig/include/linux/pm_runtime.h
> +++ linux-2.6/include/linux/pm_runtime.h
> @@ -62,6 +62,11 @@ static inline void device_set_run_wake(s
>  	dev->power.run_wake = enable;
>  }
>  
> +static inline bool pm_runtime_suspended(struct device *dev)
> +{
> +	return dev->power.runtime_status == RPM_SUSPENDED;
> +}
> +

You didn't add this to the documentation file.

Alan Stern
