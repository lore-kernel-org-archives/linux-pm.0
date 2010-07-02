From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: make runtime_status attribute not
	debug-only
Date: Fri, 2 Jul 2010 21:14:41 +0200
Message-ID: <201007022114.41645.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1007021248460.1309-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007021248460.1309-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Friday, July 02, 2010, Alan Stern wrote:
> This patch (as1404) makes the runtime_status sysfs attribute available
> even in the absence of CONFIG_PM_ADVANCED_DEBUG, and it changes the
> routine to display "unknown" when runtime PM is disabled for a device.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> Maybe "unsupported" would be a little better than "unknown".  What do 
> you think?

I thought about that.  "Unsupported" seems to suggest that the device/driver
doesn't support runtime PM, whiile in fact it may be supported, although it's
not enabled at the moment.

Rafael


> Index: usb-2.6/drivers/base/power/sysfs.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/sysfs.c
> +++ usb-2.6/drivers/base/power/sysfs.c
> @@ -108,6 +108,38 @@ static ssize_t control_store(struct devi
>  }
>  
>  static DEVICE_ATTR(control, 0644, control_show, control_store);
> +
> +static ssize_t rtpm_status_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	const char *p;
> +
> +	if (dev->power.runtime_error) {
> +		p = "error\n";
> +	} else if (dev->power.disable_depth) {
> +		p = "unknown\n";
> +	} else {
> +		switch (dev->power.runtime_status) {
> +		case RPM_SUSPENDED:
> +			p = "suspended\n";
> +			break;
> +		case RPM_SUSPENDING:
> +			p = "suspending\n";
> +			break;
> +		case RPM_RESUMING:
> +			p = "resuming\n";
> +			break;
> +		case RPM_ACTIVE:
> +			p = "active\n";
> +			break;
> +		default:
> +			return -EIO;
> +		}
> +	}
> +	return sprintf(buf, p);
> +}
> +
> +static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
>  #endif
>  
>  static ssize_t
> @@ -172,27 +204,8 @@ static ssize_t rtpm_enabled_show(struct 
>  	return sprintf(buf, "enabled\n");
>  }
>  
> -static ssize_t rtpm_status_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	if (dev->power.runtime_error)
> -		return sprintf(buf, "error\n");
> -	switch (dev->power.runtime_status) {
> -	case RPM_SUSPENDED:
> -		return sprintf(buf, "suspended\n");
> -	case RPM_SUSPENDING:
> -		return sprintf(buf, "suspending\n");
> -	case RPM_RESUMING:
> -		return sprintf(buf, "resuming\n");
> -	case RPM_ACTIVE:
> -		return sprintf(buf, "active\n");
> -	}
> -	return -EIO;
> -}
> -
>  static DEVICE_ATTR(runtime_usage, 0444, rtpm_usagecount_show, NULL);
>  static DEVICE_ATTR(runtime_active_kids, 0444, rtpm_children_show, NULL);
> -static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
>  static DEVICE_ATTR(runtime_enabled, 0444, rtpm_enabled_show, NULL);
>  
>  #endif
> @@ -228,6 +241,7 @@ static DEVICE_ATTR(async, 0644, async_sh
>  static struct attribute * power_attrs[] = {
>  #ifdef CONFIG_PM_RUNTIME
>  	&dev_attr_control.attr,
> +	&dev_attr_runtime_status.attr,
>  #endif
>  	&dev_attr_wakeup.attr,
>  #ifdef CONFIG_PM_ADVANCED_DEBUG
> @@ -235,7 +249,6 @@ static struct attribute * power_attrs[] 
>  #ifdef CONFIG_PM_RUNTIME
>  	&dev_attr_runtime_usage.attr,
>  	&dev_attr_runtime_active_kids.attr,
> -	&dev_attr_runtime_status.attr,
>  	&dev_attr_runtime_enabled.attr,
>  #endif
>  #endif
> 
> 
> 
