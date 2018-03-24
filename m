From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Sat, 24 Mar 2018 01:34:22 +0000
Message-ID: <20180324013421.GB1317@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <20180321153518.GC13951@e110439-lin>
 <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com>
 <20180323154745.GP4589@e105550-lin.cambridge.arm.com>
 <CAJWu+oqP9NLkhhZsTZ5JogSWgp6D2FoGAmP76Szi4+n87XNSsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJWu+oqP9NLkhhZsTZ5JogSWgp6D2FoGAmP76Szi4+n87XNSsQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

On Friday 23 Mar 2018 at 18:13:56 (-0700), Joel Fernandes wrote:
> Hi Morten,
> 
> On Fri, Mar 23, 2018 at 8:47 AM, Morten Rasmussen
> <morten.rasmussen@arm.com> wrote:
> > On Thu, Mar 22, 2018 at 01:10:22PM -0700, Joel Fernandes wrote:

[...]

> > You mean if SD_BALANCE_WAKE isn't set on sched_domains?
> 
> Yes.
> 
> > The current code seems to rely on that flag to be set to work correctly.
> > Otherwise, the loop might bail out on !want_affine and we end up doing
> > the find_energy_efficient_cpu() on the lowest level sched_domain even if
> > there is higher level one which isn't over-utilized.
> >
> > However, SD_BALANCE_WAKE should be set if SD_ASYM_CPUCAPACITY is set so
> > sd == NULL shouldn't be possible? This only holds as long as we only
> > want EAS for asymmetric systems.
> 
> Yes, I see you had topology code that set SD_BALANCE_WAKE for ASYM. It
> makes sense to me then, thanks for the clarification.
> 
> Still I feel it is a bit tedious/confusing when reading code to draw
> the conclusion about why sd is checked first before doing
> find_energy_efficient_cpu (and that sd will != NULL for ASYM systems).
> If energy_sd is set, then we can just proceed with EAS without
> checking that sd != NULL. This function in mainline is already pretty
> confusing as it is :-(

Right I see your point. The code is correct as is, but I agree that having
a code structured as

	if (energy_sd) {
		new_cpu = find_energy_efficient_cpu(energy_sd, p, prev_cpu);
	} else if (!sd) {
		...

might be easier to understand and functionally equivalent. What do you
think ?

Thanks,
Quentin
