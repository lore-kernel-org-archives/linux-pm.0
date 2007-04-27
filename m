From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Fri, 27 Apr 2007 10:08:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704271004090.3430-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0704271525071.11149@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

On Fri, 27 Apr 2007, Pekka J Enberg wrote:

> From: Nigel Cunningham <nigel@nigel.suspend2.net>
> 
> Add power management related debugging into driver core. Make the
> kernel complain if a device driver lacks bus and class support for
> resume or if a PCI or USB driver does not have a driver specific
> resume function.

> Index: 2.6/drivers/usb/core/driver.c
> ===================================================================
> --- 2.6.orig/drivers/usb/core/driver.c	2007-04-27 14:42:13.000000000 +0300
> +++ 2.6/drivers/usb/core/driver.c	2007-04-27 14:43:14.000000000 +0300
> @@ -721,6 +721,12 @@ 	int retval = 0;
>  		pr_info("%s: registered new device driver %s\n",
>  			usbcore_name, new_udriver->name);
>  		usbfs_update_special();
> +#ifdef CONFIG_PM
> +		if (!new_udriver->resume)
> +			printk(KERN_WARNING "USB driver %s lacks driver "
> +					    "specific resume support.\n",
> +					    new_udriver->name);
> +#endif
>  	} else {
>  		printk(KERN_ERR "%s: error %d registering device "
>  			"	driver %s\n",

This part seems unnecessary.  There is only one USB device driver, it is
built into the USB core, and it does have the appropriate methods.  
Checking isn't needed.

Now perhaps you would prefer to check the USB interface drivers -- there 
are many of them, and quite a few don't have suspend or resume methods.  
You would need to modify usb_register_driver() instead of 
usb_register_device_driver().

On the other hand, the drivers' maintainers are probably quite aware of 
the missing PM support, so it's not clear that printing out warning 
messages will actually help anybody.

Alan Stern
