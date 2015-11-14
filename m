From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] PM / suspend: replacing printk
Date: Sat, 14 Nov 2015 21:29:02 +0100
Message-ID: <20151114202902.GD20429@amd>
References: <saurabh.truth@gmail.com>
 <1446002641-3052-1-git-send-email-saurabh.truth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34828 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbbKNU3E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2015 15:29:04 -0500
Content-Disposition: inline
In-Reply-To: <1446002641-3052-1-git-send-email-saurabh.truth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed 2015-10-28 08:54:01, Saurabh Sengar wrote:
> replacing printk(s) with appropriate pr_info and pr_err
> in order to fix checkpatch.pl warnings
> 
> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -245,7 +245,7 @@ static int suspend_test(int level)
>  {
>  #ifdef CONFIG_PM_DEBUG
>  	if (pm_test_level == level) {
> -		printk(KERN_INFO "suspend debug: Waiting for %d second(s).\n",
> +		pr_info("suspend debug: Waiting for %d second(s).\n",
>  				pm_test_delay);
>  		mdelay(pm_test_delay * 1000);
>  		return 1;
> @@ -317,7 +317,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>  
>  	error = dpm_suspend_late(PMSG_SUSPEND);
>  	if (error) {
> -		printk(KERN_ERR "PM: late suspend of devices failed\n");
> +		pr_err("PM: late suspend of devices failed\n");
>  		goto Platform_finish;
>  	}
>  	error = platform_suspend_prepare_late(state);
> @@ -326,7 +326,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>  
>  	error = dpm_suspend_noirq(PMSG_SUSPEND);
>  	if (error) {
> -		printk(KERN_ERR "PM: noirq suspend of devices failed\n");
> +		pr_err("PM: noirq suspend of devices failed\n");
>  		goto Platform_early_resume;
>  	}
>  	error = platform_suspend_prepare_noirq(state);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
