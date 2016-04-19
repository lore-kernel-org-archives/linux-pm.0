From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
Date: Tue, 19 Apr 2016 15:25:40 +0530
Message-ID: <5716009C.8050704@linux.vnet.ibm.com>
References: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460701739-31549-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160418101846.GB2322@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([125.16.236.4]:48128 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbcDSJzu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 05:55:50 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
	Tue, 19 Apr 2016 15:25:47 +0530
In-Reply-To: <20160418101846.GB2322@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com

Hi Viresh,

On 04/18/2016 03:48 PM, Viresh Kumar wrote:
> On 15-04-16, 11:58, Akshay Adiga wrote:
>>   static int powernv_cpufreq_reboot_notifier(struct notifier_block *nb,
>> -				unsigned long action, void *unused)
>> +					   unsigned long action, void *unused)
> Unrelated change.. better don't add such changes..

Posting out v3 with out this unrelated change.

>>   {
>>   	int cpu;
>>   	struct cpufreq_policy cpu_policy;
>> @@ -603,15 +843,18 @@ static struct notifier_block powernv_cpufreq_opal_nb = {
>>   static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>>   {
>>   	struct powernv_smp_call_data freq_data;
>> -
>> +	struct global_pstate_info *gpstates = policy->driver_data;
> You removed a blank line here and I feel the code looks better with
> that.
>
>>   	freq_data.pstate_id = powernv_pstate_info.min;
>> +	freq_data.gpstate_id = powernv_pstate_info.min;
>>   	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
>> +	del_timer_sync(&gpstates->timer);
>>   }
>>   
>>   static struct cpufreq_driver powernv_cpufreq_driver = {
>>   	.name		= "powernv-cpufreq",
>>   	.flags		= CPUFREQ_CONST_LOOPS,
>>   	.init		= powernv_cpufreq_cpu_init,
>> +	.exit		= powernv_cpufreq_cpu_exit,
>>   	.verify		= cpufreq_generic_frequency_table_verify,
>>   	.target_index	= powernv_cpufreq_target_index,
>>   	.get		= powernv_cpufreq_get,
> None of the above comments are mandatory for you to fix..
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
Thanks for Ack  :)

