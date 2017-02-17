From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: govern how frequently we change
 frequency with rate_limit
Date: Fri, 17 Feb 2017 13:48:54 +0100
Message-ID: <20170217124854.GD6500@twins.programming.kicks-ass.net>
References: <4c9afe0a2cda5016b342f777f244c89c03cdc524.1487178939.git.viresh.kumar@linaro.org>
 <20170216101210.GD21911@vireshk-i7>
 <20170216123605.GA6515@twins.programming.kicks-ass.net>
 <2324492.GOLxZvFDJN@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51456 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755495AbdBQMs4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 07:48:56 -0500
Content-Disposition: inline
In-Reply-To: <2324492.GOLxZvFDJN@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On Fri, Feb 17, 2017 at 01:15:56PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 16, 2017 01:36:05 PM Peter Zijlstra wrote:
> > On Thu, Feb 16, 2017 at 03:42:10PM +0530, Viresh Kumar wrote:
> > > But when I discussed this with Vincent, he suggested that it may not be required
> > > at all as the scheduler (with the helped of "decayed") doesn't call into
> > > schedutil too often, i.e. at least 1 ms. And if the CPUs are stable enough (i.e.
> > > no interruptions to the running task), we wouldn't reevaluate before the next
> > > tick.
> > 
> > There are still the attach/detach callers to cfs_rq_util_change() that
> > kick in for fork/exit and migration.
> > 
> > But yes, barring those we shouldn't end up calling it at silly rates.
> 
> OK
> 
> Does this mean that running governor computations every time its callback
> is invoked by the scheduler would be fine?

I'd say yes right up till the point someone reports a regression ;-)
