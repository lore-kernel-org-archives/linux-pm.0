From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH v2] x86 kernel crash fix when thermal interrupt called
Date: Tue, 25 Aug 2015 09:45:52 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB01F7B@SHSMSX101.ccr.corp.intel.com>
References: <1440491511-2751-1-git-send-email-aospan@netup.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3794 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbbHYJp4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2015 05:45:56 -0400
In-Reply-To: <1440491511-2751-1-git-send-email-aospan@netup.ru>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abylay Ospan <aospan@netup.ru>, "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi, Abylay

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Abylay Ospan
> Sent: Tuesday, August 25, 2015 4:32 PM
> To: Zhang, Rui; Eduardo Valentin; linux-pm@vger.kernel.org
> Cc: Abylay Ospan
> Subject: [PATCH v2] x86 kernel crash fix when thermal interrupt called
> 
>  	if (platform_thermal_package_rate_control &&
>  		platform_thermal_package_rate_control()) {
>  		/* Rate control is implemented in callback */
>  		platform_thermal_package_notify(msr_val);
Hum, I have one question, is there a risk here ?
After graping platform_thermal_lock, we try to get another lock of
worker_pool->lock by :
pkg_temp_thermal_platform_thermal_notify->
schedule_delayed_work_on(cpu,
				&per_cpu(pkg_temp_thermal_threshold_work, cpu),
				msecs_to_jiffies(notify_delay_ms));
since schedule_work can be called in many context, and it only use a 
spinlock rather than spinlock_irq,  a AB-BA deadlock may happen.
I think CONFIG_LOCK_DEP might help.
Am I missing something?

Best Regards,
Yu

> +		spin_unlock_irqrestore(&platform_thermal_lock, flags);
>  		return;
>  	}
> 

