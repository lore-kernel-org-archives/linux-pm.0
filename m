From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: Add a predict callback for the governors
Date: Tue, 26 Feb 2019 11:57:49 +0100
Message-ID: <CAJZ5v0ggcCCrUjbkYLB6qu+h3KOTcFhOgx75YcXPSE=SYYieFA@mail.gmail.com>
References: <20190221145631.26356-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com>
 <d315736a-2aa0-3c8d-f3cf-f73b60e7ebe0@linaro.org> <CAJZ5v0ishtmAJ4vyosedTY6ZY+RcenpP_yzwVAgGybONGU6Zsw@mail.gmail.com>
 <e3421211-c59d-a372-2e27-68f452f4f8b1@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e3421211-c59d-a372-2e27-68f452f4f8b1@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Mon, Feb 25, 2019 at 4:01 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 22/02/2019 11:35, Rafael J. Wysocki wrote:
> > On Thu, Feb 21, 2019 at 6:40 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 21/02/2019 17:18, Rafael J. Wysocki wrote:
> >>> On Thu, Feb 21, 2019 at 3:56 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> Predicting the next event on the current CPU is implemented in the
> >>>> idle state selection function, thus the selection logic and the
> >>>> prediction are tied together and it is hard to decorrelate both.
> >>>>
> >>>> The following change introduces the cpuidle function to give the
> >>>> opportunity to the governor to store the guess estimate of the
> >>>> different source of wakeup and then reuse them in the selection
> >>>> process. Consequently we end up with two separate operations clearly
> >>>> identified.
> >>>>
> >>>> As the next events are stored in the cpuidle device structure it is
> >>>> easy to propagate them in the different governor callbacks.
> >>>
> >>> Can you explain a bit how you would use this new callback in a governor?
> >>
> >> Sure.
> >>
> >> Today we have the selection and the prediction tied together. The
> >> prediction is modulated with some inputs coming from the governor's
> >> policy (eg. performance multiplier).
> >>
> >> It is hard to know if the prediction is correct or not, hard to know the
> >> duration of the computation for the next event and hard to know if the
> >> idle state selection succeeded because of a good prediction or a good
> >> governor policy.
> >>
> >> I propose to provide the callback where we fill the guess estimated next
> >> events on the system, so we can trace them and benchmark the computation
> >> time.
> >>
> >> The selection of the idle state becomes an separate action where we can
> >> apply any specific governor heuristic or policy.
> >>
> >> By separating the selection and the prediction, we can identify where
> >> the weakness is in our test scenario: the prediction or the governor
> >> selection policy.
> >
> > I'm not quite convinced about the idea that the "prediction" and
> > "selection" parts can be entirely separate.
> >
> > Besides, this new callback doesn't return anything, it goes before
> > ->select and the latter is invoked unconditionally anyway.  That's
> > extra overhead (even if small) for no real gain.  I don't see why it
> > is better to do the split in the core rather than in the governor
> > itself.  You can always design a governor ->select() to call two
> > separate functions, one after another, internally, so why to do that
> > in the core and inflict that particular design choice on everybody?
>
> It is a way to clearly identify what is part of the prediction and what
> is part of the decision in order to easily spot the weakness of the
> governor. We may be doing good predictions but bad decisions or the
> opposite.
>
> I agree we are not forced to create a new callback for this and we can
> create a prediction function directly inside the governor. I don't have
> a strong preference actually and I'm fine with your proposal.
>
> > For example, there's no "predict" part running before the "select" one
> > in the TEO governor at all.  There is something like that in menu, but
> > splitting it off would be rather artificial IMO.
> >
> > Next, the cpuidle_predict structure.  I'm not even sure why it is there at all.
> >
> > Presumably, the purpose of it is to pass some data from ->predict to
> > ->select, but why does it have to be there in struct cpuidle_device?
> > The governor appears to be the only user of it anyway, so wouldn't it
> > be better to store that information in the governor's internal data
> > structures if really needed?
>
> At one moment we will need the prediction information from the scheduler
> in order to optimize the cpu selection for the wakeup. I thought the
> cpuidle device structure can be a place where we can store it.
>
> There are a lot of optimizations we can do after knowing when a CPU is
> expected to wakeup.
>
> Do you have a suggestion where to store the next wakeup for a CPU?

There is no need to store it in the core data structures unless
different parts of the framework need it.

For example, if both the governor and the driver used that value, it
would make sense to store it in struct cpuidle_device (I believe that
Ulf has a use case going it that direction), but if it is used by the
governor alone, it should be internal to the governor IMO.

> > Moreover, why does it include the next_hrtimer and next_timer fields?
> > It looks like you'd need to do some nohz code surgery to separate the
> > two and would that be useful even?  And even so, these values need not
> > be predicted.
>
> I agree they don't need to be predicted but they are part of the sources
> of wake up with a deterministic behavior and fall under the prediction
> umbrella as they are part of the equation for the next event.
>
> The purpose of filling these fields is to give the select callback all
> the clues to take its decision.

They still should be internal to the governor as long as it is the
only user of them.

> But regarding your POV, which is valid, we can consider using an
> internal prediction function and just export the next event without a
> full description of the different wake up source categories.

Right.

> > It is known when the next timer event is going to
> > occur, both with and without the scheduler tick included, and that's
> > why there is tick_nohz_get_sleep_length().
>
> The next hrtimer and the next timer are the deadline versions of
> tick_nohz_get_sleep_length(), respectively the delta_time parameter and
> the returned value.

I would give them different names then.

The return value is the one without the scheduler tick and the
delta_time is the value including it.  They both cover all timers
(high-res and the other).

> I massaged the tick_nohz_get_sleep_length() to return the deadline
> rather than the remaining time.

I'm not sure what you mean by the "deadline".  Do you add anything to
them before returning?  That may not be correct.

> The changes will come with the patches
> Ulf is about to send. IMHO, it helps to understand the code by splitting
> in two functions rather than passing an extra parameter.

OK, so those changes need to be submitted first.

> > If you want to do a similar thing for non-timer interrupts in order to
> > use the IRQ stats, you can simply provide a function similar to
> > tick_nohz_get_sleep_length() for that, but that's available already,
> > isn't it?
>
> Actually, I'm interested in deadlines not in relative remaining time
> because we need later to compare those when we are about to wake up a
> CPU or enter the cluster state.

The deadlines can be produced easily by adding the current value of
the local CPU clock to the delta.  If you return the deadline,
however, it may not be comparable with the local clock.

> Indeed, the irq timings is already available but with the limitation of
> predicting regular intervals. I rewrote the code to handle both regular
> and repeating pattern. I'll post the series as soon as I have the numbers.
>
>
> > Also, I'm not really sure what next_resched is and how exactly it is
> > going to be computed.
>
>
> The next_resched estimation is to handle the situation where you have
> one CPU handling IO related interrupts for a specific device waking up
> another CPU with the io blocked task. It is very similar to the avg_idle
> value.

So you want to estimate when something like that may happen for the
CPU going idle at the moment?
