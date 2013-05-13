From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/2] x86, mcheck, therm_throt: Process package thresholds
Date: Mon, 13 May 2013 15:28:32 -0400
Message-ID: <51913EE0.6060008@ti.com>
References: <1367953065-2729-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1367953065-2729-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2XXRRMBRTPXKMKBNJIJQJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51381 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab3EMT2t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 May 2013 15:28:49 -0400
In-Reply-To: <1367953065-2729-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, tony.luck@intel.com, linux-edac@vger.kernel.org, eduardo.valentin@ti.com

------enig2XXRRMBRTPXKMKBNJIJQJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07-05-2013 14:57, Srinivas Pandruvada wrote:
> Added callback registration for package threshold reports. Also added
> a callback to check the rate control implemented in callback or not.
> If there is no rate control implemented, then there is a default rate
> control similar to core threshold notification by delaying for
> CHECK_INTERVAL (5 minutes) between reports.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
> ---
>  arch/x86/include/asm/mce.h               |  7 ++++
>  arch/x86/kernel/cpu/mcheck/therm_throt.c | 63 ++++++++++++++++++++++++=
++++++--
>  2 files changed, 66 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index f4076af..4c619bf 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -214,6 +214,13 @@ void mce_log_therm_throt_event(__u64 status);
>  /* Interrupt Handler for core thermal thresholds */
>  extern int (*platform_thermal_notify)(__u64 msr_val);
> =20
> +/* Interrupt Handler for package thermal thresholds */
> +extern int (*platform_thermal_package_notify)(__u64 msr_val);
> +
> +/* Callback support of rate control, return true, if
> + * callback has rate control */
> +extern bool (*platform_thermal_package_rate_control)(void);
> +
>  #ifdef CONFIG_X86_THERMAL_VECTOR
>  extern void mcheck_intel_therm_init(void);
>  #else
> diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel=
/cpu/mcheck/therm_throt.c
> index 47a1870..28cecab 100644
> --- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> @@ -54,12 +54,24 @@ struct thermal_state {
>  	struct _thermal_state package_power_limit;
>  	struct _thermal_state core_thresh0;
>  	struct _thermal_state core_thresh1;
> +	struct _thermal_state pkg_thresh0;
> +	struct _thermal_state pkg_thresh1;
>  };
> =20
>  /* Callback to handle core threshold interrupts */
>  int (*platform_thermal_notify)(__u64 msr_val);
>  EXPORT_SYMBOL(platform_thermal_notify);
> =20
> +/* Callback to handle core package threshold_interrupts */
> +int (*platform_thermal_package_notify)(__u64 msr_val);
> +EXPORT_SYMBOL(platform_thermal_package_notify);

How about EXPORT_SYMBOL_GPL?

> +
> +/* Callback support of rate control, return true, if
> + * callback has rate control */
> +bool (*platform_thermal_package_rate_control)(void);
> +EXPORT_SYMBOL(platform_thermal_package_rate_control);
> +

ditto..

Are you sure this is a 1 to 1 notification system? Why not using
linux/notifier.h?

> +
>  static DEFINE_PER_CPU(struct thermal_state, thermal_state);
> =20
>  static atomic_t therm_throt_en	=3D ATOMIC_INIT(0);
> @@ -203,19 +215,25 @@ static int therm_throt_process(bool new_event, in=
t event, int level)
>  	return 0;
>  }
> =20
> -static int thresh_event_valid(int event)
> +static int thresh_event_valid(int level, int event)
>  {
>  	struct _thermal_state *state;
>  	unsigned int this_cpu =3D smp_processor_id();
>  	struct thermal_state *pstate =3D &per_cpu(thermal_state, this_cpu);
>  	u64 now =3D get_jiffies_64();
> =20
> -	state =3D (event =3D=3D 0) ? &pstate->core_thresh0 : &pstate->core_th=
resh1;
> +	if (level =3D=3D PACKAGE_LEVEL)
> +		state =3D (event =3D=3D 0) ? &pstate->pkg_thresh0 :
> +						&pstate->pkg_thresh1;
> +	else
> +		state =3D (event =3D=3D 0) ? &pstate->core_thresh0 :
> +						&pstate->core_thresh1;
> =20
>  	if (time_before64(now, state->next_check))
>  		return 0;
> =20
>  	state->next_check =3D now + CHECK_INTERVAL;
> +
>  	return 1;
>  }
> =20
> @@ -321,6 +339,39 @@ device_initcall(thermal_throttle_init_device);
> =20
>  #endif /* CONFIG_SYSFS */
> =20
> +static void notify_package_thresholds(__u64 msr_val)
> +{
> +	bool notify_thres_0 =3D false;
> +	bool notify_thres_1 =3D false;
> +
> +	if (!platform_thermal_package_notify)
> +		return;
> +
> +	/* lower threshold check */
> +	if (msr_val & THERM_LOG_THRESHOLD0)
> +		notify_thres_0 =3D true;
> +	/* higher threshold check */
> +	if (msr_val & THERM_LOG_THRESHOLD1)
> +		notify_thres_1 =3D true;
> +
> +	if (!notify_thres_0 && !notify_thres_1)
> +		return;
> +
> +	if (platform_thermal_package_rate_control &&
> +		platform_thermal_package_rate_control()) {
> +		/* Rate control is implemented in callback */
> +		platform_thermal_package_notify(msr_val);
> +		return;
> +	}
> +
> +	/* lower threshold reached */
> +	if (notify_thres_0 && thresh_event_valid(PACKAGE_LEVEL, 0))
> +		platform_thermal_package_notify(msr_val);
> +	/* higher threshold reached */
> +	if (notify_thres_1 && thresh_event_valid(PACKAGE_LEVEL, 1))
> +		platform_thermal_package_notify(msr_val);
> +}
> +
>  static void notify_thresholds(__u64 msr_val)
>  {
>  	/* check whether the interrupt handler is defined;
> @@ -330,10 +381,12 @@ static void notify_thresholds(__u64 msr_val)
>  		return;
> =20
>  	/* lower threshold reached */
> -	if ((msr_val & THERM_LOG_THRESHOLD0) &&	thresh_event_valid(0))
> +	if ((msr_val & THERM_LOG_THRESHOLD0) &&
> +			thresh_event_valid(CORE_LEVEL, 0))
>  		platform_thermal_notify(msr_val);
>  	/* higher threshold reached */
> -	if ((msr_val & THERM_LOG_THRESHOLD1) && thresh_event_valid(1))
> +	if ((msr_val & THERM_LOG_THRESHOLD1) &&
> +			thresh_event_valid(CORE_LEVEL, 1))
>  		platform_thermal_notify(msr_val);
>  }
> =20
> @@ -359,6 +412,8 @@ static void intel_thermal_interrupt(void)
> =20
>  	if (this_cpu_has(X86_FEATURE_PTS)) {
>  		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
> +		/* check violations of package thermal thresholds */
> +		notify_package_thresholds(msr_val);
>  		therm_throt_process(msr_val & PACKAGE_THERM_STATUS_PROCHOT,
>  					THERMAL_THROTTLING_EVENT,
>  					PACKAGE_LEVEL);
>=20



------enig2XXRRMBRTPXKMKBNJIJQJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGRPuAACgkQCXcVR3XQvP03UQD/VmMIKmAxdr4fL3cLSij6niFK
9lZgySzxyoWfsTaMjUkA/2fiEysjnK1GuGQ7QTW7si/LYPXy21Oa+S5YqaGtzEmp
=PikM
-----END PGP SIGNATURE-----

------enig2XXRRMBRTPXKMKBNJIJQJ--
