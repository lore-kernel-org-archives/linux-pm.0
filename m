From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Fri, 6 Jun 2014 14:27:40 +0200
Message-ID: <20140606122740.GA9318@gmail.com>
References: <20140604160230.GS29593@e103034-lin>
 <20140604172712.GJ13930@laptop.programming.kicks-ass.net>
 <2484761.vkWavnsDx3@vostro.rjw.lan>
 <20140605065205.GA3213@twins.programming.kicks-ass.net>
 <539086B3.2010804@gmail.com>
 <20140605202930.GA15484@intel.com>
 <20140606080543.GR6758@twins.programming.kicks-ass.net>
 <20140606003520.GB22261@intel.com>
 <20140606105036.GQ3213@twins.programming.kicks-ass.net>
 <20140606121305.GA8571@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:60470 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbaFFM1q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jun 2014 08:27:46 -0400
Content-Disposition: inline
In-Reply-To: <20140606121305.GA8571@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yuyang Du <yuyang.du@intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Morten Rasmussen <morten.rasmussen@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, len.brown@intel.com, jacob.jun.pan@linux.intel.com


* Ingo Molnar <mingo@kernel.org> wrote:

> * Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > > Voltage is combined with frequency, roughly, voltage is=20
> > > proportional to freuquecy, so roughly, power is proportionaly to=20
> > > voltage^3. You
> >=20
> > P ~ V^2, last time I checked.
>=20
> Yes, that's a good approximation for CMOS gates:
>=20
>   The switching power dissipated by a chip using static CMOS gates is=
=20
>   C=B7V^2=B7f, where C is the capacitance being switched per clock cy=
cle,=20
>   V is the supply voltage, and f is the switching frequency,[1] so=20
>   this part of the power consumption decreases quadratically with=20
>   voltage. The formula is not exact however, as many modern chips are=
=20
>   not implemented using 100% CMOS, but also use special memory=20
>   circuits, dynamic logic such as domino logic, etc. Moreover, there=20
>   is also a static leakage current, which has become more and more=20
>   accentuated as feature sizes have become smaller (below 90=20
>   nanometres) and threshold levels lower.
>=20
>   Accordingly, dynamic voltage scaling is widely used as part of=20
>   strategies to manage switching power consumption in battery powered=
=20
>   devices such as cell phones and laptop computers. Low voltage modes=
=20
>   are used in conjunction with lowered clock frequencies to minimize=20
>   power consumption associated with components such as CPUs and DSPs;=
=20
>   only when significant computational power is needed will the voltag=
e=20
>   and frequency be raised.
>=20
>   Some peripherals also support low voltage operational modes. For=20
>   example, low power MMC and SD cards can run at 1.8 V as well as at=20
>   3.3 V, and driver stacks may conserve power by switching to the=20
>   lower voltage after detecting a card which supports it.
>=20
>   When leakage current is a significant factor in terms of power=20
>   consumption, chips are often designed so that portions of them can=20
>   be powered completely off. This is not usually viewed as being=20
>   dynamic voltage scaling, because it is not transparent to software.=
=20
>   When sections of chips can be turned off, as for example on TI OMAP=
3=20
>   processors, drivers and other support software need to support that=
=2E
>=20
>   http://en.wikipedia.org/wiki/Dynamic_voltage_scaling
>=20
> Leakage current typically gets higher with higher frequencies, but=20
> it's also highly process dependent AFAIK.
>=20
> If switching power dissipation is the main factor in power use, then=20
> we can essentially assume that P ~ V^2, at the same frequency - and=20
> scales linearly with frequency - but real work performed also scales=20
> semi-linearly with frequency for many workloads, so that's an=20
> invariant for everything except highly memory bound workloads.

So in practice this probably means that Turbo probably has a somewhat=20
super-linear power use factor.

At lower frequencies the leakage current difference is probably=20
negligible.

In any case, even with turbo frequencies, switching power use is=20
probably an order of magnitude higher than leakage current power use,=20
on any marketable chip, so we should concentrate on being able to=20
cover this first order effect (P/work ~ V^2), before considering any=20
second order effects (leakage current).

Thanks,

	Ingo
