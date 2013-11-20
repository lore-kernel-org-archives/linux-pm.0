From: Eliezer Tamir <eliezer.tamir@linux.intel.com>
Subject: Re: [PATCH 6/7] sched: Clean up preempt_enable_no_resched() abuse
Date: Wed, 20 Nov 2013 22:14:02 +0200
Message-ID: <528D180A.5050209@linux.intel.com>
References: <20131120160450.072555619@infradead.org> <20131120162736.691879744@infradead.org> <528CF94E.8020300@linux.intel.com> <20131120181536.GW16796@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44177 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982Ab3KTUOW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Nov 2013 15:14:22 -0500
In-Reply-To: <20131120181536.GW16796@laptop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eliezer Tamir <eliezer@tamir.org.il>

On 20/11/2013 20:15, Peter Zijlstra wrote:
> There are options (CONFIG_PREEMPT_RCU) that allow scheduling while
> holding rcu_read_lock().
> 
> Also, preempt_enable() only schedules when its possible to schedule, so
> calling it when you know you cannot schedule is no issue.
> 

I have no issue with you changing busy_loop_us_clock() to use a regular
preempt enable.

I think that we still need to only do this if config preempt debug
is on. When it's off we should use the alternate implementation.
We are silencing a warning, but this is a performance critical path,
and we think we know what we are doing.

I tried to explain this in the comments. If you think my comments are
not clear enough, I'm open to suggestions.

Cheers,
Eliezer
