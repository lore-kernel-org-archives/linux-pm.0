From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 15:18:55 +0100
Message-ID: <CAKfTPtBu0VkHh9VvDEFVf=BxyXynvnFCCMA3V1FrASrWOK-xiw@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan> <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
 <20170321132253.vjp7f72qkubpttmf@hirez.programming.kicks-ass.net>
 <CAKfTPtBp7GevDfnOTrOnrc79XP1mbY0onq=uh4Aw2tGu-DgHGw@mail.gmail.com> <20170321140325.gf64gc7eaqu335t5@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321140325.gf64gc7eaqu335t5@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 21 March 2017 at 15:03, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 21, 2017 at 02:37:08PM +0100, Vincent Guittot wrote:
>> On 21 March 2017 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> For the not overloaded case, it makes sense to immediately update to
>> OPP to be aligned with the new utilization of the CPU even if it was
>> not idle in the past couple of ticks
>
> Yeah, but we cannot know. Also, who cares?

embedded system that doesn't want to stay at higest OPP if significant
part of the utilzation has moved away as an example
AFAICT, schedutil tries to select the best OPP according to the
current utilization of the CPU so if the utilization decreases, the
OPP should also decrease

>
>> > does exactly that. Note that the lack of idle time is an exact
>> > equivalent of 100% utilized.
>> >
>> > So even while we cannot currently detect the 100% utilized state through
>> > the running state tracking; because averages etc.. we can detect the
>> > lack of idle time.
>>
>> But after how much lack of idle time do we consider that we are overloaded ?
>
> 0 :-)
>
> Note that utilization is an absolute metric, not a windowed one. That
> is, there is no actual time associated with it. Now, for practical
> purposes we end up using windowed things in many places,
>
