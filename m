From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] sched: fair: Don't update CPU frequency too frequently
Date: Thu, 1 Jun 2017 14:22:24 +0200
Message-ID: <20170601122224.c324h4t7y3i4wr6e@hirez.programming.kicks-ass.net>
References: <b3a96d619a4cad34f4243a173a42915c41059669.1496316723.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdFAMWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 08:22:31 -0400
Content-Disposition: inline
In-Reply-To: <b3a96d619a4cad34f4243a173a42915c41059669.1496316723.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Juri Lelli <Juri.Lelli@arm.com>, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com

On Thu, Jun 01, 2017 at 05:04:27PM +0530, Viresh Kumar wrote:
> This patch relocates the call to utilization hook from
> update_cfs_rq_load_avg() to task_tick_fair().

That's not right. Consider hardware where 'setting' the DVFS is a
'cheap' MSR write, doing that once every 10ms (HZ=100) is absurd.

We spoke about this problem in Pisa, the proposed solution was having
each driver provide a cost metric and the generic code doing a max
filter over the window constructed from that cost metric.
