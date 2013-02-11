From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 01/16] APM idle: register apm_cpu_idle via cpuidle
Date: Mon, 11 Feb 2013 10:18:46 +0100
Message-ID: <5118B776.6090604@linaro.org>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org> <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:39320 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab3BKJSs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Feb 2013 04:18:48 -0500
Received: by mail-wi0-f181.google.com with SMTP id hm6so2833664wib.8
        for <linux-pm@vger.kernel.org>; Mon, 11 Feb 2013 01:18:47 -0800 (PST)
In-Reply-To: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Jiri Kosina <jkosina@suse.cz>

On 02/10/2013 06:58 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> Update APM to register its local idle routine with cpuidle.
>=20
> This allows us to stop exporting pm_idle to modules on x86.
>=20
> The Kconfig sub-option, APM_CPU_IDLE, now depends on on CPU_IDLE.
>=20
> Compile-tested only.
>=20
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> ---

[ ... ]

> =20
> +static int apm_cpu_idle(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv, int index);
> +
> +static struct cpuidle_driver apm_idle_driver =3D {
> +	.name =3D "apm_idle",
> +	.owner =3D THIS_MODULE,
> +	.en_core_tk_irqen =3D 1,
> +	.states =3D {
> +		{ /* entry 0 is for polling */ },
> +		{ /* entry 1 is for APM idle */
> +			.name =3D "APM",
> +			.desc =3D "APM idle",
> +			.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +			.exit_latency =3D 250,	/* WAG */
> +			.target_residency =3D 500,	/* WAG */
> +			.enter =3D &apm_cpu_idle
> +		},
> +	},
> +};
> +
> +static struct cpuidle_device apm_cpuidle_device =3D {
> +	.state_count =3D 2,
> +};

This will make the cpuidle_register_driver to fail because the
state_count field of the cpuidle_driver is zero, no ?

static struct cpuidle_driver apm_idle_driver =3D {
	.name =3D "apm_idle",
	...
	.states =3D {
	...
	},
	.state_count =3D 2,
}

static struct cpuidle_device apm_cpuidle_device;

>  /*
>   * Local variables
>   */
> @@ -377,7 +402,6 @@ static struct {
>  static int clock_slowed;
>  static int idle_threshold __read_mostly =3D DEFAULT_IDLE_THRESHOLD;
>  static int idle_period __read_mostly =3D DEFAULT_IDLE_PERIOD;
> -static int set_pm_idle;
>  static int suspends_pending;
>  static int standbys_pending;
>  static int ignore_sys_suspend;
> @@ -884,8 +908,6 @@ static void apm_do_busy(void)
>  #define IDLE_CALC_LIMIT	(HZ * 100)
>  #define IDLE_LEAKY_MAX	16
> =20
> -static void (*original_pm_idle)(void) __read_mostly;
> -
>  /**
>   * apm_cpu_idle		-	cpu idling for APM capable Linux
>   *
> @@ -894,7 +916,8 @@ static void (*original_pm_idle)(void) __read_most=
ly;
>   * Furthermore it calls the system default idle routine.
>   */
> =20
> -static void apm_cpu_idle(void)
> +static int apm_cpu_idle(struct cpuidle_device *dev,
> +	struct cpuidle_driver *drv, int index)
>  {
>  	static int use_apm_idle; /* =3D 0 */
>  	static unsigned int last_jiffies; /* =3D 0 */
> @@ -904,7 +927,6 @@ static void apm_cpu_idle(void)
>  	unsigned int jiffies_since_last_check =3D jiffies - last_jiffies;
>  	unsigned int bucket;
> =20
> -	WARN_ONCE(1, "deprecated apm_cpu_idle will be deleted in 2012");
>  recalc:
>  	if (jiffies_since_last_check > IDLE_CALC_LIMIT) {
>  		use_apm_idle =3D 0;
> @@ -950,10 +972,7 @@ recalc:
>  				break;
>  			}
>  		}
> -		if (original_pm_idle)
> -			original_pm_idle();
> -		else
> -			default_idle();
> +		default_idle();
>  		local_irq_disable();
>  		jiffies_since_last_check =3D jiffies - last_jiffies;
>  		if (jiffies_since_last_check > idle_period)
> @@ -964,6 +983,7 @@ recalc:
>  		apm_do_busy();
> =20
>  	local_irq_enable();

           ^^^^^^^^

As the 'en_core_tk_irqen' flag has been enabled in the driver, the
caller of this function will call 'local_irq_enable'. We can remove the
this line no ?

> +	return index;
>  }
> =20
>  /**
> @@ -2381,9 +2401,9 @@ static int __init apm_init(void)
>  	if (HZ !=3D 100)
>  		idle_period =3D (idle_period * HZ) / 100;
>  	if (idle_threshold < 100) {
> -		original_pm_idle =3D pm_idle;
> -		pm_idle  =3D apm_cpu_idle;
> -		set_pm_idle =3D 1;
> +		if (!cpuidle_register_driver(&apm_idle_driver))
> +			if (cpuidle_register_device(&apm_cpuidle_device))
> +				cpuidle_unregister_driver(&apm_idle_driver);
>  	}
> =20
>  	return 0;
> @@ -2393,15 +2413,9 @@ static void __exit apm_exit(void)
>  {
>  	int error;
> =20
> -	if (set_pm_idle) {
> -		pm_idle =3D original_pm_idle;
> -		/*
> -		 * We are about to unload the current idle thread pm callback
> -		 * (pm_idle), Wait for all processors to update cached/local
> -		 * copies of pm_idle before proceeding.
> -		 */
> -		kick_all_cpus_sync();
> -	}
> +	cpuidle_unregister_device(&apm_cpuidle_device);
> +	cpuidle_unregister_driver(&apm_idle_driver);
> +
>  	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) =3D=3D 0)
>  	    && (apm_info.connection_version > 0x0100)) {
>  		error =3D apm_engage_power_management(APM_DEVICE_ALL, 0);
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 2ed787f..f571a6e 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -272,9 +272,6 @@ EXPORT_SYMBOL(boot_option_idle_override);
>   * Powermanagement idle function, if any..
>   */
>  void (*pm_idle)(void);
> -#ifdef CONFIG_APM_MODULE
> -EXPORT_SYMBOL(pm_idle);
> -#endif
> =20
>  #ifndef CONFIG_SMP
>  static inline void play_dead(void)
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

