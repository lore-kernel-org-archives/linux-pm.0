From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH] thermal: powerclamp: Add support for ARM machine
 to powerclamp driver.
Date: Thu, 25 Jul 2013 09:16:04 -0400
Message-ID: <51F12514.9030606@ti.com>
References: <1374747727-18602-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nxSdb65PsocpB1ER3bp9AEtQSNGC6HWPJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53458 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab3GYNQb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2013 09:16:31 -0400
In-Reply-To: <1374747727-18602-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com, rui.zhang@intel.com, eduardo.valentin@ti.com, amit.daniel@samsung.com, Myungjoo Ham <myungjoo.ham@samsung.com>

--nxSdb65PsocpB1ER3bp9AEtQSNGC6HWPJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Jonghwa,

On 25-07-2013 06:22, Jonghwa Lee wrote:
> This patch modifies intel_powerclamp driver can be used in not only x86=

> but also ARM. Any ARM system can use intel_powerclamp driver for managi=
ng
> thermal problem through injecting intentional idle cycle. The required
> modification is only that it replaces x86's instruction, mwait, with ar=
m
> specific one, wfi and changes the way of calculation of idle rate of la=
st
> window. Other algorithm and codes can be shared without any amendment.
>=20

First of all, thanks for taking this up. It was on my TODO list, but I
still could not manage to start doing it.

I have had a quick look on your patch. I promise to review it properly
as soon as possible. Two major concerns are (1) I think the ARM part of
it is not really specific to ARM (more like non-x86), and could be
reused to other archs (ok, there are couple of points that may need to
be checked); and (2) I would rather split the code into two layers, one
that talks to thermal fw and another that is specific to arch, this way
we could reduce ifdefery.



> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/thermal/Kconfig            |    3 +-
>  drivers/thermal/intel_powerclamp.c |   94 ++++++++++++++++++++++++++--=
--------
>  2 files changed, 70 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e988c81..912a788 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -162,8 +162,7 @@ config DB8500_CPUFREQ_COOLING
>  config INTEL_POWERCLAMP
>  	tristate "Intel PowerClamp idle injection driver"
>  	depends on THERMAL
> -	depends on X86
> -	depends on CPU_SUP_INTEL
> +	depends on (X86 && CPU_SUP_INTEL) || ARM
>  	help
>  	  Enable this to enable Intel PowerClamp idle injection driver. This
>  	  enforce idle time which results in more package C-state residency. =
The
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel=
_powerclamp.c
> index b40b37c..3ff350b 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -52,12 +52,18 @@
>  #include <linux/seq_file.h>
>  #include <linux/sched/rt.h>
> =20
> +#include <asm/hardirq.h>
> +#ifdef CONFIG_X86
>  #include <asm/nmi.h>
>  #include <asm/msr.h>
>  #include <asm/mwait.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/idle.h>
> -#include <asm/hardirq.h>
> +
> +static unsigned int target_mwait;
> +#elif CONFIG_ARM
> +#include <asm/proc-fns.h>

I don't think this is specific to ARM.

