From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Thu, 16 Mar 2017 12:23:21 +0000
Message-ID: <20170316122321.GA22319@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1831216.C7tcY13Jiv@aspire.rjw.lan>
 <20170315125957.GD18557@e110439-lin>
 <CAJZ5v0je7vPOrcAAu7jB6h+FDFMJZ048EZf4_Cemk2dvt-ffHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbdCPMXb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Mar 2017 08:23:31 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0je7vPOrcAAu7jB6h+FDFMJZ048EZf4_Cemk2dvt-ffHA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 16-Mar 02:04, Rafael J. Wysocki wrote:
> On Wed, Mar 15, 2017 at 1:59 PM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > On 15-Mar 12:41, Rafael J. Wysocki wrote:
> >> On Tuesday, February 28, 2017 02:38:37 PM Patrick Bellasi wrote:
> >> > Was: SchedTune: central, scheduler-driven, power-perfomance control
> >> >
> >> > This series presents a possible alternative design for what has been presented
> >> > in the past as SchedTune. This redesign has been defined to address the main
> >> > concerns and comments collected in the LKML discussion [1] as well at the last
> >> > LPC [2].
> >> > The aim of this posting is to present a working prototype which implements
> >> > what has been discussed [2] with people like PeterZ, PaulT and TejunH.
> >> >
> >> > The main differences with respect to the previous proposal [1] are:
> >> >  1. Task boosting/capping is now implemented as an extension on top of
> >> >     the existing CGroup CPU controller.
> >> >  2. The previous boosting strategy, based on the inflation of the CPU's
> >> >     utilization, has been now replaced by a more simple yet effective set
> >> >     of capacity constraints.
> >> >
> >> > The proposed approach allows to constrain the minimum and maximum capacity
> >> > of a CPU depending on the set of tasks currently RUNNABLE on that CPU.
> >> > The set of active constraints are tracked by the core scheduler, thus they
> >> > apply across all the scheduling classes. The value of the constraints are
> >> > used to clamp the CPU utilization when the schedutil CPUFreq's governor
> >> > selects a frequency for that CPU.
> >> >
> >> > This means that the new proposed approach allows to extend the concept of
> >> > tasks classification to frequencies selection, thus allowing informed
> >> > run-times (e.g. Android, ChromeOS, etc.) to efficiently implement different
> >> > optimization policies such as:
> >> >  a) Boosting of important tasks, by enforcing a minimum capacity in the
> >> >     CPUs where they are enqueued for execution.
> >> >  b) Capping of background tasks, by enforcing a maximum capacity.
> >> >  c) Containment of OPPs for RT tasks which cannot easily be switched to
> >> >     the usage of the DL class, but still don't need to run at the maximum
> >> >     frequency.
> >>
> >> Do you have any practical examples of that, like for example what exactly
> >> Android is going to use this for?
> >
> > In general, every "informed run-time" usually know quite a lot about
> > tasks requirements and how they impact the user experience.
> >
> > In Android for example tasks are classified depending on their _current_
> > role. We can distinguish for example between:
> >
> > - TOP_APP:    which are tasks currently affecting the UI, i.e. part of
> >               the app currently in foreground
> > - BACKGROUND: which are tasks not directly impacting the user
> >               experience
> >
> > Given these information it could make sense to adopt different
> > service/optimization policy for different tasks.
> > For example, we can be interested in
> > giving maximum responsiveness to TOP_APP tasks while we still want to
> > be able to save as much energy as possible for the BACKGROUND tasks.
> >
> > That's where the proposal in this series (partially) comes on hand.
> 
> A question: Does "responsiveness" translate directly to "capacity" somehow?
> 
> Moreover, how exactly is "responsiveness" defined?

A) "responsiveness" correlates somehow with "capacity". It's subject
   to profiling which, for some critical system components, can be
   done in an app-independent way.

   Optimization of the rendering pipeline is an example. Other system
   services, which are provided by Android to all applications, are
   also examples of where the integrator can tune and optimize to
   give benefits across all apps.

B) the definition of "responsiveness", from a certain perspective, is
   more "qualitative" than "quantitative".

   Android is aware about different "application contexts", TOP_APP vs
   FOREGROUND is just an example (there are others).
   Thus, the run-time has the knowledge about the "qualitative
   responsiveness" required by each context.

   Moreover, Andoid integrators knows about the specific HW they are
   targeting.  This knowledge in addition to the "application
   contexts", in our experience, it allows Android to feed valuable
   input to both the scheduler and schedutil.

