From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [RFC PATCH] cpufreq: intel_pstate: Change the calculation of
 next pstate
Date: Sat, 17 May 2014 09:52:12 +0300
Message-ID: <5377071C.1030104@semaphore.gr>
References: <5368255D.3090207@semaphore.gr> <536BEE89.3040602@gmail.com> <536CECB4.1090109@semaphore.gr> <53712F4B.7000101@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:51639 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756956AbaEQGwS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 May 2014 02:52:18 -0400
In-Reply-To: <53712F4B.7000101@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Yuyang Du <yuyang.du@intel.com>

Hi all!

On 12/05/2014 11:30 =CE=BC=CE=BC, Stratos Karafotis wrote:
> On 09/05/2014 05:56 =CE=BC=CE=BC, Stratos Karafotis wrote:
>> Hi Dirk,
>>
>> On 08/05/2014 11:52 =CE=BC=CE=BC, Dirk Brandewie wrote:
>>> On 05/05/2014 04:57 PM, Stratos Karafotis wrote:
>>>> Currently the driver calculates the next pstate proportional to
>>>> core_busy factor, scaled by the ratio max_pstate / current_pstate.
>>>>
>>>> Using the scaled load (core_busy) to calculate the next pstate
>>>> is not always correct, because there are cases that the load is
>>>> independent from current pstate. For example, a tight 'for' loop
>>>> through many sampling intervals will cause a load of 100% in
>>>> every pstate.
>>>>
>>>> So, change the above method and calculate the next pstate with
>>>> the assumption that the next pstate should not depend on the
>>>> current pstate. The next pstate should only be proportional
>>>> to measured load. Use the linear function to calculate the load:
>>>>
>>>> Next P-state =3D A + B * load
>>>>
>>>> where A =3D min_state and B =3D (max_pstate - min_pstate) / 100
>>>> If turbo is enabled the B =3D (turbo_pstate - min_pstate) / 100
>>>> The load is calculated using the kernel time functions.
>>>>
>>
>> Thank you very much for your comments and for your time to test my p=
atch!
>>
>>
>>>
>>> This will hurt your power numbers under "normal" conditions where y=
ou
>>> are not running a performance workload. Consider the following:
>>>
>>>    1. The system is idle, all core at min P state and utilization i=
s low say < 10%
>>>    2. You run something that drives the load as seen by the kernel =
to 100%
>>>       which scaled by the current P state.
>>>
>>> This would cause the P state to go from min -> max in one step.  Wh=
ich is
>>> what you want if you are only looking at a single core.  But this w=
ill also
>>> drag every core in the package to the max P state as well.  This wo=
uld be fine
>>
>> I think, this will also happen using the original driver (before you=
r
>> new patch 4/5), after some sampling intervals.
>>
>>
>>> if the power vs frequency cure was linear all the cores would finis=
h
>>> their work faster and go idle sooner (race to halt) and maybe spend
>>> more time in a deeper C state which dwarfs the amount of power we c=
an
>>> save by controlling P states. Unfortunately this is *not* the case,=
=20
>>> power vs frequency curve is non-linear and get very steep in the tu=
rbo
>>> range.  If it were linear there would be no reason to have P state
>>> control you could select the highest P state and walk away.
>>>
>>> Being conservative on the way up and aggressive on way down give yo=
u
>>> the best power efficiency on non-benchmark loads.  Most benchmarks
>>> are pretty useless for measuring power efficiency (unless they were
>>> designed for it) since they are measuring how fast something can be
>>> done which is measuring the efficiency at max performance.
>>>
>>> The performance issues you pointed out were caused by commit=20
>>> fcb6a15c intel_pstate: Take core C0 time into account for core busy=
 calculation
>>> and the ensuing problem is caused. These have been fixed in the pat=
ch set
>>>
>>>    https://lkml.org/lkml/2014/5/8/574
>>>
>>> The performance comparison between before/after this patch set, you=
r patch
>>> and ondemand/acpi_cpufreq is available at:
>>>     http://openbenchmarking.org/result/1405085-PL-C0200965993
>>> ffmpeg was added to the set of benchmarks because there was a regre=
ssion
>>> reported against this benchmark as well.
>>>     https://bugzilla.kernel.org/show_bug.cgi?id=3D75121
>>
>> Of course, I agree generally with your comments above. But I believe=
 that
>> the we should scale the core as soon as we measure high load.=20
>>
>> I tested your new patches and I confirm your benchmarks. But I think
>> they are against the above theory (at least on low loads).
>> With the new patches I get increased frequencies even on an idle sys=
tem.
>> Please compare the results below.
>>
>> With your latest patches during a mp3 decoding (a non-benchmark load=
)
>> the energy consumption increased to 5187.52 J from 5036.57 J (almost=
 3%).
>>
>>
>> Thanks again,
>> Stratos
>>
>=20
> I would like to explain a little bit further the logic behind this pa=
tch.
>=20
> The patch is based on the following assumptions (some of them are pre=
tty
> obvious but please let me mention them):
>=20
> 1) We define the load of the CPU as the percentage of sampling period=
 that
> CPU was busy (not idle), as measured by the kernel.
>=20
> 2) It's not possible to predict (with accuracy) the load of a CPU in =
future
> sampling periods.
>=20
> 3) The load in the next sampling interval is most probable to be very
> close to the current sampling interval. (Actually the load in the
> next sampling interval could have any value, 0 - 100).
>=20
> 4) In order to select the next performance state of the CPU we need t=
o
> calculate the load frequently (as fast as hardware permits) and chang=
e
> the next state accordingly.
>=20
> 5) At a given constant 0% (zero) load in a specific period, the CPU
> performance state should be equal to minimum available state.
>=20
> 6) At a given constant 100% load in a specific period, the CPU perfor=
mance
> state should be equal to maximum available state.
>=20
> 7) Ideally, the CPU should execute instructions at maximum performanc=
e state.
>=20
>=20
> According to the above if the measured load in a sampling interval is=
, for
> example 50%, ideally the CPU should spent half of the next sampling p=
eriod
> to maximum pstate and half of the period to minimum pstate. Of course
> it's impossible to increase the sampling frequency so much.
>=20
> Thus, we consider that the best approximation would be:
>=20
> Next performance state =3D min_perf + (max_perf - min_perf) * load / =
100
>=20

Any additional comments?
Should I consider it a rejected approach?


Thanks,
Stratos


