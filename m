From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 2/7] cpufreq: intel_pstate: Avoid duplicate call of intel_pstate_get_scaled_busy
Date: Tue, 10 Jun 2014 19:26:57 +0300
Message-ID: <539731D1.6040504@semaphore.gr>
References: <53962067.4060504@semaphore.gr> <53972CE1.1060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:57421 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751063AbaFJQ1A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 12:27:00 -0400
In-Reply-To: <53972CE1.1060209@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 10/06/2014 07:05 =CE=BC=CE=BC, Dirk Brandewie wrote:
> On 06/09/2014 02:00 PM, Stratos Karafotis wrote:
>> Store busy_scaled value to avoid to duplicate call of
>> intel_pstate_get_scaled_busy on every sampling interval.
>>
>=20
> The second call *only* happens if the tracepoint is being used otherw=
ise
> the whole function call to  trace_pstate_sample() is a noop.

Yes, I'm sorry, I forgot to add this in my changelog. I have written th=
is
in cover letter.
I made this change mostly to support patch 3/7.

> This makes the code less readable IMHO the reader is left wondering
> how cpu->sample.busy_scaled was set in intel_pstate_adjust_busy_pstat=
e()
>=20

I agree that the the original code is more readable. If we don't care
about the small overhead when tracing is on and forget patch 3/7,
of course the original code is by far better.


>> Also, rename the function to intel_pstate_calc_scaled_busy.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>   drivers/cpufreq/intel_pstate.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_=
pstate.c
>> index 4e7f492..31e2ae5 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -55,6 +55,7 @@ static inline int32_t div_fp(int32_t x, int32_t y)
>>
>>   struct sample {
>>       int32_t core_pct_busy;
>> +    int32_t busy_scaled;
>>       u64 aperf;
>>       u64 mperf;
>>       int freq;
>> @@ -604,7 +605,7 @@ static inline void intel_pstate_set_sample_time(=
struct cpudata *cpu)
>>       mod_timer_pinned(&cpu->timer, jiffies + delay);
>>   }
>>
>> -static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *=
cpu)
>> +static inline void intel_pstate_calc_scaled_busy(struct cpudata *cp=
u)
>>   {
>>       int32_t core_busy, max_pstate, current_pstate, sample_ratio;
>>       u32 duration_us;
>> @@ -624,20 +625,19 @@ static inline int32_t intel_pstate_get_scaled_=
busy(struct cpudata *cpu)
>>           core_busy =3D mul_fp(core_busy, sample_ratio);
>>       }
>>
>> -    return core_busy;
>> +    cpu->sample.busy_scaled =3D core_busy;
>>   }
>>
>>   static inline void intel_pstate_adjust_busy_pstate(struct cpudata =
*cpu)
>>   {
>> -    int32_t busy_scaled;
>>       struct _pid *pid;
>>       signed int ctl =3D 0;
>>       int steps;
>>
>>       pid =3D &cpu->pid;
>> -    busy_scaled =3D intel_pstate_get_scaled_busy(cpu);
>> +    intel_pstate_calc_scaled_busy(cpu);
>>
>> -    ctl =3D pid_calc(pid, busy_scaled);
>> +    ctl =3D pid_calc(pid, cpu->sample.busy_scaled);
>>
>>       steps =3D abs(ctl);
>>
>> @@ -659,7 +659,7 @@ static void intel_pstate_timer_func(unsigned lon=
g __data)
>>       intel_pstate_adjust_busy_pstate(cpu);
>>
>>       trace_pstate_sample(fp_toint(sample->core_pct_busy),
>> -            fp_toint(intel_pstate_get_scaled_busy(cpu)),
>> +            fp_toint(sample->busy_scaled),
>>               cpu->pstate.current_pstate,
>>               sample->mperf,
>>               sample->aperf,
>>
>=20
>=20

