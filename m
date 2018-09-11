From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Date: Tue, 11 Sep 2018 17:26:24 +0100
Message-ID: <20180911162624.GB1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com>
 <20180911151819.GH1100574@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911151819.GH1100574@devbig004.ftw2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 11-Sep 08:18, Tejun Heo wrote:
> Hello, Patrick.

Hi Tejun,

> Can we first concentrate on getting in the non-cgroup part first?

That's the reason why I've reordered (as per your request) the series
to have all the core and non-cgroup related bits at the beginning.

There are a couple of patches at the end of this series which can be
anticipated but, apart from those, the cgroup code is very well
self-contained within patches 7-12.

> The feature has to make sense without cgroup too

Indeed, this is what I worked on since you pointed out in v1 that
there must be a meaningful non-cgroup API and that's what we have
since v2.

> and I think it'd be a lot easier to discuss cgroup details once the
> scheduler core side is settled.

IMHO, developing the cgroup interface on top of the core bits is quite
important to ensure that we have effective data structures and
implementation which can satisfy both worlds.

My question is: IF the scheduler maintainers are going to be happy
with the overall design for the core bits, are you happy to start the
review of the cgroups bits before the core ones are (eventually) merged?

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
