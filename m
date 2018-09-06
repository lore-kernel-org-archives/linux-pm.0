From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Date: Thu, 6 Sep 2018 11:18:55 +0200
Message-ID: <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-14-quentin.perret@arm.com> <20180904105906.t5i7twyyt2omc45b@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904105906.t5i7twyyt2omc45b@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skann>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 4, 2018 at 12:59 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Monday 20 Aug 2018 at 10:44:19 (+0100), Quentin Perret wrote:
> > Energy Aware Scheduling (EAS) is designed with the assumption that
> > frequencies of CPUs follow their utilization value. When using a CPUFreq
> > governor other than schedutil, the chances of this assumption being true
> > are small, if any. When schedutil is being used, EAS' predictions are at
> > least consistent with the frequency requests. Although those requests
> > have no guarantees to be honored by the hardware, they should at least
> > guide DVFS in the right direction and provide some hope in regards to the
> > EAS model being accurate.
> >
> > To make sure EAS is only used in a sane configuration, create a strong
> > dependency on schedutil being used. Since having sugov compiled-in does
> > not provide that guarantee, extend the existing CPUFreq policy notifier
> > with a new case on governor changes. That allows the scheduler to
> > register a callback on this notifier to rebuild the scheduling domains
> > when governors are changed, and enable/disable EAS accordingly.
> >
> > cc: Ingo Molnar <mingo@redhat.com>
> > cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> >
> > ---
> > This patch could probably be squashed into another one, but I kept it
> > separate to ease the review. Also, it's probably optional as not having
> > it will not 'break' things per se.
> >
> > I went for the smallest possible solution I could find, which has the
> > good side of being simple, but it's definitely not the only one.
> >
> > Another possibility would be to hook things in sugov_start() and
> > sugov_stop(), but that requires some more work. In this case, it
> > wouldn't be possible to just re-build the sched_domains() from there,
> > because when sugov_stop() is called, the 'governor' field of the policy
> > hasn't been updated yet, so the condition (if gov == schedutil) in
> > build_freq_domains() doesn't work.
> >
> > To workaround the issue we'll need to find a way to pass a cpumask to
> > the topology code to specifically say 'sugov has been stopped on these
> > CPUs'. That would mean more code to handle that, but that would also
> > mean we don't have to mess around with the CPUFreq notifiers ...
> >
> > Not sure what's best, so all feedback is more than welcome.
>
> Hi,
>
> Does anybody have concerns with this patch ? Is it a reasonable option
> to use the CPUFreq notifiers in this case ? If there is anything I can
> do to ease the review please let me know.

I'm not a particular fan of notifiers to be honest and you don't need
to add an extra chain just in order to be able to register a callback
from a single user.  That can be achieved with a single callback
pointer too, but also you could just call a function exported by the
scheduler directly from where in the cpufreq code it needs to be
called.

> Also, is there any hope that the 12 first patches could make it in 4.20
> on their own ? Or is it already too late ?

I'm walking through them right now, albeit somewhat slowly due to
various distractions, so we'll see.

Thanks,
Rafael
