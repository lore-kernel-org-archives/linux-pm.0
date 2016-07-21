From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC v5] PM / hibernate: Introduce test_resume mode for hibernation
Date: Thu, 21 Jul 2016 15:23:32 +0200
Message-ID: <9253636.UcfhxActux@vostro.rjw.lan>
References: <1468888604-9337-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42438 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752534AbcGUNSh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 09:18:37 -0400
In-Reply-To: <1468888604-9337-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Tuesday, July 19, 2016 08:36:44 AM Chen Yu wrote:
> test_resume mode is to verify if the snapshot data
> written to swap device can be successfully restored
> to memory. It is useful to ease the debugging process
> on hibernation, since this mode can not only bypass
> the BIOSes/bootloader, but also the system re-initialization.
> 
> For example:
> echo test_resume > /sys/power/disk
> echo disk > /sys/power/state
> 
> [  187.306470] PM: Image saving progress:  70%
> [  187.395298] PM: Image saving progress:  80%
> [  187.476697] PM: Image saving progress:  90%
> [  187.554641] PM: Image saving done.
> [  187.558896] PM: Wrote 594600 kbytes in 0.90 seconds (660.66 MB/s)
> [  187.566000] PM: S|
> [  187.589742] PM: Basic memory bitmaps freed
> [  187.594694] PM: Checking hibernation image
> [  187.599865] PM: Image signature found, resuming
> [  187.605209] PM: Loading hibernation image.
> [  187.665753] PM: Basic memory bitmaps created
> [  187.691397] PM: Using 3 thread(s) for decompression.
> [  187.691397] PM: Loading and decompressing image data (148650 pages)...
> [  187.889719] PM: Image loading progress:   0%
> [  188.100452] PM: Image loading progress:  10%
> [  188.244781] PM: Image loading progress:  20%
> [  189.057305] PM: Image loading done.
> [  189.068793] PM: Image successfully loaded
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v5:
>  - Introduce a new function to be shared with software_resume().
> v4:
>  - Fix some errors and modify the comment for software_resume_unthaw.
> v3:
>  - As Pavel mentioned, there was a potential risk in previous
>    version that might break the filesystem. According to Rafael's suggestion,
>    this version avoids that issue by restoring the pages with user/kernel
>    threads kept in frozen. Also updated the patch on top of linux-next.
> ---
>  kernel/power/hibernate.c | 61 ++++++++++++++++++++++++++++++++----------------
>  kernel/power/swap.c      |  6 +++++
>  2 files changed, 47 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 5f3523e..73ec63c 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -52,6 +52,7 @@ enum {
>  #ifdef CONFIG_SUSPEND
>  	HIBERNATION_SUSPEND,
>  #endif
> +	HIBERNATION_TEST_RESUME,
>  	/* keep last */
>  	__HIBERNATION_AFTER_LAST
>  };
> @@ -647,12 +648,39 @@ static void power_down(void)
>  		cpu_relax();
>  }
>  
> +static int load_image_and_restore(void)
> +{
> +	int error;
> +	unsigned int flags;
> +
> +	pr_debug("PM: Loading hibernation image.\n");
> +
> +	lock_device_hotplug();
> +	error = create_basic_memory_bitmaps();
> +	if (error)
> +		goto Unlock;
> +
> +	error = swsusp_read(&flags);
> +	swsusp_close(FMODE_READ);
> +	if (!error)
> +		hibernation_restore(flags & SF_PLATFORM_MODE);
> +
> +	printk(KERN_ERR "PM: Failed to load hibernation image, recovering.\n");
> +	swsusp_free();
> +	free_basic_memory_bitmaps();
> + Unlock:
> +	unlock_device_hotplug();
> +
> +	return error;
> +}
> +
>  /**
>   * hibernate - Carry out system hibernation, including saving the image.
>   */
>  int hibernate(void)
>  {
>  	int error, nr_calls = 0;
> +	bool snapshot_test = false;
>  
>  	if (!hibernation_available()) {
>  		pr_debug("PM: Hibernation not available.\n");
> @@ -704,7 +732,9 @@ int hibernate(void)
>  		pr_debug("PM: writing image.\n");
>  		error = swsusp_write(flags);
>  		swsusp_free();
> -		if (!error)
> +		if (hibernation_mode == HIBERNATION_TEST_RESUME)
> +			snapshot_test = true;
> +		if (!error && !snapshot_test)

The above change isn't correct IMO.

If swsusp_write() returns an error, snapshot_test shouldn't be set (that
basically means "no image", so nothing to test).

So this code should look like

	if (!error) {
		if (hibernation_mode == HIBERNATION_TEST_RESUME)
			snapshot_test = true;
		else
			power_down();
	}

The rest of the patch looks OK to me.

Thanks,
Rafael

