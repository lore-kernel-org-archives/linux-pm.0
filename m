From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Mon, 20 Mar 2017 13:15:11 -0400
Message-ID: <20170320171511.GB3623@htj.duckdns.org>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36817 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbdCTRXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 13:23:53 -0400
Content-Disposition: inline
In-Reply-To: <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hello,

On Tue, Feb 28, 2017 at 02:38:38PM +0000, Patrick Bellasi wrote:
> This patch extends the CPU controller by adding a couple of new
> attributes, capacity_min and capacity_max, which can be used to enforce
> bandwidth boosting and capping. More specifically:
> 
> - capacity_min: defines the minimum capacity which should be granted
>                 (by schedutil) when a task in this group is running,
>                 i.e. the task will run at least at that capacity
> 
> - capacity_max: defines the maximum capacity which can be granted
>                 (by schedutil) when a task in this group is running,
>                 i.e. the task can run up to that capacity

cpu.capacity.min and cpu.capacity.max are the more conventional names.
I'm not sure about the name capacity as it doesn't encode what it does
and is difficult to tell apart from cpu bandwidth limits.  I think
it'd be better to represent what it controls more explicitly.

> These attributes:
> a) are tunable at all hierarchy levels, i.e. root group too

This usually is problematic because there should be a non-cgroup way
of configuring the feature in case cgroup isn't configured or used,
and it becomes awkward to have two separate mechanisms configuring the
same thing.  Maybe the feature is cgroup specific enough that it makes
sense here but this needs more explanation / justification.

> b) allow to create subgroups of tasks which are not violating the
>    capacity constraints defined by the parent group.
>    Thus, tasks on a subgroup can only be more boosted and/or more

For both limits and protections, the parent caps the maximum the
children can get.  At least that's what memcg does for memory.low.
Doing that makes sense for memcg because for memory the parent can
still do protections regardless of what its children are doing and it
makes delegation safe by default.

I understand why you would want a property like capacity to be the
other direction as that way you get more specific as you walk down the
tree for both limits and protections; however, I think we need to
think a bit more about it and ensure that the resulting interface
isn't confusing.  Would it work for capacity to behave the other
direction - ie. a parent's min restricting the highest min that its
descendants can get?  It's completely fine if that's weird.

Thanks.

-- 
tejun
