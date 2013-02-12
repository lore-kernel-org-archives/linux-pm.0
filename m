From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] APM idle: register apm_cpu_idle via cpuidle
Date: Tue, 12 Feb 2013 16:00:16 +0100
Message-ID: <511A5900.4040607@linaro.org>
References: <5118B776.6090604@linaro.org> <1360623789-12247-1-git-send-email-lenb@kernel.org> <17242de27db147c4f828d6089016e1f485c038fb.1360623445.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <17242de27db147c4f828d6089016e1f485c038fb.1360623445.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-pm@vger.kernel.org

On 02/12/2013 12:03 AM, Len Brown wrote:
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
> v2: updates from Daniel Lezcano's review
> ---
>  arch/x86/Kconfig          |  1 +
>  arch/x86/kernel/apm_32.c  | 60 +++++++++++++++++++++++++++++--------=
----------
>  arch/x86/kernel/process.c |  3 ---
>  3 files changed, 38 insertions(+), 26 deletions(-)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 225543b..1b63586 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1912,6 +1912,7 @@ config APM_DO_ENABLE
>  	  this feature.
> =20
>  config APM_CPU_IDLE
> +	depends on CPU_IDLE
>  	bool "Make CPU Idle calls when idle"
>  	---help---
>  	  Enable calls to APM CPU Idle/CPU Busy inside the kernel's idle lo=
op.
> diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
> index d65464e..f9f8afc 100644
> --- a/arch/x86/kernel/apm_32.c
> +++ b/arch/x86/kernel/apm_32.c
> @@ -232,6 +232,7 @@
>  #include <linux/acpi.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/i8253.h>
> +#include <linux/cpuidle.h>
> =20
>  #include <asm/uaccess.h>
>  #include <asm/desc.h>
> @@ -360,13 +361,38 @@ struct apm_user {
>   * idle percentage above which bios idle calls are done
>   */
>  #ifdef CONFIG_APM_CPU_IDLE
> -#warning deprecated CONFIG_APM_CPU_IDLE will be deleted in 2012
>  #define DEFAULT_IDLE_THRESHOLD	95
>  #else
>  #define DEFAULT_IDLE_THRESHOLD	100
>  #endif
>  #define DEFAULT_IDLE_PERIOD	(100 / 3)
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
> +	.state_count =3D 2,
> +};
> +
> +static struct cpuidle_device apm_cpuidle_device =3D {
> +	.state_count =3D 2,
> +};

Actually this initialization is not needed because when it is set to
zero, the cpuidle_enable_device function will set it for us from the
driver's state_count.

int cpuidle_enable_device(struct cpuidle_device *dev)
{
	...
	if (!dev->state_count)
                dev->state_count =3D drv->state_count;
}

It is useful to set a value when it differs from the driver's one.

Otherwise :

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  /*
>   * Local variables
>   */
> @@ -377,7 +403,6 @@ static struct {
>  static int clock_slowed;
>  static int idle_threshold __read_mostly =3D DEFAULT_IDLE_THRESHOLD;
>  static int idle_period __read_mostly =3D DEFAULT_IDLE_PERIOD;
> -static int set_pm_idle;
>  static int suspends_pending;
>  static int standbys_pending;
>  static int ignore_sys_suspend;
> @@ -884,8 +909,6 @@ static void apm_do_busy(void)
>  #define IDLE_CALC_LIMIT	(HZ * 100)
>  #define IDLE_LEAKY_MAX	16
> =20
> -static void (*original_pm_idle)(void) __read_mostly;
> -
>  /**
>   * apm_cpu_idle		-	cpu idling for APM capable Linux
>   *
> @@ -894,7 +917,8 @@ static void (*original_pm_idle)(void) __read_most=
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
> @@ -904,7 +928,6 @@ static void apm_cpu_idle(void)
>  	unsigned int jiffies_since_last_check =3D jiffies - last_jiffies;
>  	unsigned int bucket;
> =20
> -	WARN_ONCE(1, "deprecated apm_cpu_idle will be deleted in 2012");
>  recalc:
>  	if (jiffies_since_last_check > IDLE_CALC_LIMIT) {
>  		use_apm_idle =3D 0;
> @@ -950,10 +973,7 @@ recalc:
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
> @@ -963,7 +983,7 @@ recalc:
>  	if (apm_idle_done)
>  		apm_do_busy();
> =20
> -	local_irq_enable();
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

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
