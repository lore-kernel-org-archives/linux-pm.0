From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC] sched: fair: Don't update CPU frequency too frequently
Date: Wed, 7 Jun 2017 23:55:12 +0200
Message-ID: <CAJZ5v0h9=Fx2TvgW2=f4RLr+Dh0rMUxt-m6yp2bcd6F_WeHwCA@mail.gmail.com>
References: <b3a96d619a4cad34f4243a173a42915c41059669.1496316723.git.viresh.kumar@linaro.org>
 <20170601122224.c324h4t7y3i4wr6e@hirez.programming.kicks-ass.net>
 <20170607120655.GB11126@vireshk-i7> <20170607154351.GA2551@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35176 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdFGVzO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 17:55:14 -0400
In-Reply-To: <20170607154351.GA2551@e105550-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Wed, Jun 7, 2017 at 5:43 PM, Morten Rasmussen
<morten.rasmussen@arm.com> wrote:
> On Wed, Jun 07, 2017 at 05:36:55PM +0530, Viresh Kumar wrote:
>> + Patrick,
>>
>> On 01-06-17, 14:22, Peter Zijlstra wrote:
>> > On Thu, Jun 01, 2017 at 05:04:27PM +0530, Viresh Kumar wrote:
>> > > This patch relocates the call to utilization hook from
>> > > update_cfs_rq_load_avg() to task_tick_fair().
>> >
>> > That's not right. Consider hardware where 'setting' the DVFS is a
>> > 'cheap' MSR write, doing that once every 10ms (HZ=100) is absurd.
>>
>> Yeah, that may be too much for such a platforms. Actually we (/me & Vincent)
>> were worried about the current location of the utilization update hooks and
>> believed that they are getting called way too often. But yeah, this patch
>> optimized it way too much.
>>
>> One of the goals of this patch was to avoid doing small OPP updates from
>> update_load_avg() which can potentially block significant utilization changes
>> (and hence big OPP changes) while a task is attached or detached, etc.
>
> To me that sounds like you want to apply a more clever filter to the
> utilization updates than a simple rate limiter as Peter suggests below.
> IMHO, it would be better to feed schedutil with all the available
> information and improve the filtering policy there instead of trying to
> hack the policy tweaking the input data.

Agreed.

Unless the tweaked input data would be used somewhere else too, that is.

>> > We spoke about this problem in Pisa, the proposed solution was having
>> > each driver provide a cost metric and the generic code doing a max
>> > filter over the window constructed from that cost metric.
>
> Maybe it is possible to somehow let the rate at which we allow OPP
> changes depend on the size of the 'error' delta between the current OPP
> and what we need. So radical changes causes OPP changes immediately, and
> small corrections have to wait longer?

That sounds reasonable to me.

Thanks,
Rafael
