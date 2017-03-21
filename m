From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 18:01:50 +0100
Message-ID: <CAKfTPtABNHNZDUWCD+D1JCJHm1AQwRZMkQ+C=CG7a7JfXJYYXg@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan> <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
 <20170321132253.vjp7f72qkubpttmf@hirez.programming.kicks-ass.net>
 <CAKfTPtBp7GevDfnOTrOnrc79XP1mbY0onq=uh4Aw2tGu-DgHGw@mail.gmail.com>
 <20170321140325.gf64gc7eaqu335t5@hirez.programming.kicks-ass.net>
 <CAKfTPtALorn7HNpz4LOfWWSc3u+9y5iHB5byzfTHGQXDA+tVJQ@mail.gmail.com>
 <20170321145808.GS3093@worktop> <CAKfTPtBzeKZkYeyw2pp7g3fvhnY0gzViargmDpEbkPhA+df72g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35914 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932882AbdCURCM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 13:02:12 -0400
Received: by mail-ot0-f180.google.com with SMTP id i1so155587926ota.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2017 10:02:11 -0700 (PDT)
In-Reply-To: <CAKfTPtBzeKZkYeyw2pp7g3fvhnY0gzViargmDpEbkPhA+df72g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On 21 March 2017 at 18:00, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> On 21 March 2017 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Tue, Mar 21, 2017 at 03:16:19PM +0100, Vincent Guittot wrote:
>> > On 21 March 2017 at 15:03, Peter Zijlstra <peterz@infradead.org> wrote:
>> >
>> > > On Tue, Mar 21, 2017 at 02:37:08PM +0100, Vincent Guittot wrote:
>> > > > On 21 March 2017 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
>> > >
>> > > > For the not overloaded case, it makes sense to immediately update to
>> > > > OPP to be aligned with the new utilization of the CPU even if it was
>> > > > not idle in the past couple of ticks
>> > >
>> > > Yeah, but we cannot know. Also, who cares?
>> > >
>> >
>> > embedded system that doesn't want to stay at higest OPP if significant part
>> > of the utilzation has moved away as an example
>> > AFAICT, schedutil tries to select the best OPP according to the current
>> > utilization of the CPU so if the utilization decreases, the OPP should also
>> > decrease
>>
>> Sure I get that; but given the lack of crystal ball instructions we
>> cannot know if this is the case or not.
>
> cfs_rq->avg.load_avg account the waiting time of CPU (in addition to

sorry i wanted to say the waiting time of tasks on the CPU

> the weight of task) so i was wondering if we can't use it to detect if
> we are in the overloaded  case or not even if utilization is not mac
> capacity because we have just migrated a task (and its utilization)
> out
>
>
>
>>
>> And if we really dropped below 100% utilization, we should hit idle
>> fairly soon.
