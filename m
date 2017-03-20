From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Mon, 20 Mar 2017 23:51:37 +0100
Message-ID: <CAJZ5v0hyvL-hzpmM5TkEH4FRbJ1JyK4m7Q=urSO1F_Ghz8Vf4A@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1831216.C7tcY13Jiv@aspire.rjw.lan> <20170315125957.GD18557@e110439-lin>
 <CAJZ5v0je7vPOrcAAu7jB6h+FDFMJZ048EZf4_Cemk2dvt-ffHA@mail.gmail.com> <CAJWu+opFdFYnKks8ywcbto1CAk=-k437bwzez-txp+8tRb3QzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:34630 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755862AbdCTWvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 18:51:39 -0400
In-Reply-To: <CAJWu+opFdFYnKks8ywcbto1CAk=-k437bwzez-txp+8tRb3QzA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On Thu, Mar 16, 2017 at 4:15 AM, Joel Fernandes <joelaf@google.com> wrote:
> Hi Rafael,

Hi,

> On Wed, Mar 15, 2017 at 6:04 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Mar 15, 2017 at 1:59 PM, Patrick Bellasi
>>>> Do you have any practical examples of that, like for example what exactly
>>>> Android is going to use this for?
>>>
>>> In general, every "informed run-time" usually know quite a lot about
>>> tasks requirements and how they impact the user experience.
>>>
>>> In Android for example tasks are classified depending on their _current_
>>> role. We can distinguish for example between:
>>>
>>> - TOP_APP:    which are tasks currently affecting the UI, i.e. part of
>>>               the app currently in foreground
>>> - BACKGROUND: which are tasks not directly impacting the user
>>>               experience
>>>
>>> Given these information it could make sense to adopt different
>>> service/optimization policy for different tasks.
>>> For example, we can be interested in
>>> giving maximum responsiveness to TOP_APP tasks while we still want to
>>> be able to save as much energy as possible for the BACKGROUND tasks.
>>>
>>> That's where the proposal in this series (partially) comes on hand.
>>
>> A question: Does "responsiveness" translate directly to "capacity" somehow?
>>
>> Moreover, how exactly is "responsiveness" defined?
>
> Responsiveness is basically how quickly the UI is responding to user
> interaction after doing its computation, application-logic and
> rendering. Android apps have 2 important threads, the main thread (or
> UI thread) which does all the work and computation for the app, and a
> Render thread which does the rendering and submission of frames to
> display pipeline for further composition and display.
>
> We wish to bias towards performance than energy for this work since
> this front facing to the user and we don't care about much about
> energy for these tasks at this point, what's most critical is
> completion as quickly as possible so the user experience doesn't
> suffer from a performance issue that is noticeable.
>
> One metric to define this is "Jank" where we drop frames and aren't
> able to render on time. One of the reasons this can happen because the
> main thread (UI thread) took longer than expected for some
> computation. Whatever the interface - we'd just like to bias the
> scheduling and frequency guidance to be more concerned with
> performance and less with energy. And use this information for both
> frequency selection and task placement. 'What we need' is also app
> dependent since every app has its own main thread and is free to
> compute whatever it needs. So Android can't estimate this - but we do
> know that this app is user facing so in broad terms the interface is
> used to say please don't sacrifice performance for these top-apps -
> without accurately defining what these performance needs really are
> because we don't know it.
> For YouTube app for example, the complexity of the video decoding and
> the frame rate are very variable depending on the encoding scheme and
> the video being played. The flushing of the frames through the display
> pipeline is also variable (frame rate depends on the video being
> decoded), so this work is variable and we can't say for sure in
> definitive terms how much capacity we need.
>
> What we can do is with Patrick's work, we can take the worst case
> based on measurements and specify say we need atleast this much
> capacity regardless of what load-tracking thinks we need and then we
> can scale frequency accordingly. This is the usecase for the minimum
> capacity in his clamping patch. This is still not perfect in terms of
> defining something accurately because - we don't even know how much we
> need, but atleast in broad terms we have some way of telling the
> governor to maintain atleast X capacity.

First off, it all seems to depend a good deal on what your
expectations regarding the in-kernel performance scaling are.

You seem to be expecting it to decide whether or not to sacrifice some
performance for energy savings, but it can't do that really, simply
because it has no guidance on that.  It doesn't know how much
performance (or capacity) it can trade for a given amount of energy,
for example.

What it can do and what I expect it to be doing is to avoid
maintaining excess capacity (maintaining capacity is expensive in
general and a clear waste if the capacity is not actually used).

For instance, if you take the schedutil governor, it doesn't do
anything really fancy.  It just attempts to set a frequency sufficient
to run the given workload without slowing it down artificially, but
not much higher than that, and that's not based on any arcane
energy-vs-performance considerations.  It's based on an (arguably
vague) idea about how fast should be sufficient.

So if you want to say "please don't sacrifice performance for these
top-apps" to it, chances are it will not understand what you are
asking it for. :-)

