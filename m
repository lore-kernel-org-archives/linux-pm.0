From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: schedutil: govern how frequently we change frequency with rate_limit
Date: Mon, 20 Feb 2017 14:49:18 +0100
Message-ID: <4853380.1xLm2rt1ou@aspire.rjw.lan>
References: <4c9afe0a2cda5016b342f777f244c89c03cdc524.1487178939.git.viresh.kumar@linaro.org> <20170217124854.GD6500@twins.programming.kicks-ass.net> <20170220095803.GT21911@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48105 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752726AbdBTNyW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2017 08:54:22 -0500
In-Reply-To: <20170220095803.GT21911@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On Monday, February 20, 2017 03:28:03 PM Viresh Kumar wrote:
> On 17-02-17, 13:48, Peter Zijlstra wrote:
> > On Fri, Feb 17, 2017 at 01:15:56PM +0100, Rafael J. Wysocki wrote:
> > > On Thursday, February 16, 2017 01:36:05 PM Peter Zijlstra wrote:
> > > > On Thu, Feb 16, 2017 at 03:42:10PM +0530, Viresh Kumar wrote:
> > > > > But when I discussed this with Vincent, he suggested that it may not be required
> > > > > at all as the scheduler (with the helped of "decayed") doesn't call into
> > > > > schedutil too often, i.e. at least 1 ms. And if the CPUs are stable enough (i.e.
> > > > > no interruptions to the running task), we wouldn't reevaluate before the next
> > > > > tick.
> > > > 
> > > > There are still the attach/detach callers to cfs_rq_util_change() that
> > > > kick in for fork/exit and migration.
> > > > 
> > > > But yes, barring those we shouldn't end up calling it at silly rates.
> > > 
> > > OK
> > > 
> > > Does this mean that running governor computations every time its callback
> > > is invoked by the scheduler would be fine?
> > 
> > I'd say yes right up till the point someone reports a regression ;-)
> 
> @Rafael: Do you want me to send a V2 with the changes you suggested in
> commit log?

Yes, in general, but I have more suggestions regarding that. :-)

I'll send them shortly.

Thanks,
Rafael
