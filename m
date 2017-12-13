From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 0/4] Utilization estimation (util_est) for FAIR tasks
Date: Wed, 13 Dec 2017 16:23:02 +0000
Message-ID: <20171213162302.GC8264@e110439-lin>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171213160357.3se4vvyo5lqud2uo@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213160357.3se4vvyo5lqud2uo@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 13-Dec 17:03, Peter Zijlstra wrote:
> On Tue, Dec 05, 2017 at 05:10:14PM +0000, Patrick Bellasi wrote:
> > With this feature enabled, the measured overhead is in the range of ~1%
> > on the same HW/SW test configuration.
> 
> That's quite a lot; did you look where that comes from?

I've tracked it down to  util_est_dequeue() introduced by PATCH 2/4,
mainly due to the EWMA udpate. Initially the running average was
implemented using the library function provided in:

   include/linux/average.h::DECLARE_EWMA

but that solution generated even more overhead.
That's why we switched to an "inline custom" implementation.

Hackbench is quite stressful for that path and we have also few
branches which can play a role. One for example has been added to
avoid the EWMA if the rolling average is "close enough" to the
current PELT value.

All that considered, that's why I disable by default the sched_feat,
in which case we have 0 overheads... in !SCHED_DEBUG kernel the code
is actually removed by the compiler.

In mobile systems (i.e. non-hackbench scenarios) the additional
benefits on tasks placement and OPP selection is likely still worth
the overhead.

Do you think the idea to have a Kconfig to enabled this feature only
on systems which do not care about the possible  overheads is a viable
solution?

-- 
#include <best/regards.h>

Patrick Bellasi
