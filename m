From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Fri, 26 Feb 2010 22:24:02 +0100
Message-ID: <201002262224.02694.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1002261130440.2029-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002261130440.2029-100000@iolanthe.rowland.org>
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

On Friday 26 February 2010, Alan Stern wrote:
...
> Index: usb-2.6/drivers/base/power/power.h
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/power.h
> +++ usb-2.6/drivers/base/power/power.h
> @@ -72,3 +72,14 @@ static inline void dpm_sysfs_remove(stru
>  }
>  
>  #endif
> +
> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)

CONFIG_PM_OPS can be used for that, it means exactly the above.

> +/*
> + * invoke_runtime.c
> + */
> +extern void dpm_invoke_runtime_idle(struct device *dev);
> +extern int dpm_invoke_runtime_suspend(struct device *dev);
> +extern int dpm_invoke_runtime_resume(struct device *dev);
> +
> +#endif
> Index: usb-2.6/drivers/base/power/Makefile
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/Makefile
> +++ usb-2.6/drivers/base/power/Makefile
> @@ -1,6 +1,6 @@
>  obj-$(CONFIG_PM)	+= sysfs.o
> -obj-$(CONFIG_PM_SLEEP)	+= main.o
> -obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
> +obj-$(CONFIG_PM_SLEEP)	+= main.o invoke_runtime.o
> +obj-$(CONFIG_PM_RUNTIME)	+= runtime.o invoke_runtime.o

And here I think.

There seem to be a few more places where the comment applies.

>  obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> Index: usb-2.6/drivers/base/power/main.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/main.c
> +++ usb-2.6/drivers/base/power/main.c
> @@ -936,3 +936,51 @@ void __suspend_report_result(const char 
>  		printk(KERN_ERR "%s(): %pF returns %d\n", function, fn, ret);
>  }
>  EXPORT_SYMBOL_GPL(__suspend_report_result);
> +
> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
> +
> +/* Convenience routines for drivers that want to use the same functions
> + * for system suspend/resume and runtime suspend/resume:
> + * Set driver->pm_ops->suspend = dpm_use_runtime_suspend and
> + * driver->pm_ops->resume = dpm_use_runtime_resume.
> + */

I have one problem with the design.  Namely, dpm_invoke_runtime_*() can
run a callback from another subsystem.  Say you are a device class and you
decide to use dpm_invoke_runtime_*(), but the device's bus type implements
the runtime PM callbacks, so they will be run as device class suspend and
resume callbacks.  That doesn't look particularly clean to me.

Rafael
