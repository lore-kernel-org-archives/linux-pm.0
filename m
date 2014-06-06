From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Fri, 6 Jun 2014 14:13:05 +0200
Message-ID: <20140606121305.GA8571@gmail.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
 <20140604160230.GS29593@e103034-lin>
 <20140604172712.GJ13930@laptop.programming.kicks-ass.net>
 <2484761.vkWavnsDx3@vostro.rjw.lan>
 <20140605065205.GA3213@twins.programming.kicks-ass.net>
 <539086B3.2010804@gmail.com>
 <20140605202930.GA15484@intel.com>
 <20140606080543.GR6758@twins.programming.kicks-ass.net>
 <20140606003520.GB22261@intel.com>
 <20140606105036.GQ3213@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:48470 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbaFFMNK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jun 2014 08:13:10 -0400
Content-Disposition: inline
In-Reply-To: <20140606105036.GQ3213@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yuyang Du <yuyang.du@intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Morten Rasmussen <morten.rasmussen@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, len.brown@intel.com, jacob.jun.pan@linux.intel.com


* Peter Zijlstra <peterz@infradead.org> wrote:

> > Voltage is combined with frequency, roughly, voltage is=20
> > proportional to freuquecy, so roughly, power is proportionaly to=20
> > voltage^3. You
>=20
> P ~ V^2, last time I checked.

Yes, that's a good approximation for CMOS gates:

  The switching power dissipated by a chip using static CMOS gates is=20
  C=B7V^2=B7f, where C is the capacitance being switched per clock cycl=
e,=20
  V is the supply voltage, and f is the switching frequency,[1] so=20
  this part of the power consumption decreases quadratically with=20
  voltage. The formula is not exact however, as many modern chips are=20
  not implemented using 100% CMOS, but also use special memory=20
  circuits, dynamic logic such as domino logic, etc. Moreover, there=20
  is also a static leakage current, which has become more and more=20
  accentuated as feature sizes have become smaller (below 90=20
  nanometres) and threshold levels lower.

  Accordingly, dynamic voltage scaling is widely used as part of=20
  strategies to manage switching power consumption in battery powered=20
  devices such as cell phones and laptop computers. Low voltage modes=20
  are used in conjunction with lowered clock frequencies to minimize=20
  power consumption associated with components such as CPUs and DSPs;=20
  only when significant computational power is needed will the voltage=20
  and frequency be raised.

  Some peripherals also support low voltage operational modes. For=20
  example, low power MMC and SD cards can run at 1.8 V as well as at=20
  3.3 V, and driver stacks may conserve power by switching to the=20
  lower voltage after detecting a card which supports it.

  When leakage current is a significant factor in terms of power=20
  consumption, chips are often designed so that portions of them can=20
  be powered completely off. This is not usually viewed as being=20
  dynamic voltage scaling, because it is not transparent to software.=20
  When sections of chips can be turned off, as for example on TI OMAP3=20
  processors, drivers and other support software need to support that.

  http://en.wikipedia.org/wiki/Dynamic_voltage_scaling

Leakage current typically gets higher with higher frequencies, but=20
it's also highly process dependent AFAIK.

If switching power dissipation is the main factor in power use, then=20
we can essentially assume that P ~ V^2, at the same frequency - and=20
scales linearly with frequency - but real work performed also scales=20
semi-linearly with frequency for many workloads, so that's an=20
invariant for everything except highly memory bound workloads.

Thanks,

	Ingo
