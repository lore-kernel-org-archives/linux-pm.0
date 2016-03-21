From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Mon, 21 Mar 2016 10:28:09 +0100
Message-ID: <94B138B5-2AA0-4756-BF7E-1EA8764860F2@linux.intel.com>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com> <10670722.U2p4NnYGsS@vostro.rjw.lan> <CA+5PVA78uXrqgm5a9h5ytbrd5sun4mVU5+u9V9GnY1V6rizhzg@mail.gmail.com> <6130650.QZM8FIW1Fl@vostro.rjw.lan> <E8E228AA-B140-4C15-8984-EFACDC95FB9F@linux.intel.com> <1458323535.3861.76.camel@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55975 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbcCUJ2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 05:28:14 -0400
In-Reply-To: <1458323535.3861.76.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Josh Boyer <jwboyer@fedoraproject.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>


=E2=80=94
Steph




> On Mar 18, 2016, at 6:52 PM, Srinivas Pandruvada <srinivas.pandruvada=
@linux.intel.com> wrote:
>=20
> On Fri, 2016-03-18 at 17:13 +0100, Stephane Gasparini wrote:
>> Rafael,
>>=20
>> Why in step 3) both atom_set_pstate() and atom_set_pstate() were not
>> both
>> changed to use wrmsrl ?
> Initial Atom support was experimental as there were no users, till
> Chrome started using. So it was just a miss.
>=20
> We should never have to use wrmsrl_on_cpu. But looks like
> cpufreq_driver.init() can't guarantee that.
>=20
>> BTW, what is the interest of setting the pstate to LFM during
>> initialization ?
>> The BIOS is setting the pstate to either LFM, HFM or BFM, and why
>> bothering
>> changing it.
> This is a different issue. BIOS has different configuration option to
> enable fast boot modes which are not necessarily optimized for Linux.
> Some aggressive setting will force system to reboot on boot. So I wil=
l
> leave the way it is.

Here is my understanding.

1) until the driver starts, the CPUS will anyway starts at the P-State =
set by the BIOS.
2) even if you force it to Lowest P-State in init Intel P-State init, i=
f there is load associated
   to the execution, 10ms after (or may be quicker with the new schedul=
er based option) the
   P-State will again set to P0.

so because 1) and 2) you=E2=80=99ll have basically the following behavi=
or assuming we have high load
during boot, as this what can cause a reboot due to high frequencies I =
assume

a) BIOS set LFM
10 ms after init of intel P-State, CPUs will go to Turbo according to l=
oad.

b) BIOS set HFM
CPU will boot to HFM until we reach intel_state init.
During 10ms, CPU will be at LFM.
Due to load they will go up to BFM.

c) BIOS set to BFM.
CPU will boot to BFM until we reach intel_state init.
During 10ms, CPU will be at LFM.
Due to load they will go up to BFM.

So I may have miss something but I do not see what is the real benefit =
of doing this init to LFM=20
that will last for 10ms.

I still think this initialization is useless and complexity the code.

Can you point me to case where having this initialization did solve an =
issue so that I understand=20
the interest of doing this initialization ?

thanks

