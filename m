From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 17:08:27 +0300
Message-ID: <539862DB.9060905@semaphore.gr>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <009b01cf857a$d5032090$7f0961b0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:60034 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753971AbaFKOIb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 10:08:31 -0400
In-Reply-To: <009b01cf857a$d5032090$7f0961b0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>=20
> On 2014.06.11 05:34 Stratos Karafotis wrote:
>=20
>> Local variable core_pct holds fixed point values.
>> When we round it we add "1" to core_pct. This has almost
>> no effect.
>>
>> So, add int_toftp(1) to core_pct when rounding.
>>
>> For example, in a given sample point (values taken from
>> tracepoint) with:
>> aperf =3D 5024
>> mperf =3D 10619
>>
>> the core_pct is (before rounding):
>> core_pct =3D 12111
>> fp_toint(core_pct) =3D 47
>>
>> After rounding:
>> core_pct =3D 12112
>> fp_toint(core_pct) =3D 47
>>
>> After rounding with int_toftp(1):
>> core_pct =3D 12367
>> fp_toint(core_pct) =3D 48
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>
>> Hi Rafael,
>>
>> I'm sorry for submitting again in merge window, but
>> I thought that maybe we need this fix for 3.16.
>>
>>
>> drivers/cpufreq/intel_pstate.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_=
pstate.c
>> index 4e7f492..dd80aa2 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -564,7 +564,7 @@ static inline void intel_pstate_calc_busy(struct=
 cpudata *cpu)
>> 	core_pct =3D div_u64_rem(core_pct, int_tofp(sample->mperf), &rem);
>>
>> 	if ((rem << 1) >=3D int_tofp(sample->mperf))
>> -		core_pct +=3D 1;
>> +		core_pct +=3D int_tofp(1);
>>
>> 	sample->freq =3D fp_toint(
>> 		mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_pct));
>> --=20
>> 1.9.3
>=20
> No.
>=20
> The intent was only ever to round properly the pseudo floating point =
result of the divide.
> It was much more important (ugh, well 4 times more) when FRACBITS was=
 still 6, which also got changed to 8 in a recent patch.
>=20

Are you sure? This rounding was very recently added.
As far as I can understand, I don't see the meaning of this rounding, a=
s is.
Even if FRAC_BITS was 6, I think it would have almost no improvement in
calculations.


Stratos

