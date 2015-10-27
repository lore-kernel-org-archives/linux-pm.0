From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] PM / suspend: replacing printk
Date: Tue, 27 Oct 2015 12:37:24 -0700
Message-ID: <1445974644.2757.48.camel@perches.com>
References: <saurabh.truth@gmail.com>
	 <1445973676-4394-1-git-send-email-saurabh.truth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:37694 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754473AbbJ0Th2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 15:37:28 -0400
In-Reply-To: <1445973676-4394-1-git-send-email-saurabh.truth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2015-10-28 at 00:51 +0530, Saurabh Sengar wrote:
> replacing prink(s) with appropriate pr_info and pr_err

Removing the terminating newlines is likely incorrect.

> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
[]
> @@ -245,7 +245,7 @@ static int suspend_test(int level)
>  {
>  #ifdef CONFIG_PM_DEBUG
>  	if (pm_test_level == level) {
> -		printk(KERN_INFO "suspend debug: Waiting for %d second(s).\n",
> +		pr_info("suspend debug: Waiting for %d second(s).",
>  				pm_test_delay);
>  		mdelay(pm_test_delay * 1000);
>  		return 1;
> @@ -317,7 +317,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>  
>  	error = dpm_suspend_late(PMSG_SUSPEND);
>  	if (error) {
> -		printk(KERN_ERR "PM: late suspend of devices failed\n");
> +		pr_err("PM: late suspend of devices failed");
>  		goto Platform_finish;
>  	}
>  	error = platform_suspend_prepare_late(state);
> @@ -326,7 +326,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>  
>  	error = dpm_suspend_noirq(PMSG_SUSPEND);
>  	if (error) {
> -		printk(KERN_ERR "PM: noirq suspend of devices failed\n");
> +		pr_err("PM: noirq suspend of devices failed");
>  		goto Platform_early_resume;
>  	}
>  	error = platform_suspend_prepare_noirq(state);



