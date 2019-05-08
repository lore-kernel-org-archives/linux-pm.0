From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/1] Forced-wakeup for stop lite states on Powernv
Date: Wed, 08 May 2019 14:59:07 +1000
Message-ID: <1557291178.ow4spjzq5t.astroid@bobo.none>
References: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: daniel.lezcano@linaro.org, dja@axtens.net, ego@linux.vnet.ibm.com, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Abhishek Goel's on April 22, 2019 4:32 pm:
> Currently, the cpuidle governors determine what idle state a idling CPU
> should enter into based on heuristics that depend on the idle history on
> that CPU. Given that no predictive heuristic is perfect, there are cases
> where the governor predicts a shallow idle state, hoping that the CPU wil=
l
> be busy soon. However, if no new workload is scheduled on that CPU in the
> near future, the CPU will end up in the shallow state.
>=20
> Motivation
> ----------
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>=20
> So we do not want to get stucked in such states for longer duration. To
> address this, the cpuidle-core can queue timer to correspond with the
> residency value of the next available state. This timer will forcefully
> wakeup the cpu. Few such iterations will essentially train the governor t=
o
> select a deeper state for that cpu, as the timer here corresponds to the
> next available cpuidle state residency. Cpu will be kicked out of the lit=
e
> state and end up in a non-lite state.
>=20
> Experiment
> ----------
> I performed experiments for three scenarios to collect some data.
>=20
> case 1 :
> Without this patch and without tick retained, i.e. in a upstream kernel,
> It would spend more than even a second to get out of stop0_lite.
>=20
> case 2 : With tick retained in a upstream kernel -
>=20
> Generally, we have a sched tick at 4ms(CONF_HZ =3D 250). Ideally I expect=
ed
> it to take 8 sched tick to get out of stop0_lite. Experimentally,
> observation was
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> sample          min            max           99percentile
> 20              4ms            12ms          4ms
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> It would take atleast one sched tick to get out of stop0_lite.
>=20
> case 2 :  With this patch (not stopping tick, but explicitly queuing a
>           timer)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> sample          min             max             99percentile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 20              144us           192us           144us
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> In this patch, we queue a timer just before entering into a stop0_lite
> state. The timer fires at (residency of next available state + exit laten=
cy
> of next available state * 2). Let's say if next state(stop0) is available
> which has residency of 20us, it should get out in as low as (20+2*2)*8
> [Based on the forumla (residency + 2xlatency)*history length] microsecond=
s
> =3D 192us. Ideally we would expect 8 iterations, it was observed to get o=
ut
> in 6-7 iterations. Even if let's say stop2 is next available state(stop0
> and stop1 both are unavailable), it would take (100+2*10)*8 =3D 960us to =
get
> into stop2.
>=20
> So, We are able to get out of stop0_lite generally in 150us(with this
> patch) as compared to 4ms(with tick retained). As stated earlier, we do n=
ot
> want to get stuck into stop0_lite as it inhibits SMT folding for other
> sibling threads, depriving them of core resources. Current patch is using
> forced-wakeup only for stop0_lite, as it gives performance benefit(primar=
y
> reason) along with lowering down power consumption. We may extend this
> model for other states in future.

I still have to wonder, between our snooze loop and stop0, what does
stop0_lite buy us.

That said, the problem you're solving here is a generic one that all
stop states have, I think. Doesn't the same thing apply going from
stop0 to stop5? You might under estimate the sleep time and lose power
savings and therefore performance there too. Shouldn't we make it
generic for all stop states?

Thanks,
Nick

=
