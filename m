From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light"
	atomic readers to prevent CPU offline
Date: Fri, 7 Dec 2012 20:56:29 +0100
Message-ID: <20121207195629.GA13238@redhat.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com> <50BF96DF.3000500@linux.vnet.ibm.com> <50BF979A.50304@linux.vnet.ibm.com> <50BF982D.7090704@linux.vnet.ibm.com> <50BF98F7.3030600@linux.vnet.ibm.com> <50BF999C.6030707@linux.vnet.ibm.com> <50BFAB17.3090603@linux.vnet.ibm.com> <20121206161850.GA6710@redhat.com> <50C0E88E.9050909@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50C0E88E.9050909@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tj@kernel.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/07, Srivatsa S. Bhat wrote:
>
> On 12/06/2012 09:48 PM, Oleg Nesterov wrote:
> > On 12/06, Srivatsa S. Bhat wrote:
> >>
> >> +void get_online_cpus_atomic(void)
> >> +{
> >> +	int c, old;
> >> +
> >> +	preempt_disable();
> >> +	read_lock(&hotplug_rwlock);
> >
> > Confused... Why it also takes hotplug_rwlock?
>
> To avoid ABBA deadlocks.
>
> hotplug_rwlock was meant for the "light" readers.
> The atomic counters were meant for the "heavy/full" readers.

OK, I got lost a bit. I'll try to read v3 tomorrow.

> > Obviously you can't use get_online_cpus_atomic() under rq->lock or
> > task->pi_lock or any other lock CPU_DYING can take. Probably this is
> > fine, but perhaps it makes sense to add the lockdep annotations.
>
> Hmm, you are right. We can't use _atomic() in the CPU_DYING path.

Not sure I undestand... I simply meant that, say,
get_online_cpus_atomic() under task->pi_lock can obviously deadlock
with take_cpu_down() which can want the same task->pi_lock after
disable_atomic_reader().

Oleg.
