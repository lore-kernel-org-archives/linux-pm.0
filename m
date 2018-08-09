From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 05/14] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Date: Thu, 9 Aug 2018 16:30:59 +0100
Message-ID: <20180809153059.3cfw45qibcv5qqqk@darkstar>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-6-patrick.bellasi@arm.com>
 <CAKfTPtC2adLupg7wy1JU9zxKx1466Sza6fSCcr92wcawm1OYkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtC2adLupg7wy1JU9zxKx1466Sza6fSCcr92wcawm1OYkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, viresh kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, "Cc: Steve Muckle" <smuckle@google.com>, surenb@google.com
List-Id: linux-pm@vger.kernel.org

On 08-Aug 15:18, Vincent Guittot wrote:
> Hi Patrick,

Hi VIncent,

> On Mon, 6 Aug 2018 at 18:40, Patrick Bellasi <patrick.bellasi@arm.com> wrote:

[...]

> > +static inline unsigned int uclamp_util(unsigned int cpu, unsigned int util)
> 
> using struct *rq rq instead of cpu as parameter would align
> uclamp_util() interface with other cpu_util_*() interface and remove
> some cpu_of(rq) and  cpu_rq(cpu)

Right, I've tired to keep consistency within the "uclamp_*" APIs...
but what you suggests makes also sense and I've also already
switched some other APIs to use *rq.

I'll look into better aligning these APIs for the next posting.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
