From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 02/14] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Tue, 14 Aug 2018 16:21:17 +0100
Message-ID: <20180814152117.GF2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-3-patrick.bellasi@arm.com>
 <20180814112509.GB2661@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180814112509.GB2661@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Pavan,

On 14-Aug 16:55, Pavan Kondeti wrote:
> On Mon, Aug 06, 2018 at 05:39:34PM +0100, Patrick Bellasi wrote:

> I see that we drop reference on the previous clamp group when a task changes
> its clamp limits. What about exiting tasks which claimed clamp groups? should
> not we drop the reference?

Yes, you right... when a task ends we are not currently releasing the
reference to its (eventually defined) task-specific clamp value!

Thanks for pointing this out... I'll fix this on the next posting!

-- 
#include <best/regards.h>

Patrick Bellasi
