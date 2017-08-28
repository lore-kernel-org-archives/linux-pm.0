From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFCv4 1/6] sched/core: add utilization clamping to CPU
 controller
Date: Mon, 28 Aug 2017 11:23:03 -0700
Message-ID: <20170828182303.GZ491396@devbig577.frc2.facebook.com>
References: <20170824180857.32103-1-patrick.bellasi@arm.com>
 <20170824180857.32103-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34380 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdH1SXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2017 14:23:08 -0400
Content-Disposition: inline
In-Reply-To: <20170824180857.32103-2-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>

Hello,

No idea whether this makes sense overall.  I'll just comment on the
cgroup interface part.

On Thu, Aug 24, 2017 at 07:08:52PM +0100, Patrick Bellasi wrote:
> This patch extends the CPU controller by adding a couple of new attributes,
> util_min and util_max, which can be used to enforce frequency boosting and
> capping. Specifically:
> 
> - util_min: defines the minimum CPU utilization which should be considered,
> 	    e.g. when  schedutil selects the frequency for a CPU while a
> 	    task in this group is RUNNABLE.
> 	    i.e. the task will run at least at a minimum frequency which
> 	         corresponds to the min_util utilization
> 
> - util_max: defines the maximum CPU utilization which should be considered,
> 	    e.g. when schedutil selects the frequency for a CPU while a
> 	    task in this group is RUNNABLE.
> 	    i.e. the task will run up to a maximum frequency which
> 	         corresponds to the max_util utilization

I'm not sure min/max are the right names here.  min/low/high/max are
used to designate guarantees and limits on resources and the above is
more restricting the range of an attribute.  I'll think more about
what'd be better names here.

> These attributes:
> a) are tunable at all hierarchy levels, i.e. at root group level too, thus
>    allowing to defined minimum and maximum frequency constraints for all
>    otherwise non-classified tasks (e.g. autogroups)

The problem with doing the above is two-fold.

1. The feature becomes inaccessible without cgroup even though it
   doesn't have much to do with cgroup at system level.

2. For the above and other historical reasons, most other features
   have a separate way to configure at the system level.

I think it'd be better to keep the root level control outside cgorup.

> b) allow to create subgroups of tasks which are not violating the
>    utilization constraints defined by the parent group.

The problem with doing the above is that it ties the configs of a
cgroup with its ancestors and that gets weird across delegation
boundaries.  Other resource knobs don't behave this way - a descendant
cgroup can have any memory.low/high/max values and an ancestor
changing config doesn't destory its descendants' configs.  Please
follow the same convention.

> Tasks on a subgroup can only be more boosted and/or capped, which is
> matching with the "limits" schema proposed by the "Resource Distribution
> Model (RDM)" suggested by the CGroups v2 documentation:
>    Documentation/cgroup-v2.txt

So, the guarantee side (min / low) shouldn't allow the descendants to
have more.  ie. if memory.low is 512M at the parent, its children can
never have more than 512M of low protection.  Given that "boosting"
means more CPU consumption, I think it'd make more sense to follow
such semantics - ie. a descendant cannot have higher boosting than the
lowest of its ancestors.

Thanks.

-- 
tejun
