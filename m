From: Ingo Molnar <mingo@elte.hu>
Subject: Re: sleepy linux self-test
Date: Fri, 1 Feb 2008 15:22:55 +0100
Message-ID: <20080201142255.GA26232@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz> <20080130193626.GA15384@elte.hu> <20080130232606.GB5937@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756799AbYBAOXW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080130232606.GB5937@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> index b8b2de3..222d22d 100644
> --- a/kernel/power/sleepy.c
> +++ b/kernel/power/sleepy.c
> @@ -31,7 +31,8 @@ int ksleepyd(void *data)
>  {
>  	msleep(5000);
>  	while (1) {
> -		set_alarm(5);
> +		if (set_alarm(5))
> +			return -EFAULT;
>  		pm_suspend(PM_SUSPEND_MEM);
>  		msleep(500000);

could you send me a clean patch against mainline please? The above chunk 
didnt apply because there's no ksleepyd (only test_sleep()). Thanks,

	Ingo
