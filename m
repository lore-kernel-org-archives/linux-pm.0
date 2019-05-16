From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/1] Forced-wakeup for stop lite states on Powernv
Date: Thu, 16 May 2019 16:13:17 +1000
Message-ID: <1557986956.6pmjz10b9z.astroid@bobo.none>
References: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
        <1557291178.ow4spjzq5t.astroid@bobo.none>
        <b2fcf69a-aecd-ea81-b497-737642354736@linux.vnet.ibm.com>
        <1557981860.eltms77ctp.astroid@bobo.none>
        <20190516053659.GA20396@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516053659.GA20396@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: daniel.lezcano@linaro.org, dja@axtens.net, Abhishek <huntbag@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Gautham R Shenoy's on May 16, 2019 3:36 pm:
> Hello Nicholas,
>=20
>=20
> On Thu, May 16, 2019 at 02:55:42PM +1000, Nicholas Piggin wrote:
>> Abhishek's on May 13, 2019 7:49 pm:
>> > On 05/08/2019 10:29 AM, Nicholas Piggin wrote:
>> >> Abhishek Goel's on April 22, 2019 4:32 pm:
>> >>> Currently, the cpuidle governors determine what idle state a idling =
CPU
>> >>> should enter into based on heuristics that depend on the idle histor=
y on
>> >>> that CPU. Given that no predictive heuristic is perfect, there are c=
ases
>> >>> where the governor predicts a shallow idle state, hoping that the CP=
U will
>> >>> be busy soon. However, if no new workload is scheduled on that CPU i=
n the
>> >>> near future, the CPU will end up in the shallow state.
>> >>>
>> >>> Motivation
>> >>> ----------
>> >>> In case of POWER, this is problematic, when the predicted state in t=
he
>> >>> aforementioned scenario is a lite stop state, as such lite states wi=
ll
>> >>> inhibit SMT folding, thereby depriving the other threads in the core=
 from
>> >>> using the core resources.
>> >>>
>> >>> So we do not want to get stucked in such states for longer duration.=
 To
>> >>> address this, the cpuidle-core can queue timer to correspond with th=
e
>> >>> residency value of the next available state. This timer will forcefu=
lly
>> >>> wakeup the cpu. Few such iterations will essentially train the gover=
nor to
>> >>> select a deeper state for that cpu, as the timer here corresponds to=
 the
>> >>> next available cpuidle state residency. Cpu will be kicked out of th=
e lite
>> >>> state and end up in a non-lite state.
>> >>>
>> >>> Experiment
>> >>> ----------
>> >>> I performed experiments for three scenarios to collect some data.
>> >>>
>> >>> case 1 :
>> >>> Without this patch and without tick retained, i.e. in a upstream ker=
nel,
>> >>> It would spend more than even a second to get out of stop0_lite.
>> >>>
>> >>> case 2 : With tick retained in a upstream kernel -
>> >>>
>> >>> Generally, we have a sched tick at 4ms(CONF_HZ =3D 250). Ideally I e=
xpected
>> >>> it to take 8 sched tick to get out of stop0_lite. Experimentally,
>> >>> observation was
>> >>>
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> sample          min            max           99percentile
>> >>> 20              4ms            12ms          4ms
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>>
>> >>> It would take atleast one sched tick to get out of stop0_lite.
>> >>>
>> >>> case 2 :  With this patch (not stopping tick, but explicitly queuing=
 a
>> >>>            timer)
>> >>>
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> sample          min             max             99percentile
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> 20              144us           192us           144us
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>>
>> >>> In this patch, we queue a timer just before entering into a stop0_li=
te
>> >>> state. The timer fires at (residency of next available state + exit =
latency
>> >>> of next available state * 2). Let's say if next state(stop0) is avai=
lable
>> >>> which has residency of 20us, it should get out in as low as (20+2*2)=
*8
>> >>> [Based on the forumla (residency + 2xlatency)*history length] micros=
econds
>> >>> =3D 192us. Ideally we would expect 8 iterations, it was observed to =
get out
>> >>> in 6-7 iterations. Even if let's say stop2 is next available state(s=
top0
>> >>> and stop1 both are unavailable), it would take (100+2*10)*8 =3D 960u=
s to get
>> >>> into stop2.
>> >>>
>> >>> So, We are able to get out of stop0_lite generally in 150us(with thi=
s
>> >>> patch) as compared to 4ms(with tick retained). As stated earlier, we=
 do not
