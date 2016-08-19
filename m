From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Thu, 18 Aug 2016 22:03:13 -0700
Message-ID: <20160819050313.GD11114@graphite.smuckle.net>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
 <CANRm+CwDNDNEDjtgooFVvdDfzBwC+akopOss9J0nhmT8Vt94Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANRm+CwDNDNEDjtgooFVvdDfzBwC+akopOss9J0nhmT8Vt94Mg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 19, 2016 at 10:30:36AM +0800, Wanpeng Li wrote:
> 2016-08-19 9:55 GMT+08:00 Steve Muckle <steve.muckle@linaro.org>:
> > PELT scales its util_sum and util_avg values via
> > arch_scale_cpu_capacity(). If that function is passed the CPU's sched
> > domain then it will reduce the scaling capacity if SD_SHARE_CPUCAPACITY
> > is set. PELT does not pass in the sd however. The other caller of
> > arch_scale_cpu_capacity, update_cpu_capacity(), does. This means
> > util_sum and util_avg scale beyond the CPU capacity on SMT.
> >
> > On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> > util_avg scales up to 1024.
> >
> > Fix this by passing in the sd in __update_load_avg() as well.
> 
> I believe we notice this at least several months ago.
> https://lkml.org/lkml/2016/5/25/228

Glad to see I'm not alone in thinking this is an issue.

It causes an issue with schedutil, effectively doubling the apparent
demand on SMT. I don't know the load balance code well enough offhand to
say whether it's an issue there.

cheers,
Steve