Of course, as Joel pointed out in his previous response,
responsiveness has also a "quantitative" definition, where "jank
frames" is the main metric in the Android world. With the help of the
propose interface we provide a useful interface for integrators to
tune their platform for the power-vs-performance trade-off they most
like.

> > What we propose is a "standard" interface to collect sensible
> > information from "informed run-times" which can be used to:
> >
> > a) classify tasks according to the main optimization goals:
> >    performance boosting vs energy saving
> >
> > b) support a more dynamic tuning of kernel side behaviors, mainly
> >    OPPs selection and tasks placement
> >
> > Regarding this last point, this series specifically represents a
> > proposal for the integration with schedutil. The main usages we are
> > looking for in Android are:
> >
> > a) Boosting the OPP selected for certain critical tasks, with the goal
> >    to speed-up their completion regardless of (potential) energy impacts.
> >    A kind-of "race-to-idle" policy for certain tasks.
> 
> It looks like this could be addressed by adding a "this task should
> race to idle" flag too.

With the proposed interface we don't need an additional flag. If you
set capacity_min=capacity_max=1024 then you are informing schedutil,
and the scheduler as well, that this task would like to race-to-idle.

I say "would like" because here we are not proposing a mandatory
interface but we are still in the domain of "best effort" guarantees.

> > b) Capping the OPP selection for certain non critical tasks, which is
> >    a major concerns especially for RT tasks in mobile context, but
> >    it also apply to FAIR tasks representing background activities.
> 
> Well, is the information on how much CPU capacity assign to those
> tasks really there in user space?  What's the source of it if so?

I think my previous comment, two paragraphs above, should have
contributed to address this question.

I'm still wondering if you are after a formal, scientific and
mathematical definition of CPU capacity demands?
Because in that case it's worth to stress that this is not the aim of
the proposed interface.

If you have such detailed information you are probably better
positioned to got for a different solution, perhaps using DEADLINE.
If instead you are dealing with FAIR tasks but still find not
sufficient the (completely application-context transparent) in-kernel
utilization tracking mechanism, than you can give value to any kind of
user-space input about tasks requirements in each and every instant.

Notice that these requirements are not set by tasks themselves but
instead they come from the run-time knowledge.
Thus, the main point is not "how to precisely measure CPU demands" but
how to feed additional and useful _context sensitive_ information from
user-space to kernel-space.

> >> I gather that there is some experience with the current EAS implementation
> >> there, so I wonder how this work is related to that.
> >
> > You right. We started developing a task boosting strategy a couple of
> > years ago. The first implementation we did is what is currently in use
> > by the EAS version in used on Pixel smartphones.
> >
> > Since the beginning our attitude has always been "mainline first".
> > However, we found it extremely valuable to proof both interface's
> > design and feature's benefits on real devices. That's why we keep
> > backporting these bits on different Android kernels.
> >
> > Google, which primary representatives are in CC, is also quite focused
> > on using mainline solutions for their current and future solutions.
> > That's why, after the release of the Pixel devices end of last year,
> > we refreshed and posted the proposal on LKML [1] and collected a first
> > run of valuable feedbacks at LCP [2].
> 
> Thanks for the info, but my question was more about how it was related
> from the technical angle.  IOW, there surely is some experience
> related to how user space can deal with energy problems and I would
> expect that experience to be an important factor in designing a kernel
> interface for that user space, so I wonder if any particular needs of
> the Android user space are addressed here.

We are not addressing specific needs of the Android user-space,
although we used Android as our main design and testing support
vehicle.
Still, the concepts covered by this proposal aims to be suitable for a
better integration of each "informed run-times" running on top of the
Linux kernel.

> I'm not intimately familiar with Android, so I guess I would like to
> be educated somewhat on that. :-)

Android is just one of such possible run-times, and a notable
representative of the mobile world.

ChromeOS is another notable potential user, which is mainly
representative of the laptops/clamshell world.

Finally, every "container manager", mainly used in server domain,
can potentially get benefits from the proposed interface (e.g.
kubernets).

The point here is that we have many different instances of user-space
run-times which know a lot more about the "user-space contexts" than
what we can aim to figure out by just working in kernel-space.

What we propose is a simple, best-effort and generic interface to feed
some of these information to kernel-space, thus supporting and
integrating already available policies and mechanisms.

> > This posting is an expression of the feedbacks collected so far and
> > the main goal for us are:
> > 1) validate once more the soundness of a scheduler-driven run-time
> >    power-performance control which is based on information collected
> >    from informed run-time
> > 2) get an agreement on whether the current interface can be considered
> >    sufficiently "mainline friendly" to have a chance to get merged
> > 3) rework/refactor what is required if point 2 is not (yet) satisfied
> 
> My definition of "mainline friendly" may be different from a someone
> else's one, but I usually want to know two things:
>  1. What problem exactly is at hand.