>=20
> Thanks,
> Srinivas
>=20
>> =20
>> =E2=80=94
>> Steph
>>=20
>>=20
>>=20
>>=20
>>>=20
>>> On Mar 18, 2016, at 3:36 PM, Rafael J. Wysocki <rjw@rjwysocki.net>
>>> wrote:
>>>=20
>>> On Friday, March 18, 2016 08:37:15 AM Josh Boyer wrote:
>>>>=20
>>>> On Thu, Mar 17, 2016 at 8:20 PM, Rafael J. Wysocki <rjw@rjwysocki
>>>> .net> wrote:
>>>>>=20
>>>>> On Thursday, March 17, 2016 12:44:54 PM Josh Boyer wrote:
>>>>>>=20
>>>>>> On Thu, Mar 17, 2016 at 10:07 AM, Rafael J. Wysocki <rjw@rjwy
>>>>>> socki.net> wrote:
>>>>>>>=20
>>>>>>> On Thursday, March 17, 2016 09:02:29 AM Josh Boyer wrote:
>>>>>>>>=20
>>>>>>>> Hello,
>>>>>>> Hi,
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> I have an Intel Atom based NUC that is producing the
>>>>>>>> following
>>>>>>>> backtraces on boot of Linus' tree as of last
>>>>>>>> evening.  This does not
>>>>>>>> happen with a tree with top level commit 271ecc5253e2,
>>>>>>>> but does happen
>>>>>>>> when using the tree mentioned in the subject with top
>>>>>>>> level commit
>>>>>>>> 63e30271b04c.
>>>>>>>>=20
>>>>>>>> The first backtrace appears to be a warning because the
>>>>>>>> intel_pstate
>>>>>>>> driver is calling wrmsrl_on_cpu when interrupts are
>>>>>>>> disabled?  Not
>>>>>>>> sure on that one.
>>>>>>>>=20
>>>>>>>> The second backtrace is a lockdep report.  Both are from
>>>>>>>> the same boot.
>>>>>>> OK, thanks for the report.
>>>>>>>=20
>>>>>>> Can you please try the patch below?
>>>>>>>=20
>>>>>>> I'm actually unsure if we can do that safely in general for
>>>>>>> Atom because
>>>>>>> of the initialization, but that's what Core does anyway.
>>>>>>>=20
>>>>>>> Srinivas, Philippe, why exactly do we need the
>>>>>>> wrmsrl_on_cpu() in
>>>>>>> atom_set_pstate()?  core_set_pstate() uses wrmsrl() and
>>>>>>> seems to be doing fine.
>>>>>>>=20
>>>>>>> ---
>>>>>>> drivers/cpufreq/intel_pstate.c |    2 +-
>>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>=20
>>>>>>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>>>>>>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>>>>>>> @@ -587,7 +587,7 @@ static void atom_set_pstate(struct
>>>>>>> cpuda
>>>>>>>=20
>>>>>>>        val |=3D vid;
>>>>>>>=20
>>>>>>> -       wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL,
>>>>>>> val);
>>>>>>> +       wrmsrl(MSR_IA32_PERF_CTL, val);
>>>>>>> }
>>>>>>>=20
>>>>>>> static int silvermont_get_scaling(void)
>>>>>>>=20
>>>>>> I applied this on top of commit 09fd671ccb24 and the
>>>>>> backtrace and
>>>>>> lockdep report both go away.  So yes, this seems to clear up
>>>>>> the
>>>>>> issue.  I tested it on a variety of different CPU types and
>>>>>> didn't
>>>>>> notice anything wrong on them either.
>>>>> The problems may show up during initialization and cleanup
>>>>> where one CPU
>>>>> may be running code trying to configure a different one.  In
>>>>> those cases
>>>>> wrmsrl_on_cpu() needs to be used.
>>>>>=20
>>>>> Let me cut a patch taking that into account.
>>>> OK.  Happy to test when you have it ready.
>>> Thanks!
>>>=20
>>> Please test the patch below.
>>>=20
>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Subject: [PATCH] intel_pstate: Do not call wrmsrl_on_cpu() with
>>> disabled interrupts
>>>=20
>>> After commit a4675fbc4a7a (cpufreq: intel_pstate: Replace timers
>>> with
>>> utilization update callbacks) wrmsrl_on_cpu() cannot be called in
>>> the
>>> intel_pstate_adjust_busy_pstate() path as that is executed with
>>> disabled interrupts.  However, atom_set_pstate() called from there
>>> via intel_pstate_set_pstate() uses wrmsrl_on_cpu() to update the
>>> IA32_PERF_CTL MSR which triggers the WARN_ON_ONCE() in
>>> smp_call_function_single().
>>>=20
>>> The reason why wrmsrl_on_cpu() is used by atom_set_pstate() is
>>> because intel_pstate_set_pstate() calling it is also invoked during
>>> the initialization and cleanup of the driver and in those cases it
>>> is
>>> not guaranteed to be run on the CPU that is being
>>> updated.  However,
>>> in the case when intel_pstate_set_pstate() is called by
>>> intel_pstate_adjust_busy_pstate(), wrmsrl() can be used to update
>>> the register safely.  Moreover, intel_pstate_set_pstate() already
>>> contains code that only is executed if the function is called by
>>> intel_pstate_adjust_busy_pstate() and there is a special argument
>>> passed to it because of that.
>>>=20
>>> To fix the problem at hand, rearrange the code taking the above
>>> observations into account.
>>>=20
>>> First, replace the ->set() callback in struct pstate_funcs with a
>>> ->get_val() one that will return the value to be written to the
>>> IA32_PERF_CTL MSR without updating the register.
>>>=20
>>> Second, split intel_pstate_set_pstate() into two functions,
>>> intel_pstate_update_pstate() to be called by
>>> intel_pstate_adjust_busy_pstate() that will contain all of the
>>> intel_pstate_set_pstate() code which only needs to be executed in
>>> that case and will use wrmsrl() to update the MSR (after obtaining
>>> the value to write to it from the ->get_val() callback), and
>>> intel_pstate_set_min_pstate() to be invoked during the
>>> initialization and cleanup that will set the P-state to the
>>> minimum one and will update the MSR using wrmsrl_on_cpu().
>>>=20
>>> Finally, move the code shared between intel_pstate_update_pstate()
>>> and intel_pstate_set_min_pstate() to a new static inline function
>>> intel_pstate_record_pstate() and make them both call it.
>>>=20
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Fixes: a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with
>>> utilization update callbacks)
>>> ---
>>> drivers/cpufreq/intel_pstate.c |   73 ++++++++++++++++++++++++-----
>>> ------------
>>> 1 file changed, 43 insertions(+), 30 deletions(-)
>>>=20
>>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>>> @@ -134,7 +134,7 @@ struct pstate_funcs {
>>> 	int (*get_min)(void);
>>> 	int (*get_turbo)(void);
>>> 	int (*get_scaling)(void);
>>> -	void (*set)(struct cpudata*, int pstate);
>>> +	u64 (*get_val)(struct cpudata*, int pstate);
>>> 	void (*get_vid)(struct cpudata *);
>>> 	int32_t (*get_target_pstate)(struct cpudata *);
>>> };
>>> @@ -565,7 +565,7 @@ static int atom_get_turbo_pstate(void)
>>> 	return value & 0x7F;
>>> }
>>>=20
>>> -static void atom_set_pstate(struct cpudata *cpudata, int pstate)
>>> +static u64 atom_get_val(struct cpudata *cpudata, int pstate)
>>> {
>>> 	u64 val;
>>> 	int32_t vid_fp;
>>> @@ -585,9 +585,7 @@ static void atom_set_pstate(struct cpuda
>>> 	if (pstate > cpudata->pstate.max_pstate)
>>> 		vid =3D cpudata->vid.turbo;
>>>=20
>>> -	val |=3D vid;
>>> -
>>> -	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
>>> +	return val | vid;
>>> }
>>>=20
>>> static int silvermont_get_scaling(void)
>>> @@ -711,7 +709,7 @@ static inline int core_get_scaling(void)
>>> 	return 100000;
>>> }
>>>=20
>>> -static void core_set_pstate(struct cpudata *cpudata, int pstate)
>>> +static u64 core_get_val(struct cpudata *cpudata, int pstate)
>>> {
>>> 	u64 val;
>>>=20
>>> @@ -719,7 +717,7 @@ static void core_set_pstate(struct cpuda
>>> 	if (limits->no_turbo && !limits->turbo_disabled)
>>> 		val |=3D (u64)1 << 32;
>>>=20
>>> -	wrmsrl(MSR_IA32_PERF_CTL, val);
>>> +	return val;
>>> }
>>>=20
>>> static int knl_get_turbo_pstate(void)
>>> @@ -750,7 +748,7 @@ static struct cpu_defaults core_params =3D
>>> 		.get_min =3D core_get_min_pstate,
>>> 		.get_turbo =3D core_get_turbo_pstate,
>>> 		.get_scaling =3D core_get_scaling,
>>> -		.set =3D core_set_pstate,
>>> +		.get_val =3D core_get_val,
>>> 		.get_target_pstate =3D get_target_pstate_use_performance,
>>> 	},
>>> };
>>> @@ -769,7 +767,7 @@ static struct cpu_defaults silvermont_pa
>>> 		.get_max_physical =3D atom_get_max_pstate,
>>> 		.get_min =3D atom_get_min_pstate,
>>> 		.get_turbo =3D atom_get_turbo_pstate,
>>> -		.set =3D atom_set_pstate,
>>> +		.get_val =3D atom_get_val,
>>> 		.get_scaling =3D silvermont_get_scaling,
>>> 		.get_vid =3D atom_get_vid,
>>> 		.get_target_pstate =3D get_target_pstate_use_cpu_load,
>>> @@ -790,7 +788,7 @@ static struct cpu_defaults airmont_param
>>> 		.get_max_physical =3D atom_get_max_pstate,
>>> 		.get_min =3D atom_get_min_pstate,
>>> 		.get_turbo =3D atom_get_turbo_pstate,
>>> -		.set =3D atom_set_pstate,
>>> +		.get_val =3D atom_get_val,
>>> 		.get_scaling =3D airmont_get_scaling,
>>> 		.get_vid =3D atom_get_vid,
>>> 		.get_target_pstate =3D get_target_pstate_use_cpu_load,
>>> @@ -812,7 +810,7 @@ static struct cpu_defaults knl_params =3D
>>> 		.get_min =3D core_get_min_pstate,
>>> 		.get_turbo =3D knl_get_turbo_pstate,
>>> 		.get_scaling =3D core_get_scaling,
>>> -		.set =3D core_set_pstate,
>>> +		.get_val =3D core_get_val,
>>> 		.get_target_pstate =3D get_target_pstate_use_performance,
>>> 	},
>>> };
>>> @@ -839,25 +837,24 @@ static void intel_pstate_get_min_max(str
>>> 	*min =3D clamp_t(int, min_perf, cpu->pstate.min_pstate,
>>> max_perf);
>>> }
>>>=20
>>> -static void intel_pstate_set_pstate(struct cpudata *cpu, int
>>> pstate, bool force)
>>> +static inline void intel_pstate_record_pstate(struct cpudata *cpu,
>>> int pstate)
>>> {
>>> -	int max_perf, min_perf;
>>> -
>>> -	if (force) {
>>> -		update_turbo_state();
>>> -
>>> -		intel_pstate_get_min_max(cpu, &min_perf,
>>> &max_perf);
>>> -
>>> -		pstate =3D clamp_t(int, pstate, min_perf, max_perf);
>>> -
>>> -		if (pstate =3D=3D cpu->pstate.current_pstate)
>>> -			return;
>>> -	}
>>> 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
>>> -
>>> 	cpu->pstate.current_pstate =3D pstate;
>>> +}
>>>=20
>>> -	pstate_funcs.set(cpu, pstate);
>>> +static void intel_pstate_set_min_pstate(struct cpudata *cpu)
>>> +{
>>> +	int pstate =3D cpu->pstate.min_pstate;
>>> +
>>> +	intel_pstate_record_pstate(cpu, pstate);
>>> +	/*
>>> +	 * Generally, there is no guarantee that this code will
>>> always run on
>>> +	 * the CPU being updated, so force the register update to
>>> run on the
>>> +	 * right CPU.
>>> +	 */
>>> +	wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
>>> +		      pstate_funcs.get_val(cpu, pstate));
>>> }
>>>=20
>>> static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>>> @@ -870,7 +867,8 @@ static void intel_pstate_get_cpu_pstates
>>>=20
>>> 	if (pstate_funcs.get_vid)
>>> 		pstate_funcs.get_vid(cpu);
>>> -	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate,
>>> false);
>>> +
>>> +	intel_pstate_set_min_pstate(cpu);
>>> }
>>>=20
>>> static inline void intel_pstate_calc_busy(struct cpudata *cpu)
>>> @@ -997,6 +995,21 @@ static inline int32_t get_target_pstate_
>>> 	return cpu->pstate.current_pstate - pid_calc(&cpu->pid,
>>> core_busy);
>>> }
>>>=20
>>> +static inline void intel_pstate_update_pstate(struct cpudata *cpu,
>>> int pstate)
>>> +{
>>> +	int max_perf, min_perf;
>>> +
>>> +	update_turbo_state();
>>> +
>>> +	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
>>> +	pstate =3D clamp_t(int, pstate, min_perf, max_perf);
>>> +	if (pstate =3D=3D cpu->pstate.current_pstate)
>>> +		return;
>>> +
>>> +	intel_pstate_record_pstate(cpu, pstate);
>>> +	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu,
>>> pstate));
>>> +}
>>> +
>>> static inline void intel_pstate_adjust_busy_pstate(struct cpudata
>>> *cpu)
>>> {
>>> 	int from, target_pstate;
>>> @@ -1006,7 +1019,7 @@ static inline void intel_pstate_adjust_b
>>>=20
>>> 	target_pstate =3D pstate_funcs.get_target_pstate(cpu);
>>>=20
>>> -	intel_pstate_set_pstate(cpu, target_pstate, true);
>>> +	intel_pstate_update_pstate(cpu, target_pstate);
>>>=20
>>> 	sample =3D &cpu->sample;
>>> 	trace_pstate_sample(fp_toint(sample->core_pct_busy),
>>> @@ -1180,7 +1193,7 @@ static void intel_pstate_stop_cpu(struct
>>> 	if (hwp_active)
>>> 		return;
>>>=20
>>> -	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate,
>>> false);
>>> +	intel_pstate_set_min_pstate(cpu);
>>> }
>>>=20
>>> static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
>>> @@ -1255,7 +1268,7 @@ static void copy_cpu_funcs(struct pstate
>>> 	pstate_funcs.get_min   =3D funcs->get_min;
>>> 	pstate_funcs.get_turbo =3D funcs->get_turbo;
>>> 	pstate_funcs.get_scaling =3D funcs->get_scaling;
>>> -	pstate_funcs.set       =3D funcs->set;
>>> +	pstate_funcs.get_val   =3D funcs->get_val;
>>> 	pstate_funcs.get_vid   =3D funcs->get_vid;
>>> 	pstate_funcs.get_target_pstate =3D funcs->get_target_pstate;
>>>=20
>>>=20
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pm"=
=20
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

