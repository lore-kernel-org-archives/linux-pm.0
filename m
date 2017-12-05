From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC PATCH v2 1/8] sched/cpufreq_schedutil: make use of DEADLINE
 utilization signal
Date: Tue, 5 Dec 2017 16:34:10 +0000
Message-ID: <20171205163409.GN31247@e110439-lin>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
 <20171204102325.5110-2-juri.lelli@redhat.com>
 <20171205150935.GL31247@e110439-lin>
 <20171205152424.GC15085@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51638 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbdLEQeQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Dec 2017 11:34:16 -0500
Content-Disposition: inline
In-Reply-To: <20171205152424.GC15085@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, alessio.balsini@arm.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 05-Dec 16:24, Juri Lelli wrote:
> On 05/12/17 15:09, Patrick Bellasi wrote:
> > > +	/*
> > > +	 * Ideally we would like to set util_dl as min/guaranteed freq and
> > > +	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> > > +	 * ready for such an interface. So, we only do the latter for now.
> > > +	 */
> > 
> > Maybe I don't completely get the above comment, but to me it is not
> > really required.
> > 
> > When you say that "util_dl" should be set to a min/guaranteed freq
> > are you not actually talking about a DL implementation detail?
> > 
> > From the cpufreq standpoint instead, we should always set a capacity
> > which can accommodate util_dl + util_cfs.
> 
> It's more for platforms which supports such combination of values for
> frequency requests (CPPC like, AFAIU). The idea being that util_dl is
> what the system has to always guarantee, but it could go up to the sum
> if feasible.

I see, you mean for systems where you can specify both values at the
same time, i.e.
- please give me util_dl...
- ... but if you have more beer, I would like util_dl + util_cfs

However, I'm not an expert, on those systems can we really set a
minimum guaranteed performance level?

I was more of the idea that the "minimum guaranteed" is something we
can only read from "firmware", while we can only ask for something
which is never "guaranteed".

> > We don't care about the meaning of util_dl and we should always assume
> > (by default) that the signal is properly updated by the scheduling
> > class... which unfortunately does not always happen for CFS.
> > 

-- 
#include <best/regards.h>

Patrick Bellasi