Feed "context aware" information about tasks requirements from
"informed run-times" to kernel-space to integrate/improve existing
decision policies for OPPs selections and tasks placement.


>  2. What alternative ways of addressing it have been considered and

We initially considered and evaluated what was possible to achieve by
just using existing APIs.
For example, we considered different combinations of:

- tuning task-affinity: which sounds too much like scheduling from
  user-space and does not have biasing on OPPs selection.

- tuning tasks-priorities: which is a concept mainly devoted to
  partitioning of the available bandwidth among RUNNABLE tasks within
  the same CPU.

- tuning 'cpusets' and/or 'cpu' controllers: which can be used to bias
  task placement but still it sounds like scheduling from user-space
  and they are missing the biasing on OPPs selection.

All these interfaces was not completely satisfying mainly because it
seemed to abuse their usage for a different scope.

Since the main goals are to bias OPP selection and tasks placement
based on application context, what we identified _initially_ was a
new CGroup based interface to tag tasks with a "boost" value.
That proposal [1] has been considered not suitable for a proper
kernel integration and thus, discussing with PeterZ, Tejun and PaulT
we identified a different proposal [2] which is what this series
implements.


> why the particular one proposed has been chosen over the other ones.

The current proposal has been chosen because:

1) it satisfy the main goal to have a simple interface which allows
   "informed run-time" (like Android but not limited to it) to feed
   "context aware" information related to user-space applications.

2) it allows to use this information to bias existing policies for
   both "OPP selection" (presented in this series) as well as "task
   placement" (as an extension on top of this series).

3) it extend the existing CPU controller, which is already devoted to
   control the available CPU bandwidth, thus allowing for a consistent
   view on how this resource is allocated to tasks.

4) it does not enforce by default any new/different behaviors (for
   example on OPP selection) but it just open possibilities for finer
   tuning whenever necessary.

5) it has almost negligible run-time overhead, mainly defined by the
   complexity of a couple of RBTree operations per each task
   wakeup/suspend.

> At the moment I don't feel like I have enough information in both aspects.

Hope the previous points cast some light on both aspects.

> For example, if you said "Android wants to do XYZ because of ABC and
> that's how we want to make that possible, and it also could be done in
> the other GHJ ways, but they are not attractive and here's why etc"
> that would help quite a bit from my POV.

Main issue for others solutions we evaluated so far is that they are
missing a clean and simple interface to express "context awareness"
at a task group level.

CGroups is the Linux framework devoted to the collection and tracking
of task group's properties. What we propose leverage this concept by
extending it just as much as required to support the dual goal of
biasing "OPPs selection" and "tasks placement" without really
requiring to re-implement these concepts in user-space.

Do you see other possible solutions?

> > It's worth to notice that these bits are completely independent from
> > EAS. OPP biasing (i.e. capping/boosting) is a feature which stand by
> > itself and it can be quite useful in many different scenarios where
> > EAS is not used at all. A simple example is making schedutil to behave
> > concurrently like the powersave governor for certain tasks and the
> > performance governor for other tasks.
> 
> That's fine in theory, but honestly an interface like this will be a
> maintenance burden and adding it just because it may be useful to
> somebody sounds not serious enough.

Actually, it is already useful to "someone". Google is using something
similar on Pixel devices and in the future it will be likely adopted
by other smartphones.

Here we are just trying to push it mainline to make it available also
to all the other potential clients I've described before.

> IOW, I'd like to be able to say "This is going to be used by user
> space X to do A and that's how etc" is somebody asks me about that
> which honestly I can't at this point.

In that case, again I think we have a strong case for "this is going
to be used by".

> > As a final remark, this series is going to be a discussion topic in
> > the upcoming OSPM summit [3]. It would be nice if we can get there
> > with a sufficient knowledge of the main goals and the current status.
> 
> I'm not sure what you mean here, sorry.

Just that I like this discussion and I would like to get some sort of
initial agreement at least on basic concepts, requirements and
use-cases before OSPM.

That would allow us to be more active on the technical details side
during the summit and, hopefully, come to the definition of a roadmap
detailing the required steps to get merged a suitable interface,
whether is the one proposed by this series or another achieving the
same goals.

> > However, please let's keep discussing here about all the possible
> > concerns which can be raised about this proposal.
> 
> OK
> 
> Thanks,
> Rafael

[1] https://lkml.org/lkml/2016/10/27/503
[2] https://lkml.org/lkml/2016/11/25/342

-- 
#include <best/regards.h>

Patrick Bellasi
