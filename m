Return-Path: <SRS0=TlO+=ST=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B0C282DC
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B8A217F4
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBOpFwat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbfDQUgY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:36:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34426 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbfDQUgX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2019 16:36:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id w16so94756wrl.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2019 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3DQvc3AZ2atftlei5LGBuLnz2lFpDVhQ7pQU8Nuxbs=;
        b=kBOpFwatfLpNmonFrnKqIchflCqCZRx2O8/50/RQ9JXD8VJV9A5K6a4GFmYTHOEDO5
         AK128Hw5DIHnGQOBwke4asS0K0LXpOuM4TR+LeAhwE+mRy4Jt64fg41mxqDBNL8PU8Un
         eErwUQmzsxSdHVBlCHLSdVjcG9IqWypDQcX1Y3rOJkaYBNObxeBfvtUFkok770H6f61Z
         IfPqczxXjTl0mrhCuKcCdtGZqBJZqTafgyX2v8LLE43A8FCTp7O+AOIoaymzcpQxST78
         zhwHeGdoo6HokInhb5G99fBVBfiG1TBZYFBox+ae1OJtfehk0bpZLkYXM7lJ4WDFTO+l
         /1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3DQvc3AZ2atftlei5LGBuLnz2lFpDVhQ7pQU8Nuxbs=;
        b=PV4TlTqkW/79rOevM5uRXgKqGhPq4Z4YTFhK2zxt3V6Cc0532CV19ec0Z3imMFUnas
         ZwqTgdpSCKXdo5UTLYv6GupB5DpAqxLwY14J7gYEHff0XWNMYYXbkt6kuLnAqjz+1UDW
         aBWADbIDZqVca/cYVLRDnckQh+aYeL+wMY8C/1DKJkA0fKRVXXn0w2P51Sz84d4eokRr
         ij2gq9661UMXw5E6cWWNY8wpWnIUZz9kskWYBOK6On8uSPT6f1IYq9p21h3UN6qKpC9I
         KIyEc2jKe8k9VY4VbBsDJbqvNja55NPu7zX4nhIXfsjhmG4Val6FWtwfUaaZonxjULZe
         asyA==
X-Gm-Message-State: APjAAAWkx1Gz2JukPecUFiJ1GQnNl2MA/jWSmYj5bjFDs/hStUpTfuKt
        ClLy74yVP3MrRp3tdjr1DFdFFKDGq9giSCrUALfQHg==
X-Google-Smtp-Source: APXvYqw3jWyP4fQuOdDO5uptQn2XmuiRzw+DlCMsrSdDDdHqx0YhLs049o6IVd2JPyIwNj6/8DDXzVU8omjbO/BrwLA=
X-Received: by 2002:adf:9144:: with SMTP id j62mr1357869wrj.320.1555533381179;
 Wed, 17 Apr 2019 13:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190402104153.25404-1-patrick.bellasi@arm.com> <20190402104153.25404-4-patrick.bellasi@arm.com>
In-Reply-To: <20190402104153.25404-4-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 17 Apr 2019 13:36:10 -0700
Message-ID:
 <CAJuCfpHN4kMBScdEdJodtmbHQ2qhVDnXrJKFDdaSYyjWH0JH5Q@mail.gmail.com>
Subject: Re: [PATCH v8 03/16] sched/core: uclamp: Enforce last task's UCLAMP_MAX
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190417203610.yyE0JDxoORyHcZXQPNf2G2PQt-ZqmQnltxzZ7zXbptM@z>

 Hi Patrick,

On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> When a task sleeps it removes its max utilization clamp from its CPU.
> However, the blocked utilization on that CPU can be higher than the max
> clamp value enforced while the task was running. This allows undesired
> CPU frequency increases while a CPU is idle, for example, when another
> CPU on the same frequency domain triggers a frequency update, since
> schedutil can now see the full not clamped blocked utilization of the
> idle CPU.
>
> Fix this by using
>   uclamp_rq_dec_id(p, rq, UCLAMP_MAX)
>     uclamp_rq_max_value(rq, UCLAMP_MAX, clamp_value)
> to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
> condition.
>

If I understand the intent correctly, you are trying to exclude idle
CPUs from affecting calculations of rq UCLAMP_MAX value. If that is
true I think description can be simplified a bit :) In particular it
took me some time to understand what "blocked utilization" means,
however if it's a widely accepted term then feel free to ignore my
input.

