From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: NOHZ: WARNING: at arch/x86/kernel/smp.c:123 native_smp_send_reschedule,
 round 2
Date: Mon, 20 May 2013 14:39:22 +0530
Message-ID: <CAKohponS+tCkZyVpDO9fEMQCfsn5h=N235sj5sBGUkD2qKY=cQ@mail.gmail.com>
References: <alpine.LNX.2.00.1305091423460.23038@pobox.suse.cz>
	<20130509125040.GF27333@pd.tnic>
	<20130509125859.GG27333@pd.tnic>
	<20130515184528.GO4442@linux.vnet.ibm.com>
	<20130515224358.GF11783@pd.tnic>
	<20130515235512.GT4442@linux.vnet.ibm.com>
	<20130517135641.GF23035@pd.tnic>
	<51999591.8030401@linux.vnet.ibm.com>
	<20130520045023.GA12690@pd.tnic>
	<5199C169.7060504@linux.vnet.ibm.com>
	<20130520064727.GD12690@pd.tnic>
	<5199C990.3020602@linux.vnet.ibm.com>
	<5199CB59.1020309@linux.vnet.ibm.com>
	<CAKohponk-FQpHOx407FL63ZCYVgz2C-ScvZQBQFVxddbL+fS=A@mail.gmail.com>
	<5199CFD0.9030101@linux.vnet.ibm.com>
	<5199E54D.7030407@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39126 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab3ETJJX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2013 05:09:23 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6756262obc.27
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2013 02:09:22 -0700 (PDT)
In-Reply-To: <5199E54D.7030407@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Wang <wangyun@linux.vnet.ibm.com>
Cc: Borislav Petkov <bp@alien8.de>, Tejun Heo <tj@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Jiri Kosina <jkosina@suse.cz>, Frederic Weisbecker <fweisbec@gmail.com>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 20 May 2013 14:26, Michael Wang <wangyun@linux.vnet.ibm.com> wrote:
> On 05/20/2013 03:25 PM, Michael Wang wrote:
>> Yeah, that's right, I guess the issue is, although the policy->cpus is
>> correct at a given time, after get cpu from it, it's possible to be
>> changed, unless we disabled preempt or irq, or hotplug before we use it...
>>
>> Like such issue cases:
>>                               get x from policy->cpus
>>       DOWN notifier
>>       change policy->cpus
>>       do offline x
>>                               send ipi to x
>>
>> Will that happen?

Sorry I am not sure. :(

I can see mutex being used in cpufreq_governor.c which should take care
of race conditions...

> May be we could do some test to confirm it?
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index 443442d..449be88 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -26,6 +26,7 @@
>  #include <linux/tick.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> +#include <linux/cpu.h>
>
>  #include "cpufreq_governor.h"
>
> @@ -180,8 +181,10 @@ void gov_queue_work(struct dbs_data *dbs_data,
> struct cpufreq_policy *policy,
>         if (!all_cpus) {
>                 __gov_queue_work(smp_processor_id(), dbs_data, delay);
>         } else {
> +               get_online_cpus();
>                 for_each_cpu(i, policy->cpus)
>                         __gov_queue_work(i, dbs_data, delay);
> +               put_online_cpus();
>         }
>  }
>  EXPORT_SYMBOL_GPL(gov_queue_work);
>
> This is supposed to make WARN disappear, if it works, then BINGO :)

Let people test it and then we can talk :)
