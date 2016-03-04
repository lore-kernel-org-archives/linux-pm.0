From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 10/10] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Fri, 04 Mar 2016 07:56:13 -0800
Message-ID: <1457106973.4356.13.camel@linux.intel.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	 <2409306.qzzMXcm4dm@vostro.rjw.lan> <4627718.FT18d2LR5p@vostro.rjw.lan>
	 <20160304112639.GD4061@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160304112639.GD4061@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2016-03-04 at 11:26 +0000, Juri Lelli wrote:
> Hi Rafael,
>=20
> On 04/03/16 04:35, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > Add a new cpufreq scaling governor, called "schedutil", that uses
> > scheduler-provided CPU utilization information as input for making
> > its decisions.
> >=20
> > Doing that is possible after commit fe7034338ba0 (cpufreq: Add
> > mechanism for registering utilization update callbacks) that
> > introduced cpufreq_update_util() called by the scheduler on
> > utilization changes (from CFS) and RT/DL task status updates.
> > In particular, CPU frequency scaling decisions may be based on
> > the the utilization data passed to cpufreq_update_util() by CFS.
> >=20
> > The new governor is relatively simple.
> >=20
> > The frequency selection formula used by it is
> >=20
> > 	next_freq =3D util * max_freq / max
> >=20
> > where util and max are the utilization and CPU capacity coming from
> > CFS.
> >=20
>=20
> The formula looks better to me now. However, problem is that, if you
> have freq. invariance, util will slowly saturate to the current
> capacity. So, we won't trigger OPP changes for a task that for
> example
> starts light and then becomes big.
>=20
> This is the same problem we faced with schedfreq. The current
> solution
> there is to use a margin for calculating a threshold (80% of current
> capacity ATM). Once util goes above that threshold we trigger an OPP
> change.=C2=A0=C2=A0Current policy is pretty aggressive, we go to max_=
f and then
> adapt to the "real" util during successive enqueues. This was also
> tought to cope with the fact that PELT seems slow to react to abrupt
> changes in tasks behaviour.
>=20
I also tried something like this in intel_pstate with scheduler util,
where you ramp up to turbo when a threshold percent exceeded then ramp
down slowly in steps. This helped some workloads like tbench to perform
better, but it resulted in lower performance/watt on specpower server
workload. The problem is finding what is the right threshold value.

Thanks,
Srinivas

> I'm not saying this is the definitive solution, but I fear something
> along this line is needed when you add freq invariance in the mix.
>=20
> Best,
>=20
> - Juri
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
