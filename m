From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 6/6] cpufreq: schedutil: ignore sugov kthreads
Date: Thu, 30 Nov 2017 16:42:51 +0000
Message-ID: <20171130164237.GI31247@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-7-patrick.bellasi@arm.com>
 <20171130134155.GF9903@localhost.localdomain>
 <20171130160234.GG31247@e110439-lin>
 <20171130161220.GK9903@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130161220.GK9903@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 30-Nov 17:12, Juri Lelli wrote:
> On 30/11/17 16:02, Patrick Bellasi wrote:
> > On 30-Nov 14:41, Juri Lelli wrote:
> 
> [...]
> 
> > > If the DL changes (which I shall post again as soon as tip/sched/core is
> > > bumped up to 4.15-rc1) get in first, this is going to be useless (as the
> > > DL kthread gets ignored by the scheduling class itself). But, this looks
> > > good to me "in the meantime".
> > 
> > Just to better understand, you mean that the DL kthread does not send
> > out schedutil updates?
> 
> It doesn't have a "proper" bandwidth (utilization) :/. So it gets
> "unnoticed" and schedutil updates are not triggered.

Ah, right... that was the "let CBS ignore this DL task" solution! ;-)

> > 
> > If that's the case I agree we can discard this patch... that's also
> > one of the reasons why I move it at the end of this series.
> 
> Not sure about this though, not my call :). I guess this still helps
> until we get the DL changes in.

Yes, agree... well Viresh had some concerns about this patch.
Let see what he thinks.
 
> Best,
> 
> Juri

-- 
#include <best/regards.h>

Patrick Bellasi
