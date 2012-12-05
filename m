From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 02/10] CPU hotplug: Provide APIs for "full" atomic
 readers to prevent CPU offline
Date: Thu, 06 Dec 2012 02:01:35 +0530
Message-ID: <50BFAF27.9060203@linux.vnet.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184313.3750.17752.stgit@srivatsabhat.in.ibm.com> <50BF99FA.8060109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50BF99FA.8060109@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, oleg@redhat.com, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> Replaying what Tejun wrote:
> 
> On 12/06/2012 12:13 AM, Srivatsa S. Bhat wrote:
>> Some of the atomic hotplug readers cannot tolerate CPUs going offline while
>> they are in their critical section. That is, they can't get away with just
>> synchronizing with the updates to the cpu_online_mask; they really need to
>> synchronize with the entire CPU tear-down sequence, because they are very
>> much involved in the hotplug related code paths.
>>
>> Such "full" atomic hotplug readers need a way to *actually* and *truly*
>> prevent CPUs from going offline while they are active.
>>
> 
> I don't think this is a good idea.  You really should just need
> get/put_online_cpus() and get/put_online_cpus_atomic().  The former
> the same as they are.  The latter replacing what
> preempt_disable/enable() was protecting.  Let's please not go
> overboard unless we know they're necessary.  I strongly suspect that
> breaking up reader side from preempt_disable and making writer side a
> bit lighter should be enough.  Conceptually, it really should be a
> simple conversion - convert preempt_disable/enable() pairs protecting
> CPU on/offlining w/ get/put_cpu_online_atomic() and wrap the
> stop_machine() section with the matching write lock.
> 

Yes, that _sounds_ sufficient, but IMHO it won't be, in practice. The
*number* of call-sites that you need to convert from preempt_disable/enable
to get/put_online_cpus_atomic() won't be too many, however the *frequency*
of usage of those call-sites can potentially be very high.

For example, the IPI path (smp_call_function_*) needs to use the new APIs
instead of preempt_disable(); and this is quite a hot path. So if we replace
preempt_disable/enable() with a synchronization mechanism that spins
the reader *throughout* the CPU offline operation, and provide no light-weight
alternative API, then even such very hot readers will have to bear the wrath.

And IPIs and interrupts are the work-generators in a system. Since they
can be hotplug readers, if we spin them like this, we effectively end up
recreating the stop_machine() "effect", without even using stop_machine().

This is what I meant in my yesterday's reply too:
https://lkml.org/lkml/2012/12/4/349

That's why we need a light-weight variant IMHO, so that we can use them
atleast where feasible, like IPI path (smp_call_function_*) for example.
That'll help us avoid the "stop_machine effect", hoping that most readers
are of the light-type. As I mentioned in the cover-letter, most readers
_are_ of the light-type (eg: 5 patches in this series deal with light
readers, only 1 patch deals with a heavy/full reader). I don't see why
we should unnecessarily slow down every reader just because a minority of
readers actually need full synchronization with CPU offline.

Regards,
Srivatsa S. Bhat
