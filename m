From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH v1 4/8] sched/cpufreq_schedutil: split utilization signals
Date: Mon, 10 Jul 2017 00:46:42 -0700
Message-ID: <CAJWu+orMR4ATOhdyDm0PpqOgLhr6drnVNA97heafnfKc9g6+7g@mail.gmail.com>
References: <20170705085905.6558-1-juri.lelli@arm.com> <20170705085905.6558-5-juri.lelli@arm.com>
 <20170707085848.GA32542@vireshk-i7> <20170707105932.bnslgcqjp4rwg273@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33473 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdGJHqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 03:46:44 -0400
Received: by mail-oi0-f45.google.com with SMTP id p188so67798832oia.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2017 00:46:43 -0700 (PDT)
In-Reply-To: <20170707105932.bnslgcqjp4rwg273@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Luca Abeni <luca.abeni@santannapisa.it>, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, Mathieu Poirier <mathieu.poirier@linaro.org>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>Ingo

On Fri, Jul 7, 2017 at 3:59 AM, Juri Lelli <juri.lelli@arm.com> wrote:
[..]
>
>> If yes, then I don't think it was about having separate APIs, but just storing
>> util_cfs/dl separately.
>>
>> > -static void sugov_get_util(unsigned long *util, unsigned long *max)
>> > +static void sugov_get_util(struct sugov_cpu *sg_cpu)
>> >  {
>> >     struct rq *rq = this_rq();
>> > -   unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
>> > -                           >> BW_SHIFT;
>> >
>> > -   *max = arch_scale_cpu_capacity(NULL, smp_processor_id());
>> > +   sg_cpu->max = arch_scale_cpu_capacity(NULL, smp_processor_id());
>> > +   sg_cpu->util_cfs = rq->cfs.avg.util_avg;
>> > +   sg_cpu->util_dl = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
>> > +                     >> BW_SHIFT;
>> > +}
>> >
>> > +static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>>
>> As Joel already mentioned, I don't think we should create two separate routines
>> here.
>>
>
> Mmm, it makes retrieving of utilization in sugov_update_shared and
> aggregating values for the domain in sugov_next_freq_shared cleaner,
> IMHO.
>

I agree, thanks.

-Joel
