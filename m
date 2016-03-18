From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Fri, 18 Mar 2016 17:13:41 +0100
Message-ID: <E8E228AA-B140-4C15-8984-EFACDC95FB9F@linux.intel.com>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com> <10670722.U2p4NnYGsS@vostro.rjw.lan> <CA+5PVA78uXrqgm5a9h5ytbrd5sun4mVU5+u9V9GnY1V6rizhzg@mail.gmail.com> <6130650.QZM8FIW1Fl@vostro.rjw.lan>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8779 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbcCRQNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 12:13:48 -0400
In-Reply-To: <6130650.QZM8FIW1Fl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

Rafael,

Something still obscure to me

1)
on commit 303ae7230751

core were using wrmsrl_on_cpu() in core_set_pstate()
atom were using wrmsrl() in byt_set_pstate()

call sequence is=20


intel_state_init_cpu
 -> intel_pstate_get_cpu_pstates()=20
   -> intel_pstate_set_pstate()
     -> pstate_funcs.set() +- byt_set_pstate()
                           +- core_set_pstate()=20

2)
commit 0dd23f94251f aligned both core and atom=20
so both used wrmsrl_on_cpu() in core_set_state() and byt_set_pstate()

Which means that during the init we are sure to always use wrmsrl_on_cp=
u()
on both atom and core.

The comment on this commit is not that precise, but we can guess that t=
his=20
issue solve here was happening during suspend_resume path that is off l=
ining
on lining cpus (which happen a lot on Tablets and phone).

3)
at part of commit a4675fbc4a7a
the code of core_set_state  was changed to use wrmsrl instead=20
of wrmsrl_on_cpu()
while the code of atom_set_pstate() (formerly byt_set_pstate() ) was ke=
pt
unchanged.


Why in step 3) both atom_set_pstate() and atom_set_pstate() were not bo=
th
changed to use wrmsrl ?
If it was OK to use wrmsrl on core, why it would not OK on atom ?

I assume that due to 0dd23f94251f commit, it was felt that the initiali=
zation=20
issue as only been seen on BYT but this is not true as in step 1) core =
was=20
already using wmsrl_on_cpu() vs byt that was using wrmsrl()

So either as part of commit a4675fbc4a7a both, core and atom should hav=
e kept=20
using wrmsrl_on_cpu() or both should have been changed to use wrmsrl().

I still don=E2=80=99t see why atom would behave differently than core h=
ere.

If we go for using wmsrml only then reverting commit 0dd23f94251f is su=
fficient
compare to the patch you are proposing here.

If we agree that during initialization we need to use wrmsrl_on_cpu(), =
I would
change only the initialization on both core and atom.

BTW, what is the interest of setting the pstate to LFM during initializ=
ation ?
The BIOS is setting the pstate to either LFM, HFM or BFM, and why bothe=
ring
changing it.

Not setting the pstate at initialization will simply make the intel_sta=
te
starts from BIOS setting and will avoid all this complexity, i.e. calli=
ng
wrmsrl() in intel_pstate_set_pstate() and not calling it during init ph=
ase that
are prone to exhibit the issue.
=20
=E2=80=94
Steph




> On Mar 18, 2016, at 3:36 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wr=
ote:
>=20
> On Friday, March 18, 2016 08:37:15 AM Josh Boyer wrote:
>> On Thu, Mar 17, 2016 at 8:20 PM, Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>>> On Thursday, March 17, 2016 12:44:54 PM Josh Boyer wrote:
>>>> On Thu, Mar 17, 2016 at 10:07 AM, Rafael J. Wysocki <rjw@rjwysocki=
=2Enet> wrote:
>>>>> On Thursday, March 17, 2016 09:02:29 AM Josh Boyer wrote:
>>>>>> Hello,
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>>> I have an Intel Atom based NUC that is producing the following
>>>>>> backtraces on boot of Linus' tree as of last evening.  This does=
 not
