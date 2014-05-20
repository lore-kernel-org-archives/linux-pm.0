From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [query] cpufreq: intel_pstate: diverge of current_pstate and
 actual P state
Date: Wed, 21 May 2014 00:59:52 +0300
Message-ID: <537BD058.9070609@semaphore.gr>
References: <537BC4E8.60500@semaphore.gr> <537BC9C2.6030801@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:59591 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750766AbaETV7z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 17:59:55 -0400
In-Reply-To: <537BC9C2.6030801@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: dirk.j.brandewie@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 21/05/2014 12:31 =CF=80=CE=BC, Dirk Brandewie wrote:
> On 05/20/2014 02:11 PM, Stratos Karafotis wrote:
>> Hi all,
>>
>> Currently, we use the current P state to calculate the busy_scaled f=
actor
>> and then the next P state.
>>
>> We also read the MSR_TURBO_RATIO_LIMIT to get the turbo ratio limit =
as the
>> turbo_pstate. But, we always read bits 7:0 ("Maximum turbo ratio lim=
it of 1
>> core active").
>>
>> So, in processor families that have different turbo ratio limit
>> depending on active cores the current P state as it's considered
>> by the driver might be different from the actual current P state.
>>
>> For example, I use an i7-3770 which reports as maximum turbo ratio l=
imits
>> with 1/2/3/4 actives cores the values 39/39/38/37. So, in some cases
>> we will calculate as the next P state the value 39. If the active co=
res
>> at that time was 3 or 4 the actual P state will be 38 or 37.
>> The current_pstate variable will have the value 39 and this will lea=
d
>> to wrong calculation at the next sampling interval.
>>
>> Trying to find a solution to the above I couldn't find an MSR that
>> we could use to get the number of active cores and use the respectiv=
e
>> turbo ratio limit.
>>
>> I also thought to use the IA32_PERF_STATUS to get the current P stat=
e
>> and use it in the calculations, but its scope is per core and not pe=
r
>> thread.
>>
>> Am I missing something? If the above is correct, any idea how this
>> could be resolved?
>=20
> The above is correct except the requested pstate is calculated using
> max_pstate and turbo_pstate is used as the upper limit when calling
> intel_pstate_set_pstate.

Thanks for your prompt reply!

But when we call intel_pstate_set_pstate we also set the current_pstate
to the requested pstate (which it may be, for example, 39).

>=20
> The value written to (MSR_IA32_PPERF_CTL is a request that is process=
ed by the
> CPU and is clipped internally to the current state of the CPU.  Wheth=
er or
> not any turbo is available is decided by the CPU asking for the top
> turbo bin says give me all that is available.
>=20
> Asking for more than the CPU has to give ATM is harmless.

Then the CPU clips internally, as you said, to the current actual state=
=2E
If all cores are active the current state (in CPU) will be 37.
Driver will still consider the current_pstate as 39.

In next sampling interval, in intel_pstate_get_scaled_busy we calculate
the core_busy as core_busy * max_pstate / current_pstate.

So, in the above example we have:
core_busy =3D core_busy * 34 / 39
and not
core_busy =3D core_busy * 34 / 37
as it should be.


Stratos
