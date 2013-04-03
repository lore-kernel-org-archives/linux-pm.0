From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 9/9] POWERPC: pseries: cpuidle: use time keeping flag
Date: Wed, 03 Apr 2013 16:25:54 +0200
Message-ID: <515C3BF2.7040609@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <1364991322-20585-9-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1364991322-20585-9-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
> The current code computes the idle time but that can be handled
> by the cpuidle framework if we enable the .en_core_tk_irqen flag.
>
> Set the flag and remove the code related to the time computation.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Deepthi Dharwar <deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> ---

Rafael,

Deepthi took the patch, did a fix and tested it, this is why there is
its signed-off.

Deepthi, could you ack the patch for Rafael also ?

Thanks
-- Daniel

>  arch/powerpc/platforms/pseries/processor_idle.c |   35 ++++++++++---=
----------
>  1 file changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/p=
owerpc/platforms/pseries/processor_idle.c
> index 4d806b4..a197120 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -23,8 +23,9 @@
>  #include "pseries.h"
> =20
>  struct cpuidle_driver pseries_idle_driver =3D {
> -	.name =3D		"pseries_idle",
> -	.owner =3D	THIS_MODULE,
> +	.name             =3D "pseries_idle",
> +	.owner            =3D THIS_MODULE,
> +	.en_core_tk_irqen =3D 1,
>  };
> =20
>  #define MAX_IDLE_STATE_COUNT	2
> @@ -33,10 +34,8 @@ static int max_idle_state =3D MAX_IDLE_STATE_COUNT=
 - 1;
>  static struct cpuidle_device __percpu *pseries_cpuidle_devices;
>  static struct cpuidle_state *cpuidle_state_table;
> =20
> -static inline void idle_loop_prolog(unsigned long *in_purr, ktime_t =
*kt_before)
> +static inline void idle_loop_prolog(unsigned long *in_purr)
>  {
> -
> -	*kt_before =3D ktime_get();
>  	*in_purr =3D mfspr(SPRN_PURR);
>  	/*
>  	 * Indicate to the HV that we are idle. Now would be
> @@ -45,12 +44,10 @@ static inline void idle_loop_prolog(unsigned long=
 *in_purr, ktime_t *kt_before)
>  	get_lppaca()->idle =3D 1;
>  }
> =20
> -static inline  s64 idle_loop_epilog(unsigned long in_purr, ktime_t k=
t_before)
> +static inline void idle_loop_epilog(unsigned long in_purr)
>  {
>  	get_lppaca()->wait_state_cycles +=3D mfspr(SPRN_PURR) - in_purr;
>  	get_lppaca()->idle =3D 0;
> -
> -	return ktime_to_us(ktime_sub(ktime_get(), kt_before));
>  }
> =20
>  static int snooze_loop(struct cpuidle_device *dev,
> @@ -58,10 +55,9 @@ static int snooze_loop(struct cpuidle_device *dev,
>  			int index)
>  {
>  	unsigned long in_purr;
> -	ktime_t kt_before;
>  	int cpu =3D dev->cpu;
> =20
> -	idle_loop_prolog(&in_purr, &kt_before);
> +	idle_loop_prolog(&in_purr);
>  	local_irq_enable();
>  	set_thread_flag(TIF_POLLING_NRFLAG);
> =20
> @@ -75,8 +71,8 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	clear_thread_flag(TIF_POLLING_NRFLAG);
>  	smp_mb();
> =20
> -	dev->last_residency =3D
> -		(int)idle_loop_epilog(in_purr, kt_before);
> +	idle_loop_epilog(in_purr);
> +
>  	return index;
>  }
> =20
> @@ -102,9 +98,8 @@ static int dedicated_cede_loop(struct cpuidle_devi=
ce *dev,
>  				int index)
>  {
>  	unsigned long in_purr;
> -	ktime_t kt_before;
> =20
> -	idle_loop_prolog(&in_purr, &kt_before);
> +	idle_loop_prolog(&in_purr);
>  	get_lppaca()->donate_dedicated_cpu =3D 1;
> =20
>  	ppc64_runlatch_off();
> @@ -112,8 +107,9 @@ static int dedicated_cede_loop(struct cpuidle_dev=
ice *dev,
>  	check_and_cede_processor();
> =20
>  	get_lppaca()->donate_dedicated_cpu =3D 0;
> -	dev->last_residency =3D
> -		(int)idle_loop_epilog(in_purr, kt_before);
> +
> +	idle_loop_epilog(in_purr);
> +
>  	return index;
>  }
> =20
> @@ -122,9 +118,8 @@ static int shared_cede_loop(struct cpuidle_device=
 *dev,
>  			int index)
>  {
>  	unsigned long in_purr;
> -	ktime_t kt_before;
> =20
> -	idle_loop_prolog(&in_purr, &kt_before);
> +	idle_loop_prolog(&in_purr);
> =20
>  	/*
>  	 * Yield the processor to the hypervisor.  We return if
> @@ -135,8 +130,8 @@ static int shared_cede_loop(struct cpuidle_device=
 *dev,
>  	 */
>  	check_and_cede_processor();
> =20
> -	dev->last_residency =3D
> -		(int)idle_loop_epilog(in_purr, kt_before);
> +	idle_loop_epilog(in_purr);
> +
>  	return index;
>  }
> =20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