>>>>>> happen with a tree with top level commit 271ecc5253e2, but does =
happen
>>>>>> when using the tree mentioned in the subject with top level comm=
it
>>>>>> 63e30271b04c.
>>>>>>=20
>>>>>> The first backtrace appears to be a warning because the intel_ps=
tate
>>>>>> driver is calling wrmsrl_on_cpu when interrupts are disabled?  N=
ot
>>>>>> sure on that one.
>>>>>>=20
>>>>>> The second backtrace is a lockdep report.  Both are from the sam=
e boot.
>>>>>=20
>>>>> OK, thanks for the report.
>>>>>=20
>>>>> Can you please try the patch below?
>>>>>=20
>>>>> I'm actually unsure if we can do that safely in general for Atom =
because
>>>>> of the initialization, but that's what Core does anyway.
>>>>>=20
>>>>> Srinivas, Philippe, why exactly do we need the wrmsrl_on_cpu() in
>>>>> atom_set_pstate()?  core_set_pstate() uses wrmsrl() and seems to =
be doing fine.
>>>>>=20
>>>>> ---
>>>>> drivers/cpufreq/intel_pstate.c |    2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>=20
>>>>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>>>>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>>>>> @@ -587,7 +587,7 @@ static void atom_set_pstate(struct cpuda
>>>>>=20
>>>>>        val |=3D vid;
>>>>>=20
>>>>> -       wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
>>>>> +       wrmsrl(MSR_IA32_PERF_CTL, val);
>>>>> }
>>>>>=20
>>>>> static int silvermont_get_scaling(void)
>>>>>=20
>>>>=20
>>>> I applied this on top of commit 09fd671ccb24 and the backtrace and
>>>> lockdep report both go away.  So yes, this seems to clear up the
>>>> issue.  I tested it on a variety of different CPU types and didn't
>>>> notice anything wrong on them either.
>>>=20
>>> The problems may show up during initialization and cleanup where on=
e CPU
>>> may be running code trying to configure a different one.  In those =
cases
>>> wrmsrl_on_cpu() needs to be used.
>>>=20
>>> Let me cut a patch taking that into account.
>>=20
>> OK.  Happy to test when you have it ready.
>=20
> Thanks!
>=20
> Please test the patch below.
>=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] intel_pstate: Do not call wrmsrl_on_cpu() with disab=
led interrupts
>=20
> After commit a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with
> utilization update callbacks) wrmsrl_on_cpu() cannot be called in the
> intel_pstate_adjust_busy_pstate() path as that is executed with
> disabled interrupts.  However, atom_set_pstate() called from there
> via intel_pstate_set_pstate() uses wrmsrl_on_cpu() to update the
> IA32_PERF_CTL MSR which triggers the WARN_ON_ONCE() in
> smp_call_function_single().
>=20
> The reason why wrmsrl_on_cpu() is used by atom_set_pstate() is
> because intel_pstate_set_pstate() calling it is also invoked during
> the initialization and cleanup of the driver and in those cases it is
> not guaranteed to be run on the CPU that is being updated.  However,
> in the case when intel_pstate_set_pstate() is called by
> intel_pstate_adjust_busy_pstate(), wrmsrl() can be used to update
> the register safely.  Moreover, intel_pstate_set_pstate() already
> contains code that only is executed if the function is called by
> intel_pstate_adjust_busy_pstate() and there is a special argument
> passed to it because of that.
>=20
> To fix the problem at hand, rearrange the code taking the above
> observations into account.
>=20
> First, replace the ->set() callback in struct pstate_funcs with a
> ->get_val() one that will return the value to be written to the
> IA32_PERF_CTL MSR without updating the register.
>=20
> Second, split intel_pstate_set_pstate() into two functions,
> intel_pstate_update_pstate() to be called by
> intel_pstate_adjust_busy_pstate() that will contain all of the
> intel_pstate_set_pstate() code which only needs to be executed in
> that case and will use wrmsrl() to update the MSR (after obtaining
> the value to write to it from the ->get_val() callback), and
> intel_pstate_set_min_pstate() to be invoked during the
> initialization and cleanup that will set the P-state to the
> minimum one and will update the MSR using wrmsrl_on_cpu().
>=20
> Finally, move the code shared between intel_pstate_update_pstate()
> and intel_pstate_set_min_pstate() to a new static inline function
> intel_pstate_record_pstate() and make them both call it.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Fixes: a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with utili=
zation update callbacks)
> ---
> drivers/cpufreq/intel_pstate.c |   73 ++++++++++++++++++++++++-------=
----------
> 1 file changed, 43 insertions(+), 30 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -134,7 +134,7 @@ struct pstate_funcs {
> 	int (*get_min)(void);
> 	int (*get_turbo)(void);
> 	int (*get_scaling)(void);
> -	void (*set)(struct cpudata*, int pstate);
> +	u64 (*get_val)(struct cpudata*, int pstate);
> 	void (*get_vid)(struct cpudata *);
> 	int32_t (*get_target_pstate)(struct cpudata *);
> };
> @@ -565,7 +565,7 @@ static int atom_get_turbo_pstate(void)
> 	return value & 0x7F;
> }
>=20
> -static void atom_set_pstate(struct cpudata *cpudata, int pstate)
> +static u64 atom_get_val(struct cpudata *cpudata, int pstate)
> {
> 	u64 val;
> 	int32_t vid_fp;
> @@ -585,9 +585,7 @@ static void atom_set_pstate(struct cpuda
> 	if (pstate > cpudata->pstate.max_pstate)
> 		vid =3D cpudata->vid.turbo;
>=20
> -	val |=3D vid;
> -
> -	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> +	return val | vid;
> }
>=20
> static int silvermont_get_scaling(void)
> @@ -711,7 +709,7 @@ static inline int core_get_scaling(void)
> 	return 100000;
> }
>=20
> -static void core_set_pstate(struct cpudata *cpudata, int pstate)
> +static u64 core_get_val(struct cpudata *cpudata, int pstate)
> {
> 	u64 val;
>=20
> @@ -719,7 +717,7 @@ static void core_set_pstate(struct cpuda
> 	if (limits->no_turbo && !limits->turbo_disabled)
> 		val |=3D (u64)1 << 32;
>=20
> -	wrmsrl(MSR_IA32_PERF_CTL, val);
> +	return val;
> }
>=20
> static int knl_get_turbo_pstate(void)
> @@ -750,7 +748,7 @@ static struct cpu_defaults core_params =3D
> 		.get_min =3D core_get_min_pstate,
> 		.get_turbo =3D core_get_turbo_pstate,
> 		.get_scaling =3D core_get_scaling,
> -		.set =3D core_set_pstate,
> +		.get_val =3D core_get_val,
> 		.get_target_pstate =3D get_target_pstate_use_performance,
> 	},
> };
> @@ -769,7 +767,7 @@ static struct cpu_defaults silvermont_pa
> 		.get_max_physical =3D atom_get_max_pstate,
> 		.get_min =3D atom_get_min_pstate,
> 		.get_turbo =3D atom_get_turbo_pstate,
> -		.set =3D atom_set_pstate,
> +		.get_val =3D atom_get_val,
> 		.get_scaling =3D silvermont_get_scaling,
> 		.get_vid =3D atom_get_vid,
> 		.get_target_pstate =3D get_target_pstate_use_cpu_load,
> @@ -790,7 +788,7 @@ static struct cpu_defaults airmont_param
> 		.get_max_physical =3D atom_get_max_pstate,
> 		.get_min =3D atom_get_min_pstate,
> 		.get_turbo =3D atom_get_turbo_pstate,
> -		.set =3D atom_set_pstate,
> +		.get_val =3D atom_get_val,
> 		.get_scaling =3D airmont_get_scaling,
> 		.get_vid =3D atom_get_vid,
> 		.get_target_pstate =3D get_target_pstate_use_cpu_load,
> @@ -812,7 +810,7 @@ static struct cpu_defaults knl_params =3D
> 		.get_min =3D core_get_min_pstate,
> 		.get_turbo =3D knl_get_turbo_pstate,
> 		.get_scaling =3D core_get_scaling,
> -		.set =3D core_set_pstate,
> +		.get_val =3D core_get_val,
> 		.get_target_pstate =3D get_target_pstate_use_performance,
> 	},
> };
> @@ -839,25 +837,24 @@ static void intel_pstate_get_min_max(str
> 	*min =3D clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
> }
>=20
> -static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate,=
 bool force)
