From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Thu, 23 Mar 2017 12:01:12 -0400
Message-ID: <20170323160112.GA5953@htj.duckdns.org>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org>
 <20170320180837.GB28391@e110439-lin>
 <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
 <20170323103254.GA11362@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34293 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934419AbdCWQBP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 12:01:15 -0400
Content-Disposition: inline
In-Reply-To: <20170323103254.GA11362@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hello,

On Thu, Mar 23, 2017 at 10:32:54AM +0000, Patrick Bellasi wrote:
> > But then we would lose out on being able to attach capacity
> > constraints to specific tasks or groups of tasks?
> 
> Yes, right. If CGroups are not available than you cannot specify
> per-task constraints. This is just a system-wide global tunable.
> 
> Question is: does this overall proposal makes sense outside the scope
> of task groups classification? (more on that afterwards)

I think it does, given that it's a per-thread property which requires
internal application knowledge to tune.

> > I think the concern raised is more about whether CGroups is the right
> > interface to use for attaching capacity constraints to task or groups
> > of tasks, or is there a better way to attach such constraints?
> 
> Notice that CGroups based classification allows to easily enforce
> the concept of "delegation containment". I think this feature should
> be nice to have whatever interface we choose.
> 
> However, potentially we can define a proper per-task API; are you
> thinking to something specifically?

I don't think the overall outcome was too good when we used cgroup as
the direct way of configuring certain attributes - it either excludes
the possibility of easily accessible API from application side or
conflicts with the attributes set through such API.  It's a lot
clearer when cgroup just sets what's allowed under the hierarchy.

This is also in line with the aspect that cgroup for the most part is
a scoping mechanism - it's the most straight-forward to implement and
use when the behavior inside cgroup matches a system without cgroup,
just scoped.  It shows up here too.  If you take out the cgroup part,
you're left with an interface which is hardly useful.  cgroup isn't
scoping the global system here.  It's becoming the primary interface
for this feature which most likely isn't a good sign.

So, my suggestion is to implement it as a per-task API.  If the
feature calls for scoped restrictions, we definitely can add cgroup
support for that but I'm really not convinced about using cgroup as
the primary interface for this.

Thanks.

-- 
tejun
