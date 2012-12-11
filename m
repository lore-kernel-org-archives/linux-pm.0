From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 1/9] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Tue, 11 Dec 2012 18:35:22 +0530
Message-ID: <50C72F92.9030704@linux.vnet.ibm.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com> <20121207173759.27305.84316.stgit@srivatsabhat.in.ibm.com> <20121209191437.GA2816@redhat.com> <50C4EB79.5050203@linux.vnet.ibm.com> <20121209211338.GA8090@redhat.com> <50C56CC0.4000200@linux.vnet.ibm.com> <20121210172859.GB28479@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:35009 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab2LKNG5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Dec 2012 08:06:57 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 11 Dec 2012 18:36:25 +0530
In-Reply-To: <20121210172859.GB28479@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10/2012 10:58 PM, Oleg Nesterov wrote:
> On 12/10, Srivatsa S. Bhat wrote:
>>
>> On 12/10/2012 02:43 AM, Oleg Nesterov wrote:
>>> Damn, sorry for noise. I missed this part...
>>>
>>> On 12/10, Srivatsa S. Bhat wrote:
>>>>
>>>> On 12/10/2012 12:44 AM, Oleg Nesterov wrote:
>>>>> the latency. And I guess something like kick_all_cpus_sync() is "too heavy".
>>>>
>>>> I hadn't considered that. Thinking of it, I don't think it would help us..
>>>> It won't get rid of the currently running preempt_disable() sections no?
>>>
>>> Sure. But (again, this is only my feeling so far) given that get_online_cpus_atomic()
>>> does cli/sti,
>>
>> Ah, that one! Actually, the only reason I do that cli/sti is because, potentially
>> interrupt handlers can be hotplug readers too. So we need to protect the portion
>> of the code of get_online_cpus_atomic() which is not re-entrant.
> 
> Yes, I understand.
> 
>>> this can help to implement ensure-the-readers-must-see-the-pending-writer.
>>> IOW this might help to implement sync-with-readers.
>>>
>>
>> 2 problems:
>>
>> 1. It won't help with cases like this:
>>
>>    preempt_disable()
>> 	...
>> 	preempt_disable()
>> 		...
>> 			<------- Here
>> 		...
>> 	preempt_enable()
>> 	...
>>    preempt_enable()
> 
> No, I meant that kick_all_cpus_sync() can be used to synchronize with
> cli/sti in get_online_cpus_atomic(), just like synchronize_sched() does
> in the code I posted a minute ago.
> 

Ah, OK.

>> 2. Part of the reason we want to get rid of stop_machine() is to avoid the
>> latency it induces on _all_ CPUs just to take *one* CPU offline. If we use
>> kick_all_cpus_sync(), we get into that territory again : we unfairly interrupt
>> every CPU, _even when_ that CPU's existing preempt_disabled() sections might
>> not actually be hotplug readers! (ie., not bothered about CPU Hotplug).
> 
> I agree, that is why I said it is "too heavy".
> 

Got it :)

Regards,
Srivatsa S. Bhat

