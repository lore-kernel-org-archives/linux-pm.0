From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Tue, 13 Oct 2015 11:36:25 +0100
Message-ID: <561CDEA9.7020700@arm.com>
References: <1443807532.2845.25.camel@linaro.org>
 <20151007173920.GG4557@linux> <1444296229.2847.9.camel@linaro.org>
 <561BB39A.4020400@arm.com> <1444720744.2686.10.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51754 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbbJMKg2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 06:36:28 -0400
In-Reply-To: <1444720744.2686.10.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org



On 13/10/15 08:19, Jon Medhurst (Tixy) wrote:
> On Mon, 2015-10-12 at 14:20 +0100, Sudeep Holla wrote:
>>
>> On 08/10/15 10:23, Jon Medhurst (Tixy) wrote:
>> [...]
>>
>>> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
>>> index f1e42f8..59115a4 100644
>>> --- a/drivers/cpufreq/arm_big_little.c
>>> +++ b/drivers/cpufreq/arm_big_little.c
>>> @@ -149,6 +149,18 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>>>    			__func__, cpu, old_cluster, new_cluster, new_rate);
>>>
>>>    	ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
>>> +	if (!ret) {
>>> +		/*
>>> +		 * FIXME: clk_set_rate has to handle the case where clk_change_rate
>>> +		 * can fail due to hardware or firmware issues. Until the clk core
>>> +		 * layer is fixed, we can check here. In most of the cases we will
>>> +		 * be reading only the cached value anyway. This needs to  be removed
>>> +		 * once clk core is fixed.
>>> +		 */
>>> +		if (clk_get_rate(clk[new_cluster]) != new_rate * 1000)
>>> +			ret = -EIO;
>>> +	}
>>> +
>>>    	if (WARN_ON(ret)) {
>>>    		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
>>>    				new_cluster);
>>> @@ -189,15 +201,6 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>>>    		mutex_unlock(&cluster_lock[old_cluster]);
>>>    	}
>>>
>>> -	/*
>>> -	 * FIXME: clk_set_rate has to handle the case where clk_change_rate
>>> -	 * can fail due to hardware or firmware issues. Until the clk core
>>> -	 * layer is fixed, we can check here. In most of the cases we will
>>> -	 * be reading only the cached value anyway. This needs to  be removed
>>> -	 * once clk core is fixed.
>>> -	 */
>>> -	if (bL_cpufreq_get_rate(cpu) != new_rate)
>>> -		return -EIO;
>>>    	return 0;
>>>    }
>>>
>>>
>>>
>>>
>>
>> The above change looks good to me but with minor nit. You can get rid of
>> if(!ret) check if you move the hunk after if (WARN_ON(ret))
>
> But then we wouldn't get the WARN_ON and pr_err triggered when we detect
> the clock rate isn't set, which surely is half the reason for the check
> in the first place?
>

Not sure if I understand what you mean or may be I was not clear, so
thought I will put the delta here. Let me know if and how its still a 
problem.

Regards,
Sudeep

-->8

diff --git i/drivers/cpufreq/arm_big_little.c 
w/drivers/cpufreq/arm_big_little.c
index f1e42f8ce0fc..05e850f80f39 100644
--- i/drivers/cpufreq/arm_big_little.c
+++ w/drivers/cpufreq/arm_big_little.c
@@ -164,6 +164,16 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 
new_cluster, u32 rate)

         mutex_unlock(&cluster_lock[new_cluster]);

+       /*
+        * FIXME: clk_set_rate has to handle the case where clk_change_rate
+        * can fail due to hardware or firmware issues. Until the clk core
+        * layer is fixed, we can check here. In most of the cases we will
+        * be reading only the cached value anyway. This needs to  be 
removed
+        * once clk core is fixed.
+        */
+       if (bL_cpufreq_get_rate(cpu) != new_rate)
+               return -EIO;
+
         /* Recalc freq for old cluster when switching clusters */
         if (old_cluster != new_cluster) {
                 pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d\n",
@@ -189,15 +199,6 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 
new_cluster, u32 rate)
                 mutex_unlock(&cluster_lock[old_cluster]);
         }

-       /*
-        * FIXME: clk_set_rate has to handle the case where clk_change_rate
-        * can fail due to hardware or firmware issues. Until the clk core
-        * layer is fixed, we can check here. In most of the cases we will
-        * be reading only the cached value anyway. This needs to  be 
removed
-        * once clk core is fixed.
-        */
-       if (bL_cpufreq_get_rate(cpu) != new_rate)
-               return -EIO;
         return 0;
  }
