From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 22 Dec 2017 09:30:10 +0100
Message-ID: <20171222083010.6fniwzwh3ftjs6ev@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220154358.663yoodeoxkqghx7@hirez.programming.kicks-ass.net>
 <20171221091502.GE19815@vireshk-i7>
 <20171221102530.all2hqoyh77mffmf@hirez.programming.kicks-ass.net>
 <20171221103022.GA8312@vireshk-i7>
 <20171221103941.ykehmki7m32r4pyr@hirez.programming.kicks-ass.net>
 <20171221104317.GB8312@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38544 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdLVIaS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 03:30:18 -0500
Content-Disposition: inline
In-Reply-To: <20171221104317.GB8312@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Thu, Dec 21, 2017 at 04:13:17PM +0530, Viresh Kumar wrote:
> On 21-12-17, 11:39, Peter Zijlstra wrote:
> > The difference is that we apply the per-cpu boost on the per-cpu util
> > value and _then_ find the overall maximum.
> > 
> > Instead of finding the overall maximum and then apply the per-cpu boost
> > to that.
> 
> Okay, so it is just about the right sequencing of these comparisons but the
> outcome will still be same, i.e. max of the 3 util/max values. Thanks.

Aah, you're right. I was thinking we have relative boost, and in that
case the ordering matters much more.
