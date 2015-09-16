From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: Fix broken builds without CONFIG_PM_SLEEP_DEBUG
Date: Wed, 16 Sep 2015 03:43:21 +0200
Message-ID: <4171587.Rkb7nBLebe@vostro.rjw.lan>
References: <e7097f9c9cc28de234486e3f3865bf9bbea92aac.1442304707.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57002 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752543AbbIPBPW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 21:15:22 -0400
In-Reply-To: <e7097f9c9cc28de234486e3f3865bf9bbea92aac.1442304707.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, alexandra.yates@linux.intel.com, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Tuesday, September 15, 2015 01:42:21 PM Viresh Kumar wrote:
> The variable 'wakeup_irq' is defined within #ifdef CONFIG_PM_SLEEP_DEBUG
> and used outside of it. And that breaks kernel build:
> 
> /home/viresh/linux/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
> /home/viresh/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
> 
> Fix it by defining the variable outside of the ifdef.
> 
> Fixes: d1e59c235322 ("PM / sleep: Report interrupt that caused system wakeup")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I've applied the v11 of the Alexandra's patch that doesn't have this problem AFAICS.

> ---
>  kernel/power/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 9880bf888a5b..f97a188f4ccc 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -235,6 +235,9 @@ late_initcall(pm_debugfs_init);
>  
>  #endif /* CONFIG_PM_SLEEP */
>  
> +/* IRQ number which causes system wakeup */
> +unsigned int wakeup_irq;
> +
>  #ifdef CONFIG_PM_SLEEP_DEBUG
>  /*
>   * pm_print_times: print time taken by devices to suspend and resume.
> @@ -273,7 +276,6 @@ static inline void pm_print_times_init(void)
>  	pm_print_times_enabled = !!initcall_debug;
>  }
>  
> -unsigned int wakeup_irq;
>  static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
>  					struct kobj_attribute *attr,
>  					char *buf)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
