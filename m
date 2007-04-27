From: Greg KH <greg@kroah.com>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Fri, 27 Apr 2007 08:40:20 -0700
Message-ID: <20070427154020.GA11190@kroah.com>
References: <Pine.LNX.4.64.0704271525071.11149@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704271525071.11149@sbz-30.cs.Helsinki.FI>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 27, 2007 at 03:25:46PM +0300, Pekka J Enberg wrote:
> From: Nigel Cunningham <nigel@nigel.suspend2.net>
> 
> Add power management related debugging into driver core. Make the
> kernel complain if a device driver lacks bus and class support for
> resume or if a PCI or USB driver does not have a driver specific
> resume function.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
>  drivers/base/core.c       |   13 +++++++++++++
>  drivers/pci/pci-driver.c  |    6 ++++++
>  drivers/usb/core/driver.c |    6 ++++++
>  include/linux/device.h    |    1 +
>  4 files changed, 26 insertions(+)
> 
> Index: 2.6/drivers/base/core.c
> ===================================================================
> --- 2.6.orig/drivers/base/core.c	2007-04-27 14:42:13.000000000 +0300
> +++ 2.6/drivers/base/core.c	2007-04-27 14:43:14.000000000 +0300
> @@ -652,6 +652,18 @@ int device_add(struct device *dev)
>  				class_intf->add_dev(dev, class_intf);
>  		up(&dev->class->sem);
>  	}
> +
> +#ifdef CONFIG_PM
> +	if (!((dev->class && dev->class->resume) ||
> +	      (dev->bus && (dev->bus->resume || dev->bus->resume_early))) &&
> +	    !dev->pm_safe) {
> +		printk(KERN_WARNING "Device driver %s lacks bus and class "
> +				    "support for being resumed.\n",
> +				    kobject_name(&dev->kobj));
> +		dump_stack();
> +	}
> +#endif


I think you are reporting the wrong thing here, we want to know about
the busses and classes without suspend support, not the individual
devices, right?

And dumping stuff like this to the log for every bus/class isn't the
nicest :(


> +
>   Done:
>   	kfree(class_name);
>  	put_device(dev);
> @@ -989,6 +1001,7 @@ struct device *device_create(struct clas
>  	dev->class = class;
>  	dev->parent = parent;
>  	dev->release = device_create_release;
> +	dev->pm_safe = 1;

I don't understand the use of this flag, it looks like it is only being
set, which doesn't really make it very useful.

So NAK on this patch.

Oh, and please CC: me on driver core and USB and PCI core changes
please...

thanks,

greg k-h
