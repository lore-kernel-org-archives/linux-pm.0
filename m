From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Thu, 23 Mar 2017 18:15:33 +0000
Message-ID: <20170323181533.GB11362@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org>
 <20170320180837.GB28391@e110439-lin>
 <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
 <20170323103254.GA11362@e110439-lin>
 <20170323160112.GA5953@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323160112.GA5953@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 23-Mar 12:01, Tejun Heo wrote:
> Hello,

Hi Tejun,

> On Thu, Mar 23, 2017 at 10:32:54AM +0000, Patrick Bellasi wrote:
> > > But then we would lose out on being able to attach capacity
> > > constraints to specific tasks or groups of tasks?
> > 
> > Yes, right. If CGroups are not available than you cannot specify
> > per-task constraints. This is just a system-wide global tunable.
> > 
> > Question is: does this overall proposal makes sense outside the scope
> > of task groups classification? (more on that afterwards)
> 
> I think it does, given that it's a per-thread property which requires
> internal application knowledge to tune.

Yes and no... perhaps I'm biased on some specific usage scenarios, but where I
find this interface more useful is not when apps tune themselves but instead
when an "external actor" (which I usually call an "informed run-time") controls
these apps.

> > > I think the concern raised is more about whether CGroups is the right
> > > interface to use for attaching capacity constraints to task or groups
> > > of tasks, or is there a better way to attach such constraints?
> > 
> > Notice that CGroups based classification allows to easily enforce
> > the concept of "delegation containment". I think this feature should
> > be nice to have whatever interface we choose.
> > 
> > However, potentially we can define a proper per-task API; are you
> > thinking to something specifically?
> 
> I don't think the overall outcome was too good when we used cgroup as
> the direct way of configuring certain attributes - it either excludes
> the possibility of easily accessible API from application side or

That's actually one of the main point: does it make sense to expose
such an API to applications at all?

What we are after is a properly defined interface where kernel-space and
user-space can potentially close this control loop:

a) a "privileged" user-space, which has much more a-priori information about
   tasks requirements, can feed some constraints to kernel-space

b) kernel-space, which has optimized and efficient mechanisms,
   enforces these constraints on a per task basis

Here is a graphical representation of these concepts:

      +-------------+    +-------------+  +-------------+
      | App1 Tasks  ++   | App2 Tasks  ++ | App3 Tasks  ++
      |             ||   |             || |             ||
      +--------------|   +--------------| +--------------|
       +-------------+    +-------------+  +-------------+
                |               |              |
  +----------------------------------------------------------+
  |                                                          |
  |      +--------------------------------------------+      |
  |      |  +-------------------------------------+   |      |
  |      |  |      Run-Time Optimized Services    |   |      |
  |      |  |        (e.g. execution model)       |   |      |
  |      |  +-------------------------------------+   |      |
  |      |                                            |      |
  |      |     Informed Run-Time Resource Manager     |      |
  |      |   (Android, ChromeOS, Kubernets, etc...)   |      |
  |      +------------------------------------------^-+      |
  |        |                                        |        |
  |        |Constraints                             |        |
  |        |(OPP and Task Placement biasing)        |        |
  |        |                                        |        |
  |        |                             Monitoring |        |
  |      +-v------------------------------------------+      |
  |      |               Linux Kernel                 |      |
  |      |         (Scheduler, schedutil, ...)        |      |
  |      +--------------------------------------------+      |
  |                                                          |
  | Closed control and optimization loop                     |
  +----------------------------------------------------------+

What is important to notice is that there is a middleware, in between
the kernel and the applications. This is a special kind of user-space
where it is still safe for the kernel to delegate some "decisions".

The ultimate user of the proposed interface will be such a middleware, not each
and every application. That's why the "containment" feature provided by CGroups
I think is a good fitting for the kind of design.

> conflicts with the attributes set through such API.

In this "run-time resource management" schema, generic applications do not
access the proposed API, which is reserved to the privileged user-space.

Applications eventually can request better services to the middleware, using a
completely different and more abstract API, which can also be domain specific.


> It's a lot clearer when cgroup just sets what's allowed under the hierarchy.
> This is also in line with the aspect that cgroup for the most part is
> a scoping mechanism - it's the most straight-forward to implement and
> use when the behavior inside cgroup matches a system without cgroup,
> just scoped.

I like this concept of "CGroups being a scoping mechanism" and I think it
perfectly matches this use-case as well...

>  It shows up here too.  If you take out the cgroup part,
> you're left with an interface which is hardly useful.  cgroup isn't
> scoping the global system here.

It is, indeed:

1) Applications do not see CGroups, never.
   They use whatever resources are available when CGroups are not in use.

2) When an "Informed Run-time Resource Manager" schema is used, then the same
   applications are scoped in the sense that they becomes "managed applications".

   Managed applications are still completely "unaware" about the CGroup
   interface, they do not relay on that interface for what they have to do.
   However, in this scenario, there is a supervisor which know how much an
   application can get each and every instant.

> It's becoming the primary interface
> for this feature which most likely isn't a good sign.

It's a primary interface yes, but not for apps, only for an (optional)
run-time resource manager.

What we want to enable with this interface is exactly the possibility for a
privileged user-space entity to "scope" different applications.

Described like that we can argue that we can still implement this model using a
custom per-task API. However, this proposal is about "tuning/partitioning" a
resource which is already (would say only) controllable using the CPU
controller.
That's also why the proposed interface has now been defined as a extension of
the CPU controller in such a way to keep a consistent view.

This controller is already used by run-times like Android to "scope" apps by
constraining the amount of CPUs resource they are getting.
Is that not a legitimate usage of the cpu controller?

What we are doing here is just extending it a bit in such a way that, while:

  {cfs,rt}_{period,runtime}_us limits the amount of TIME we can use a CPU

we can also use:

  capacity_{min,max} to limit the actual COMPUTATIONAL BANDWIDTH we can use
                     during that time.

> So, my suggestion is to implement it as a per-task API.  If the
> feature calls for scoped restrictions, we definitely can add cgroup
> support for that but I'm really not convinced about using cgroup as
> the primary interface for this.

Given this viewpoint, I can definitively see a "scoped restrictions" usage, as
well as the idea that this can be a unique and primary interface.
Again, not exposed generically to apps but targeting a proper integration
of user-space run-time resource managers.

I hope this contributed to clarify better the scope.  Do you still see the
CGroup API not as the best fit for such a usage?

> Thanks.
> 
> --
> tejun

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
