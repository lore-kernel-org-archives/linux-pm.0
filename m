From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/7] PM: combine runtime PM entry points
Date: Sat, 25 Sep 2010 23:45:12 +0200
Message-ID: <201009252345.12618.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009241636310.1287-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009241636310.1287-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 24, 2010, Alan Stern wrote:
> This patch (as1424) combines the various public entry points for the
> runtime PM routines into three simple functions: one for idle, one for
> suspend, and one for resume.  A new bitflag specifies whether or not
> to increment or decrement the usage_count field.
> 
> The new entry points are named __pm_runtime_idle,
> __pm_runtime_suspend, and __pm_runtime_resume, to reflect that they
> are trampolines.  Simultaneously, the corresponding internal routines
> are renamed to rpm_idle, rpm_suspend, and rpm_resume.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Appled  to suspend-2.6/linux-next.

Thanks,
Rafael


> ---
> 
> Index: usb-2.6/include/linux/pm_runtime.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm_runtime.h
> +++ usb-2.6/include/linux/pm_runtime.h
> @@ -16,19 +16,17 @@
>  #define RPM_ASYNC		0x01	/* Request is asynchronous */
>  #define RPM_NOWAIT		0x02	/* Don't wait for concurrent
>  					    state change */
> +#define RPM_GET_PUT		0x04	/* Increment/decrement the
> +					    usage_count */
>  
>  #ifdef CONFIG_PM_RUNTIME
>  
>  extern struct workqueue_struct *pm_wq;
>  
> -extern int pm_runtime_idle(struct device *dev);
> -extern int pm_runtime_suspend(struct device *dev);
> -extern int pm_runtime_resume(struct device *dev);
> -extern int pm_request_idle(struct device *dev);
> +extern int __pm_runtime_idle(struct device *dev, int rpmflags);
> +extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
> +extern int __pm_runtime_resume(struct device *dev, int rpmflags);
>  extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
> -extern int pm_request_resume(struct device *dev);
> -extern int __pm_runtime_get(struct device *dev, int rpmflags);
> -extern int __pm_runtime_put(struct device *dev, int rpmflags);
>  extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
>  extern int pm_runtime_barrier(struct device *dev);
>  extern void pm_runtime_enable(struct device *dev);
> @@ -77,19 +75,22 @@ static inline bool pm_runtime_suspended(
>  
>  #else /* !CONFIG_PM_RUNTIME */
>  
> -static inline int pm_runtime_idle(struct device *dev) { return -ENOSYS; }
> -static inline int pm_runtime_suspend(struct device *dev) { return -ENOSYS; }
> -static inline int pm_runtime_resume(struct device *dev) { return 0; }
> -static inline int pm_request_idle(struct device *dev) { return -ENOSYS; }
> +static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
> +{
> +	return -ENOSYS;
> +}
> +static inline int __pm_runtime_suspend(struct device *dev, int rpmflags)
> +{
> +	return -ENOSYS;
> +}
> +static inline int __pm_runtime_resume(struct device *dev, int rpmflags)
> +{
> +	return 1;
> +}
>  static inline int pm_schedule_suspend(struct device *dev, unsigned int delay)
>  {
>  	return -ENOSYS;
>  }
> -static inline int pm_request_resume(struct device *dev) { return 0; }
> -static inline int __pm_runtime_get(struct device *dev, int rpmflags)
> -					{ return 1; }
> -static inline int __pm_runtime_put(struct device *dev, int rpmflags)
> -					{ return 0; }
>  static inline int __pm_runtime_set_status(struct device *dev,
>  					    unsigned int status) { return 0; }
>  static inline int pm_runtime_barrier(struct device *dev) { return 0; }
> @@ -112,24 +113,49 @@ static inline int pm_generic_runtime_res
>  
>  #endif /* !CONFIG_PM_RUNTIME */
>  
> +static inline int pm_runtime_idle(struct device *dev)
> +{
> +	return __pm_runtime_idle(dev, 0);
> +}
> +
> +static inline int pm_runtime_suspend(struct device *dev)
> +{
> +	return __pm_runtime_suspend(dev, 0);
> +}
> +
> +static inline int pm_runtime_resume(struct device *dev)
> +{
> +	return __pm_runtime_resume(dev, 0);
> +}
> +
> +static inline int pm_request_idle(struct device *dev)
> +{
> +	return __pm_runtime_idle(dev, RPM_ASYNC);
> +}
> +
> +static inline int pm_request_resume(struct device *dev)
> +{
> +	return __pm_runtime_resume(dev, RPM_ASYNC);
> +}
> +
>  static inline int pm_runtime_get(struct device *dev)
>  {
> -	return __pm_runtime_get(dev, RPM_ASYNC);
> +	return __pm_runtime_resume(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>  
>  static inline int pm_runtime_get_sync(struct device *dev)
>  {
> -	return __pm_runtime_get(dev, 0);
> +	return __pm_runtime_resume(dev, RPM_GET_PUT);
>  }
>  
>  static inline int pm_runtime_put(struct device *dev)
>  {
> -	return __pm_runtime_put(dev, RPM_ASYNC);
> +	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>  
>  static inline int pm_runtime_put_sync(struct device *dev)
>  {
> -	return __pm_runtime_put(dev, 0);
> +	return __pm_runtime_idle(dev, RPM_GET_PUT);
>  }
>  
>  static inline int pm_runtime_set_active(struct device *dev)
> Index: usb-2.6/drivers/base/power/runtime.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/runtime.c
> +++ usb-2.6/drivers/base/power/runtime.c
> @@ -11,7 +11,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/jiffies.h>
>  
> -static int __pm_runtime_resume(struct device *dev, int rpmflags);
> +static int rpm_resume(struct device *dev, int rpmflags);
>  
>  /**
>   * update_pm_runtime_accounting - Update the time accounting of power states
> @@ -107,7 +107,7 @@ static int rpm_check_suspend_allowed(str
>  
>  
>  /**
> - * __pm_runtime_idle - Notify device bus type if the device can be suspended.
> + * rpm_idle - Notify device bus type if the device can be suspended.
>   * @dev: Device to notify the bus type about.
>   * @rpmflags: Flag bits.
>   *
> @@ -118,7 +118,7 @@ static int rpm_check_suspend_allowed(str
>   *
>   * This function must be called under dev->power.lock with interrupts disabled.
>   */
> -static int __pm_runtime_idle(struct device *dev, int rpmflags)
> +static int rpm_idle(struct device *dev, int rpmflags)
>  	__releases(&dev->power.lock) __acquires(&dev->power.lock)
>  {
>  	int retval;
> @@ -189,23 +189,7 @@ static int __pm_runtime_idle(struct devi
>  }
>  
>  /**
> - * pm_runtime_idle - Notify device bus type if the device can be suspended.
> - * @dev: Device to notify the bus type about.
> - */
> -int pm_runtime_idle(struct device *dev)
> -{
> -	int retval;
> -
> -	spin_lock_irq(&dev->power.lock);
> -	retval = __pm_runtime_idle(dev, 0);
> -	spin_unlock_irq(&dev->power.lock);
> -
> -	return retval;
> -}
> -EXPORT_SYMBOL_GPL(pm_runtime_idle);
> -
> -/**
> - * __pm_runtime_suspend - Carry out run-time suspend of given device.
> + * rpm_suspend - Carry out run-time suspend of given device.
>   * @dev: Device to suspend.
>   * @rpmflags: Flag bits.
>   *
> @@ -220,7 +204,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_idle);
>   *
>   * This function must be called under dev->power.lock with interrupts disabled.
>   */
> -static int __pm_runtime_suspend(struct device *dev, int rpmflags)
> +static int rpm_suspend(struct device *dev, int rpmflags)
>  	__releases(&dev->power.lock) __acquires(&dev->power.lock)
>  {
>  	struct device *parent = NULL;
> @@ -332,13 +316,13 @@ static int __pm_runtime_suspend(struct d
>  	wake_up_all(&dev->power.wait_queue);
>  
>  	if (dev->power.deferred_resume) {
> -		__pm_runtime_resume(dev, 0);
> +		rpm_resume(dev, 0);
>  		retval = -EAGAIN;
>  		goto out;
>  	}
>  
>  	if (notify)
> -		__pm_runtime_idle(dev, 0);
> +		rpm_idle(dev, 0);
>  
>  	if (parent && !parent->power.ignore_children) {
>  		spin_unlock_irq(&dev->power.lock);
> @@ -355,23 +339,7 @@ static int __pm_runtime_suspend(struct d
>  }
>  
>  /**
> - * pm_runtime_suspend - Carry out run-time suspend of given device.
> - * @dev: Device to suspend.
> - */
> -int pm_runtime_suspend(struct device *dev)
> -{
> -	int retval;
> -
> -	spin_lock_irq(&dev->power.lock);
> -	retval = __pm_runtime_suspend(dev, 0);
> -	spin_unlock_irq(&dev->power.lock);
> -
> -	return retval;
> -}
> -EXPORT_SYMBOL_GPL(pm_runtime_suspend);
> -
> -/**
> - * __pm_runtime_resume - Carry out run-time resume of given device.
> + * rpm_resume - Carry out run-time resume of given device.
>   * @dev: Device to resume.
>   * @rpmflags: Flag bits.
>   *
> @@ -387,7 +355,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_suspend);
>   *
>   * This function must be called under dev->power.lock with interrupts disabled.
>   */
> -static int __pm_runtime_resume(struct device *dev, int rpmflags)
> +static int rpm_resume(struct device *dev, int rpmflags)
>  	__releases(&dev->power.lock) __acquires(&dev->power.lock)
>  {
>  	struct device *parent = NULL;
> @@ -469,7 +437,7 @@ static int __pm_runtime_resume(struct de
>  		 */
>  		if (!parent->power.disable_depth
>  		    && !parent->power.ignore_children) {
> -			__pm_runtime_resume(parent, 0);
> +			rpm_resume(parent, 0);
>  			if (parent->power.runtime_status != RPM_ACTIVE)
>  				retval = -EBUSY;
>  		}
> @@ -521,7 +489,7 @@ static int __pm_runtime_resume(struct de
>  	wake_up_all(&dev->power.wait_queue);
>  
>  	if (!retval)
> -		__pm_runtime_idle(dev, RPM_ASYNC);
> +		rpm_idle(dev, RPM_ASYNC);
>  
>   out:
>  	if (parent) {
> @@ -538,22 +506,6 @@ static int __pm_runtime_resume(struct de
>  }
>  
>  /**
> - * pm_runtime_resume - Carry out run-time resume of given device.
> - * @dev: Device to suspend.
> - */
> -int pm_runtime_resume(struct device *dev)
> -{
> -	int retval;
> -
> -	spin_lock_irq(&dev->power.lock);
> -	retval = __pm_runtime_resume(dev, 0);
> -	spin_unlock_irq(&dev->power.lock);
> -
> -	return retval;
> -}
> -EXPORT_SYMBOL_GPL(pm_runtime_resume);
> -
> -/**
>   * pm_runtime_work - Universal run-time PM work function.
>   * @work: Work structure used for scheduling the execution of this function.
>   *
> @@ -578,13 +530,13 @@ static void pm_runtime_work(struct work_
>  	case RPM_REQ_NONE:
>  		break;
>  	case RPM_REQ_IDLE:
> -		__pm_runtime_idle(dev, RPM_NOWAIT);
> +		rpm_idle(dev, RPM_NOWAIT);
>  		break;
>  	case RPM_REQ_SUSPEND:
> -		__pm_runtime_suspend(dev, RPM_NOWAIT);
> +		rpm_suspend(dev, RPM_NOWAIT);
>  		break;
>  	case RPM_REQ_RESUME:
> -		__pm_runtime_resume(dev, RPM_NOWAIT);
> +		rpm_resume(dev, RPM_NOWAIT);
>  		break;
>  	}
>  
> @@ -593,23 +545,6 @@ static void pm_runtime_work(struct work_
>  }
>  
>  /**
> - * pm_request_idle - Submit an idle notification request for given device.
> - * @dev: Device to handle.
> - */
> -int pm_request_idle(struct device *dev)
> -{
> -	unsigned long flags;
> -	int retval;
> -
> -	spin_lock_irqsave(&dev->power.lock, flags);
> -	retval = __pm_runtime_idle(dev, RPM_ASYNC);
> -	spin_unlock_irqrestore(&dev->power.lock, flags);
> -
> -	return retval;
> -}
> -EXPORT_SYMBOL_GPL(pm_request_idle);
> -
> -/**
>   * pm_suspend_timer_fn - Timer function for pm_schedule_suspend().
>   * @data: Device pointer passed by pm_schedule_suspend().
>   *
> @@ -627,7 +562,7 @@ static void pm_suspend_timer_fn(unsigned
>  	/* If 'expire' is after 'jiffies' we've been called too early. */
>  	if (expires > 0 && !time_after(expires, jiffies)) {
>  		dev->power.timer_expires = 0;
> -		__pm_runtime_suspend(dev, RPM_ASYNC);
> +		rpm_suspend(dev, RPM_ASYNC);
>  	}
>  
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
> @@ -646,7 +581,7 @@ int pm_schedule_suspend(struct device *d
>  	spin_lock_irqsave(&dev->power.lock, flags);
>  
>  	if (!delay) {
> -		retval = __pm_runtime_suspend(dev, RPM_ASYNC);
> +		retval = rpm_suspend(dev, RPM_ASYNC);
>  		goto out;
>  	}
>  
> @@ -669,62 +604,81 @@ int pm_schedule_suspend(struct device *d
>  EXPORT_SYMBOL_GPL(pm_schedule_suspend);
>  
>  /**
> - * pm_request_resume - Submit a resume request for given device.
> - * @dev: Device to resume.
> + * __pm_runtime_idle - Entry point for run-time idle operations.
> + * @dev: Device to send idle notification for.
> + * @rpmflags: Flag bits.
> + *
> + * If the RPM_GET_PUT flag is set, decrement the device's usage count and
> + * return immediately if it is larger than zero.  Then carry out an idle
> + * notification, either synchronous or asynchronous.
> + *
> + * This routine may be called in atomic context if the RPM_ASYNC flag is set.
>   */
> -int pm_request_resume(struct device *dev)
> +int __pm_runtime_idle(struct device *dev, int rpmflags)
>  {
>  	unsigned long flags;
>  	int retval;
>  
> +	if (rpmflags & RPM_GET_PUT) {
> +		if (!atomic_dec_and_test(&dev->power.usage_count))
> +			return 0;
> +	}
> +
>  	spin_lock_irqsave(&dev->power.lock, flags);
> -	retval = __pm_runtime_resume(dev, RPM_ASYNC);
> +	retval = rpm_idle(dev, rpmflags);
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
>  
>  	return retval;
>  }
> -EXPORT_SYMBOL_GPL(pm_request_resume);
> +EXPORT_SYMBOL_GPL(__pm_runtime_idle);
>  
>  /**
> - * __pm_runtime_get - Reference count a device and wake it up, if necessary.
> - * @dev: Device to handle.
> + * __pm_runtime_suspend - Entry point for run-time put/suspend operations.
> + * @dev: Device to suspend.
>   * @rpmflags: Flag bits.
>   *
> - * Increment the usage count of the device and resume it or submit a resume
> - * request for it, depending on the RPM_ASYNC flag bit.
> + * Carry out a suspend, either synchronous or asynchronous.
> + *
> + * This routine may be called in atomic context if the RPM_ASYNC flag is set.
>   */
> -int __pm_runtime_get(struct device *dev, int rpmflags)
> +int __pm_runtime_suspend(struct device *dev, int rpmflags)
>  {
> +	unsigned long flags;
>  	int retval;
>  
> -	atomic_inc(&dev->power.usage_count);
> -	retval = (rpmflags & RPM_ASYNC) ?
> -	    pm_request_resume(dev) : pm_runtime_resume(dev);
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	retval = rpm_suspend(dev, rpmflags);
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
>  
>  	return retval;
>  }
> -EXPORT_SYMBOL_GPL(__pm_runtime_get);
> +EXPORT_SYMBOL_GPL(__pm_runtime_suspend);
>  
>  /**
> - * __pm_runtime_put - Decrement the device's usage counter and notify its bus.
> - * @dev: Device to handle.
> + * __pm_runtime_resume - Entry point for run-time resume operations.
> + * @dev: Device to resume.
>   * @rpmflags: Flag bits.
>   *
> - * Decrement the usage count of the device and if it reaches zero, carry out a
> - * synchronous idle notification or submit an idle notification request for it,
> - * depending on the RPM_ASYNC flag bit.
> + * If the RPM_GET_PUT flag is set, increment the device's usage count.  Then
> + * carry out a resume, either synchronous or asynchronous.
> + *
> + * This routine may be called in atomic context if the RPM_ASYNC flag is set.
>   */
> -int __pm_runtime_put(struct device *dev, int rpmflags)
> +int __pm_runtime_resume(struct device *dev, int rpmflags)
>  {
> -	int retval = 0;
> +	unsigned long flags;
> +	int retval;
>  
> -	if (atomic_dec_and_test(&dev->power.usage_count))
> -		retval = (rpmflags & RPM_ASYNC) ?
> -		    pm_request_idle(dev) : pm_runtime_idle(dev);
> +	if (rpmflags & RPM_GET_PUT)
> +		atomic_inc(&dev->power.usage_count);
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	retval = rpm_resume(dev, rpmflags);
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
>  
>  	return retval;
>  }
> -EXPORT_SYMBOL_GPL(__pm_runtime_put);
> +EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>  
>  /**
>   * __pm_runtime_set_status - Set run-time PM status of a device.
> @@ -875,7 +829,7 @@ int pm_runtime_barrier(struct device *de
>  
>  	if (dev->power.request_pending
>  	    && dev->power.request == RPM_REQ_RESUME) {
> -		__pm_runtime_resume(dev, 0);
> +		rpm_resume(dev, 0);
>  		retval = 1;
>  	}
>  
> @@ -924,7 +878,7 @@ void __pm_runtime_disable(struct device 
>  		 */
>  		pm_runtime_get_noresume(dev);
>  
> -		__pm_runtime_resume(dev, 0);
> +		rpm_resume(dev, 0);
>  
>  		pm_runtime_put_noidle(dev);
>  	}
> @@ -972,7 +926,7 @@ void pm_runtime_forbid(struct device *de
>  
>  	dev->power.runtime_auto = false;
>  	atomic_inc(&dev->power.usage_count);
> -	__pm_runtime_resume(dev, 0);
> +	rpm_resume(dev, 0);
>  
>   out:
>  	spin_unlock_irq(&dev->power.lock);
> @@ -993,7 +947,7 @@ void pm_runtime_allow(struct device *dev
>  
>  	dev->power.runtime_auto = true;
>  	if (atomic_dec_and_test(&dev->power.usage_count))
> -		__pm_runtime_idle(dev, 0);
> +		rpm_idle(dev, 0);
>  
>   out:
>  	spin_unlock_irq(&dev->power.lock);
> 
> 
> 
