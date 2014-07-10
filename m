From: "Bu, Yitian" <ybu@qti.qualcomm.com>
Subject: RE: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 07:08:24 +0000
Message-ID: <E807E903FE6CBE4D95E420FBFCC273B87065D4@nasanexd01h.na.qualcomm.com>
References: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:47656 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbaGJHI0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jul 2014 03:08:26 -0400
In-Reply-To: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "arvind.chauhan@arm.com" <arvind.chauhan@arm.com>, "srivatsa@mit.edu" <srivatsa@mit.edu>, "skannan@codeaurora.org" <skannan@codeaurora.org>, Stable <stable@vger.kernel.org>

Hi Viresh:

I have verified this patch, all the issues I reported disappeared.
Thanks for the quick fix.

Best Regards

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Thursday, July 10, 2014 1:19 PM
> To: rjw@rjwysocki.net
> Cc: linaro-kernel@lists.linaro.org; linux-pm@vger.kernel.org;
> arvind.chauhan@arm.com; srivatsa@mit.edu; skannan@codeaurora.org; Bu,
> Yitian; Viresh Kumar; Stable
> Subject: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
> 
> This is only relevant to implementations with multiple clusters, where clusters
> have separate clock lines but all CPUs within a cluster share it.
> 
> Consider a dual cluster platform with 2 cores per cluster. During suspend we
> start offlining CPUs from 1 to 3. When CPU2 is remove, policy->kobj would be
> moved to CPU3 and when CPU3 goes down we wouldn't free policy or its kobj.
> 
> Now on resume, we will get CPU2 before CPU3 and will call
> __cpufreq_add_dev().
> We will recover the old policy and update policy->cpu from 3 to 2 from
> update_policy_cpu().
> 
> But the kobj is still tied to CPU3 and wasn't moved to CPU2. We wouldn't create
> a link for CPU2, but would try that while bringing CPU3 online. Which will
> report errors as CPU3 already has kobj assigned to it.
> 
> This bug got introduced with commit 42f921a, which overlooked this scenario.
> 
> To fix this, lets move kobj to the new policy->cpu while bringing first CPU of a
> cluster back.
> 
> Fixes: ("42f921a cpufreq: remove sysfs files for CPUs which failed to come back
> after resume")
> Cc: Stable <stable@vger.kernel.org> # 3.13+
> Reported-by: Bu Yitian <ybu@qti.qualcomm.com>
> Reported-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Rafael,
> 
> This is for 3.16 release, please take it once Yitian/Saravana test this out.
> 
> @Yitian/Saravana: Sorry of overlooking this when both of you reported this first.
> I (and Srivatsa as well) was damn sure that this scenario is taken into account in
> current code and a close look proved that wrong.
> 
> I couldn't test it out, can any of you please see if it fixes things for you?
> 
>  drivers/cpufreq/cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c index
> 62259d2..6f02485 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1153,10 +1153,12 @@ static int __cpufreq_add_dev(struct device *dev,
> struct subsys_interface *sif)
>  	 * the creation of a brand new one. So we need to perform this update
>  	 * by invoking update_policy_cpu().
>  	 */
> -	if (recover_policy && cpu != policy->cpu)
> +	if (recover_policy && cpu != policy->cpu) {
>  		update_policy_cpu(policy, cpu);
> -	else
> +		WARN_ON(kobject_move(&policy->kobj, &dev->kobj));
> +	} else {
>  		policy->cpu = cpu;
> +	}
> 
>  	cpumask_copy(policy->cpus, cpumask_of(cpu));
> 
> --
> 2.0.0.rc2