It only may take the minimum capacity limit for a task as a correction
to its idea about how fast is sufficient in this particular case (and
energy doesn't even enter the picture at this point).  Now, of course,
its idea about what should be sufficient may be entirely incorrect for
some reason, but then the question really is: why?  And whether or not
it can be fixed without supplying corrections from user space in a
very direct way.

What you are saying generally indicates that you see under-provisioned
tasks and that's rather nor because the kernel tries to sacrifice
performance for energy.  Maybe the CPU utilization is under-estimated
by schedutil or the scheduler doesn't give enough time to these
particular tasks for some reason.  In any case, having a way to set a
limit from user space may allow you to work around these issues quite
bluntly and is not a solution.  And even if the underlying problems
are solved, the user space interface will stay there and will have to
be maintained going forward.

Also when you set a minimum frequency limit from user space, you may
easily over-provision the task and that would defeat the purpose of
what the kernel tries to achieve.

> For the clamping of maximum capacity, there are usecases like
> background tasks like Patrick said, but also usecases where we don't
> want to run at max frequency even though load-tracking thinks that we
> need to. For example, there are case where for foreground camera
> tasks, where we want to provide sustainable performance without
> entering thermal throttling, so the capping will help there.

Fair enough.

To me, that case is more compelling than the previous one, but again
I'm not sure if the ability to set a specific capacity limit may fit
the bill entirely.  You need to know what limit to set in the first
place (and that may depend on multiple factors in principle) and then
you may need to adjust it over time and so on.

>>> What we propose is a "standard" interface to collect sensible
>>> information from "informed run-times" which can be used to:
>>>
>>> a) classify tasks according to the main optimization goals:
>>>    performance boosting vs energy saving
>>>
>>> b) support a more dynamic tuning of kernel side behaviors, mainly
>>>    OPPs selection and tasks placement
>>>
>>> Regarding this last point, this series specifically represents a
>>> proposal for the integration with schedutil. The main usages we are
>>> looking for in Android are:
>>>
>>> a) Boosting the OPP selected for certain critical tasks, with the goal
>>>    to speed-up their completion regardless of (potential) energy impacts.
>>>    A kind-of "race-to-idle" policy for certain tasks.
>>
>> It looks like this could be addressed by adding a "this task should
>> race to idle" flag too.
>
> But he said 'kind-of' race-to-idle. Racing to idle all the time for
> ex. at max frequency will be wasteful of energy so although we don't
> care about energy much for top-apps, we do care a bit.

You actually don't know whether or not it will be wasteful and there
may even be differences from workload to workload on the same system
in that respect.

>>
>>> b) Capping the OPP selection for certain non critical tasks, which is
>>>    a major concerns especially for RT tasks in mobile context, but
>>>    it also apply to FAIR tasks representing background activities.
>>
>> Well, is the information on how much CPU capacity assign to those
>> tasks really there in user space?  What's the source of it if so?
>
> I believe this is just a matter of tuning and modeling for what is
> needed. For ex. to prevent thermal throttling as I mentioned and also
> to ensure background activities aren't running at highest frequency
> and consuming excessive energy (since racing to idle at higher
> frequency is more expensive energy than running slower to idle since
> we run at higher voltages at higher frequency and the slow of the
> perf/W curve is steeper - p = c * V^2 * F. So the V component being
> higher just drains more power quadratic-ally which is of no use to
> background tasks - infact in some tests, we're just as happy with
> setting them at much lower frequencies than what load-tracking thinks
> is needed.

As I said, I actually can see a need to go lower than what performance
scaling thinks, because the way it tries to estimate the sufficient
capacity is by checking how much utilization is there for the
currently provided capacity and adjusting if necessary.  OTOH, there
are applications aggressive enough to be able to utilize *any*
capacity provided to them.

>>>> I gather that there is some experience with the current EAS implementation
>>>> there, so I wonder how this work is related to that.
>>>
>>> You right. We started developing a task boosting strategy a couple of
>>> years ago. The first implementation we did is what is currently in use
>>> by the EAS version in used on Pixel smartphones.
>>>
>>> Since the beginning our attitude has always been "mainline first".
>>> However, we found it extremely valuable to proof both interface's
>>> design and feature's benefits on real devices. That's why we keep
>>> backporting these bits on different Android kernels.
>>>
>>> Google, which primary representatives are in CC, is also quite focused
>>> on using mainline solutions for their current and future solutions.
>>> That's why, after the release of the Pixel devices end of last year,
>>> we refreshed and posted the proposal on LKML [1] and collected a first
>>> run of valuable feedbacks at LCP [2].
>>
>> Thanks for the info, but my question was more about how it was related
>> from the technical angle.  IOW, there surely is some experience
>> related to how user space can deal with energy problems and I would
>> expect that experience to be an important factor in designing a kernel
>> interface for that user space, so I wonder if any particular needs of
>> the Android user space are addressed here.
>>
>> I'm not intimately familiar with Android, so I guess I would like to
>> be educated somewhat on that. :-)
>
> Hope this sheds some light into the Android side of things a bit.

Yes, it does, thanks!

Best regards,
Rafael
