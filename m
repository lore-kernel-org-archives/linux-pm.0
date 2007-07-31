From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 2/2] PM: Lock all devices during
	suspend/hibernate
Date: Wed, 1 Aug 2007 00:20:46 +0200
Message-ID: <200708010020.47144.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0707311648530.4896-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707311648530.4896-100000@iolanthe.rowland.org>
Content-Disposition: inline
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

On Tuesday, 31 July 2007 22:51, Alan Stern wrote:
> This patch adds an extra step to the device suspend/resume procedures, 
> in which every device is locked/unlocked.  In addition, a new global 
> rwsem prevents additional devices from being registered at these times.
> 
> Alan Stern
> 
> 
> Index: usb-2.6/drivers/base/power/main.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/main.c
> +++ usb-2.6/drivers/base/power/main.c
> @@ -24,17 +24,38 @@
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
>  #include <linux/resume-trace.h>
> +#include <linux/rwsem.h>
>  
>  #include "../base.h"
>  #include "power.h"
>  
> +/*
> + * The entries in the dpm_active list are in a depth first order, simply
> + * because children are guaranteed to be discovered after parents, and
> + * are inserted at the back of the list on discovery.
> + *
> + * All the other lists are kept in the same order, for consistency.
> + * However the lists aren't always traversed in the same order.
> + * Semaphores must be acquired from the top (i.e., front) down
> + * and released in the opposite order.  Devices must be suspended
> + * from the bottom (i.e., end) up and resumed in the opposite order.
> + * That way no parent will be suspended while it still has an active
> + * child.
> + *
> + * Since device_pm_add() may be called with a device semaphore held,
> + * we must never try to acquire a device semaphore while holding
> + * dpm_list_mutex.
> + */
> +
>  LIST_HEAD(dpm_active);
> +static LIST_HEAD(dpm_locked);
>  static LIST_HEAD(dpm_off);
>  static LIST_HEAD(dpm_off_irq);
>  
> -static DEFINE_MUTEX(dpm_mtx);
>  static DEFINE_MUTEX(dpm_list_mtx);
>  
> +static DECLARE_RWSEM(device_registration_rwsem);

Is it only intended for device registration, or can it be used in some other
code paths too?

> +
>  int (*platform_enable_wakeup)(struct device *dev, int is_on);
>  
>  
> @@ -59,29 +80,112 @@ void device_pm_remove(struct device *dev
>  	pr_debug("PM: Removing info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus",
>  		 kobject_name(&dev->kobj));
> +
> +	/* Don't remove a device while the PM core has it locked for suspend */
> +	down(&dev->sem);
>  	mutex_lock(&dpm_list_mtx);
>  	dpm_sysfs_remove(dev);
>  	list_del_init(&dev->power.entry);
>  	mutex_unlock(&dpm_list_mtx);
> +	up(&dev->sem);
> +}
> +
> +/**
> + *	device_add_pm_lock - mutual exclusion for registration and suspend
> + *
> + *	Returns 0 if no suspend is underway and device registration
> + *	may proceed, otherwise -EBUSY.
> + */
> +int device_add_pm_lock(void)
> +{
> +	if (down_read_trylock(&device_registration_rwsem))
> +		return 0;
> +	return -EBUSY;
> +}

I would do:

+	return down_read_trylock(&device_registration_rwsem) ? 0 : -EBUSY;

Apart from this, I have no comments. :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
