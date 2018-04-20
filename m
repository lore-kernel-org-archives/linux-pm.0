From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point
 indicator
Date: Fri, 20 Apr 2018 10:57:23 +0200
Message-ID: <20180420085723.GE24599@localhost.localdomain>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-4-dietmar.eggemann@arm.com>
 <CAJWu+oqxGkUKzmj6OokRHoQ=1B+618cnLL_SXrnXFOgX1GWdkA@mail.gmail.com>
 <20180418111729.GB6783@e108498-lin.cambridge.arm.com>
 <CAJWu+opgqZ9DJtZtxzsum+d-CsCqvm2FOtaLAHuDv-mcD74Qew@mail.gmail.com>
 <CAJWu+oqGtfpwX9_s=Gwt5CKQNfRhztV48RjriGiBS7ZXG8g90w@mail.gmail.com>
 <20180420083118.GA14391@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180420083118.GA14391@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Joel Fernandes <joelaf@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 20/04/18 09:31, Quentin Perret wrote:
> On Friday 20 Apr 2018 at 01:14:35 (-0700), Joel Fernandes wrote:
> > On Fri, Apr 20, 2018 at 1:13 AM, Joel Fernandes <joelaf@google.com> wrote:
> > > On Wed, Apr 18, 2018 at 4:17 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> > >> On Friday 13 Apr 2018 at 16:56:39 (-0700), Joel Fernandes wrote:

[...]

> > >>>
> > >>> I'm wondering if it makes sense for considering scenarios whether
> > >>> other classes cause CPUs in the domain to go above the tipping point.
> > >>> Then in that case also, it makes sense to not to do EAS in that domain
> > >>> because of the overutilization.
> > >>>
> > >>> I guess task_fits using cpu_util which is PELT only at the moment...
> > >>> so may require some other method like aggregation of CFS PELT, with
> > >>> RT-PELT and DL running bw or something.
> > >>>
> > >>
> > >> So at the moment in cpu_overutilized() we comapre cpu_util() to
> > >> capacity_of() which should include RT and IRQ pressure IIRC. But
> > >> you're right, we might be able to do more here... Perhaps we
> > >> could also use cpu_util_dl() which is available in sched.h now ?
> > >
> > > Yes, should be Ok, and then when RT utilization stuff is available,
> > > then that can be included in the equation as well (probably for now
> > > you could use rt_avg).
> > >
> > > Another crazy idea is to check the contribution of higher classes in
> > > one-shot with (capacity_orig_of - capacity_of) although I think that
> > > method would be less instantaneous/accurate.
> > 
> > Just to add to the last point, the capacity_of also factors in the IRQ
> > contribution if I remember correctly, which is probably a good thing?
> > 
> 
> I think so too yes. But actually, since we compare cpu_util() to
> capacity_of() in cpu_overutilized(), the current implementation should
> already be fairly similar to the "capacity_orig_of - capacity_of"
> implementation you're suggesting I guess.
> And I agree that when Vincent's RT PELT patches get merged we should
> probably use that :-)

Mind that rt_avg contains DL contribution as well ATM

https://elixir.bootlin.com/linux/v4.17-rc1/source/kernel/sched/deadline.c#L1182

So you shouldn't add newer DL utilization signal to it.

OTOH, using RT PELT (once in) is of course to be preferred.

Best,

- Juri
