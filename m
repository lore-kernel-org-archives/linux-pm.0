From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Change the calculation of next
 pstate
Date: Fri, 02 May 2014 16:45:27 +0300
Message-ID: <5363A177.7010302@semaphore.gr>
References: <5362B5F5.1020706@semaphore.gr> <21200760.cENPVVrS5i@vostro.rjw.lan> <5362F958.6000807@gmail.com> <7610386.oS78YEZMBm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <7610386.oS78YEZMBm@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/05/2014 03:26 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
> On Thursday, May 01, 2014 06:48:08 PM Dirk Brandewie wrote:
>> On 05/01/2014 04:18 PM, Rafael J. Wysocki wrote:
>>> On Thursday, May 01, 2014 02:30:42 PM Dirk Brandewie wrote:
>>>> On 05/01/2014 02:00 PM, Stratos Karafotis wrote:
>>>>> Currently the driver calculates the next pstate proportional to
>>>>> core_busy factor, scaled by the ratio max_pstate / current_pstate=
=2E
>>>>>
>>>>> Using the scaled load (core_busy) to calculate the next pstate
>>>>> is not always correct, because there are cases that the load is
>>>>> independent from current pstate. For example, a tight 'for' loop
>>>>> through many sampling intervals will cause a load of 100% in
>>>>> every pstate.
>>>>>
>>>>> So, change the above method and calculate the next pstate with
>>>>> the assumption that the next pstate should not depend on the
>>>>> current pstate. The next pstate should only be directly
>>>>> proportional to measured load.
>>>>>
>>>>> Tested on Intel i7-3770 CPU @ 3.40GHz.
>>>>> Phoronix benchmark of Linux Kernel Compilation 3.1 test shows an
>>>>> increase ~1.5% in performance. Below the test results using turbo=
stat
>>>>> (5 iterations):
>>>>>
>>>>> Without patch:
>>>>>
>>>>> Ph. avg Time	Total time	PkgWatt		Total Energy
>>>>> 	79.63	266.416		57.74		15382.85984
>>>>> 	79.63	265.609		57.87		15370.79283
>>>>> 	79.57	266.994		57.54		15362.83476
>>>>> 	79.53	265.304		57.83		15342.53032
>>>>> 	79.71	265.977		57.76		15362.83152
>>>>> avg	79.61	266.06		57.74		15364.36985
>>>>>
>>>>> With patch:
>>>>>
>>>>> Ph. avg Time	Total time	PkgWatt		Total Energy
>>>>> 	78.23	258.826		59.14		15306.96964
>>>>> 	78.41	259.110		59.15		15326.35650
>>>>> 	78.40	258.530		59.26		15320.48780
>>>>> 	78.46	258.673		59.20		15313.44160
>>>>> 	78.19	259.075		59.16		15326.87700
>>>>> avg	78.34	258.842		59.18		15318.82650
>>>>>
>>>>> The total test time reduced by ~2.6%, while the total energy
>>>>> consumption during a test iteration reduced by ~0.35%
>>>>>
>>>>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>>>>> ---
>>>>>
>>>>> Changes v1 -> v2
>>>>> 	- Enhance change log as Rafael and Viresh suggested
>>>>>
>>>>>
>>>>>    drivers/cpufreq/intel_pstate.c | 15 +++++++--------
>>>>>    1 file changed, 7 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/int=
el_pstate.c
>>>>> index 0999673..8e309db 100644
>>>>> --- a/drivers/cpufreq/intel_pstate.c
>>>>> +++ b/drivers/cpufreq/intel_pstate.c
>>>>> @@ -608,28 +608,27 @@ static inline void intel_pstate_set_sample_=
time(struct cpudata *cpu)
>>>>>    	mod_timer_pinned(&cpu->timer, jiffies + delay);
>>>>>    }
>>>>>
>>>>> -static inline int32_t intel_pstate_get_scaled_busy(struct cpudat=
a *cpu)
>>>>> +static inline int32_t intel_pstate_get_busy(struct cpudata *cpu)
>>>>>    {
>>>>> -	int32_t core_busy, max_pstate, current_pstate;
>>>>> +	int32_t core_busy, max_pstate;
>>>>>
>>>>>    	core_busy =3D cpu->sample.core_pct_busy;
>>>>>    	max_pstate =3D int_tofp(cpu->pstate.max_pstate);
>>>>> -	current_pstate =3D int_tofp(cpu->pstate.current_pstate);
>>>>> -	core_busy =3D mul_fp(core_busy, div_fp(max_pstate, current_psta=
te));
>>>>> +	core_busy =3D mul_fp(core_busy, max_pstate);
>>>>
>>>> NAK,  The goal of this code is to find out how busy the core is at=
 the current
>>>> P state. This change will return a value WAY too high.
>>>>
>>>> Assume core_busy is 100 and the max non-turbo P state is 34 (3.4GH=
z) this code
>>>> would return a busy value of 3400. The PID  is trying to keep the =
busy value
>>>> at the setpoint any value of ~3% will drive the P state to the hig=
hest turbo
>>>> P state in this example.
>>>
>>> Well, the problem is that the numbers above indicate an improvement=
 in energy
>>> efficiency as a result of this patch and we need to explain that re=
sult.
>>>
>> The performance governor is the best option for this workload.
>>
>> This change will give you the highest trubo for all but very idle wo=
rk loads.
>=20
> I see.
>=20
>> Lets say you have a processor with max P state of 3.4GHz  The curren=
t P state
>> is 1.6 GHz so if the processor was 100% in C0 the core_busy values w=
ould be
>> 47% This number scaled would be 100%.  With the change above the PID=
 would be
>> reacting to a load of 1598%.  APERF/MPERF give you the percent of en=
tire
>> core scaling it lets you find out how busy your are within the curee=
nt P state.
>=20
> OK
>=20
> Stratos seems to be arguing that we can achieve better results, in th=
erms of
> both performance and energy efficiency, if we disregard the history a=
nd only
> take the current situation into account.  The patch itself may not be=
 correct,
> but the idea is worth consideration in my opinion, especially in the =
face
> of the fact that we made a similar change in cpufreq and the results =
improved.
>=20
>=20

=46irst of all, thank you very much all of you for your time reviewing =
this patch and
for your help!

With the hope that I will not waste more your time, I will try to imple=
ment
correctly this assumption, and test it.

My first thought, after Dirk's explanation, is to try to fix the logic =
in the patch
using the c0_pct as the core_pct_busy in the intel_pstate_calc_busy fun=
ction. Thus:

-        sample->core_pct_busy =3D mul_fp(core_pct, c0_pct);
+	 sample->core_pct_busy =3D c0_pct;

But, I'm not sure if c0_pct is (always) equivalent to CPU load.
Otherwise, I will try to get the absolute load using the get_cpu_idle_t=
ime_us and
calculate the next pstate directly proportional to this load.


Thanks,
Stratos