> +static inline void intel_pstate_record_pstate(struct cpudata *cpu, i=
nt pstate)
> {
> -	int max_perf, min_perf;
> -
> -	if (force) {
> -		update_turbo_state();
> -
> -		intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
> -
> -		pstate =3D clamp_t(int, pstate, min_perf, max_perf);
> -
> -		if (pstate =3D=3D cpu->pstate.current_pstate)
> -			return;
> -	}
> 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
> -
> 	cpu->pstate.current_pstate =3D pstate;
> +}
>=20
> -	pstate_funcs.set(cpu, pstate);
> +static void intel_pstate_set_min_pstate(struct cpudata *cpu)
> +{
> +	int pstate =3D cpu->pstate.min_pstate;
> +
> +	intel_pstate_record_pstate(cpu, pstate);
> +	/*
> +	 * Generally, there is no guarantee that this code will always run =
on
> +	 * the CPU being updated, so force the register update to run on th=
e
> +	 * right CPU.
> +	 */
> +	wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
> +		      pstate_funcs.get_val(cpu, pstate));
> }
>=20
> static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
> @@ -870,7 +867,8 @@ static void intel_pstate_get_cpu_pstates
>=20
> 	if (pstate_funcs.get_vid)
> 		pstate_funcs.get_vid(cpu);
> -	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
> +
> +	intel_pstate_set_min_pstate(cpu);
> }
>=20
> static inline void intel_pstate_calc_busy(struct cpudata *cpu)
> @@ -997,6 +995,21 @@ static inline int32_t get_target_pstate_
> 	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, core_busy);
> }
>=20
> +static inline void intel_pstate_update_pstate(struct cpudata *cpu, i=
nt pstate)
> +{
> +	int max_perf, min_perf;
> +
> +	update_turbo_state();
> +
> +	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
> +	pstate =3D clamp_t(int, pstate, min_perf, max_perf);
> +	if (pstate =3D=3D cpu->pstate.current_pstate)
> +		return;
> +
> +	intel_pstate_record_pstate(cpu, pstate);
> +	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
> +}
> +
> static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cp=
u)
> {
> 	int from, target_pstate;
> @@ -1006,7 +1019,7 @@ static inline void intel_pstate_adjust_b
>=20
> 	target_pstate =3D pstate_funcs.get_target_pstate(cpu);
>=20
> -	intel_pstate_set_pstate(cpu, target_pstate, true);
> +	intel_pstate_update_pstate(cpu, target_pstate);
>=20
> 	sample =3D &cpu->sample;
> 	trace_pstate_sample(fp_toint(sample->core_pct_busy),
> @@ -1180,7 +1193,7 @@ static void intel_pstate_stop_cpu(struct
> 	if (hwp_active)
> 		return;
>=20
> -	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
> +	intel_pstate_set_min_pstate(cpu);
> }
>=20
> static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
> @@ -1255,7 +1268,7 @@ static void copy_cpu_funcs(struct pstate
> 	pstate_funcs.get_min   =3D funcs->get_min;
> 	pstate_funcs.get_turbo =3D funcs->get_turbo;
> 	pstate_funcs.get_scaling =3D funcs->get_scaling;
> -	pstate_funcs.set       =3D funcs->set;
> +	pstate_funcs.get_val   =3D funcs->get_val;
> 	pstate_funcs.get_vid   =3D funcs->get_vid;
> 	pstate_funcs.get_target_pstate =3D funcs->get_target_pstate;
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

