From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] x86 thermal: Delete power-limit-notification
 console messages
Date: Tue, 28 May 2013 10:17:10 +0800
Message-ID: <1369707430.1913.3.camel@rzhang1-mobl4>
References: <1368741246-3998-1-git-send-email-lenb@kernel.org>
	 <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13266 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758539Ab3E1CRN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 May 2013 22:17:13 -0400
In-Reply-To: <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>

On Tue, 2013-05-21 at 15:35 -0400, Len Brown wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Package power limits are common on some systems under some conditions --
> so printing console messages when limits are reached
> causes unnecessary customer concern and support calls.
> 
> Note that even with these console messages gone,
> the events can still be observed via system counters:
> 
> $ grep TRM /proc/interrupts
> 
> Shows total thermal interrupts, which includes both power
> limit notifications and thermal throttling interrupts.
> 
> $ grep . /sys/devices/system/cpu/cpu*/thermal_throttle/*
> 
> Will show what caused those interrupts, core and package
> throttling and power limit notifications.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=36182
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

who should take these two patches?

thanks,
rui
> ---
>  arch/x86/kernel/cpu/mcheck/therm_throt.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> index 47a1870..68fa890 100644
> --- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> @@ -181,11 +181,6 @@ static int therm_throt_process(bool new_event, int event, int level)
>  				this_cpu,
>  				level == CORE_LEVEL ? "Core" : "Package",
>  				state->count);
> -		else
> -			printk(KERN_CRIT "CPU%d: %s power limit notification (total events = %lu)\n",
> -				this_cpu,
> -				level == CORE_LEVEL ? "Core" : "Package",
> -				state->count);
>  		return 1;
>  	}
>  	if (old_event) {
> @@ -193,10 +188,6 @@ static int therm_throt_process(bool new_event, int event, int level)
>  			printk(KERN_INFO "CPU%d: %s temperature/speed normal\n",
>  				this_cpu,
>  				level == CORE_LEVEL ? "Core" : "Package");
> -		else
> -			printk(KERN_INFO "CPU%d: %s power limit normal\n",
> -				this_cpu,
> -				level == CORE_LEVEL ? "Core" : "Package");
>  		return 1;
>  	}
>  


