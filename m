From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Thu, 3 Mar 2016 03:49:17 +0100
Message-ID: <CAJZ5v0h7HeQYgx91Z4EQLrWh=xa+NP9zunMUvBy6XLt-863n_A@mail.gmail.com>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
	<1456190570-4475-4-git-send-email-smuckle@linaro.org>
	<8427745.Y8N2bqC3SO@vostro.rjw.lan>
	<56CF9D8F.7010607@linaro.org>
	<20160302074910.10178.35029@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160302074910.10178.35029@quark.deferred.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ricky Liang <jcliang@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 2, 2016 at 8:49 AM, Michael Turquette
<mturquette@baylibre.com> wrote:
>

[cut]

> I do not have any data to back up a case for stalls caused by RT/DL
> starvation, but conceptually I would say that latency is fundamentally
> more important in a scheduler-driven cpu frequency selection scenario,
> versus the legacy timer-based governors.
>
> In the latter case we get woken up by a timer (prior to Rafael's recent
> "cpufreq: governor: Replace timers with utilization update callbacks"
> patch), we sample idleness/busyness, and change frequency, all in one go
> and all from process context.
>
> In the case of the scheduler selecting frequency in the hot path, with
> hardware that takes a long time to transition frequency (and thus must
> be done in a slow path), we want to minimize the time delta between the
> scheduler picking a frequency and the thread that executes that change
> actually being run.

That is a good point.  However, the Peter's one about the RT tasks
having to run at the max util and affecting the frequency control this
way is good too.

I'm not actually sure if RT is the right answer here.  DL may be a
better choice.  After all, we want the thing to happen shortly, but
not necessarily at full speed.

So something like a DL workqueue would be quite useful here it seems.

> In my over-simplified view of the scheduler, it would be great if we
> could have a backdoor mechanism to place the frequency transition
> kthread onto a runqueue from within the schedule() context and dispense
> with the irq_work stuff in Steve's series altogether.

Well, I use irq_work() now in schedutil and ondemand/conservative too
for queuing up work items and it gets the job done.

Thanks,
Rafael
