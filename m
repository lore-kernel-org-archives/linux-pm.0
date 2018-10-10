From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 15:27:57 +0200
Message-ID: <CAKfTPtA=GYaiKcJ9N5zEnzxJTKBATG41c0xDjhbA21G-Cv6LvA@mail.gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin> <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin> <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010130549.hzpkaskvlgifbdrp@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010130549.hzpkaskvlgifbdrp@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Zhang Rui <rui.zhang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ionela Voinescu <ionela.voinescu@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Oct 2018 at 15:05, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Wednesday 10 Oct 2018 at 14:04:40 (+0200), Vincent Guittot wrote:
> > This patchset doesn't touch cpu_capacity_orig and doesn't need to  as
> > it assume that the max capacity is unchanged but some capacity is
> > momentary stolen by thermal.
> >  If you want to reflect immediately all thermal capping change, you
> > have to update this field and all related fields and struct around
>
> I don't follow you here. I never said I wanted to change
> cpu_capacity_orig. I don't think we should do that actually. Changing
> capacity_of (which is updated during LB IIRC) is just fine. The question
> is about what you want to do there: reflect an averaged value or the
> instantaneous one.

Sorry I though your were speaking about updating this cpu_capacity_orig.
With using instantaneous max  value in capacity_of(), we are back to
the problem raised by Thara that  the value will most probably not
reflect the current capping value when it is used in LB, because LB
period can quite long on busy CPU (default max value is 32*sd_weight
ms)

>
> It's not obvious (to me) that the complex one (the averaged value) is
> better than the other, simpler, one. All I'm saying from the beginning
> is that it'd be nice to have numbers and use cases to discuss the pros
> and cons of both approaches.
>
> > > > > Hmm, let me have a closer look at the patches, I must have missed
> > > > > something ...
> > > > >
> > > > > > The pace of changing the capping is to fast to reflect that in the
> > > > > > whole scheduler topology
> > > > >

[snip]

> > >
> > > Well, that wasn't the problem with rt tasks. The problem with RT tasks
> > > was that the time they spend on the CPU wasn't accounted _at all_ when
> > > selecting frequency for CFS, not that the accounting was at a different
> > > pace ...
> >
> > The problem was the same with RT, the cfs utilization was lower than
> > reality because RT steals soem cycle to CFS
> > So schedutil was selecting a lower frequency when cfs was running
> > whereas the CPU was fully used.
> > The same can happen with thermal:
> > cap the max freq because of thermal
> > the utilization with decrease.
> > remove the cap
> > the utilization is still low and you will select a low OPP because you
> > don't take into account cycle stolen by thermal like with RT
>
> I'm not arguing with the fact that we need to reflect the thermal
> pressure in the scheduler to see that a CPU is fully busy. I agree with
> that.
>
> I'm saying you don't necessarily have to update the thermal stuff and
> the existing PELT signals *at the same pace*, because different
> platforms have different thermal characteristics.

But you also need to take into account how fast other metrics in the
scheduler are updated otherwise a metric will reflect a change not
already reflected in the other metrics and you might take wrong
decision as my example above where utilization is still low but
thermal pressure is nul and you assume that you have lot of spare
capacity
Having metrics that use same responsiveness and are synced, help to
get a consolidated view of the system.

Vincent
>
> Thanks,*
> Quentin
