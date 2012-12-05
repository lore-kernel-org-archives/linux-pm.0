From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light" atomic
 readers to prevent CPU offline
Date: Thu, 06 Dec 2012 00:17:59 +0530
Message-ID: <50BF96DF.3000500@linux.vnet.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:46497 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab2LESt1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Dec 2012 13:49:27 -0500
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 6 Dec 2012 00:19:14 +0530
In-Reply-To: <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, oleg@redhat.com, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Replaying what Tejun wrote:

(cc'ing Oleg)

Hello, Srivatsa.

On 12/06/2012 12:13 AM, Srivatsa S. Bhat wrote:
> Also, since we don't use per-cpu locks (because rwlocks themselves are quite
> scalable for readers), we don't end up in any lock ordering problems that can
> occur if we try to use per-cpu locks.
> 

Read-lock really isn't that scalable when you compare it to
preempt_disable/enable().  When used on hot paths, it's gonna generate
a lot of cacheline pingpongs.  This patch is essentially creating a
new big lock which has potential for being very hot.

preempt_disable/enable() + stop_machine() essentially works as percpu
rwlock with very heavy penalty on the writer side.  Because the reader
side doesn't even implement spinning while writer is in progress, the
writer side has to preempt the readers before entering critical
section and that's what the "stopping machine" is about.

Note that the resolution on the reader side is very low.  Any section
w/ preemption disabled is protected against stop_machine().  Also, the
stop_machine() itself is extremely heavy involving essentially locking
up the machine until all CPUs can reach the same condition via
scheduling the stop_machine tasks.  So, I *think* all you need to do
here is making cpu online locking finer grained (separated from
preemption) and lighten the writer side a bit.  I'm quite doubtful
that you would need to go hunting donw all get_online_cpus().  They
aren't used that often anyway.

Anyways, so, separating out cpu hotplug locking from preemption is the
right thing to do but I think rwlock is likely to be too heavy on the
reader side.  I think percpu reader accounting + reader spinning while
writer in progress should be a good combination.  It's a bit heavier
than preempt_disable() - it'll have an extra conditional jump on the
hot path, but there won't be any cacheline bouncing.  The writer side
would need to synchronize against all CPUs but only against the ones
actually read locking cpu hotplug.  As long as reader side critical
sections don't go crazy, it should be okay.

So, we basically need percpu_rwlock.  We already have percpu_rwsem.
We used to have some different variants of writer-heavy locks.  Dunno
what happened to them.  Maybe we still have it somewhere.  Oleg has
been working on the area lately and should know more.  Oleg, it seems
CPU hotplug needs big-reader rwlock, ideas on how to proceed?

Thanks.

-- tejun 

