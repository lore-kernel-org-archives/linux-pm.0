From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 1/2] x86 thermal: Delete power-limit-notification
 console messages
Date: Wed, 22 May 2013 04:54:15 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59C9371C@BGSMSX101.gar.corp.intel.com>
References: <1368741246-3998-1-git-send-email-lenb@kernel.org>
 <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7643 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab3EVEyU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2013 00:54:20 -0400
In-Reply-To: <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>

Hi Len/Fenghua,

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Len Brown
> Sent: Wednesday, May 22, 2013 1:05 AM
> To: Zhang, Rui
> Cc: linux-pm@vger.kernel.org; Yu, Fenghua
> Subject: [PATCH 1/2] x86 thermal: Delete power-limit-notification console
> messages
> 
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Package power limits are common on some systems under some conditions -
> -
> so printing console messages when limits are reached
> causes unnecessary customer concern and support calls.

We are facing the exact similar situation here, but on the
Thermal throttling events. So, basically I am in support of
this removal patch.

> 
> Note that even with these console messages gone,
> the events can still be observed via system counters:
> 
> $ grep TRM /proc/interrupts
> 
> Shows total thermal interrupts, which includes both power
> limit notifications and thermal throttling interrupts.

Yes, On the other hand, we can use these counters, and not
print those console messages.

> 
> $ grep . /sys/devices/system/cpu/cpu*/thermal_throttle/*
> 
> Will show what caused those interrupts, core and package
> throttling and power limit notifications.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=36182

Thanks for the link ;)

> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/cpu/mcheck/therm_throt.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> index 47a1870..68fa890 100644
> --- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> @@ -181,11 +181,6 @@ static int therm_throt_process(bool new_event, int
> event, int level)
>  				this_cpu,
>  				level == CORE_LEVEL ? "Core" : "Package",
>  				state->count);

Here, can we remove the other print also ?
(The thermal throttling prints)

Thanks,
Durga

> -		else
> -			printk(KERN_CRIT "CPU%d: %s power limit
> notification (total events = %lu)\n",
> -				this_cpu,
> -				level == CORE_LEVEL ? "Core" : "Package",
> -				state->count);
>  		return 1;
>  	}
>  	if (old_event) {
> @@ -193,10 +188,6 @@ static int therm_throt_process(bool new_event, int
> event, int level)
>  			printk(KERN_INFO "CPU%d: %s temperature/speed
> normal\n",
>  				this_cpu,
>  				level == CORE_LEVEL ? "Core" : "Package");
> -		else
> -			printk(KERN_INFO "CPU%d: %s power limit
> normal\n",
> -				this_cpu,
> -				level == CORE_LEVEL ? "Core" : "Package");
>  		return 1;
>  	}
> 
> --
> 1.8.3.rc2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
