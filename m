From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Thu, 23 Mar 2017 14:39:37 -0400
Message-ID: <20170323183937.GC5953@htj.duckdns.org>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org>
 <20170320180837.GB28391@e110439-lin>
 <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
 <20170323103254.GA11362@e110439-lin>
 <20170323160112.GA5953@htj.duckdns.org>
 <20170323181533.GB11362@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34366 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbdCWSjk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 14:39:40 -0400
Content-Disposition: inline
In-Reply-To: <20170323181533.GB11362@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hello, Patrick.

On Thu, Mar 23, 2017 at 06:15:33PM +0000, Patrick Bellasi wrote:
> What is important to notice is that there is a middleware, in between
> the kernel and the applications. This is a special kind of user-space
> where it is still safe for the kernel to delegate some "decisions".
> 
> The ultimate user of the proposed interface will be such a middleware, not each
> and every application. That's why the "containment" feature provided by CGroups
> I think is a good fitting for the kind of design.

cgroup isn't required for this type of uses.  We've always had this
sort of usages in combination with mechanisms to restrict what
non-priv applications can do.  The usage is perfectly valid but
whether to use cgroup as the sole interface is a different issue.

Yes, cgroup interface can be used this way; however, it does exclude,
or at least makes pretty cumbersome, different use cases which can be
served by a regular API.  And that isn't the case when we approach it
from the other direction.

> I like this concept of "CGroups being a scoping mechanism" and I think it
> perfectly matches this use-case as well...
> 
> >  It shows up here too.  If you take out the cgroup part,
> > you're left with an interface which is hardly useful.  cgroup isn't
> > scoping the global system here.
> 
> It is, indeed:
> 
> 1) Applications do not see CGroups, never.
>    They use whatever resources are available when CGroups are not in use.
> 
> 2) When an "Informed Run-time Resource Manager" schema is used, then the same
>    applications are scoped in the sense that they becomes "managed applications".
> 
>    Managed applications are still completely "unaware" about the CGroup
>    interface, they do not relay on that interface for what they have to do.
>    However, in this scenario, there is a supervisor which know how much an
>    application can get each and every instant.

But it isn't useful if you take cgroup out of the picture.  cgroup
isn't scoping a feature.  The feature is buried in the cgroup itself.
I don't think it's useful to argue over the fine semantics.  Please
see below.

> > It's becoming the primary interface
> > for this feature which most likely isn't a good sign.
> 
> It's a primary interface yes, but not for apps, only for an (optional)
> run-time resource manager.
> 
> What we want to enable with this interface is exactly the possibility for a
> privileged user-space entity to "scope" different applications.
> 
> Described like that we can argue that we can still implement this model using a
> custom per-task API. However, this proposal is about "tuning/partitioning" a
> resource which is already (would say only) controllable using the CPU
> controller.
> That's also why the proposed interface has now been defined as a extension of
> the CPU controller in such a way to keep a consistent view.
> 
> This controller is already used by run-times like Android to "scope" apps by
> constraining the amount of CPUs resource they are getting.
> Is that not a legitimate usage of the cpu controller?
> 
> What we are doing here is just extending it a bit in such a way that, while:
> 
>   {cfs,rt}_{period,runtime}_us limits the amount of TIME we can use a CPU
> 
> we can also use:
> 
>   capacity_{min,max} to limit the actual COMPUTATIONAL BANDWIDTH we can use
>                      during that time.

Yes, we do have bandwidth restriction as a cgroup only feature, which
is different from how we handle nice levels and weights.  Given the
nature of bandwidth limits, if necessary, it is straight-forward to
expose per-task interface.

capacity min/max isn't the same thing.  It isn't a limit on countable
units of a specific resource and that's why the interface you
suggested for .min is different.  It's restricting attribute set which
can be picked in the subhierarchy rather than controlling distribution
of atoms of the resource.

That's also why we're gonna have problem if we later decide we need a
thread based API for it.  Once we make cgroup the primary owner of the
attribute, it's not straight forward to add another owner.

> > So, my suggestion is to implement it as a per-task API.  If the
> > feature calls for scoped restrictions, we definitely can add cgroup
> > support for that but I'm really not convinced about using cgroup as
> > the primary interface for this.
> 
> Given this viewpoint, I can definitively see a "scoped restrictions" usage, as
> well as the idea that this can be a unique and primary interface.
> Again, not exposed generically to apps but targeting a proper integration
> of user-space run-time resource managers.
> 
> I hope this contributed to clarify better the scope.  Do you still see the
> CGroup API not as the best fit for such a usage?

Yes, I still think so.  It'd be best to first figure out how the
attribute should be configured, inherited and restricted using the
normal APIs and then layer scoped restrictions on top with cgroup.
cgroup shouldn't be used as a way to bypass or get in the way of a
proper API.

Thanks.

-- 
tejun
