From: Michael Wang <wangyun@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 01/10] CPU hotplug: Introduce "stable" cpu online
 mask, for atomic hotplug readers
Date: Wed, 05 Dec 2012 11:28:50 +0800
Message-ID: <50BEBF72.80906@linux.vnet.ibm.com>
References: <20121204085149.25919.29920.stgit@srivatsabhat.in.ibm.com> <20121204085324.25919.53090.stgit@srivatsabhat.in.ibm.com> <20121204141017.94a559f1.akpm@linux-foundation.org> <50BEB7C4.9080906@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:42324 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab2LED3J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Dec 2012 22:29:09 -0500
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <wangyun@linux.vnet.ibm.com>;
	Wed, 5 Dec 2012 13:25:13 +1000
In-Reply-To: <50BEB7C4.9080906@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, namhyung@kernel.org, vincent.guittot@linaro.org, sbw@mit.edu, tj@kernel.org, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/05/2012 10:56 AM, Michael Wang wrote:
[...]
>>
>> I wonder about the cpu-online case.  A typical caller might want to do:
>>
>>
>> /*
>>  * Set each online CPU's "foo" to "bar"
>>  */
>>
>> int global_bar;
>>
>> void set_cpu_foo(int bar)
>> {
>> 	get_online_cpus_stable_atomic();
>> 	global_bar = bar;
>> 	for_each_online_cpu_stable()
>> 		cpu->foo = bar;
>> 	put_online_cpus_stable_atomic()
>> }
>>
>> void_cpu_online_notifier_handler(void)
>> {
>> 	cpu->foo = global_bar;
>> }

Oh, forgive me for misunderstanding your question :(

In this case, we have to prevent hotplug happen, not just ensure the
online mask is correct.

Hmm..., we need more consideration.

Regards,
Michael Wang

>>
>> And I think that set_cpu_foo() would be buggy, because a CPU could come
>> online before global_bar was altered, and that newly-online CPU would
>> pick up the old value of `bar'.
>>
>> So what's the rule here?  global_bar must be written before we run
>> get_online_cpus_stable_atomic()?
>>
>> Anyway, please have a think and spell all this out?
> 
> That's right, actually this related to one question, should the hotplug
> happen during get_online and put_online?
> 
> Answer will be YES according to old API which using mutex, the hotplug
> won't happen in critical section, but the cost is get_online() will
> block, which will kill the performance.
> 
> So we designed this mechanism to do acceleration, but as you pointed
> out, although the result will never be wrong, but the 'stable' mask is
> not stable since it could be changed in critical section.
> 
> And we have two solution.
> 
> One is from Srivatsa, using 'read_lock' and 'write_lock', it will
> prevent hotplug happen just like the old rule, the cost is we need a
> global 'rw_lock' which perform bad on NUMA system, and no doubt,
> get_online() will block for short time when doing hotplug.
> 
> Another is to maintain a per-cpu cache mask, this mask will only be
> updated in get_online(), and be used in critical section, then we will
> get a real stable mask, but one flaw is, on different cpu in critical
> section, online mask will be different.
> 
> We will be appreciate if we could collect some comments on which one to
> be used in next version.
> 
> Regards,
> Michael Wang
> 
>>
>>>  struct take_cpu_down_param {
>>>  	unsigned long mod;
>>>  	void *hcpu;
>>> @@ -246,7 +351,9 @@ struct take_cpu_down_param {
>>>  static int __ref take_cpu_down(void *_param)
>>>  {
>>>  	struct take_cpu_down_param *param = _param;
>>> -	int err;
>>> +	int err, cpu = (long)(param->hcpu);
>>> +
>>
>> Like this please:
>>
>> 	int err;
>> 	int cpu = (long)(param->hcpu);
>>
>>> +	prepare_cpu_take_down(cpu);
>>>  
>>>  	/* Ensure this CPU doesn't handle any more interrupts. */
>>>  	err = __cpu_disable();
>>>
>>> ...
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 

