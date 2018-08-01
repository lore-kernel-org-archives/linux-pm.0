From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Date: Wed, 1 Aug 2018 09:32:49 +0200
Message-ID: <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com> <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin> <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@quicinc.com, skannan@quicinc.com, Pava
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 31, 2018 at 9:31 PM,  <skannan@codeaurora.org> wrote:
> On 2018-07-31 00:59, Quentin Perret wrote:
>>
>> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org wrote:
>> [...]
>>>
>>> If it's going to be a different aggregation from what's done for
>>> frequency
>>> guidance, I don't see the point of having this inside schedutil. Why not
>>> keep it inside the scheduler files?
>>
>>
>> This code basically results from a discussion we had with Peter on v4.
>> Keeping everything centralized can make sense from a maintenance
>> perspective, I think. That makes it easy to see the impact of any change
>> to utilization signals for both EAS and schedutil.
>
>
> In that case, I'd argue it makes more sense to keep the code centralized in
> the scheduler. The scheduler can let schedutil know about the utilization
> after it aggregates them. There's no need for a cpufreq governor to know
> that there are scheduling classes or how many there are. And the scheduler
> can then choose to aggregate one way for task packing and another way for
> frequency guidance.

Also the aggregate utilization may be used by cpuidle governors in
principle to decide how deep they can go with idle state selection.
