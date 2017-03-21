From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 19:28:19 +0000
Message-ID: <20170321192819.GG11054@e110439-lin>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <3429350.K2FUBgvcIK@aspire.rjw.lan>
 <20170321143842.GE11054@e110439-lin>
 <1844525.jBn1oKmyb6@aspire.rjw.lan>
 <20170321150820.GF11054@e110439-lin>
 <20170321151827.GW3093@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933926AbdCUT2a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Mar 2017 15:28:30 -0400
Content-Disposition: inline
In-Reply-To: <20170321151827.GW3093@worktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On 21-Mar 16:18, Peter Zijlstra wrote:
> On Tue, Mar 21, 2017 at 03:08:20PM +0000, Patrick Bellasi wrote:
> 
> > And than we can move this bit into an inline function, something like e.g.:
> > 
> >    static inline bool sugov_this_cpu_is_busy()
> >    {
> >            return this_rq()->rd->overloaded
> >    }
> 
> No, that's just entirely and utterly wrong. It being in rd means its
> very much not about _this_ CPU in any way.

You right (of course), we cannot really use "this_" in the name of
a function with such a code.

The suggestion here was at least to factor out whatever code we want
to use to check if the current CPU has to be subject to a down-scaling
constraint.

However, using rd->overload is not the best option, for the many reasons
you explained in your previous comment. Thus, we should probably stay
with the idle time tracking solution initially proposed by Rafael.

Sorry for the noise :-(

-- 
#include <best/regards.h>

Patrick Bellasi
