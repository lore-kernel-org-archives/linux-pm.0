From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Add no_suspend attribute V2] Let the driver
 know if	it's in	use
Date: Fri, 24 Apr 2009 19:55:55 +0200
Message-ID: <49F1FD2B.5020906@gandalf.sssup.it>
References: <20090424172435.GA18448@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090424172435.GA18448@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: len.brown@intel.com, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

Hi

I add all in cc because mutt give me some trouble :(
Michael Trimarchi wrote:
> Drivers on embedded systems would be smart enough to know that some
> of the devices _should_ remain powered up, because they could still
> be useful even when the CPU wasn't running.  The only obstacle is
> letting the drivers know when their devices actually _are_ in use
> and sometimes this is apparent only at the application level.
> The patch add the no_suspend attribute and it can be used by the
> the drivers to stop power down during suspend.
>
> Signed-off-by: Michael Trimarchi <trimarchi@gandalf.sssup.it>
> Cc: "Alan Stern" <stern@rowland.harvard.edu>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: "Pavel Mackek" <pavel@ucw.cz>
> Cc: "Len Brown" <lenb@kernel.org>
>
> ---
>  drivers/base/power/main.c  |   54 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/base/power/power.h |    5 ++++
>  include/linux/device.h     |    1 +
>  include/linux/pm.h         |    3 ++
>  4 files changed, 62 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 69b4ddb..baae309 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -65,6 +65,45 @@ void device_pm_unlock(void)
>  }
>  
>  /**
> + *	device_set_no_suspend_enable - Mark the device as used by userspace
> + *	application
> + */
> +void device_set_no_suspend_enable(struct device *dev, bool enable)
> +{
> +	struct device *next;
> +
> +	mutex_lock(&dpm_list_mtx);
> +
> +	/* the new status is equal the old one */
> +	if (dev->power.no_suspend == !!enable)
> +		goto out;
> +
> +	/* change the device status */
> +	dev->power.no_suspend = !!enable;
> +	if (dev->power.no_suspend)
> +		dev->power.subtree_no_suspend = 0;
>   
I find a bug here, i will fix.
It can be ok the rest of the code?
> +
> +	list_for_each_entry_reverse(next, &dev->power.entry, power.entry) {
> +		/* 
> +		 * exit if we find a node with the same parent of the start
> +		 * device
> +		 */
> +		if (dev->parent && next->parent == dev->parent)
> +			break;
> +
> +		if (next->parent) {
> +			/* Propagate the status */
> +			next->power.subtree_no_suspend =
> +				device_no_suspend_enable(next->parent);
> +		}
> +	}
> +out:
> +	mutex_unlock(&dpm_list_mtx);
> +	return;
> +}
> +EXPORT_SYMBOL_GPL(device_set_no_suspend_enable);
> +
> +/**
>   *	device_pm_add - add a device to the list of active devices
>   *	@dev:	Device to be added to the list
>   */
> @@ -78,6 +117,11 @@ void device_pm_add(struct device *dev)
>  		if (dev->parent->power.status >= DPM_SUSPENDING)
>  			dev_warn(dev, "parent %s should not be sleeping\n",
>  				 dev_name(dev->parent));
> +		if (device_no_suspend_enable(dev->parent)) {
> +			/* if the parent has suspend disable, propagate it
> +			 * to the new child */
> +			dev->power.subtree_no_suspend = 1;
> +		}
>  	} else if (transition_started) {
>  		/*
>  		 * We refuse to register parentless devices while a PM
> @@ -87,7 +131,15 @@ void device_pm_add(struct device *dev)
>  		dev_WARN(dev, "Parentless device registered during a PM transaction\n");
>  	}
>  
> -	list_add_tail(&dev->power.entry, &dpm_list);
> +	if (dev->parent) {
> +		/*
> +		 * if the device has a parent insert just before it.
> +		 */
> +		list_add_tail(&dev->power.entry, &(dev->parent)->power.entry);
> +	}
> +	else
> +		list_add_tail(&dev->power.entry, &dpm_list);
> +
>  	mutex_unlock(&dpm_list_mtx);
>  }
>  
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index c7cb4fc..a997b20 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -3,6 +3,11 @@ static inline void device_pm_init(struct device *dev)
>  	dev->power.status = DPM_ON;
>  }
>  
> +static inline int device_no_suspend_enable(struct device *dev)
> +{
> +	return dev->power.no_suspend || dev->power.subtree_no_suspend;
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  
>  /*
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 2918c0e..74ca60d 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -496,6 +496,7 @@ extern struct device *device_find_child(struct device *dev, void *data,
>  extern int device_rename(struct device *dev, char *new_name);
>  extern int device_move(struct device *dev, struct device *new_parent,
>  		       enum dpm_order dpm_order);
> +extern void device_set_no_suspend_enable(struct device *dev, bool enable);
>  
>  /*
>   * Root device objects for grouping under /sys/devices
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 1d4e2d2..e664d63 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -319,6 +319,9 @@ struct dev_pm_info {
>  	pm_message_t		power_state;
>  	unsigned		can_wakeup:1;
>  	unsigned		should_wakeup:1;
> +	unsigned		no_suspend:1;
> +	unsigned		subtree_no_suspend:1;
> +
>  	enum dpm_state		status;		/* Owned by the PM core */
>  #ifdef	CONFIG_PM_SLEEP
>  	struct list_head	entry;
>   
