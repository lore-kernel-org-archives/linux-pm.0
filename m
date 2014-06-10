From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 4/7] cpufreq: intel_pstate: Simplify code in intel_pstate_adjust_busy_pstate
Date: Tue, 10 Jun 2014 10:07:51 -0700
Message-ID: <53973B67.5020802@gmail.com>
References: <5396207D.7030704@semaphore.gr> <CAKohpokYB4oKxrEwHH888T5hg=zrpb0PCs_QKTLS0bd-_fqeTA@mail.gmail.com> <53971B8E.4040302@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35665 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbaFJRHx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 13:07:53 -0400
In-Reply-To: <53971B8E.4040302@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: dirk.brandewie@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 06/10/2014 07:51 AM, Stratos Karafotis wrote:
> On 10/06/2014 08:27 =CF=80=CE=BC, Viresh Kumar wrote:
>> On 10 June 2014 02:30, Stratos Karafotis <stratosk@semaphore.gr> wro=
te:
>>> Simplify the code by removing the inline functions
>>> pstate_increase and pstate_decrease and use directly the
>>> intel_pstate_set_pstate.
>>>

Doesn't apply without your scaled_busy change spin this patch with
out the scaled_busy change and explain the change more fully in the
commit message to cover Viresh's question and I am good with this chang=
e.


>>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>>> ---
>>>   drivers/cpufreq/intel_pstate.c | 26 +++-----------------------
>>>   1 file changed, 3 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel=
_pstate.c
>>> index 3a49269..26a0262 100644
>>> --- a/drivers/cpufreq/intel_pstate.c
>>> +++ b/drivers/cpufreq/intel_pstate.c
>>> @@ -588,21 +588,6 @@ static void intel_pstate_set_pstate(struct cpu=
data *cpu, int pstate)
>>>          pstate_funcs.set(cpu, pstate);
>>>   }
>>>
>>> -static inline void intel_pstate_pstate_increase(struct cpudata *cp=
u, int steps)
>>> -{
>>> -       int target;
>>> -       target =3D cpu->pstate.current_pstate + steps;
>>> -
>>> -       intel_pstate_set_pstate(cpu, target);
>>> -}
>>> -
>>> -static inline void intel_pstate_pstate_decrease(struct cpudata *cp=
u, int steps)
>>> -{
>>> -       int target;
>>> -       target =3D cpu->pstate.current_pstate - steps;
>>> -       intel_pstate_set_pstate(cpu, target);
>>> -}
>>> -
>>>   static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>>>   {
>>>          cpu->pstate.min_pstate =3D pstate_funcs.get_min();
>>> @@ -695,20 +680,15 @@ static inline void intel_pstate_calc_scaled_b=
usy(struct cpudata *cpu)
>>>   static inline void intel_pstate_adjust_busy_pstate(struct cpudata=
 *cpu)
>>>   {
>>>          struct _pid *pid;
>>> -       signed int ctl =3D 0;
>>> -       int steps;
>>> +       signed int ctl;
>>>
>>>          pid =3D &cpu->pid;
>>>          intel_pstate_calc_scaled_busy(cpu);
>>>
>>>          ctl =3D pid_calc(pid, cpu->sample.busy_scaled);
>>>
>>> -       steps =3D abs(ctl);
>>> -
>>> -       if (ctl < 0)
>>> -               intel_pstate_pstate_increase(cpu, steps);
>>> -       else
>>> -               intel_pstate_pstate_decrease(cpu, steps);
>>> +       /* Negative values of ctl increase the pstate and vice vers=
a */
>>> +       intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - c=
tl);
>>>   }
>>
>> I am not very good at this driver but there is some obvious function=
al
>> change here. Earlier we used to pass
>> 'cpu->pstate.current_pstate {-|+} steps' and now you are doing '-ctl=
' only
>>
>
> The original code is:=09
>
> 	if (ctl < 0)
> 		intel_pstate_pstate_increase(cpu, steps);
> 	else
> 		intel_pstate_pstate_decrease(cpu, steps);
> 	=09
> Without inlines functions intel_pstate_pstate_increase() and
> intel_pstate_pstate_decrease() we get:
>
> 	if (ctl < 0)
> 		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate + steps);
> 	else
> 		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - steps);
>
> =09
> But steps =3D abs(ctl), so:
>
> 	if (ctl < 0)
> 		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate + abs(ctl))=
;
> 	else
> 		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - abs(ctl))=
;
> =09
> By definition, abs(ctl) =3D ctl if ctl >=3D 0, -ctl if ctl < 0. Thus:
>
> 	if (ctl < 0)
> 		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate + (-ctl));
> 	else
> 		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
>
> And:
> 	if (ctl < 0)
> 		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
> 	else
> 		intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
>
> Finally remove the unnecessary if statement.	=09
> 	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
>
> So, this is equivalent with the original code.
>
> Thanks,
> Stratos
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

