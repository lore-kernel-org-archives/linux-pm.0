From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [query] cpufreq: intel_pstate: diverge of current_pstate and
 actual P state
Date: Wed, 21 May 2014 20:22:02 +0300
Message-ID: <537CE0BA.4020105@semaphore.gr>
References: <537BC4E8.60500@semaphore.gr> <537BC9C2.6030801@intel.com> <537BD058.9070609@semaphore.gr> <537BDEE4.7080107@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:33303 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944AbaEURWH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 13:22:07 -0400
In-Reply-To: <537BDEE4.7080107@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: dirk.j.brandewie@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 21/05/2014 02:01 =CF=80=CE=BC, Dirk Brandewie wrote:
> On 05/20/2014 02:59 PM, Stratos Karafotis wrote:
>> On 21/05/2014 12:31 =CF=80=CE=BC, Dirk Brandewie wrote:
>>> On 05/20/2014 02:11 PM, Stratos Karafotis wrote:
>>>> Hi all,
>>>>
>>>> Currently, we use the current P state to calculate the busy_scaled=
 factor
>>>> and then the next P state.
>>>>
>>>> We also read the MSR_TURBO_RATIO_LIMIT to get the turbo ratio limi=
t as the
>>>> turbo_pstate. But, we always read bits 7:0 ("Maximum turbo ratio l=
imit of 1
>>>> core active").
>>>>
>>>> So, in processor families that have different turbo ratio limit
>>>> depending on active cores the current P state as it's considered
>>>> by the driver might be different from the actual current P state.
>>>>
>>>> For example, I use an i7-3770 which reports as maximum turbo ratio=
 limits
>>>> with 1/2/3/4 actives cores the values 39/39/38/37. So, in some cas=
es
>>>> we will calculate as the next P state the value 39. If the active =
cores
>>>> at that time was 3 or 4 the actual P state will be 38 or 37.
>>>> The current_pstate variable will have the value 39 and this will l=
ead
>>>> to wrong calculation at the next sampling interval.
>>>>
>>>> Trying to find a solution to the above I couldn't find an MSR that
>>>> we could use to get the number of active cores and use the respect=
ive
>>>> turbo ratio limit.
>>>>
>>>> I also thought to use the IA32_PERF_STATUS to get the current P st=
ate
>>>> and use it in the calculations, but its scope is per core and not =
per
>>>> thread.
>>>>
>>>> Am I missing something? If the above is correct, any idea how this
>>>> could be resolved?
>>>
>>> The above is correct except the requested pstate is calculated usin=
g
>>> max_pstate and turbo_pstate is used as the upper limit when calling
>>> intel_pstate_set_pstate.
>>
>> Thanks for your prompt reply!
>>
>> But when we call intel_pstate_set_pstate we also set the current_pst=
ate
>> to the requested pstate (which it may be, for example, 39).
>>
>>>
>>> The value written to (MSR_IA32_PPERF_CTL is a request that is proce=
ssed by the
>>> CPU and is clipped internally to the current state of the CPU.  Whe=
ther or
>>> not any turbo is available is decided by the CPU asking for the top
>>> turbo bin says give me all that is available.
>>>
>>> Asking for more than the CPU has to give ATM is harmless.
>>
>> Then the CPU clips internally, as you said, to the current actual st=
ate.
>> If all cores are active the current state (in CPU) will be 37.
>> Driver will still consider the current_pstate as 39.
>>
>> In next sampling interval, in intel_pstate_get_scaled_busy we calcul=
ate
>> the core_busy as core_busy * max_pstate / current_pstate.
>>
>> So, in the above example we have:
>> core_busy =3D core_busy * 34 / 39
>> and not
>> core_busy =3D core_busy * 34 / 37
>> as it should be.
>=20
> Yes and I know of no good way around it. In practice I haven't seen t=
he
> oscillation in the upper turbo range (which is what this may cause).
> Do you have a workload where this is hurting performance?
>=20
> Keep in mind you may have gotten 3.8385 Ghz or any value in the turbo
> range based on the state of the processor.  The processor updates the
> effective frequency a lot faster than we sample.

I guess, there will be no problem if all cores are full busy, because t=
he
CPU internally will go to P state 37.

But if, later, the load decrease and the CPU is for example 50% busy, w=
e
will carry this error in calculations because:

target =3D cpu->pstate.current_pstate +/- steps

The error will be vanished after some intervals (if we ask for a min P
state, for example, and the load is actually minimum). But the
above error will be introduced once in a while.


Stratos
