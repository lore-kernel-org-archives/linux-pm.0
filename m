From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light"	atomic
 readers to prevent CPU offline
Date: Fri, 07 Dec 2012 00:18:46 +0530
Message-ID: <50C0E88E.9050909@linux.vnet.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com> <50BF96DF.3000500@linux.vnet.ibm.com> <50BF979A.50304@linux.vnet.ibm.com> <50BF982D.7090704@linux.vnet.ibm.com> <50BF98F7.3030600@linux.vnet.ibm.com> <50BF999C.6030707@linux.vnet.ibm.com> <50BFAB17.3090603@linux.vnet.ibm.com> <20121206161850.GA6710@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121206161850.GA6710@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: tj@kernel.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/06/2012 09:48 PM, Oleg Nesterov wrote:
> On 12/06, Srivatsa S. Bhat wrote:
>>
>> +void get_online_cpus_atomic(void)
>> +{
>> +	int c, old;
>> +
>> +	preempt_disable();
>> +	read_lock(&hotplug_rwlock);
> 
> Confused... Why it also takes hotplug_rwlock?

To avoid ABBA deadlocks.

hotplug_rwlock was meant for the "light" readers.
The atomic counters were meant for the "heavy/full" readers.
I wanted them to be able to nest in any manner they wanted,
such as:

Full inside light:

get_online_cpus_atomic_light()
	...
	get_online_cpus_atomic_full()
	...
	put_online_cpus_atomic_full()
	...
put_online_cpus_atomic_light()

Or, light inside full:

get_online_cpus_atomic_full()
	...
	get_online_cpus_atomic_light()
	...
	put_online_cpus_atomic_light()
	...
put_online_cpus_atomic_full()

To allow this, I made the two sets of APIs take the locks
in the same order internally.

(I had some more description of this logic in the changelog
of 2/10; the only difference there is that instead of atomic
counters, I used rwlocks for the full-readers as well.
https://lkml.org/lkml/2012/12/5/320)

> 
>> +
>> +	for (;;) {
>> +		c = atomic_read(&__get_cpu_var(atomic_reader_refcount));
>> +		if (unlikely(writer_active(c))) {
>> +			cpu_relax();
>> +			continue;
>> +		}
>> +
>> +		old = atomic_cmpxchg(&__get_cpu_var(atomic_reader_refcount),
>> +				     c, c + 1);
>> +
>> +		if (likely(old == c))
>> +			break;
>> +
>> +		c = old;
>> +	}
>> +}
> 
> 	while (!atomic_inc_unless_negative(...))
> 		cpu_relax();
> 	
> and atomic_dec_unless_positive() in disable_atomic_reader().
> 

Ah, great! I was searching for them while writing the code, but somehow
overlooked them and rolled out my own. ;-)

> 
> Obviously you can't use get_online_cpus_atomic() under rq->lock or
> task->pi_lock or any other lock CPU_DYING can take. Probably this is
> fine, but perhaps it makes sense to add the lockdep annotations.
> 

Hmm, you are right. We can't use _atomic() in the CPU_DYING path.
So how about altering it to _allow_ that, instead of teaching lockdep
that we don't allow it? I mean, just like how the existing
get_online_cpus() allows such calls in the writer?

(I haven't thought it through; just thinking aloud...)

Regards,
Srivatsa S. Bhat
