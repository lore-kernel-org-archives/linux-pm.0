From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC] A new CPU load metric for power-efficient scheduler: CPU
 ConCurrency
Date: Fri, 25 Apr 2014 03:30:05 +0800
Message-ID: <20140424193004.GA2467@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:19839 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbaDYDf1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Apr 2014 23:35:27 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, rafael.j.wysocki@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, yuyang.du@intel.com

Hi Ingo, PeterZ, and others,

The current scheduler=E2=80=99s load balancing is completely work-conse=
rving. In some
workload, generally low CPU utilization but immersed with CPU bursts of
transient tasks, migrating task to engage all available CPUs for
work-conserving can lead to significant overhead: cache locality loss,
idle/active HW state transitional latency and power, shallower idle sta=
te,
etc, which are both power and performance inefficient especially for to=
day=E2=80=99s
low power processors in mobile.=20

This RFC introduces a sense of idleness-conserving into work-conserving=
 (by
all means, we really don=E2=80=99t want to be overwhelming in only one =
way). But to
what extent the idleness-conserving should be, bearing in mind that we =
don=E2=80=99t
want to sacrifice performance? We first need a load/idleness indicator =
to that
end.

Thanks to CFS=E2=80=99s =E2=80=9Cmodel an ideal, precise multi-tasking =
CPU=E2=80=9D, tasks can be seen
as concurrently running (the tasks in the runqueue). So it is natural t=
o use
task concurrency as load indicator. Having said that, we do two things:

1)	Divide continuous time into periods of time, and average task concur=
rency
in period, for tolerating the transient bursts:
a =3D sum(concurrency * time) / period
2)	Exponentially decay past periods, and synthesize them all, for hyste=
resis
to load drops or resilience to load rises (let f be decaying factor, an=
d a_x
the xth period average since period 0):
s =3D a_n + f^1 * a_n-1 + f^2 * a_n-2 +, =E2=80=A6..,+ f^(n-1) * a_1 + =
f^n * a_0

We name this load indicator as CPU ConCurrency (CC): task concurrency
determines how many CPUs are needed to be running concurrently.

To track CC, we intercept the scheduler in 1) enqueue, 2) dequeue, 3)
scheduler tick, and 4) enter/exit idle.

By CC, we implemented a Workload Consolidation patch on two Intel mobil=
e
platforms (a quad-core composed of two dual-core modules): contain load=
 and load
balancing in the first dual-core when aggregated CC low, and if not in =
the
full quad-core. Results show that we got power savings and no substanti=
al
performance regression (even gains for some).

Thanks,
Yuyang
