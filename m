From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] acpi: intel_idle : break dependency
	between modules
Date: Thu, 28 Jun 2012 13:27:39 +0200
Message-ID: <4FEC3FAB.20706@linaro.org>
References: <201206271506.29034.trenn@suse.de>
	<1340873202-2476-1-git-send-email-daniel.lezcano@linaro.org>
	<4FEC3EF7.5020208@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FEC3EF7.5020208@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 06/28/2012 01:24 PM, Srivatsa S. Bhat wrote:
> On 06/28/2012 02:16 PM, Daniel Lezcano wrote:
>> When the system is booted with some cpus offline, the idle
>> driver is not initialized. When a cpu is set online, the
>> acpi code call the intel idle init function. Unfortunately
>> this code introduce a dependency between intel_idle and acpi.
>>
>> This patch is intended to remove this dependency by using the
>> notifier of intel_idle. This patch has the benefit of
>> encapsulating the intel_idle driver and remove some exported
>> functions.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
>=20
> Looks good to me.

Thanks for the review Srivatsa.

Shall I consider it as an acked-by ?

  -- Daniel

>=20
> Regards,
> Srivatsa S. Bhat
>=20
>> ---
>>  drivers/acpi/processor_driver.c |    7 ------
>>  drivers/idle/intel_idle.c       |   41 +++++++++++++++++++++++++-----=
--------
>>  include/linux/cpuidle.h         |    7 ------
>>  3 files changed, 27 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_=
driver.c
>> index 0734086..8648b29 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -427,18 +427,11 @@ static int acpi_cpu_soft_notify(struct notifier_=
block *nfb,
>>  		 * Initialize missing things
>>  		 */
>>  		if (pr->flags.need_hotplug_init) {
>> -			struct cpuidle_driver *idle_driver =3D
>> -				cpuidle_get_driver();
>> -
>>  			printk(KERN_INFO "Will online and init hotplugged "
>>  			       "CPU: %d\n", pr->id);
>>  			WARN(acpi_processor_start(pr), "Failed to start CPU:"
>>  				" %d\n", pr->id);
>>  			pr->flags.need_hotplug_init =3D 0;
>> -			if (idle_driver && !strcmp(idle_driver->name,
>> -						   "intel_idle")) {
>> -				intel_idle_cpu_init(pr->id);
>> -			}
>>  		/* Normal CPU soft online event */
>>  		} else {
>>  			acpi_processor_ppc_has_changed(pr, 0);
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index d0f59c3..fe95d54 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -96,6 +96,7 @@ static const struct idle_cpu *icpu;
>>  static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
>>  static int intel_idle(struct cpuidle_device *dev,
>>  			struct cpuidle_driver *drv, int index);
>> +static int intel_idle_cpu_init(int cpu);
>>
>>  static struct cpuidle_state *cpuidle_state_table;
>>
>> @@ -302,22 +303,35 @@ static void __setup_broadcast_timer(void *arg)
>>  	clockevents_notify(reason, &cpu);
>>  }
>>
>> -static int setup_broadcast_cpuhp_notify(struct notifier_block *n,
>> -		unsigned long action, void *hcpu)
>> +static int cpu_hotplug_notify(struct notifier_block *n,
>> +			      unsigned long action, void *hcpu)
>>  {
>>  	int hotcpu =3D (unsigned long)hcpu;
>> +	struct cpuidle_device *dev;
>>
>>  	switch (action & 0xf) {
>>  	case CPU_ONLINE:
>> -		smp_call_function_single(hotcpu, __setup_broadcast_timer,
>> -			(void *)true, 1);
>> +
>> +		if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIABLE)
>> +			smp_call_function_single(hotcpu, __setup_broadcast_timer,
>> +						 (void *)true, 1);
>> +
>> +		/*
>> +		 * Some systems can hotplug a cpu at runtime after
>> +		 * the kernel has booted, we have to initialize the
>> +		 * driver in this case
>> +		 */
>> +		dev =3D per_cpu_ptr(intel_idle_cpuidle_devices, hotcpu);
>> +		if (!dev->registered)
>> +			intel_idle_cpu_init(hotcpu);
>> +
>>  		break;
>>  	}
>>  	return NOTIFY_OK;
>>  }
>>
>> -static struct notifier_block setup_broadcast_notifier =3D {
>> -	.notifier_call =3D setup_broadcast_cpuhp_notify,
>> +static struct notifier_block cpu_hotplug_notifier =3D {
>> +	.notifier_call =3D cpu_hotplug_notify,
>>  };
>>
>>  static void auto_demotion_disable(void *dummy)
>> @@ -405,10 +419,10 @@ static int intel_idle_probe(void)
>>
>>  	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
>>  		lapic_timer_reliable_states =3D LAPIC_TIMER_ALWAYS_RELIABLE;
>> -	else {
>> +	else
>>  		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
>> -		register_cpu_notifier(&setup_broadcast_notifier);
>> -	}
>> +
>> +	register_cpu_notifier(&cpu_hotplug_notifier);
>>
>>  	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
>>  		" model 0x%X\n", boot_cpu_data.x86_model);
>> @@ -494,7 +508,7 @@ static int intel_idle_cpuidle_driver_init(void)
>>   * allocate, initialize, register cpuidle_devices
>>   * @cpu: cpu/core to initialize
>>   */
>> -int intel_idle_cpu_init(int cpu)
>> +static int intel_idle_cpu_init(int cpu)
>>  {
>>  	int cstate;
>>  	struct cpuidle_device *dev;
>> @@ -539,7 +553,6 @@ int intel_idle_cpu_init(int cpu)
>>
>>  	return 0;
>>  }
>> -EXPORT_SYMBOL_GPL(intel_idle_cpu_init);
>>
>>  static int __init intel_idle_init(void)
>>  {
>> @@ -581,10 +594,10 @@ static void __exit intel_idle_exit(void)
>>  	intel_idle_cpuidle_devices_uninit();
>>  	cpuidle_unregister_driver(&intel_idle_driver);
>>
>> -	if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIABLE) {
>> +
>> +	if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIABLE)
>>  		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
>> -		unregister_cpu_notifier(&setup_broadcast_notifier);
>> -	}
>> +	unregister_cpu_notifier(&cpu_hotplug_notifier);
>>
>>  	return;
>>  }
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 5ab7183..66d7e0d 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -213,14 +213,7 @@ struct cpuidle_governor {
>>  extern int cpuidle_register_governor(struct cpuidle_governor *gov);
>>  extern void cpuidle_unregister_governor(struct cpuidle_governor *gov)=
;
>>
>> -#ifdef CONFIG_INTEL_IDLE
>> -extern int intel_idle_cpu_init(int cpu);
>>  #else
>> -static inline int intel_idle_cpu_init(int cpu) { return -1; }
>> -#endif
>> -
>> -#else
>> -static inline int intel_idle_cpu_init(int cpu) { return -1; }
>>
>>  static inline int cpuidle_register_governor(struct cpuidle_governor *=
gov)
>>  {return 0;}
>>
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
