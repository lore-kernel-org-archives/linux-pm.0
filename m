From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Tue, 19 Apr 2016 19:22:35 -0700
Message-ID: <20160420022235.GA754@sky.smuckle.net>
References: <20160401092019.GN3430@twins.programming.kicks-ass.net>
 <570BFAE2.4080301@linaro.org>
 <CAJZ5v0imtij-smQBds1aTNMuFsNbbzvoyAJ5-=Pp8Ae1GSNWvQ@mail.gmail.com>
 <CAJZ5v0gNt5kMV8jjQuASTxUBE=FZ45x2Go0RNsyaZMLk+dAsKQ@mail.gmail.com>
 <20160413000824.GB22643@graphite.smuckle.net>
 <CAJZ5v0hx6mG5EzU4q-OFxcKQP3CZcY+H_+PqYVfL4aAPkxmoDA@mail.gmail.com>
 <CAJZ5v0jKkKrSWhtbcWcFbLrOT8kUKCfJV05W4vQwUHbD5omGpA@mail.gmail.com>
 <CAJZ5v0hSBZaw=p2vR1PFnU9naoQ-KJUxznVfB=AasG0GnfTakA@mail.gmail.com>
 <570E8A8F.2030109@linaro.org>
 <CAJZ5v0iKwMjzBhsD2cz5j+CziA_9omNR74OBNXRakc0mUZ9zaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iKwMjzBhsD2cz5j+CziA_9omNR74OBNXRakc0mUZ9zaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 13, 2016 at 09:50:19PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 13, 2016 at 8:06 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > On 04/13/2016 09:07 AM, Rafael J. Wysocki wrote:
> >>>>>> If you want to do remote updates, I guess that will require an
> >>>>>> irq_work to run the update on the target CPU, but then you'll probably
> >>>>>> want to neglect the rate limit on it as well, so it looks like a
> >>>>>> "need_update" flag in struct update_util_data will be useful for that.
> >
> > Have you added rate limiting at the hook level that I missed? I thought
> > it was just inside schedutil.
> 
> It is in schedutil (and other governors), but if you do a cross-CPU
> update, you probably want that rate limit to be ignored in that case.
> Now, if the local and target CPUs happen to use different governors
> (eg. the local CPU uses ondemand and the target one uses schedutil) or
> they just don't belong to the same policy, you need to set the "need
> update" flag for the target CPU, so the local one needs access to it.
> It is better for that flag to be located in the per-CPU data of the
> target CPU for that.

It's not clear to me whether remote updates are necessarily more
important than updates triggered locally, such that they would
override the rate limit while local ones do not. My guess is this
special treatment could be left out at least initially.

> > Ok thanks, I'll take another look at this.
> >
> > I was thinking it might be nice to be able to push the decision on
> > whether to send the IPI in to the governor/hook client. For example in
> > the schedutil case, you don't need to IPI if sugov_should_update_freq()
> > = false (outside the slight chance it might be true when it runs on the
> > target). Beyond that perhaps for policy reasons it's desired to not send
> > the IPI if next_freq <= cur_freq, etc.
> 
> Yes, that is an option, but then your governor code gets more
> complicated.  Since every governor would need that complexity, you'd
> end up having it in multiple places.  To me, it seems more efficient
> to just have it in one place (the code that triggers a cross-CPU
> update).

More efficient in terms of lines of code perhaps but it'd be really
nice to save on IPIs by not sending unnecessary ones. I went ahead and
tried to address the issues in the governors so we could see what it
would look like. I'll send that as a separate RFC.

It also occurred to me that even when the governors filter out the
needless IPIs, it may still end up being unnecessary if the scheduler
is going to send a resched IPI to the target CPU. Need to think about
that some more.

...
> >>> And these two seem to be the only interesting cases for you, because
> >>> if you need to work for the worker thread to schedule to eventually
> >>
> >> s/work/wait/ (sorry)
> >>
> >>> change the CPU frequency for you, that will defeat the whole purpose
> >>> here.
> >
> > I was hoping to submit at some point a patch to change the context for
> > slow path frequency changes to RT or DL context, so this would benefit
> > that case as well.
> 
> But it still would require the worker thread to schedule, although it
> might just occur a bit earlier if that's DL/RT.

Scheduling latency should be very short for DL/RT tasks, I would
expect 10s of usec or less? Still much better than up to a tick.

thanks,
Steve
