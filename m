From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 02/10] CPU hotplug: Provide APIs for "full" atomic
 readers to prevent CPU offline
Date: Thu, 06 Dec 2012 00:31:14 +0530
Message-ID: <50BF99FA.8060109@linux.vnet.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184313.3750.17752.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121205184313.3750.17752.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, oleg@redhat.com, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Replaying what Tejun wrote:

On 12/06/2012 12:13 AM, Srivatsa S. Bhat wrote:
> Some of the atomic hotplug readers cannot tolerate CPUs going offline while
> they are in their critical section. That is, they can't get away with just
> synchronizing with the updates to the cpu_online_mask; they really need to
> synchronize with the entire CPU tear-down sequence, because they are very
> much involved in the hotplug related code paths.
> 
> Such "full" atomic hotplug readers need a way to *actually* and *truly*
> prevent CPUs from going offline while they are active.
> 

I don't think this is a good idea.  You really should just need
get/put_online_cpus() and get/put_online_cpus_atomic().  The former
the same as they are.  The latter replacing what
preempt_disable/enable() was protecting.  Let's please not go
overboard unless we know they're necessary.  I strongly suspect that
breaking up reader side from preempt_disable and making writer side a
bit lighter should be enough.  Conceptually, it really should be a
simple conversion - convert preempt_disable/enable() pairs protecting
CPU on/offlining w/ get/put_cpu_online_atomic() and wrap the
stop_machine() section with the matching write lock.

Thanks.

-- tejun 
