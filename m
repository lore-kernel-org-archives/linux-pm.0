From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light"
	atomic readers to prevent CPU offline
Date: Thu, 06 Dec 2012 14:28:23 -0500
Message-ID: <1354822103.17101.24.camel@gandalf.local.home>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com>
	 <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com>
	 <50BF96DF.3000500@linux.vnet.ibm.com> <50BF979A.50304@linux.vnet.ibm.com>
	 <50BF982D.7090704@linux.vnet.ibm.com> <50BF98F7.3030600@linux.vnet.ibm.com>
	 <50BF999C.6030707@linux.vnet.ibm.com> <50BFAB17.3090603@linux.vnet.ibm.com>
	 <20121206161850.GA6710@redhat.com> <50C0E88E.9050909@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50C0E88E.9050909@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, tj@kernel.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, sbw@mit.edu, amit.kucheria@linaro.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-12-07 at 00:18 +0530, Srivatsa S. Bhat wrote:
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
> I wanted them to be able to nest in any manner they wanted,
> such as:
> 
> Full inside light:
> 
> get_online_cpus_atomic_light()
> 	...
> 	get_online_cpus_atomic_full()
> 	...
> 	put_online_cpus_atomic_full()
> 	...
> put_online_cpus_atomic_light()
> 
> Or, light inside full:
> 
> get_online_cpus_atomic_full()
> 	...
> 	get_online_cpus_atomic_light()
> 	...
> 	put_online_cpus_atomic_light()
> 	...
> put_online_cpus_atomic_full()
> 
> To allow this, I made the two sets of APIs take the locks
> in the same order internally.
> 
> (I had some more description of this logic in the changelog
> of 2/10; the only difference there is that instead of atomic
> counters, I used rwlocks for the full-readers as well.
> https://lkml.org/lkml/2012/12/5/320)
> 

You know reader locks can deadlock with each other, right? And this
isn't caught be lockdep yet. This is because rwlocks have been made to
be fair with writers. Before writers could be starved if a CPU always
let a reader in. Now if a writer is waiting, a reader will block behind
the writer. But this has introduced new issues with the kernel as
follows:


   CPU0			   CPU1	 	   CPU2		   CPU3
   ----			   ----		   ----		   ----
read_lock(A);
			read_lock(B)
					write_lock(A) <- block
							write_lock(B) <- block
read_lock(B) <-block

			read_lock(A) <- block

DEADLOCK!

-- Steve
