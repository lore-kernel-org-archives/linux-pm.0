From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Fri, 6 Jun 2014 15:11:54 +0100
Message-ID: <20140606141154.GW29593@e103034-lin>
References: <20140604172712.GJ13930@laptop.programming.kicks-ass.net>
 <2484761.vkWavnsDx3@vostro.rjw.lan>
 <20140605065205.GA3213@twins.programming.kicks-ass.net>
 <539086B3.2010804@gmail.com>
 <20140605202930.GA15484@intel.com>
 <20140606080543.GR6758@twins.programming.kicks-ass.net>
 <20140606003520.GB22261@intel.com>
 <20140606105036.GQ3213@twins.programming.kicks-ass.net>
 <20140606121305.GA8571@gmail.com>
 <20140606122740.GA9318@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:15158 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751320AbaFFOL7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jun 2014 10:11:59 -0400
Content-Disposition: inline
In-Reply-To: <20140606122740.GA9318@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Yuyang Du <yuyang.du@intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "len.brown@intel.com" <len.brown@intel.com>, "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>

On Fri, Jun 06, 2014 at 01:27:40PM +0100, Ingo Molnar wrote:
>=20
> * Ingo Molnar <mingo@kernel.org> wrote:
>=20
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> >=20
> > > > Voltage is combined with frequency, roughly, voltage is=20
> > > > proportional to freuquecy, so roughly, power is proportionaly t=
o=20
> > > > voltage^3. You
> > >=20
> > > P ~ V^2, last time I checked.
> >=20
> > Yes, that's a good approximation for CMOS gates:
> >=20
> >   The switching power dissipated by a chip using static CMOS gates =
is=20
> >   C=B7V^2=B7f, where C is the capacitance being switched per clock =
cycle,=20
> >   V is the supply voltage, and f is the switching frequency,[1] so=20
> >   this part of the power consumption decreases quadratically with=20
> >   voltage. The formula is not exact however, as many modern chips a=
re=20
> >   not implemented using 100% CMOS, but also use special memory=20
> >   circuits, dynamic logic such as domino logic, etc. Moreover, ther=
e=20
> >   is also a static leakage current, which has become more and more=20
> >   accentuated as feature sizes have become smaller (below 90=20
> >   nanometres) and threshold levels lower.
> >=20
> >   Accordingly, dynamic voltage scaling is widely used as part of=20
> >   strategies to manage switching power consumption in battery power=
ed=20
> >   devices such as cell phones and laptop computers. Low voltage mod=
es=20
> >   are used in conjunction with lowered clock frequencies to minimiz=
e=20
> >   power consumption associated with components such as CPUs and DSP=
s;=20
> >   only when significant computational power is needed will the volt=
age=20
> >   and frequency be raised.
> >=20
> >   Some peripherals also support low voltage operational modes. For=20
> >   example, low power MMC and SD cards can run at 1.8 V as well as a=
t=20
> >   3.3 V, and driver stacks may conserve power by switching to the=20
> >   lower voltage after detecting a card which supports it.
> >=20
> >   When leakage current is a significant factor in terms of power=20
> >   consumption, chips are often designed so that portions of them ca=
n=20
> >   be powered completely off. This is not usually viewed as being=20
> >   dynamic voltage scaling, because it is not transparent to softwar=
e.=20
> >   When sections of chips can be turned off, as for example on TI OM=
AP3=20
> >   processors, drivers and other support software need to support th=
at.
> >=20
> >   http://en.wikipedia.org/wiki/Dynamic_voltage_scaling
> >=20
> > Leakage current typically gets higher with higher frequencies, but=20
> > it's also highly process dependent AFAIK.

Strictly speaking leakage current gets higher with voltage, not
frequency (well, not to an extend where we should care). However,
frequency increase typically implies a voltage increase, so in that
sense I agree.

> >=20
> > If switching power dissipation is the main factor in power use, the=
n=20
> > we can essentially assume that P ~ V^2, at the same frequency - and=
=20
> > scales linearly with frequency - but real work performed also scale=
s=20
> > semi-linearly with frequency for many workloads, so that's an=20
> > invariant for everything except highly memory bound workloads.

AFAIK, there isn't much sense in running a slower frequency than the
highest one supported at a given voltage unless there are specific
reasons not to (peripherals that keeps the system up anyway and such).
In the general case, I think it is safe to assume that energy-efficienc=
y
goes down for every increase in frequency. Modern ARM platforms
typically have different voltages for more or less all frequencies (TC2
is quite atypical). The voltage increases more rapidly than the
frequency which makes the higher frequencies extremely expensive in
terms of energy-efficiency.

All of this is of course without considering power gating which allow u=
s
to eliminate the leakage power (or at least partially eliminate it)
when idle. So, while energy-efficiency is bad at high frequencies, it
might pay off overall to use them anyway if we can save more leakage
energy while idle than we burn extra to race to idle. This is where the
platform energy model becomes useful.

> So in practice this probably means that Turbo probably has a somewhat=
=20
> super-linear power use factor.

I'm not familiar with the voltage scaling on Intel platforms, but as
said above, I think power always scales up faster than performance. It
can probably be ignored for lower frequencies, but for the higher ones,
the extra energy per instruction executed is significant.

> At lower frequencies the leakage current difference is probably=20
> negligible.

It is still there, but it is smaller due to the reduced voltage and so
is the dynamic power.

> In any case, even with turbo frequencies, switching power use is=20
> probably an order of magnitude higher than leakage current power use,=
=20
> on any marketable chip,=20

That strongly depends on the process and the gate library used, but I
agree that dynamic power should be our primary focus.

> so we should concentrate on being able to=20
> cover this first order effect (P/work ~ V^2), before considering any=20
> second order effects (leakage current).

I think we should be fine as long as we include the leakage power in th=
e
'busy' power consumption and know the idle-state power consumption in
the idle-states. I already do this in the TC2 model. That way we don't
have to distinguish between leakage and dynamic power.

Morten
