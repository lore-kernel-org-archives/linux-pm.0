From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 12:14:32 +0200
Message-ID: <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com> <20181010095459.orw2gse75klpwosx@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010095459.orw2gse75klpwosx@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Zhang Rui <rui.zhang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ionela Voinescu <ionela.voinescu@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Oct 2018 at 11:55, Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Vincent,
>
> On Wednesday 10 Oct 2018 at 10:50:05 (+0200), Vincent Guittot wrote:
> > The problem with reflecting directly the capping is that it happens
> > far more often than the pace at which cpu_capacity_orig is updated in
> > the scheduler.
>
> Hmm, how can you be so sure ? That most likely depends on the workload,
> the platform and the thermal governor. Some platforms heat up slowly,
> some quickly. The pace at which the thermal governor will change things
> should depend on that I assume.
>
> > This means that at the moment when scheduler uses the
> > value, it might not be correct anymore.
>
> And OTOH, when you remove a cap for example, it will take time before
> the scheduler can see the newly available capacity if you need to wait
> for the signal to decay. So you are using a wrong information too in
> that scenario.

But we stay consistant with all other metrics. The same happen when a
task decide to stay idle for a long time after some activity... You
will have to wait for the signal to decay

>
> > Then, this value are also used
> > when building the sched_domain and setting max_cpu_capacity which
> > would also implies the rebuilt the sched_domain topology ...
>
> Wait what ? I thought the thermal cap was reflected in capacity_of, not
> capacity_orig_of ... You need to rebuild the sched_domain in case of
> thermal pressure ?
>
> Hmm, let me have a closer look at the patches, I must have missed
> something ...
>
> > The pace of changing the capping is to fast to reflect that in the
> > whole scheduler topology
>
> That's probably true in some cases, but it'd be cool to have numbers to
> back up that statement, I think.
>
> Now, if you do need to rebuild the sched domain topology every time you
> update the thermal pressure, I think the PELT HL is _way_ too short for
> that ... You can't rebuild the whole thing every 32ms or so. Or am I
> misunderstanding something ?
>
> > > Thara, have you tried to experiment with a simpler implementation as
> > > suggested by Ingo ?
> > >
> > > Also, assuming that we do want to average things, do we actually want to
> > > tie the thermal ramp-up time to the PELT half life ? That provides
> > > nice maths properties wrt the other signals, but it's not obvious to me
> > > that this thermal 'constant' should be the same on all platforms. Or
> > > maybe it should ?
> >
> > The main interest of using PELT signal is that thermal pressure will
> > evolve at the same pace as other signals used in the scheduler.
>
> Right, I think this is a nice property too (assuming that we actually
> want to average things out).
>
> > With
> > thermal pressure, we have the exact same problem as with RT tasks. The
> > thermal will cap the max frequency which will cap the utilization of
> > the tasks running on the CPU
>
> Well, the nature of the signal is slightly different IMO. Yes it's
> capacity, but you're no actually measuring time spent on the CPU. All
> other PELT signals are based on time, this thermal thing isn't, so it is
> kinda different in a way. And I'm still wondering if it could be helpful

hmmm ... it is based on time too.
Both signals (current ones and thermal one) are really close. The main
difference with other utilization signal is that instead of providing
a running/not running boolean that is then weighted by the current
capacity, the signal uses direclty the capped max capacity to reflect
the amount of cycle that is stolen by thermal mitigation.

> to be able to have a different HL for that thermal signal. That would
> 'break' the nice maths properties we have, yes, but is it a problem or is
> it actually helpful to cope with the thermal characteristics of
> different platforms ?

If you don't use the sign kind of signal with the same responsiveness,
you will start to see some OPP toggles as an example when the thermal
state change because one metrics will change faster than the other one
and you can't have a correct view of the system. Same problem was
happening with rt task.

I take the example of RT task because it quite similar in the effect
except that RT task steal all cycles when it runs whereas thermal
mitigation steal only some by capping the frequency
>
> Thanks,
> Quentin