> +#endif
> =20
>  #define MAX_TARGET_RATIO (50U)
>  /* For each undisturbed clamping period (no extra wake ups during idle=
 time),
> @@ -71,7 +77,6 @@
>   */
>  #define DEFAULT_DURATION_JIFFIES (6)
> =20
> -static unsigned int target_mwait;
>  static struct dentry *debug_dir;
> =20
>  /* user selected target */
> @@ -178,6 +183,7 @@ MODULE_PARM_DESC(window_size, "sliding window in nu=
mber of clamping cycles\n"
>  	"\twindow size results in slower response time but more smooth\n"
>  	"\tclamping results. default to 2.");
> =20
> +#ifdef CONFIG_X86
>  static void find_target_mwait(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
> @@ -246,6 +252,7 @@ static u64 pkg_state_counter(void)
> =20
>  	return count;
>  }
> +#endif
> =20
>  static void noop_timer(unsigned long foo)
>  {
> @@ -316,6 +323,25 @@ static void adjust_compensation(int target_ratio, =
unsigned int win)
>  	}
>  }
> =20
> +#ifdef CONFIG_X86
> +static void inline powerclamp_get_cstate_inform(u64 *msr_now, u64 *tsc=
_now)
> +{
> +	*msr_now =3D pkg_state_counter();
> +	rdtscll(*tsc_now);
> +}
> +#elif CONFIG_ARM
> +static void inline powerclamp_get_cstate_inform(u64 *idle, u64 *wall)
> +{
> +	u64 _wall;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		*idle +=3D get_cpu_idle_time_us(cpu, &_wall);
> +		*wall +=3D _wall;
> +	}
> +}
> +#endif
> +
>  static bool powerclamp_adjust_controls(unsigned int target_ratio,
>  				unsigned int guard, unsigned int win)
>  {
> @@ -324,8 +350,7 @@ static bool powerclamp_adjust_controls(unsigned int=
 target_ratio,
>  	u64 val64;
> =20
>  	/* check result for the last window */
> -	msr_now =3D pkg_state_counter();
> -	rdtscll(tsc_now);
> +	powerclamp_get_cstate_inform(&msr_now, &tsc_now);
> =20
>  	/* calculate pkg cstate vs tsc ratio */
>  	if (!msr_last || !tsc_last)
> @@ -353,6 +378,34 @@ static bool powerclamp_adjust_controls(unsigned in=
t target_ratio,
>  	return set_target_ratio + guard <=3D current_ratio;
>  }
> =20
> +#ifdef CONFIG_X86
> +static void powerclamp_enter_idle(void)
> +{
> +	unsigned long ecx =3D 1;
> +	unsigned long eax =3D target_mwait;
> +
> +	/*
> +	 * REVISIT: may call enter_idle() to notify drivers who
> +	 * can save power during cpu idle. same for exit_idle()
> +	 */
> +	local_touch_nmi();
> +	stop_critical_timings();
> +	__monitor((void *)&current_thread_info()->flags, 0, 0);
> +	cpu_relax(); /* allow HT sibling to run */
> +	__mwait(eax, ecx);
> +	start_critical_timings();
> +	atomic_inc(&idle_wakeup_counter);
> +}
> +#elif CONFIG_ARM
> +static void  powerclamp_enter_idle(void)
> +{
> +	stop_critical_timings();
> +	cpu_do_idle();
> +	start_critical_timings();
> +	atomic_inc(&idle_wakeup_counter);
> +}
> +#endif
> +
>  static int clamp_thread(void *arg)
>  {
>  	int cpunr =3D (unsigned long)arg;
> @@ -428,22 +481,9 @@ static int clamp_thread(void *arg)
>  		preempt_disable();
>  		tick_nohz_idle_enter();
>  		/* mwait until target jiffies is reached */
> -		while (time_before(jiffies, target_jiffies)) {
> -			unsigned long ecx =3D 1;
> -			unsigned long eax =3D target_mwait;
> -
> -			/*
> -			 * REVISIT: may call enter_idle() to notify drivers who
> -			 * can save power during cpu idle. same for exit_idle()
> -			 */
> -			local_touch_nmi();
> -			stop_critical_timings();
> -			__monitor((void *)&current_thread_info()->flags, 0, 0);
> -			cpu_relax(); /* allow HT sibling to run */
> -			__mwait(eax, ecx);
> -			start_critical_timings();
> -			atomic_inc(&idle_wakeup_counter);
> -		}
> +		while (time_before(jiffies, target_jiffies))
> +			powerclamp_enter_idle();
> +
>  		tick_nohz_idle_exit();
>  		preempt_enable_no_resched();
>  	}
> @@ -465,13 +505,12 @@ static void poll_pkg_cstate(struct work_struct *d=
ummy)
>  	static u64 tsc_last;
>  	static unsigned long jiffies_last;
> =20
> -	u64 msr_now;
> +	u64 msr_now =3D 0;
>  	unsigned long jiffies_now;
> -	u64 tsc_now;
> +	u64 tsc_now =3D 0;
>  	u64 val64;
> =20
> -	msr_now =3D pkg_state_counter();
> -	rdtscll(tsc_now);
> +	powerclamp_get_cstate_inform(&msr_now, &tsc_now);
>  	jiffies_now =3D jiffies;
> =20
>  	/* calculate pkg cstate vs tsc ratio */
> @@ -499,11 +538,13 @@ static int start_power_clamp(void)
>  	unsigned long cpu;
>  	struct task_struct *thread;
> =20
> +#ifdef CONFIG_X86
>  	/* check if pkg cstate counter is completely 0, abort in this case */=

>  	if (!pkg_state_counter()) {
>  		pr_err("pkg cstate counter not functional, abort\n");
>  		return -EINVAL;
>  	}
> +#endif
> =20
>  	set_target_ratio =3D clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1=
);
>  	/* prevent cpu hotplug */
> @@ -661,6 +702,7 @@ static struct thermal_cooling_device_ops powerclamp=
_cooling_ops =3D {
>  	.set_cur_state =3D powerclamp_set_cur_state,
>  };
> =20
> +#ifdef CONFIG_X86
>  /* runs on Nehalem and later */
>  static const struct x86_cpu_id intel_powerclamp_ids[] =3D {
>  	{ X86_VENDOR_INTEL, 6, 0x1a},
> @@ -678,9 +720,11 @@ static const struct x86_cpu_id intel_powerclamp_id=
s[] =3D {
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
> +#endif
> =20
>  static int powerclamp_probe(void)
>  {
> +#ifdef CONFIG_X86
>  	if (!x86_match_cpu(intel_powerclamp_ids)) {
>  		pr_err("Intel powerclamp does not run on family %d model %d\n",
>  				boot_cpu_data.x86, boot_cpu_data.x86_model);
> @@ -694,7 +738,7 @@ static int powerclamp_probe(void)
> =20
>  	/* find the deepest mwait value */
>  	find_target_mwait();
> -
> +#endif
>  	return 0;
>  }
> =20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--nxSdb65PsocpB1ER3bp9AEtQSNGC6HWPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHxJSMACgkQCXcVR3XQvP29VQEAiu6qgFVt6AjKvyTQX1O9iFmV
WLnMwDm2FZ6WWXDh44kBALrC1C2USK2osiurm9MLCiileUs2pbJZ2KC9arlD89Ce
=6E0I
-----END PGP SIGNATURE-----

--nxSdb65PsocpB1ER3bp9AEtQSNGC6HWPJ--
