From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
	for interrupt handlers
Date: Sat, 20 Nov 2010 13:56:11 +0100
Message-ID: <201011201356.11782.rjw__775.898507754569$1290258019$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1011191044400.1344-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1011191044400.1344-100000@iolanthe.rowland.org>
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, November 19, 2010, Alan Stern wrote:
> This patch (as1431b) makes the synchronous runtime-PM interface
> suitable for use in interrupt handlers.  Subsystems can call the new
> pm_runtime_irq_safe() function to tell the PM core that a device's
> runtime-PM callbacks should be invoked with interrupts disabled
> (runtime_suspend and runtime_resume callbacks will be invoked with the
> spinlock held as well).  This permits the pm_runtime_get_sync() and
> pm_runtime_put_sync() routines to be called from within interrupt
> handlers.
> 
> When a device is declared irq-safe in this way, the PM core increments
> the parent's usage count, so the parent will never be runtime
> suspended.  This prevents difficult situations in which an irq-safe
> device can't resume because it is forced to wait for its non-irq-safe
> parent.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> Index: usb-2.6/include/linux/pm.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm.h
> +++ usb-2.6/include/linux/pm.h
> @@ -486,6 +486,7 @@ struct dev_pm_info {
>  	unsigned int		run_wake:1;
>  	unsigned int		runtime_auto:1;
>  	unsigned int		no_callbacks:1;
> +	unsigned int		irq_safe:1;
>  	unsigned int		use_autosuspend:1;
>  	unsigned int		timer_autosuspends:1;
>  	enum rpm_request	request;
> Index: usb-2.6/include/linux/pm_runtime.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm_runtime.h
> +++ usb-2.6/include/linux/pm_runtime.h
> @@ -40,6 +40,7 @@ extern int pm_generic_runtime_idle(struc
>  extern int pm_generic_runtime_suspend(struct device *dev);
>  extern int pm_generic_runtime_resume(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> +extern void pm_runtime_irq_safe(struct device *dev);
>  extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
>  extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
>  extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
> @@ -123,6 +124,7 @@ static inline int pm_generic_runtime_idl
>  static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
>  static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
>  static inline void pm_runtime_no_callbacks(struct device *dev) {}
> +static inline void pm_runtime_irq_safe(struct device *dev) {}
>  
>  static inline void pm_runtime_mark_last_busy(struct device *dev) {}
>  static inline void __pm_runtime_use_autosuspend(struct device *dev,
> Index: usb-2.6/drivers/base/power/runtime.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/runtime.c
> +++ usb-2.6/drivers/base/power/runtime.c
> @@ -223,11 +223,19 @@ static int rpm_idle(struct device *dev, 
>  		callback = NULL;
>  
>  	if (callback) {
> -		spin_unlock_irq(&dev->power.lock);
> +		if (dev->power.irq_safe) {
> +			spin_unlock(&dev->power.lock);
>  
> -		callback(dev);
> +			callback(dev);
>  
> -		spin_lock_irq(&dev->power.lock);
> +			spin_lock(&dev->power.lock);
> +		} else {
> +			spin_unlock_irq(&dev->power.lock);
> +
> +			callback(dev);
> +
> +			spin_lock_irq(&dev->power.lock);
> +		}
>  	}

I didn't like this change before and I still don't like it.  Quite frankly, I'm
not sure I can convince Linus to pull it. :-)

Why don't we simply execute the callback under the spinlock in the
IRQ safe case?

Rafael
