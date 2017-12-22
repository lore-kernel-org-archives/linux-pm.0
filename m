From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 22 Dec 2017 13:22:14 +0100
Message-ID: <20171222122214.dzzx2pjja3wn5f4q@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220173814.GC22246@localhost.localdomain>
 <20171222100626.7g5yklspjofcp2we@hirez.programming.kicks-ass.net>
 <20171222110206.GA6414@e110439-lin>
 <20171222114618.mlbqdbagrbr7oert@hirez.programming.kicks-ass.net>
 <20171222120714.GL18612@localhost.localdomain>
 <20171222121445.GB30968@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55247 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLVMWU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 07:22:20 -0500
Content-Disposition: inline
In-Reply-To: <20171222121445.GB30968@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Fri, Dec 22, 2017 at 12:14:45PM +0000, Patrick Bellasi wrote:
> I think that check is already gone for CFS in the current PeterZ tree.
> It seems we use TICK_NS just for the reset of iowait_boost, isn't it?

Easy enough to bring back though.

> However, if the remote updates of CFS works as expected,
> the removal of the TICK_NS for CFS is not intentional?

So I killed that because I now do get_util for all CPUs and figured
get_util provides up-to-date numbers. So we don't need no artificial
aging.

Esp. once we get that whole blocked load stuff sorted.
