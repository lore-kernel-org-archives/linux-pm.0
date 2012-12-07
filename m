From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 1/9] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Fri, 07 Dec 2012 23:54:01 +0530
Message-ID: <50C23441.7020309@linux.vnet.ibm.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com> <20121207173759.27305.84316.stgit@srivatsabhat.in.ibm.com> <20121207175724.GA2821@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:53012 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933527Ab2LGSZf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Dec 2012 13:25:35 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sat, 8 Dec 2012 04:21:33 +1000
In-Reply-To: <20121207175724.GA2821@htj.dyndns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, oleg@redhat.com, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/07/2012 11:27 PM, Tejun Heo wrote:
> On Fri, Dec 07, 2012 at 11:08:13PM +0530, Srivatsa S. Bhat wrote:
>> 4. No deadlock possibilities
>>
>>    Per-cpu locking is not the way to go if we want to have relaxed rules
>>    for lock-ordering. Because, we can end up in circular-locking dependencies
>>    as explained in https://lkml.org/lkml/2012/12/6/290
>>
>>    So, avoid per-cpu locking schemes (per-cpu locks/per-cpu atomic counters
>>    with spin-on-contention etc) as much as possible.
> 
> I really can't say I like this approach.  percpu locking is very
> tricky to get right and difficult to get right and we should try our
> best to avoid implementing subsystem specific ones as much as
> possible.  Also, I think the right approach would be auditing each
> get_online_cpus_atomic() callsites and figure out proper locking order
> rather than implementing a construct this unusual especially as
> hunting down the incorrect cases shouldn't be difficult given proper
> lockdep annotation.
> 
> lg_lock doesn't do local nesting and I'm not sure how big a deal that
> is as I don't know how many should be converted.  But if nesting is an
> absolute necessity, it would be much better to implement generic
> rwlock variant (say, lg_rwlock) rather than implementing unusual
> cpuhotplug-specific percpu synchronization construct.
>

To be honest, at a certain point in time while designing this, I did
realize that this was getting kinda overly complicated ;-) ... but I
wanted to see how this would actually work out when finished and get
some feedback on the same, hence I posted it out. But this also proves
that we _can_ actually compete with the flexibility of preempt_disable()
and still be safe with respect to locking, if we really want to ;-)

Regards,
Srivatsa S. Bhat

