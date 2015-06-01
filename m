From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Force setting target pstate when required.
Date: Mon, 01 Jun 2015 12:02:47 +0200
Message-ID: <2651151.7XYf1LIGT8@vostro.rjw.lan>
References: <1433083349-4039-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47919 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751376AbbFAJhj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2015 05:37:39 -0400
In-Reply-To: <1433083349-4039-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: kristen@linux.intel.com, linux-pm@vger.kernel.org, dsmythies@telus.net

On Sunday, May 31, 2015 07:42:29 AM Doug Smythies wrote:
> During initialization and exit it is possible that the
> target pstate might not actually be set. Furthermore,
> the result can be that the driver and the processor
> are out of synch and, under some conditions, the driver
> might never send the processor the proper target pstate.
>=20
> This patch adds a forced or unforced flag to the call to
> intel_pstate_set_pstate. If forced, then specifically
> bypass clamp checks and the do not send if it is the
> same as last time check. If unforced, then, and as before,
> do the current policy clamp checks, and do not do actual
> send if the new target is the same as the old.
>=20
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> Reported-by: Marien Zwart <marien.zwart@gmail.com>
> Reported-by: Alex Lochmann <alexander.lochmann@tu-dortmund.de>
> Reported-by: Piotr Ko=C5=82aczkowski <pkolaczk@gmail.com>
> Reported-by: Clemens Eisserer <linuxhippy@gmail.com>
> Tested-by: Marien Zwart <marien.zwart@gmail.com>
> Tested-by: Doug Smythies <dsmythies@telus.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_p=
state.c
> index 6414661..77b6edf 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -33,6 +33,9 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/cpufeature.h>
> =20
> +#define	FORCED		0
> +#define UNFORCED	1

Please use more descriptive names for these.

Like PSTATE_FORCE_EQUAL and PSTATE_SKIP_EQUAL or similar.

Or what's wrong with using bool for that, actually?

> +
>  #define BYT_RATIOS		0x66a
>  #define BYT_VIDS		0x66b
>  #define BYT_TURBO_RATIOS	0x66c
> @@ -704,19 +707,21 @@ static void intel_pstate_get_min_max(struct cpu=
data *cpu, int *min, int *max)
>  	*min =3D clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
>  }
> =20
> -static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
> +static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate,=
 int forced)

I'd call the last arg "mode" ->

>  {
>  	int max_perf, min_perf;
> =20
> -	update_turbo_state();
> +	if (forced !=3D FORCED)

-> and then you have=20

	if (mode !=3D PSTATE_FORCE_EQUAL) {

> +	{

Move the brace to the if () line.

> +		update_turbo_state();
> =20
> -	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
> +		intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
> =20
> -	pstate =3D clamp_t(int, pstate, min_perf, max_perf);
> -
> -	if (pstate =3D=3D cpu->pstate.current_pstate)
> -		return;
> +		pstate =3D clamp_t(int, pstate, min_perf, max_perf);
> =20
> +		if (pstate =3D=3D cpu->pstate.current_pstate)
> +			return;
> +	}
>  	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
> =20
>  	cpu->pstate.current_pstate =3D pstate;
> @@ -733,7 +738,7 @@ static void intel_pstate_get_cpu_pstates(struct c=
pudata *cpu)
> =20
>  	if (pstate_funcs.get_vid)
>  		pstate_funcs.get_vid(cpu);
> -	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
> +	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, (int) FORCED);

Decimal literals are int by default.

>  }
> =20
>  static inline void intel_pstate_calc_busy(struct cpudata *cpu)
> @@ -844,7 +849,7 @@ static inline void intel_pstate_adjust_busy_pstat=
e(struct cpudata *cpu)
>  	ctl =3D pid_calc(pid, busy_scaled);
> =20
>  	/* Negative values of ctl increase the pstate and vice versa */
> -	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
> +	intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate - ctl, (int=
) UNFORCED);
>  }
> =20
>  static void intel_hwp_timer_func(unsigned long __data)
> @@ -1007,7 +1012,7 @@ static void intel_pstate_stop_cpu(struct cpufre=
q_policy *policy)
>  	if (hwp_active)
>  		return;
> =20
> -	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
> +	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, (int) FORCED);
>  }
> =20
>  static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
