From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v4 1/9] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Tue, 18 Dec 2012 21:23:36 +0530
Message-ID: <50D09180.4080703@linux.vnet.ibm.com>
References: <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com> <20121212171720.GA22289@redhat.com> <50C8C4A5.4080104@linux.vnet.ibm.com> <20121212180248.GA24882@redhat.com> <50C8CD52.8040808@linux.vnet.ibm.com> <20121212184849.GA26784@redhat.com> <50C8D739.6030903@linux.vnet.ibm.com> <50C9F38F.3020005@linux.vnet.ibm.com> <20121213161709.GA19125@redhat.com> <50CA0317.90501@linux.vnet.ibm.com> <20121214180345.GA22024@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:46688 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab2LRPzQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Dec 2012 10:55:16 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 18 Dec 2012 21:24:28 +0530
In-Reply-To: <20121214180345.GA22024@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/14/2012 11:33 PM, Oleg Nesterov wrote:
> On 12/13, Srivatsa S. Bhat wrote:
>>
>> On 12/13/2012 09:47 PM, Oleg Nesterov wrote:
>>> On 12/13, Srivatsa S. Bhat wrote:
>>>>
>>>> On 12/13/2012 12:42 AM, Srivatsa S. Bhat wrote:
>>>>>
>>>>> Even I don't spot anything wrong with it. But I'll give it some more
>>>>> thought..
>>>>
>>>> Since an interrupt handler can also run get_online_cpus_atomic(), we
>>>> cannot use the __this_cpu_* versions for modifying reader_percpu_refcnt,
>>>> right?
>>>
>>> Hmm. I thought that __this_cpu_* must be safe under preempt_disable().
>>> IOW, I thought that, say, this_cpu_inc() is "equal" to preempt_disable +
>>> __this_cpu_inc() correctness-wise.
>>>
>>> And. I thought that this_cpu_inc() is safe wrt interrupt, like local_t.
>>>
>>> But when I try to read the comments percpu.h, I am starting to think that
>>> even this_cpu_inc() is not safe if irq handler can do the same?
>>>
>>
>> The comment seems to say that its not safe wrt interrupts. But looking at
>> the code in include/linux/percpu.h, IIUC, that is true only about
>> this_cpu_read() because it only disables preemption.
>>
>> However, this_cpu_inc() looks safe wrt interrupts because it wraps the
>> increment within raw_local_irqsave()/restore().
> 
> You mean _this_cpu_generic_to_op() I guess. So yes, I think you are right,
> this_cpu_* should be irq-safe, but __this_cpu_* is not.
> 

Yes.

> Thanks.
> 
> At least on x86 there is no difference between this_ and __this_, both do
> percpu_add_op() without local_irq_disable/enable. But it seems that most
> of architectures use generic code.
> 

So now that we can't avoid disabling and enabling interrupts, I was
wondering if we could exploit this to avoid the smp_mb()..

Maybe this is a stupid question, but I'll shoot it anyway...
Does local_irq_disable()/enable provide any ordering guarantees by any chance?
I think the answer is no, but if it is yes, I guess we can do as shown
below to ensure that STORE(reader_percpu_refcnt) happens before
LOAD(writer_signal).

void get_online_cpus_atomic(void)
{
	unsigned long flags;

	preempt_disable();

	//only for writer
	local_irq_save(flags);
	__this_cpu_add(reader_percpu_refcnt, XXXX);
	local_irq_restore(flags);

	//no need of an explicit smp_mb()

	if (__this_cpu_read(reader_percpu_refcnt) & MASK) {
		this_cpu_inc(reader_percpu_refcnt);
	} else if (writer_active()) {
		...
	}

	this_cpu_dec(reader_percpu_refcnt, XXXX);

}

I tried thinking about other ways to avoid that smp_mb() in the reader,
but was unsuccessful. So if the above assumption is wrong, I guess we'll
just have to go with the version that uses synchronize_sched() at the
writer-side.

Regards,
Srivatsa S. Bhat

