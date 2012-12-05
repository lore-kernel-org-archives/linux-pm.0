From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light" atomic
 readers to prevent CPU offline
Date: Thu, 06 Dec 2012 00:26:55 +0530
Message-ID: <50BF98F7.3030600@linux.vnet.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com> <50BF96DF.3000500@linux.vnet.ibm.com> <50BF979A.50304@linux.vnet.ibm.com> <50BF982D.7090704@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:47774 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab2LES6X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Dec 2012 13:58:23 -0500
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 6 Dec 2012 00:28:11 +0530
In-Reply-To: <50BF982D.7090704@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, oleg@redhat.com, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Replaying what Oleg wrote:

(add lkml)

> Replaying what Tejun wrote:

> Replacing get_online_cpus() w/ percpu_rwsem is great but this thread
> is about replacing preempt_disable with something finer grained and
> less heavy on the writer side

If only I understood why preempt_disable() is bad ;-)

OK, I guess "less heavy on the writer side" is the hint, and in the
previous email you mentioned that "stop_machine() itself is extremely
heavy".

Looks like, you are going to remove stop_machine() from cpu_down ???
 
> The problem seems that we don't have percpu_rwlock yet.  It shouldn't
> be too difficult to implement, right?
> 

Oh, I am not sure... unless you simply copy-and-paste the lglock code
and replace spinlock_t with rwlock_t.

We probably want something more efficient, but I bet we can't avoid
the barriers on the read side.

And somehow we should avoid the livelocks. Say, we can't simply add
the per_cpu_reader_counter, _read_lock should spin if the writer is
active. But at the same time _read_lock should be recursive.

Tejun, could you please send me mbox with this thread offlist?

[That should now be unnecessary, since the discussion can continue
on-list on this thread].

Oleg.

