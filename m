From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Thu, 16 Mar 2017 02:04:01 +0100
Message-ID: <CAJZ5v0je7vPOrcAAu7jB6h+FDFMJZ048EZf4_Cemk2dvt-ffHA@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1831216.C7tcY13Jiv@aspire.rjw.lan> <20170315125957.GD18557@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170315125957.GD18557@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 15, 2017 at 1:59 PM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 15-Mar 12:41, Rafael J. Wysocki wrote:
>> On Tuesday, February 28, 2017 02:38:37 PM Patrick Bellasi wrote:
>> > Was: SchedTune: central, scheduler-driven, power-perfomance control
>> >
>> > This series presents a possible alternative design for what has been presented
>> > in the past as SchedTune. This redesign has been defined to address the main
>> > concerns and comments collected in the LKML discussion [1] as well at the last
>> > LPC [2].
>> > The aim of this posting is to present a working prototype which implements
>> > what has been discussed [2] with people like PeterZ, PaulT and TejunH.
>> >
>> > The main differences with respect to the previous proposal [1] are:
>> >  1. Task boosting/capping is now implemented as an extension on top of
>> >     the existing CGroup CPU controller.
>> >  2. The previous boosting strategy, based on the inflation of the CPU's
>> >     utilization, has been now replaced by a more simple yet effective set
>> >     of capacity constraints.
>> >
>> > The proposed approach allows to constrain the minimum and maximum capacity
>> > of a CPU depending on the set of tasks currently RUNNABLE on that CPU.
>> > The set of active constraints are tracked by the core scheduler, thus they
>> > apply across all the scheduling classes. The value of the constraints are
>> > used to clamp the CPU utilization when the schedutil CPUFreq's governor
>> > selects a frequency for that CPU.
>> >
>> > This means that the new proposed approach allows to extend the concept of
>> > tasks classification to frequencies selection, thus allowing informed
>> > run-times (e.g. Android, ChromeOS, etc.) to efficiently implement different
>> > optimization policies such as:
>> >  a) Boosting of important tasks, by enforcing a minimum capacity in the
>> >     CPUs where they are enqueued for execution.
>> >  b) Capping of background tasks, by enforcing a maximum capacity.
>> >  c) Containment of OPPs for RT tasks which cannot easily be switched to
>> >     the usage of the DL class, but still don't need to run at the maximum
>> >     frequency.
>>
>> Do you have any practical examples of that, like for example what exactly
>> Android is going to use this for?
>
> In general, every "informed run-time" usually know quite a lot about
> tasks requirements and how they impact the user experience.
>
> In Android for example tasks are classified depending on their _current_
> role. We can distinguish for example between:
>
> - TOP_APP:    which are tasks currently affecting the UI, i.e. part of
>               the app currently in foreground
> - BACKGROUND: which are tasks not directly impacting the user
>               experience
>
> Given these information it could make sense to adopt different
> service/optimization policy for different tasks.
> For example, we can be interested in
> giving maximum responsiveness to TOP_APP tasks while we still want to
> be able to save as much energy as possible for the BACKGROUND tasks.
>
> That's where the proposal in this series (partially) comes on hand.

A question: Does "responsiveness" translate directly to "capacity" somehow?

Moreover, how exactly is "responsiveness" defined?

> What we propose is a "standard" interface to collect sensible
> information from "informed run-times" which can be used to:
>
> a) classify tasks according to the main optimization goals:
>    performance boosting vs energy saving
>
> b) support a more dynamic tuning of kernel side behaviors, mainly
>    OPPs selection and tasks placement
>
> Regarding this last point, this series specifically represents a
> proposal for the integration with schedutil. The main usages we are
> looking for in Android are:
>
> a) Boosting the OPP selected for certain critical tasks, with the goal
>    to speed-up their completion regardless of (potential) energy impacts.
>    A kind-of "race-to-idle" policy for certain tasks.

It looks like this could be addressed by adding a "this task should
race to idle" flag too.

> b) Capping the OPP selection for certain non critical tasks, which is
>    a major concerns especially for RT tasks in mobile context, but
>    it also apply to FAIR tasks representing background activities.

Well, is the information on how much CPU capacity assign to those
tasks really there in user space?  What's the source of it if so?

>> I gather that there is some experience with the current EAS implementation
>> there, so I wonder how this work is related to that.
>
> You right. We started developing a task boosting strategy a couple of
> years ago. The first implementation we did is what is currently in use
> by the EAS version in used on Pixel smartphones.
>
> Since the beginning our attitude has always been "mainline first".
> However, we found it extremely valuable to proof both interface's
> design and feature's benefits on real devices. That's why we keep
> backporting these bits on different Android kernels.
>
> Google, which primary representatives are in CC, is also quite focused
> on using mainline solutions for their current and future solutions.
> That's why, after the release of the Pixel devices end of last year,
> we refreshed and posted the proposal on LKML [1] and collected a first
> run of valuable feedbacks at LCP [2].

Thanks for the info, but my question was more about how it was related
from the technical angle.  IOW, there surely is some experience
related to how user space can deal with energy problems and I would
expect that experience to be an important factor in designing a kernel
interface for that user space, so I wonder if any particular needs of
the Android user space are addressed here.

I'm not intimately familiar with Android, so I guess I would like to
be educated somewhat on that. :-)

> This posting is an expression of the feedbacks collected so far and
> the main goal for us are:
> 1) validate once more the soundness of a scheduler-driven run-time
>    power-performance control which is based on information collected
>    from informed run-time
> 2) get an agreement on whether the current interface can be considered
>    sufficiently "mainline friendly" to have a chance to get merged
> 3) rework/refactor what is required if point 2 is not (yet) satisfied

My definition of "mainline friendly" may be different from a someone
else's one, but I usually want to know two things:
 1. What problem exactly is at hand.
 2. What alternative ways of addressing it have been considered and
why the particular one proposed has been chosen over the other ones.

At the moment I don't feel like I have enough information in both aspects.

For example, if you said "Android wants to do XYZ because of ABC and
that's how we want to make that possible, and it also could be done in
the other GHJ ways, but they are not attractive and here's why etc"
that would help quite a bit from my POV.

> It's worth to notice that these bits are completely independent from
> EAS. OPP biasing (i.e. capping/boosting) is a feature which stand by
> itself and it can be quite useful in many different scenarios where
> EAS is not used at all. A simple example is making schedutil to behave
> concurrently like the powersave governor for certain tasks and the
> performance governor for other tasks.

That's fine in theory, but honestly an interface like this will be a
maintenance burden and adding it just because it may be useful to
somebody sounds not serious enough.

IOW, I'd like to be able to say "This is going to be used by user
space X to do A and that's how etc" is somebody asks me about that
which honestly I can't at this point.

>
> As a final remark, this series is going to be a discussion topic in
> the upcoming OSPM summit [3]. It would be nice if we can get there
> with a sufficient knowledge of the main goals and the current status.

I'm not sure what you mean here, sorry.

> However, please let's keep discussing here about all the possible
> concerns which can be raised about this proposal.

OK

Thanks,
Rafael
