From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/13] PM: earlysuspend: Removing dependence
	on console.
Date: Thu, 5 Feb 2009 10:06:21 +0100
Message-ID: <20090205090621.GE2077@elf.ucw.cz>
References: <1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<1233802226-23386-11-git-send-email-arve@android.com>
	<1233802226-23386-12-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-12-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj??nnev??g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, Rebecca Schultz <rschultz@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed 2009-02-04 18:50:24, Arve Hj??nnev??g wrote:
> From: Rebecca Schultz <rschultz@google.com>
> 
> Rather than signaling a full update of the display from userspace via a
> console switch, this patch introduces 2 files int /sys/power,
> wait_for_fb_sleep and wait_for_fb_wake.  Reading these files will block
> until the requested state has been entered.  When a read from
> wait_for_fb_sleep returns userspace should stop drawing.  When
> wait_for_fb_wake returns, it should do a full update.  If either are called
> when the fb driver is already in the requested state, they will return
> immediately.

You have just introduced another method of console switching in
previous patch. Please drop pieces of duplicate functionality you are
not using any more.

> @@ -181,6 +182,14 @@ choice
>  		  Register early suspend handler to perform a console switch to
>  		  when user-space should stop drawing to the screen and a switch
>  		  back when it should resume.
> +
> +	config FB_EARLYSUSPEND
> +		bool "Sysfs interface"
> +		depends on HAS_EARLYSUSPEND
> +		---help---
> +		  Register early suspend handler that notifies and waits for
> +		  user-space through sysfs when user-space should stop drawing
> +		  to the screen and notifies user-space when it should resume.
>  endchoice

Hmm, as far as I can tell, turning this option on will immediately
break suspend on all existing setups. Bad.

> +static int __init android_power_init(void)
> +{
> +	int ret;
> +
> +	init_waitqueue_head(&fb_state_wq);
> +	fb_state = FB_STATE_DRAWING_OK;
> +
> +	ret = sysfs_create_group(power_kobj, &attr_group);
> +	if (ret) {
> +		pr_err("android_power_init: sysfs_create_group failed\n");
> +		return ret;
> +	}
> +
> +	register_early_suspend(&stop_drawing_early_suspend_desc);
> +	return 0;
> +}
> +
> +static void  __exit android_power_exit(void)
> +{
> +	unregister_early_suspend(&stop_drawing_early_suspend_desc);
> +	sysfs_remove_group(power_kobj, &attr_group);
> +}
> +
> +module_init(android_power_init);
> +module_exit(android_power_exit);
> +

You probably want to avoid android_ prefix here, and invent some
better one.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