>> >>> want to get stuck into stop0_lite as it inhibits SMT folding for oth=
er
>> >>> sibling threads, depriving them of core resources. Current patch is =
using
>> >>> forced-wakeup only for stop0_lite, as it gives performance benefit(p=
rimary
>> >>> reason) along with lowering down power consumption. We may extend th=
is
>> >>> model for other states in future.
>> >> I still have to wonder, between our snooze loop and stop0, what does
>> >> stop0_lite buy us.
>> >>
>> >> That said, the problem you're solving here is a generic one that all
>> >> stop states have, I think. Doesn't the same thing apply going from
>> >> stop0 to stop5? You might under estimate the sleep time and lose powe=
r
>> >> savings and therefore performance there too. Shouldn't we make it
>> >> generic for all stop states?
>> >>
>> >> Thanks,
>> >> Nick
>> >>
>> >>
>> > When a cpu is in snooze, it takes both space and time of core. When in=
=20
>> > stop0_lite,
>> > it free up time but it still takes space.
>>=20
>> True, but snooze should only be taking less than 1% of front end
>> cycles. I appreciate there is some non-zero difference here, I just
>> wonder in practice what exactly we gain by it.
>=20
> The idea behind implementing a lite-state was that on the future
> platforms it can be made to wait on a flag and hence act as a
> replacement for snooze. On POWER9 we don't have this feature.

Right. I mean for POWER9.

> The motivation behind this patch was a HPC customer issue where they
> were observing some CPUs in the core getting stuck at stop0_lite
> state, thereby lowering the performance on the other CPUs of the core
> which were running the application.
>=20
> Disabling stop0_lite via sysfs didn't help since we would fallback to
> snooze and it would make matters worse.

snooze has the timeout though, so it should kick into stop0 properly
(and if it doesn't that's another issue that should be fixed in this
series).

I'm not questioning the patch for stop0_lite, to be clear. I think
the logic is sound. I just raise one urelated issue that happens to
be for stop0_lite as well (should we even enable it on P9?), and one
peripheral issue (should we make a similar fix for deeper stop states?)

>=20
>>=20
>> We should always have fewer states unless proven otherwise.
>=20
> I agree.
>=20
>>=20
>> That said, we enable it today so I don't want to argue this point
>> here, because it is a different issue from your patch.
>>=20
>> > When it is in stop0 or deeper,=20
>> > it free up both
>> > space and time slice of core.
>> > In stop0_lite, cpu doesn't free up the core resources and thus inhibit=
s=20
>> > thread
>> > folding. When a cpu goes to stop0, it will free up the core resources=20
>> > thus increasing
>> > the single thread performance of other sibling thread.
>> > Hence, we do not want to get stuck in stop0_lite for long duration, an=
d=20
>> > want to quickly
>> > move onto the next state.
>> > If we get stuck in any other state we would possibly be losing on to=20
>> > power saving,
>> > but will still be able to gain the performance benefits for other=20
>> > sibling threads.
>>=20
>> That's true, but stop0 -> deeper stop is also a benefit (for
>> performance if we have some power/thermal constraints, and/or for power
>> usage).
>>=20
>> Sure it may not be so noticable as the SMT switch, but I just wonder
>> if the infrastructure should be there for the same reason.
>>=20
>> I was testing interrupt frequency on some tickless workloads configs,
>> and without too much trouble you can get CPUs to sleep with no
>> interrupts for many minutes. Hours even. We wouldn't want the CPU to
>> stay in stop0 for that long.
>=20
> If it stays in stop0 or even stop2 for that long, we would want to
> "promote" it to a deeper state, such as say STOP5 which allows the
> other cores to run at higher frequencies.

So we would want this same logic for all but the deepest runtime
stop state?

>> Just thinking about the patch itself, I wonder do you need a full
>> kernel timer, or could we just set the decrementer? Is there much=20
>> performance cost here?
>>
>=20
> Good point. A decrementer would do actually.

That would be good if it does, might save a few cycles.

Thanks,
Nick

=
