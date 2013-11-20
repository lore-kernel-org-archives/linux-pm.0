From: Eliezer Tamir <eliezer.tamir@linux.intel.com>
Subject: Re: [PATCH 6/7] sched: Clean up preempt_enable_no_resched() abuse
Date: Wed, 20 Nov 2013 20:02:54 +0200
Message-ID: <528CF94E.8020300@linux.intel.com>
References: <20131120160450.072555619@infradead.org> <20131120162736.691879744@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21104 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223Ab3KTSDB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Nov 2013 13:03:01 -0500
In-Reply-To: <20131120162736.691879744@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 20/11/2013 18:04, Peter Zijlstra wrote:
> The only valid use of preempt_enable_no_resched() is if the very next
> line is schedule() or if we know preemption cannot actually be enabled
> by that statement due to known more preempt_count 'refs'.

The reason I used the no resched version is that busy_poll_end_time()
is almost always called with rcu read lock held, so it seemed the more
correct option.

I have no issue with you changing this.

> As to the busy_poll mess; that looks to be completely and utterly
> broken, sched_clock() can return utter garbage with interrupts enabled
> (rare but still), it can drift unbounded between CPUs, so if you get
> preempted/migrated and your new CPU is years behind on the previous
> CPU we get to busy spin for a _very_ long time. There is a _REASON_
> sched_clock() warns about preemptability - papering over it with a
> preempt_disable()/preempt_enable_no_resched() is just terminal brain
> damage on so many levels.

IMHO This has been reviewed thoroughly.

When Ben Hutchings voiced concerns I rewrote the code to use time_after,
so even if you do get switched over to a CPU where the time is random
you will at most poll another full interval.

Linus asked me to remove this since it makes us use two time values
instead of one. see https://lkml.org/lkml/2013/7/8/345.

Cheers,
Eliezer
