From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC v3 5/5] sched/{core,cpufreq_schedutil}: add capacity
 clamping for RT/DL tasks
Date: Wed, 15 Mar 2017 14:44:49 +0000
Message-ID: <20170315144449.GH31499@e106622-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-6-git-send-email-patrick.bellasi@arm.com>
 <CAEi0qNkn8xS=8vzStXjtJVwYwiXiu4vefZwe3VQPUVqz72YiKw@mail.gmail.com>
 <20170315114052.GB18557@e110439-lin>
 <CAJWu+opgLoa3EGdhQKXSi+dkQjXtc62tKmTL0krXxpqJp+PjPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJWu+opgLoa3EGdhQKXSi+dkQjXtc62tKmTL0krXxpqJp+PjPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Andres Oportus <andresoportus@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Joel,

On 15/03/17 05:59, Joel Fernandes wrote:
> On Wed, Mar 15, 2017 at 4:40 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > On 13-Mar 03:08, Joel Fernandes (Google) wrote:
> >> Hi Patrick,
> >>
> >> On Tue, Feb 28, 2017 at 6:38 AM, Patrick Bellasi
> >> <patrick.bellasi@arm.com> wrote:
> >> > Currently schedutil enforce a maximum OPP when RT/DL tasks are RUNNABLE.
> >> > Such a mandatory policy can be made more tunable from userspace thus
> >> > allowing for example to define a reasonable max capacity (i.e.
> >> > frequency) which is required for the execution of a specific RT/DL
> >> > workload. This will contribute to make the RT class more "friendly" for
> >> > power/energy sensible applications.
> >> >
> >> > This patch extends the usage of capacity_{min,max} to the RT/DL classes.
> >> > Whenever a task in these classes is RUNNABLE, the capacity required is
> >> > defined by the constraints of the control group that task belongs to.
> >> >
> >>
> >> We briefly discussed this at Linaro Connect that this works well for
> >> sporadic RT tasks that run briefly and then sleep for long periods of
> >> time - so certainly this patch is good, but its only a partial
> >> solution to the problem of frequent and short-sleepers and something
> >> is required to keep the boost active for short non-RUNNABLE as well.
> >> The behavior with many periodic RT tasks is that they will sleep for
> >> short intervals and run for short intervals periodically. In this case
> >> removing the clamp (or the boost as in schedtune v2) on a dequeue will
> >> essentially mean during a narrow window cpufreq can drop the frequency
> >> and only to make it go back up again.
> >>
> >> Currently for schedtune v2, I am working on prototyping something like
> >> the following for Android:
> >> - if RT task is enqueue, introduce the boost.
> >> - When task is dequeued, start a timer for a  "minimum deboost delay
> >> time" before taking out the boost.
> >> - If task is enqueued again before the timer fires, then cancel the timer.
> >>
> >> I don't think any "fix" to this particular issue should be to the
> >> schedutil governor and should be sorted before going to cpufreq itself
> >> (that is before making the request). What do you think about this?
> >
> > My short observations are:
> >
> > 1) for certain RT tasks, which have a quite "predictable" activation
> >    pattern, we should definitively try to use DEADLINE... which will
> >    factor out all "boosting potential races" since the bandwidth
> >    requirements are well defined at task description time.
> 
> I don't immediately see how deadline can fix this, when a task is
> dequeued after end of its current runtime, its bandwidth will be
> subtracted from the active running bandwidth. This is what drives the
> DL part of the capacity request. In this case, we run into the same
> issue as with the boost-removal on dequeue. Isn't it?
> 

Unfortunately, I still have to post the set of patches (based on Luca's
reclaiming set) that introduces driving of clock frequency from
DEADLINE, so I guess everything we can discuss about how DEADLINE might
help here might be difficult to understand. :(

I should definitely fix that.

However, trying to quickly summarize how that would work (for who is
already somewhat familiar with reclaiming bits):

 - a task utilization contribution is accounted for (at rq level) as
   soon as it wakes up for the first time in a new period
 - its contribution is then removed after the 0lag time (or when the
   task gets throttled)
 - frequency transitions are triggered accordingly

So, I don't see why triggering a go down request after the 0lag time
expired and quickly reacting to tasks waking up would have create
problems in your case?

Thanks,

- Juri
