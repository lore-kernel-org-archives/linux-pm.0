From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 1/2][RFC v3] PM / hibernate: Introduce snapshot test mode
 for hibernation
Date: Thu, 14 Jul 2016 19:09:11 +0800
Message-ID: <578772D7.1070402@intel.com>
References: <cover.1468491815.git.yu.c.chen@intel.com>
 <a402214c2c9c35e57ee6ae444c10155d4c0d0828.1468491815.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17122 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbcGNLBZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 07:01:25 -0400
In-Reply-To: <a402214c2c9c35e57ee6ae444c10155d4c0d0828.1468491815.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

Please ignore this patch, will resend another version later.
thanks!

On 2016=E5=B9=B407=E6=9C=8814=E6=97=A5 18:45, Chen Yu wrote:
> This mode is used to verify if the snapshot data written to
> the swap device can be successfully restored to the memory. It
> is useful to ease the debugging process on hibernation,
> since this mode can not only bypass the BIOSes/bootloader,
> but also the system re-initialization.
>
> For example:
>
> echo snapshot > /sys/power/pm_test
> echo disk > /sys/power/state
>
> [  267.959784] PM: Image saving progress:  80%
> [  268.038669] PM: Image saving progress:  90%
> [  268.111745] PM: Image saving progress: 100%
> [  268.129269] PM: Image saving done.
> [  268.133485] PM: Wrote 518612 kbytes in 0.75 seconds (691.48 MB/s)
> [  268.140564] PM: S|
> [  268.160067] hibernation debug: Waiting for 5 seconds.
> ...
> [  273.508638] PM: Looking for hibernation image.
> [  273.516583] PM: Image signature found, resuming
> [  273.926547] PM: Loading and decompressing image data (129653 pages=
)...
> [  274.122452] PM: Image loading progress:   0%
> [  274.322127] PM: Image loading progress:  10%
> ...
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3:
>   - According to the discussion, there was a potential risk in previo=
us
>     version that might break the filesystem. This version avoids that=
 issue
>     by restoring the pages with user/kernel threads kept in frozen.
>     Also updated the document.
> ---
>   kernel/power/hibernate.c | 49 +++++++++++++++++++++++++++++++++++++=
++++++++++-
>   kernel/power/main.c      |  3 +++
>   kernel/power/power.h     |  3 +++
>   kernel/power/suspend.c   |  7 +++++++
>   kernel/power/swap.c      |  7 +++++++
>   5 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 51441d8..c0c8fe3 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -643,11 +643,53 @@ static void power_down(void)
>   }
>  =20
>   /**
> + * software_resume_unthaw - Resume from a saved hibernation image wi=
th threads frozen.
> + *
> + * This routine is similar to software_resume, except that this one =
tries
> + * to resume from hibernation with user/kernel threads frozen.
> + * It is mainly used for snapshot test mode because it is important =
to keep the
> + * threads frozen, otherwise the filesystem might be broken due to i=
nconsistent
> + * disk-data/metadata across hibernate.
> + */
> +static int software_resume_unthaw(void)
> +{
> +	int error;
> +	unsigned int flags;
> +
> +	pr_debug("PM: Hibernation image partition %d:%d present\n",
> +		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
> +
> +	pr_debug("PM: Looking for hibernation image.\n");
> +	error =3D swsusp_check();
> +	if (error)
> +		return error;
> +
> +	lock_device_hotplug();
> +	error =3D create_basic_memory_bitmaps();
> +	if (error)
> +		goto Unlock;
> +
> +	error =3D swsusp_read(&flags);
> +	swsusp_close(FMODE_READ);
> +	if (!error)
> +		hibernation_restore(flags & SF_PLATFORM_MODE);
> +
> +	printk(KERN_ERR "PM: Failed to load hibernation image, recovering.\=
n");
> +	swsusp_free();
> +	free_basic_memory_bitmaps();
> + Unlock:
> +	unlock_device_hotplug();
> +
> +	return error;
> +}
> +
> +/**
>    * hibernate - Carry out system hibernation, including saving the i=
mage.
>    */
>   int hibernate(void)
>   {
>   	int error, nr_calls =3D 0;
> +	bool snapshot_test =3D false;
>  =20
>   	if (!hibernation_available()) {
>   		pr_debug("PM: Hibernation not available.\n");
> @@ -699,7 +741,9 @@ int hibernate(void)
>   		pr_debug("PM: writing image.\n");
>   		error =3D swsusp_write(flags);
>   		swsusp_free();
> -		if (!error)
> +		if (hibernation_test(TEST_SNAPSHOT))
> +			snapshot_test =3D true;
> +		if (!error && !snapshot_test)
>   			power_down();
>   		in_suspend =3D 0;
>   		pm_restore_gfp_mask();
> @@ -711,6 +755,8 @@ int hibernate(void)
>   	free_basic_memory_bitmaps();
>    Thaw:
>   	unlock_device_hotplug();
> +	if (snapshot_test)
> +		software_resume_unthaw();
>   	thaw_processes();
>  =20
>   	/* Don't bother checking whether freezer_test_done is true */
> @@ -721,6 +767,7 @@ int hibernate(void)
>   	atomic_inc(&snapshot_device_available);
>    Unlock:
>   	unlock_system_sleep();
> +
>   	return error;
>   }
>  =20
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 5ea50b1..80fe48e 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -83,6 +83,9 @@ int pm_test_level =3D TEST_NONE;
>  =20
>   static const char * const pm_tests[__TEST_AFTER_LAST] =3D {
>   	[TEST_NONE] =3D "none",
> +#ifdef CONFIG_HIBERNATION
> +	[TEST_SNAPSHOT] =3D "snapshot",
> +#endif
>   	[TEST_CORE] =3D "core",
>   	[TEST_CPUS] =3D "processors",
>   	[TEST_PLATFORM] =3D "platform",
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 064963e..101d636 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -225,6 +225,9 @@ static inline int restore_highmem(void) { return =
0; }
>   enum {
>   	/* keep first */
>   	TEST_NONE,
> +#ifdef CONFIG_HIBERNATION
> +	TEST_SNAPSHOT,
> +#endif
>   	TEST_CORE,
>   	TEST_CPUS,
>   	TEST_PLATFORM,
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0acab9d..7c0d5e9 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -479,6 +479,13 @@ static int enter_state(suspend_state_t state)
>   			return -EAGAIN;
>   		}
>   #endif
> +	} else if (state =3D=3D PM_SUSPEND_MEM) {
> +#ifdef CONFIG_PM_DEBUG
> +		if (pm_test_level !=3D TEST_NONE && pm_test_level < TEST_CORES) {
> +			pr_warn("PM: Unsupported test mode for suspend to ram, please cho=
ose none/freezer/devices/platform/processors/core.\n");
> +			return -EAGAIN;
> +		}
> +#endif
>   	} else if (!valid_state(state)) {
>   		return -EINVAL;
>   	}
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 160e100..facd71b 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -348,6 +348,13 @@ static int swsusp_swap_check(void)
>   	if (res < 0)
>   		blkdev_put(hib_resume_bdev, FMODE_WRITE);
>  =20
> +	/*
> +	 * Update the resume device to the one actually used,
> +	 * so software_resume() can use it in case it is invoked
> +	 * from hibernate() to test the snapshot.
> +	 */
> +	swsusp_resume_device =3D hib_resume_bdev->bd_dev;
> +
>   	return res;
>   }
>  =20

