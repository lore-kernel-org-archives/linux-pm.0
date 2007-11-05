From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] Add the "icebox"
Date: Mon, 5 Nov 2007 23:11:07 +0100
Message-ID: <200711052311.08392.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0711051611190.2800-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711051611190.2800-100000@iolanthe.rowland.org>
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

On Monday, 5 of November 2007, Alan Stern wrote:
> Rafael:
> 
> This patch adds the icebox, for use by kernel threads that want to 
> freeze themselves without using the freezer -- which is likely to crop 
> up when the freezer gets eliminated.
> 
> It's straightforward enough.  It could be used as-is, for example for 
> freezing workqueue threads.  Using it for other sorts of kernel threads 
> seems to be rather difficult, requiring a fair amount of extra code 
> that's hard to centralize since each thread will have to be woken up 
> its own way.
> 
> Do you have any particular suggestions?

I like the idea, but I think that start_icebox() should be called after
freeze_processes().  Similarly, IMO it's better to call stop_icebox() before
thaw_processes().

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
> @@ -205,3 +205,8 @@ static inline int suspend_devices_and_en
>  
>  /* kernel/power/process.c */
>  extern int pm_notifier_call_chain(unsigned long val);
> +
> +#ifdef CONFIG_PM_SLEEP
> +extern void start_icebox(void);
> +extern void stop_icebox(void);
> +#endif
> Index: usb-2.6/kernel/power/main.c
> ===================================================================
> --- usb-2.6.orig/kernel/power/main.c
> +++ usb-2.6/kernel/power/main.c
> @@ -71,6 +71,8 @@ static int suspend_prepare(void)
>  	if (!suspend_ops || !suspend_ops->enter)
>  		return -EPERM;
>  
> +	start_icebox();
> +
>  	error = pm_notifier_call_chain(PM_SUSPEND_PREPARE);
>  	if (error)
>  		goto Finish;
> @@ -98,6 +100,7 @@ static int suspend_prepare(void)
>  	thaw_processes();
>  	pm_restore_console();
>   Finish:
> +	stop_icebox();
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
>  	return error;
>  }
> @@ -191,6 +194,7 @@ static void suspend_finish(void)
>  {
>  	thaw_processes();
>  	pm_restore_console();
> +	stop_icebox();
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
>  }
>  
> Index: usb-2.6/kernel/power/disk.c
> ===================================================================
> --- usb-2.6.orig/kernel/power/disk.c
> +++ usb-2.6/kernel/power/disk.c
> @@ -389,6 +389,8 @@ int hibernate(void)
>  		goto Unlock;
>  	}
>  
> +	start_icebox();
> +
>  	error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
>  	if (error)
>  		goto Exit;
> @@ -431,6 +433,7 @@ int hibernate(void)
>   Finish:
>  	free_basic_memory_bitmaps();
>   Exit:
> +	stop_icebox();
>  	pm_notifier_call_chain(PM_POST_HIBERNATION);
>  	atomic_inc(&snapshot_device_available);
>   Unlock:
> @@ -489,6 +492,8 @@ static int software_resume(void)
>  		goto Unlock;
>  	}
>  
> +	start_icebox();
> +
>  	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
>  	if (error)
>  		goto Finish;
> @@ -516,6 +521,7 @@ static int software_resume(void)
>   Done:
>  	free_basic_memory_bitmaps();
>   Finish:
> +	stop_icebox();
>  	pm_notifier_call_chain(PM_POST_RESTORE);
>  	atomic_inc(&snapshot_device_available);
>  	/* For success case, the suspend path will release the lock */
> Index: usb-2.6/kernel/power/user.c
> ===================================================================
> --- usb-2.6.orig/kernel/power/user.c
> +++ usb-2.6/kernel/power/user.c
> @@ -45,6 +45,7 @@ static int snapshot_open(struct inode *i
>  {
>  	struct snapshot_data *data;
>  	int error;
> +	unsigned long cancel;
>  
>  	if (!atomic_add_unless(&snapshot_device_available, -1, 0))
>  		return -EBUSY;
> @@ -61,21 +62,22 @@ static int snapshot_open(struct inode *i
>  	data = &snapshot_state;
>  	filp->private_data = data;
>  	memset(&data->handle, 0, sizeof(struct snapshot_handle));
> +	start_icebox();
>  	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
>  		data->swap = swsusp_resume_device ?
>  			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
>  		data->mode = O_RDONLY;
>  		error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
> -		if (error)
> -			pm_notifier_call_chain(PM_POST_RESTORE);
> +		cancel = PM_POST_RESTORE;
>  	} else {
>  		data->swap = -1;
>  		data->mode = O_WRONLY;
>  		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
> -		if (error)
> -			pm_notifier_call_chain(PM_POST_HIBERNATION);
> +		cancel = PM_POST_HIBERNATION;
>  	}
>  	if (error) {
> +		stop_icebox();
> +		pm_notifier_call_chain(cancel);
>  		atomic_inc(&snapshot_device_available);
>  		return error;
>  	}
> @@ -99,6 +101,7 @@ static int snapshot_release(struct inode
>  		thaw_processes();
>  		mutex_unlock(&pm_mutex);
>  	}
> +	stop_icebox();
>  	pm_notifier_call_chain(data->mode == O_WRONLY ?
>  			PM_POST_HIBERNATION : PM_POST_RESTORE);
>  	atomic_inc(&snapshot_device_available);
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
> @@ -305,3 +307,49 @@ int pm_notifier_call_chain(unsigned long
>  	return (blocking_notifier_call_chain(&pm_chain_head, val, NULL)
>  			== NOTIFY_BAD) ? -EINVAL : 0;
>  }
> +
> +/*
> + * Routines for kernel threads that want to freeze themselves
> + */
> +static DECLARE_WAIT_QUEUE_HEAD(icebox_wait_queue_head);
> +static int icebox_active;
> +
> +/**
> + * start_icebox -- activate the icebox
> + *
> + * Kernel power code should call this routine before sending the
> + * PM_HIBERNATION_PREPARE or PM_SUSPEND_PREPARE notifications.
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
> + * PM_POST_HIBERNATION or PM_POST_SUSPEND notifications.
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
> + * Threads can call this routine at any time.  It will return immediately
> + * unless a system suspend or hibernation has started and the icebox is
> + * active, in which case it won't return until the suspend/hibernation
> + * is over.
> + *
> + * Freezable kernel threads should use this routine rather than relying on
> + * the freezer.
> + */
> +void icebox(void)
> +{
> +	wait_event(icebox_wait_queue_head, !icebox_active);
> +}
> +EXPORT_SYMBOL_GPL(icebox);
> 
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
