From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Date: Wed, 1 Aug 2018 11:40:30 +0200
Message-ID: <CAJZ5v0g7VK3Gh5L5PM_z3_GbuaguAd_Dz17RmA6-0pTChuW+Sg@mail.gmail.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com> <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin> <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
 <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com>
 <20180801082353.egym4tsbr7ppql27@queper01-lin> <CAJZ5v0joYFXkXxoV8odPtrCNW=jAw3RVv3rTzMoabeYWGDnREw@mail.gmail.com>
 <20180801092325.g2upcivcvdo62hub@queper01-ThinkPad-T460s>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801092325.g2upcivcvdo62hub@queper01-ThinkPad-T460s>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 1, 2018 at 11:23 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> On Wednesday 01 Aug 2018 at 10:35:32 (+0200), Rafael J. Wysocki wrote:
>> On Wed, Aug 1, 2018 at 10:23 AM, Quentin Perret <quentin.perret@arm.com> wrote:
>> > On Wednesday 01 Aug 2018 at 09:32:49 (+0200), Rafael J. Wysocki wrote:
>> >> On Tue, Jul 31, 2018 at 9:31 PM,  <skannan@codeaurora.org> wrote:
>> >> >> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org wrote:
>> >> >>> If it's going to be a different aggregation from what's done for
>> >> >>> frequency
>> >> >>> guidance, I don't see the point of having this inside schedutil. Why not
>> >> >>> keep it inside the scheduler files?
>> >> >>
>> >> >> This code basically results from a discussion we had with Peter on v4.
>> >> >> Keeping everything centralized can make sense from a maintenance
>> >> >> perspective, I think. That makes it easy to see the impact of any change
>> >> >> to utilization signals for both EAS and schedutil.
>> >> >
>> >> > In that case, I'd argue it makes more sense to keep the code centralized in
>> >> > the scheduler. The scheduler can let schedutil know about the utilization
>> >> > after it aggregates them. There's no need for a cpufreq governor to know
>> >> > that there are scheduling classes or how many there are. And the scheduler
>> >> > can then choose to aggregate one way for task packing and another way for
>> >> > frequency guidance.
>> >>
>> >> Also the aggregate utilization may be used by cpuidle governors in
>> >> principle to decide how deep they can go with idle state selection.
>> >
>> > The only issue I see with this right now is that some of the things done
>> > in this function are policy decisions which really belong to the governor,
>> > I think.
>>
>> Well, the scheduler makes policy decisions too, in quite a few places. :-)
>
> That is true ... ;-) But not so much about frequency selection yet I guess
>
>> The really important consideration here is whether or not there may be
>> multiple governors making different policy decisions in that respect.
>> If not, then where exactly the single policy decision is made doesn't
>> particularly matter IMO.
>
> I think some users of the aggregated utilization signal do want to make
> slightly different decisions (I'm thinking about the RT-go-to-max thing
> again which makes perfect sense in sugov, but could possibly hurt EAS).

Fair enough.

> So the "hard" part of this work is to figure out what really is a
> governor-specific policy decision, and what is common between all users.
> I put "hard" between quotes because I only see the case of RT as truly
> sugov-specific for now.

OK

> If we also want a special case for DL, Peter's enum should work OK, and
> enable to add more special cases for new users (cpuidle ?) if needed.
> But maybe that is something for later ?

I agree.  That can be done later if need be.
