From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 4/7] cpufreq: intel_pstate: Simplify code in intel_pstate_adjust_busy_pstate
Date: Tue, 10 Jun 2014 17:51:58 +0300
Message-ID: <53971B8E.4040302@semaphore.gr>
References: <5396207D.7030704@semaphore.gr> <CAKohpokYB4oKxrEwHH888T5hg=zrpb0PCs_QKTLS0bd-_fqeTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:57279 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750777AbaFJOwB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 10:52:01 -0400
In-Reply-To: <CAKohpokYB4oKxrEwHH888T5hg=zrpb0PCs_QKTLS0bd-_fqeTA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 10/06/2014 08:27 =CF=80=CE=BC, Viresh Kumar wrote:
> On 10 June 2014 02:30, Stratos Karafotis <stratosk@semaphore.gr> wrot=
e:
>> Simplify the code by removing the inline functions
>> pstate_increase and pstate_decrease and use directly the
>> intel_pstate_set_pstate.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>  drivers/cpufreq/intel_pstate.c | 26 +++-----------------------
>>  1 file changed, 3 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_=
pstate.c
>> index 3a49269..26a0262 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -588,21 +588,6 @@ static void intel_pstate_set_pstate(struct cpud=
ata *cpu, int pstate)
>>         pstate_funcs.set(cpu, pstate);
>>  }
>>
>> -static inline void intel_pstate_pstate_increase(struct cpudata *cpu=
, int steps)
>> -{
>> -       int target;
>> -       target =3D cpu->pstate.current_pstate + steps;
>> -
>> -       intel_pstate_set_pstate(cpu, target);
>> -}
>> -
>> -static inline void intel_pstate_pstate_decrease(struct cpudata *cpu=
, int steps)
>> -{
>> -       int target;
>> -       target =3D cpu->pstate.current_pstate - steps;
>> -       intel_pstate_set_pstate(cpu, target);
>> -}
>> -
>>  static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>>  {
>>         cpu->pstate.min_pstate =3D pstate_funcs.get_min();
>> @@ -695,20 +680,15 @@ static inline void intel_pstate_calc_scaled_bu=
sy(struct cpudata *cpu)
>>  static inline void intel_pstate_adjust_busy_pstate(struct cpudata *=
cpu)
>>  {
>>         struct _pid *pid;
>> -       signed int ctl =3D 0;
>> -       int steps;
>> +       signed int ctl;
>>
>>         pid =3D &cpu->pid;
>>         intel_pstate_calc_scaled_busy(cpu);
>>
>>         ctl =3D pid_calc(pid, cpu->sample.busy_scaled);
>>
>> -       steps =3D abs(ctl);
>> -
>> -       if (ctl < 0)
>> -               intel_pstate_pstate_increase(cpu, steps);
>> -       else
>> -               intel_pstate_pstate_decrease(cpu, steps);
>> +       /* Negative values of ctl increase the pstate and vice versa=
 */
>> +       intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ct=
l);
>>  }
>=20
> I am not very good at this driver but there is some obvious functiona=
l
> change here. Earlier we used to pass
> 'cpu->pstate.current_pstate {-|+} steps' and now you are doing '-ctl'=
 only
>=20

The original code is:=09

	if (ctl < 0)
		intel_pstate_pstate_increase(cpu, steps);
	else
		intel_pstate_pstate_decrease(cpu, steps);
	=09
Without inlines functions intel_pstate_pstate_increase() and
intel_pstate_pstate_decrease() we get:

	if (ctl < 0)
		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate + steps);
	else
		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - steps);

=09
But steps =3D abs(ctl), so:

	if (ctl < 0)
		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate + abs(ctl));
	else
		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - abs(ctl));
=09
By definition, abs(ctl) =3D ctl if ctl >=3D 0, -ctl if ctl < 0. Thus:

	if (ctl < 0)
		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate + (-ctl));
	else
		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);

And:
	if (ctl < 0)
		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
	else
		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);

=46inally remove the unnecessary if statement.	=09
	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);

So, this is equivalent with the original code.

Thanks,
Stratos
