From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH -mm 1/7] PM: Remove pm_parent from
	struct dev_pm_info
Date: Mon, 11 Jun 2007 11:59:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706111147160.2611-100000@iolanthe.rowland.org>
References: <200706111657.09038.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706111657.09038.rjw@sisk.pl>
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
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Jun 2007, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The pm_parent member of struct dev_pm_info (defined in include/linux/pm.h) is
> only used to check if the device's parent is in the right state while the
> device is being suspended or resumed.  However, this can be done just as well
> with the help of the parent pointer in struct device, so pm_parent can be
> removed along with some code that handles it.

> @@ -61,21 +40,26 @@ int device_pm_add(struct device * dev)
>  		 kobject_name(&dev->kobj));
>  	mutex_lock(&dpm_list_mtx);
>  	list_add_tail(&dev->power.entry, &dpm_active);
> -	device_pm_set_parent(dev, dev->parent);
> -	if ((error = dpm_sysfs_add(dev)))
> +	/*
> +	 * The device's parent must not be released until the device itself is
> +	 * removed from the dpm_active list.
> +	 */
> +	get_device(dev->parent);
> +	error = dpm_sysfs_add(dev);
> +	if (error)
>  		list_del(&dev->power.entry);
>  	mutex_unlock(&dpm_list_mtx);
>  	return error;
>  }

The error pathway here does an unbalanced get_device on dev->parent.

Anyway, I don't think you need to do this get_device at all (or the
coresponding put in device_pm_remove).  As long as a device is
registered it retains a reference to its parent, and unregistration
always calls device_pm_remove.  The reason it was there in the first 
place was because people recognized that dev->power.pm_parent wouldn't 
be one of dev's ancestors in the device hierarchy.

Alan Stern
