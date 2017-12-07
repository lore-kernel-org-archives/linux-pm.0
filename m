From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 6/6] cpufreq: schedutil: ignore sugov kthreads
Date: Thu, 7 Dec 2017 15:47:52 +0000
Message-ID: <20171207154752.GS31247@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-7-patrick.bellasi@arm.com>
 <20171130134155.GF9903@localhost.localdomain>
 <20171130160234.GG31247@e110439-lin>
 <20171130161220.GK9903@localhost.localdomain>
 <20171130164237.GI31247@e110439-lin>
 <20171207092449.hncv4aldaum5wivg@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207092449.hncv4aldaum5wivg@vireshk-mac-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 07-Dec 14:54, Viresh Kumar wrote:
> On 30-11-17, 16:42, Patrick Bellasi wrote:
> > On 30-Nov 17:12, Juri Lelli wrote:
> > > Not sure about this though, not my call :). I guess this still helps
> > > until we get the DL changes in.
> > 
> > Yes, agree... well Viresh had some concerns about this patch.
> > Let see what he thinks.
> 
> And the problem is that we never got to a conclusion in V2 for this
> patch as well, as you never responded to the last set of queries I
> had. Unless we finish the ongoing conversations, we will have the same
> queries again.
> 
> IOW, can you explain the exact scenario where this patch will be
> helpful ? I am not sure if this patch is that helpful at all :)

My use case is considering a small FAIR task which triggers an OPP
change while running on a CPU which is different from the one running
the schedutil kthread.

If we go for a "clear flags semantics", where the RT class clears its
flag as soon as there are not more RT tasks runnable, then this patch
likely is not more required.

Otherwise, there can be corner cases in which the RT flag remain set in
the kthread CPU thus affecting OPP decisions even then there are not
RT tasks around. Consider for example this scenarios:


CPU0:               | SUGOV |            | SUGOV |
         small FAIR |       | small FAIR |       |
                      flags = RT          ^
                    ^                     |
                    | (A)                 | (B)
                    | sugov_update_util() |
                    |                     | sugov_update_util()
CPU1:    medium growing FAIR task | another FAIR enqueued


In this case:
- in A we set the RT flag
- in B we pick the MAX OPP even if there are only small tasks.


This will not happen with a "clear flags semantics" because we ensure
to release the RT flag every time an RT task exit the CPU.
Thus, if we go for that semantics, we can skip this patch.

-- 
#include <best/regards.h>

Patrick Bellasi
