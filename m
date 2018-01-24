From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 1/3] sched/fair: add util_est on top of PELT
Date: Wed, 24 Jan 2018 14:06:05 -0800
Message-ID: <CAJWu+oqTVv7iMTFd1vXjeXSO8=WKnPM6jbQQRdShzN0fM=Cc9Q@mail.gmail.com>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
 <20180123180847.4477-2-patrick.bellasi@arm.com> <CAJWu+oo-XSB9CDg2ixZx5jWbVDX7FNk5tVbLo2WiSqR8O+fRRg@mail.gmail.com>
 <20180124191609.GA5739@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36888 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXWGH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jan 2018 17:06:07 -0500
Received: by mail-it0-f68.google.com with SMTP id q8so6975298itb.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2018 14:06:06 -0800 (PST)
In-Reply-To: <20180124191609.GA5739@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Steve Muckle <smuckle@google.com>

On Wed, Jan 24, 2018 at 11:16 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 24-Jan 08:40, Joel Fernandes wrote:
>> On Tue, Jan 23, 2018 at 10:08 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>> > The util_avg signal computed by PELT is too variable for some use-cases.
>> > For example, a big task waking up after a long sleep period will have its
>> > utilization almost completely decayed. This introduces some latency before
>> > schedutil will be able to pick the best frequency to run a task.
>> [...]
>> > -static inline unsigned long task_util(struct task_struct *p);
>> >  static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
>> >
>> >  static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
>> > @@ -6262,6 +6337,11 @@ static inline unsigned long task_util(struct task_struct *p)
>> >         return p->se.avg.util_avg;
>> >  }
>> >
>> > +static inline unsigned long task_util_est(struct task_struct *p)
>> > +{
>> > +       return max(p->se.avg.util_est.ewma, p->se.avg.util_est.last);
>> > +}
>> > +
>> >  /*
>> >   * cpu_util_wake: Compute cpu utilization with any contributions from
>> >   * the waking task p removed.
>> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>> > index 9552fd5854bf..c459a4b61544 100644
>> > --- a/kernel/sched/features.h
>> > +++ b/kernel/sched/features.h
>> > @@ -85,3 +85,8 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)
>> >  SCHED_FEAT(WA_IDLE, true)
>> >  SCHED_FEAT(WA_WEIGHT, true)
>> >  SCHED_FEAT(WA_BIAS, true)
>> > +
>> > +/*
>> > + * UtilEstimation. Use estimated CPU utilization.
>> > + */
>> > +SCHED_FEAT(UTIL_EST, false)
>> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> > index 2e95505e23c6..0b4d9750a927 100644
>> > --- a/kernel/sched/sched.h
>> > +++ b/kernel/sched/sched.h
>> > @@ -470,6 +470,7 @@ struct cfs_rq {
>> >          * CFS load tracking
>> >          */
>> >         struct sched_avg avg;
>> > +       unsigned long util_est_runnable;
>>
>> Since struct sched_avg would now have util_est, cfs_rq gets it too.
>> Then can we not try to reuse that struct and avoid having to expand
>> cfs_rq more than needed?
>
> Yes, that's possible now... the main issue is that for RQ's we do not
> track an EWMA, but still we can use the util_est::last field or maybe
> use a union just to use a better name when used from the RQ side.

Yes I think its good to make use of the space we're adding in cfs_rq
that's not used for other things.

>
>> I went through previous conversations and couldn't find a reason, if I
>> missed something I appreciate if you can explain the rationale.
>
> I've used a separate filed just because SE's util_est was not part of
> sched_avg, and missed the opportunity to consolidate better this now
> that we moved it. Thanks for pointing this out ;-)

You're welcome :)

thanks,

- Joel
