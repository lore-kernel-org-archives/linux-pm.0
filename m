From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 17:19:38 +0200
Message-ID: <CAKfTPtAjS+D7L9ckDw4bYayPf29EEkFLAzx1SeEa6Ue_V+iPyg@mail.gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin> <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin> <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010130549.hzpkaskvlgifbdrp@queper01-lin> <CAKfTPtA=GYaiKcJ9N5zEnzxJTKBATG41c0xDjhbA21G-Cv6LvA@mail.gmail.com>
 <20181010134755.jrigtogbxwaz2izb@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010134755.jrigtogbxwaz2izb@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Zhang Rui <rui.zhang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ionela Voinescu <ionela.voinescu@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Oct 2018 at 15:48, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Wednesday 10 Oct 2018 at 15:27:57 (+0200), Vincent Guittot wrote:
> > On Wed, 10 Oct 2018 at 15:05, Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > On Wednesday 10 Oct 2018 at 14:04:40 (+0200), Vincent Guittot wrote:
> > > > This patchset doesn't touch cpu_capacity_orig and doesn't need to  as
> > > > it assume that the max capacity is unchanged but some capacity is
> > > > momentary stolen by thermal.
> > > >  If you want to reflect immediately all thermal capping change, you
> > > > have to update this field and all related fields and struct around
> > >
> > > I don't follow you here. I never said I wanted to change
> > > cpu_capacity_orig. I don't think we should do that actually. Changing
> > > capacity_of (which is updated during LB IIRC) is just fine. The question
> > > is about what you want to do there: reflect an averaged value or the
> > > instantaneous one.
> >
> > Sorry I though your were speaking about updating this cpu_capacity_orig.
>
> N/p, communication via email can easily become confusing :-)
>
> > With using instantaneous max  value in capacity_of(), we are back to
> > the problem raised by Thara that  the value will most probably not
> > reflect the current capping value when it is used in LB, because LB
> > period can quite long on busy CPU (default max value is 32*sd_weight
> > ms)
>
> But averaging the capping value over time doesn't make LB happen more
> often ... That will help you account for capping that happened in the

But you know what happens in average between 2 LB

> past, but it's not obvious this is actually a good thing. Probably not
> all the time anyway.
>
> Say a CPU was capped at 50% of it's capacity, then the cap is removed.
> At that point it'll take 100ms+ for the thermal signal to decay and let
> the scheduler know about the newly available capacity. That can probably

But the point is that you don't know:
- if the capping will not happen soon. If the pressure has reached the
50%,  it means that it already happened quite often in the past 100ms.
- if there is really available capacity as the current sum of
utilization reflects what was available for tasks and not what the
tasks really wants to use


> be a performance hit in some use cases ... And the other way around, it
> can also take forever for the scheduler to notice that a CPU has a

What do you mean by forever ?

> reduced capacity before reacting to it.
>
> If you want to filter out very short transient capping events to avoid
> over-reacting in the scheduler (is this actually happening ?), then
> maybe the average should be done on the cooling device side or something
> like that ?
>
> Thanks,
> Quentin
