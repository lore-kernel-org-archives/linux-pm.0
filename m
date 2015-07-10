From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Initialize the governor again while restoring policy
Date: Fri, 10 Jul 2015 02:05:18 +0200
Message-ID: <5369372.r4v2a9W8l1@vostro.rjw.lan>
References: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org> <3814282.YWYCHNROVv@vostro.rjw.lan> <20150709051024.GJ1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61270 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750744AbbGIXit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 19:38:49 -0400
In-Reply-To: <20150709051024.GJ1805@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, open list <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>

On Thursday, July 09, 2015 10:40:24 AM Viresh Kumar wrote:
> On 09-07-15, 02:33, Rafael J. Wysocki wrote:
> > > We also missed marking policy->governor as NULL while restoring the
> > > policy. Because of that, we call __cpufreq_governor(CPUFREQ_GOV_LIMITS)
> > 
> > How exactly does that happen?
> 
> Should have mentioned that in detail, sorry for being lazy. Hopefully
> this will look better:

OK, applied (with some minor changelog fixup), thanks!


> ---------------------------8<---------------------------
> 
> Message-Id: <5f17361741c009a7f0d8488f7f94bab80d9317fd.1436418101.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Wed, 8 Jul 2015 10:45:53 +0530
> Subject: [PATCH V2] cpufreq: Initialize the governor again while restoring policy
> 
> When all CPUs of a policy are hot-unplugged, we EXIT the governor but
> don't mark policy->governor as NULL. This was done in order to keep last
> used governor's information intact in sysfs, while the CPUs are offline.
> 
> But we also marking policy->governor as NULL while restoring the policy.
> 
> Because policy->governor still points to the last governor while policy
> is restored, following sequence of event happens:
> - cpufreq_init_policy() called while restoring policy
> - find_governor() matches last_governor string for present governors and
>   returns last used governor's pointer, say ondemand. policy->governor
>   already has the same address, unless the governor was removed in
>   between.
> - cpufreq_set_policy() is called with both old/new policies governor set
>   as ondemand.
> - Because governors matched, we skip governor initialization and return
>   after calling __cpufreq_governor(CPUFREQ_GOV_LIMITS).

But this sounds fragile in principle.  What's the benefit from skipping the
governor initialization in that case?


>   Because the
>   governor wasn't initialized for this policy, it returned -EBUSY.
> - cpufreq_init_policy() exits the policy on this error, but doesn't
>   destroy it properly (should be fixed separately).
> - And so we enter a scenario where the policy isn't completely
>   initialized but used.
> 
> Fix this by setting policy->governor to NULL while restoring the policy.
> 
> Reported-and-tested-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Reported-and-tested-by: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> Tested-by: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 18bf3a124ef8 ("cpufreq: Mark policy->governor = NULL for inactive policies")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Detailed changelog
> 
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b612411655f9..2c22e3902e72 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1132,6 +1132,7 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
>  
>  		down_write(&policy->rwsem);
>  		policy->cpu = cpu;
> +		policy->governor = NULL;
>  		up_write(&policy->rwsem);
>  	}

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