> Don't track any minimum utilization clamps since an idle CPU never
> requires a minimum frequency. The decay of the blocked utilization is
> good enough to reduce the CPU frequency.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
>
> --
> Changes in v8:
>  Message-ID: <20190314170619.rt6yhelj3y6dzypu@e110439-lin>
>  - moved flag reset into uclamp_rq_inc()
> ---
>  kernel/sched/core.c  | 45 ++++++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  2 ++
>  2 files changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6e1beae5f348..046f61d33f00 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -754,8 +754,35 @@ static inline unsigned int uclamp_none(int clamp_id)
>         return SCHED_CAPACITY_SCALE;
>  }
>
> +static inline unsigned int
> +uclamp_idle_value(struct rq *rq, unsigned int clamp_id, unsigned int clamp_value)
> +{
> +       /*
> +        * Avoid blocked utilization pushing up the frequency when we go
> +        * idle (which drops the max-clamp) by retaining the last known
> +        * max-clamp.
> +        */
> +       if (clamp_id == UCLAMP_MAX) {
> +               rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
> +               return clamp_value;
> +       }
> +
> +       return uclamp_none(UCLAMP_MIN);
> +}
> +
> +static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
> +                                    unsigned int clamp_value)
> +{
> +       /* Reset max-clamp retention only on idle exit */
> +       if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> +               return;
> +
> +       WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> +}
> +
>  static inline
> -unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
> +unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
> +                                unsigned int clamp_value)

IMHO the name of uclamp_rq_max_value() is a bit misleading because:
1. It does not imply that it has to be called only when there are no
more runnable tasks on a CPU. This is currently the case because it's
called only from uclamp_rq_dec_id() and only when bucket->tasks==0 but
nothing in the name of this function indicates that it can't be called
from other places.
2. It does not imply that it marks rq UCLAMP_FLAG_IDLE.

>  {
>         struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
>         int bucket_id = UCLAMP_BUCKETS - 1;
> @@ -771,7 +798,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
>         }
>
>         /* No tasks -- default clamp values */
> -       return uclamp_none(clamp_id);
> +       return uclamp_idle_value(rq, clamp_id, clamp_value);
>  }
>
>  /*
> @@ -794,6 +821,8 @@ static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
>         bucket = &uc_rq->bucket[uc_se->bucket_id];
>         bucket->tasks++;
>
> +       uclamp_idle_reset(rq, clamp_id, uc_se->value);
> +
>         /*
>          * Local max aggregation: rq buckets always track the max
>          * "requested" clamp value of its RUNNABLE tasks.
> @@ -820,6 +849,7 @@ static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
>         struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
>         struct uclamp_se *uc_se = &p->uclamp[clamp_id];
>         struct uclamp_bucket *bucket;
> +       unsigned int bkt_clamp;
>         unsigned int rq_clamp;
>
>         bucket = &uc_rq->bucket[uc_se->bucket_id];
> @@ -848,7 +878,8 @@ static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
>                  * there are anymore RUNNABLE tasks refcounting it.
>                  */
>                 bucket->value = uclamp_bucket_base_value(bucket->value);
> -               WRITE_ONCE(uc_rq->value, uclamp_rq_max_value(rq, clamp_id));
> +               bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
> +               WRITE_ONCE(uc_rq->value, bkt_clamp);
>         }
>  }
>
> @@ -861,6 +892,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>
>         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
>                 uclamp_rq_inc_id(p, rq, clamp_id);
> +
> +       /* Reset clamp idle holding when there is one RUNNABLE task */
> +       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +               rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>  }
>
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> @@ -879,8 +914,10 @@ static void __init init_uclamp(void)
>         unsigned int clamp_id;
>         int cpu;
>
> -       for_each_possible_cpu(cpu)
> +       for_each_possible_cpu(cpu) {
>                 memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
> +               cpu_rq(cpu)->uclamp_flags = 0;
> +       }
>
>         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
>                 struct uclamp_se *uc_se = &init_task.uclamp[clamp_id];
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c3d1ae1e7eec..d8b182f1782c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -880,6 +880,8 @@ struct rq {
>  #ifdef CONFIG_UCLAMP_TASK
>         /* Utilization clamp values based on CPU's RUNNABLE tasks */
>         struct uclamp_rq        uclamp[UCLAMP_CNT] ____cacheline_aligned;
> +       unsigned int            uclamp_flags;
> +#define UCLAMP_FLAG_IDLE 0x01
>  #endif
>
>         struct cfs_rq           cfs;
> --
> 2.20.1
>
