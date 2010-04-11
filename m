From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] runtime pm: add sysfs debug files
Date: Sun, 11 Apr 2010 14:54:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004111445260.13658-100000@netrider.rowland.org>
References: <20100411150136.GA6693@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100411150136.GA6693@comet.dominikbrodowski.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 11 Apr 2010, Dominik Brodowski wrote:

> Add a few sysfs files relating to runtime power management for
> advanced debug purposes:
> 
> runtime_status:	what state is the device in currently? E.g., it
> 	reports "disabled" if runtime power management is
> 	disabled for a device, "suspended" for runtime-suspended
> 	devices, and "active" for active devices.
> 
> runtime_usage: the runtime PM usage count of a device
> 
> runtime_children: the runtime PM children usage count of a device, or
> 	0 if the ignore_children flag is set.
> 
> Also, CONFIG_PM_SLEEP_ADVANCED_DEBUG is not defined in any Kconfig
> file, so replace it with CONFIG_PM_ADVANCED_DEBUG.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Just a couple of minor comments...

> @@ -143,7 +144,49 @@ wake_store(struct device * dev, struct device_attribute *attr,
>  
>  static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
>  
> -#ifdef CONFIG_PM_SLEEP_ADVANCED_DEBUG
> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> +#ifdef CONFIG_PM_RUNTIME
> +
> +static ssize_t usagecount_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
> +}
> +
> +static ssize_t children_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", dev->power.ignore_children ?
> +		0 : atomic_read(&dev->power.child_count));
> +}
> +
> +static ssize_t rtpm_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	int status = dev->power.runtime_status;

You don't need this variable.  Use dev->power.runtime_status directly
in the switch statement.

> +	if (dev->power.disable_depth)
> +		return sprintf(buf, "disabled\n");
> +	if (dev->power.runtime_auto == false)
> +		return sprintf(buf, "forbidden\n");

The logic here isn't right.  A "disabled" device can be either 
suspended or active.  The same holds for a "forbidden" device 
(although the suspended-and-forbidden combination would be rather 
unusual).  And a device can be both "disabled" and "forbidden".

In addition, you need to check for the runtime error state.  In this 
state, a device is neither active nor suspended.

> +	switch (status) {
> +	case RPM_SUSPENDED:
> +		return sprintf(buf, "suspended\n");
> +	case RPM_SUSPENDING:
> +		return sprintf(buf, "to be suspended\n");

Use "suspending", not "to be suspended".

> +	case RPM_RESUMING:
> +		return sprintf(buf, "to be resumed\n");

Use "resuming", not "to be resumed".

> +	case RPM_ACTIVE:
> +		return sprintf(buf, "active\n");
> +	}
> +	return -EIO;
> +}
> +
> +static DEVICE_ATTR(runtime_usage, 0444, usagecount_show, NULL);
> +static DEVICE_ATTR(runtime_children, 0444, children_show, NULL);

"runtime_children" seems like a slightly odd name.  It isn't the number 
of children; it's the number of _active_ children.  But I don't have 
any suggestions for a better name.

Alan Stern
