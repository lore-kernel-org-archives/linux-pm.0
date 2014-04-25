From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC] A new CPU load metric for power-efficient scheduler: CPU
 ConCurrency
Date: Fri, 25 Apr 2014 11:23:07 +0100
Message-ID: <20140425102307.GN2500@e103034-lin>
References: <20140424193004.GA2467@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140424193004.GA2467@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuyang Du <yuyang.du@intel.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "arjan.van.de.ven@intel.com" <arjan.van.de.ven@intel.com>, "len.brown@intel.com" <len.brown@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "alan.cox@intel.com" <alan.cox@intel.com>, "mark.gross@intel.com" <mark.gross@intel.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Yuyang,

On Thu, Apr 24, 2014 at 08:30:05PM +0100, Yuyang Du wrote:
> 1)	Divide continuous time into periods of time, and average task conc=
urrency
> in period, for tolerating the transient bursts:
> a =3D sum(concurrency * time) / period
> 2)	Exponentially decay past periods, and synthesize them all, for hys=
teresis
> to load drops or resilience to load rises (let f be decaying factor, =
and a_x
> the xth period average since period 0):
> s =3D a_n + f^1 * a_n-1 + f^2 * a_n-2 +, =E2=80=A6..,+ f^(n-1) * a_1 =
+ f^n * a_0
>=20
> We name this load indicator as CPU ConCurrency (CC): task concurrency
> determines how many CPUs are needed to be running concurrently.
>=20
> To track CC, we intercept the scheduler in 1) enqueue, 2) dequeue, 3)
> scheduler tick, and 4) enter/exit idle.
>=20
> By CC, we implemented a Workload Consolidation patch on two Intel mob=
ile
> platforms (a quad-core composed of two dual-core modules): contain lo=
ad and load
> balancing in the first dual-core when aggregated CC low, and if not i=
n the
> full quad-core. Results show that we got power savings and no substan=
tial
> performance regression (even gains for some).

The idea you present seems quite similar to the task packing proposals
by Vincent and others that were discussed about a year ago. One of the
main issues related to task packing/consolidation is that it is not
always beneficial.

I have spent some time over the last couple of weeks looking into this
trying to figure out when task consolidation makes sense. The pattern I
have seen is that it makes most sense when the task energy is dominated
by wake-up costs. That is short-running tasks. The actual energy saving=
s
come from a reduced number of wake-ups if the consolidation cpu is busy
enough to be already awake when another task wakes up, and savings by
keeping the consolidation cpu in a shallower idle state and thereby
reducing the wake-up costs. The wake-up cost savings outweighs the
additional leakage in the shallower idle state in some scenarios. All o=
f
this is of course quite platform dependent. Different idle state leakag=
e
power and wake-up costs may change the picture.

I'm therefore quite interested in knowing what sort of test scenarios
you used and the parameters for CC (f and size of the periods). I'm not
convinced (yet) that a cpu load concurrency indicator is sufficient to
make the call when to consolidate tasks. I'm thinking whether we need a
power model to guide the decisions.

Whether you use CC or reintroduce usage_avg as Vincent proposes I
believe the overhead should be roughly the same.

Morten
