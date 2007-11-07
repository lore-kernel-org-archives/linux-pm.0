From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] Add the "icebox"
Date: Wed, 7 Nov 2007 23:31:54 +0100
Message-ID: <200711072331.54708.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0711071210570.6349-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711071210570.6349-100000@iolanthe.rowland.org>
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

On Wednesday, 7 of November 2007, Alan Stern wrote:
> On Mon, 5 Nov 2007, Rafael J. Wysocki wrote:
> 
> > I like the idea, but I think that start_icebox() should be called after
> > freeze_processes().  Similarly, IMO it's better to call stop_icebox() before
> > thaw_processes().
> 
> Okay.  On the assumption that freezable kernel threads will continue to 
> use the freezer and won't try to use the icebox, I have updated the 
> patch.  Other comments?

OK by me.

> Alan Stern
> 
> P.S.: What about mutual exclusion in kernel/power/user.c?  If we stop 
> freezing user tasks, there's nothing to prevent more than one task 
> holding an open file reference to the snapshot file and submitting 
> ioctls concurrently.  Maybe the regions covered by pm_mutex should be 
> expanded.

/dev/snapshot can only be open once at a time.

Greetings,
Rafael


> Index: usb-2.6/include/linux/freezer.h
> ===================================================================
> --- usb-2.6.orig/include/linux/freezer.h
> +++ usb-2.6/include/linux/freezer.h
> @@ -157,6 +157,12 @@ static inline void set_freezable(void)
>  	} while (try_to_freeze());					\
>  	__retval;							\
>  })
> +
> +/*
> + * Kernel threads that want to freeze themselves go into the icebox.
> + */
> +extern void icebox(void);
> +
>  #else /* !CONFIG_PM_SLEEP */
>  static inline int frozen(struct task_struct *p) { return 0; }
>  static inline int freezing(struct task_struct *p) { return 0; }
> @@ -181,6 +187,7 @@ static inline void set_freezable(void) {
>  #define wait_event_freezable_timeout(wq, condition, timeout)		\
>  		wait_event_interruptible_timeout(wq, condition, timeout)
>  
> +static inline void icebox(void) {}
>  #endif /* !CONFIG_PM_SLEEP */
>  
>  #endif	/* FREEZER_H_INCLUDED */
> Index: usb-2.6/kernel/power/power.h
> ===================================================================
> --- usb-2.6.orig/kernel/power/power.h
> +++ usb-2.6/kernel/power/power.h
> @@ -207,3 +207,9 @@ static inline int suspend_devices_and_en
>  /* kernel/power/main.c */
>  extern int pm_notifier_call_chain(unsigned long val);
>  #endif
> +
> +#ifdef CONFIG_PM_SLEEP
> +/* kerne/power/process.c */
> +extern void start_icebox(void);
> +extern void stop_icebox(void);
> +#endif
> Index: usb-2.6/kernel/power/main.c
> ===================================================================
> --- usb-2.6.orig/kernel/power/main.c
> +++ usb-2.6/kernel/power/main.c
> @@ -108,6 +108,8 @@ static int suspend_prepare(void)
>  		goto Thaw;
>  	}
>  
> +	start_icebox();
> +
>  	free_pages = global_page_state(NR_FREE_PAGES);
>  	if (free_pages < FREE_PAGE_NUMBER) {
>  		pr_debug("PM: free some memory\n");
> @@ -120,6 +122,7 @@ static int suspend_prepare(void)
>  	if (!error)
>  		return 0;
>  
> +	stop_icebox();
>   Thaw:
>  	thaw_processes();
>  	pm_restore_console();
> @@ -215,6 +218,7 @@ int suspend_devices_and_enter(suspend_st
>   */
>  static void suspend_finish(void)
>  {
> +	stop_icebox();
>  	thaw_processes();
>  	pm_restore_console();
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
> Index: usb-2.6/kernel/power/disk.c
> ===================================================================
> --- usb-2.6.orig/kernel/power/disk.c
> +++ usb-2.6/kernel/power/disk.c
> @@ -406,6 +406,8 @@ int hibernate(void)
>  	if (error)
>  		goto Finish;
>  
> +	start_icebox();
> +
>  	if (hibernation_mode == HIBERNATION_TESTPROC) {
>  		printk("swsusp debug: Waiting for 5 seconds.\n");
>  		mdelay(5000);
> @@ -427,6 +429,7 @@ int hibernate(void)
>  		swsusp_free();
>  	}
>   Thaw:
> +	stop_icebox();
>  	unprepare_processes();
>   Finish:
>  	free_basic_memory_bitmaps();
> @@ -504,6 +507,8 @@ static int software_resume(void)
>  		goto Done;
>  	}
>  
> +	start_icebox();
> +
>  	pr_debug("PM: Reading swsusp image.\n");
>  
>  	error = swsusp_read(&flags);
> @@ -512,6 +517,7 @@ static int software_resume(void)
>  
>  	printk(KERN_ERR "PM: Restore failed, recovering.\n");
>  	swsusp_free();
> +	stop_icebox();
>  	unprepare_processes();
>   Done:
>  	free_basic_memory_bitmaps();
> Index: usb-2.6/kernel/power/user.c
> ===================================================================
> --- usb-2.6.orig/kernel/power/user.c
> +++ usb-2.6/kernel/power/user.c
> @@ -172,13 +172,16 @@ static int snapshot_ioctl(struct inode *
>  		if (error)
>  			thaw_processes();
>  		mutex_unlock(&pm_mutex);
> -		if (!error)
> +		if (!error) {
>  			data->frozen = 1;
> +			start_icebox();
> +		}
>  		break;
>  
>  	case SNAPSHOT_UNFREEZE:
>  		if (!data->frozen || data->ready)
>  			break;
> +		stop_icebox();
>  		mutex_lock(&pm_mutex);
>  		thaw_processes();
>  		mutex_unlock(&pm_mutex);
> Index: usb-2.6/kernel/power/process.c
> ===================================================================
> --- usb-2.6.orig/kernel/power/process.c
> +++ usb-2.6/kernel/power/process.c
> @@ -14,6 +14,8 @@
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
>  
> +#include "power.h"
> +
>  /* 
>   * Timeout for stopping processes
>   */
> @@ -283,3 +285,52 @@ void thaw_processes(void)
>  }
>  
>  EXPORT_SYMBOL(refrigerator);
> +
> +/*
> + * Routines for kernel threads that want to freeze themselves in the icebox
> + */
> +static DECLARE_WAIT_QUEUE_HEAD(icebox_wait_queue_head);
> +static int icebox_active;
> +
> +/**
> + * start_icebox -- activate the icebox
> + *
> + * Kernel power code should call this routine before sending the
> + * PM_HIBERNATION_PREPARE, PM_SUSPEND_PREPARE, or PM_RESTORE_PREPARE
> + * notifications.
> + */
> +void start_icebox(void)
> +{
> +	icebox_active = 1;
> +}
> +
> +/**
> + * stop_icebox -- deactivate the icebox and awaken waiting threads
> + *
> + * Kernel power code should call this routine before sending the
> + * PM_POST_HIBERNATION, PM_POST_SUSPEND, or PM_POST_RESTORE notifications.
> + */
> +void stop_icebox(void)
> +{
> +	icebox_active = 0;
> +	wake_up_all(&icebox_wait_queue_head);
> +}
> +
> +/**
> + * icebox -- place for kernel threads to wait during suspend or hibernation
> + *
> + * Tasks can call this routine at any time.  It will return immediately
> + * unless a system suspend or hibernation has started and the icebox is
> + * active, in which case it won't return until the suspend/hibernation
> + * is over.
> + *
> + * This routine should be used by drivers that want to delay user-initiated
> + * I/O until a system sleep is over.  Kernel threads should not use it
> + * in place of the freezer, because the icebox doesn't get activated until
> + * after freezing is complete.
> + */
> +void icebox(void)
> +{
> +	wait_event(icebox_wait_queue_head, !icebox_active);
> +}
> +EXPORT_SYMBOL_GPL(icebox);
> 
