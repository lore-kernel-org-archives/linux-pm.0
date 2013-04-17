From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 06/19] cpuidle: make a single register function for
 all
Date: Wed, 17 Apr 2013 08:28:57 +0200
Message-ID: <516E4129.1090804@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-7-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34056 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965761Ab3DQG3Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 02:29:16 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so3345164wib.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2013 23:29:14 -0700 (PDT)
In-Reply-To: <1365770165-27096-7-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: andrew@lunn.ch, rob.herring@calxeda.com
Cc: rjw@sisk.pl, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

On 04/12/2013 02:35 PM, Daniel Lezcano wrote:
> The usual scheme to initialize a cpuidle driver on a SMP is:
>
> 	cpuidle_register_driver(drv);
> 	for_each_possible_cpu(cpu) {
> 		device =3D &per_cpu(cpuidle_dev, cpu);
> 		cpuidle_register_device(device);
> 	}
>
> This code is duplicated in each cpuidle driver.
>
> On UP systems, it is done this way:
>
> 	cpuidle_register_driver(drv);
> 	device =3D &per_cpu(cpuidle_dev, cpu);
> 	cpuidle_register_device(device);
>
> On UP, the macro 'for_each_cpu' does one iteration:
>
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask)
>
> Hence, the initialization loop is the same for UP than SMP.
>
> Beside, we saw different bugs / mis-initialization / return code unch=
ecked in
> the different drivers, the code is duplicated including bugs. After f=
ixing all
> these ones, it appears the initialization pattern is the same for eve=
ryone.
>
> Please note, some drivers are doing dev->state_count =3D drv->state_c=
ount. This is
> not necessary because it is done by the cpuidle_enable_device functio=
n in the
> cpuidle framework. This is true, until you have the same states for a=
ll your
> devices. Otherwise, the 'low level' API should be used instead with t=
he specific
> initialization for the driver.
>
> Let's add a wrapper function doing this initialization with a cpumask=
 parameter
> for the coupled idle states and use it for all the drivers.
>
> That will save a lot of LOC, consolidate the code, and the modificati=
ons in the
> future could be done in a single place. Another benefit is the consol=
idation of
> the cpuidle_device variable which is now in the cpuidle framework and=
 no longer
> spread accross the different arch specific drivers.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Rob, Andrew,

are you ok with this new version ?

Thanks
-- Daniel

>  Documentation/cpuidle/driver.txt |    6 ++++
>  drivers/cpuidle/cpuidle.c        |   72 ++++++++++++++++++++++++++++=
++++++++++
>  include/linux/cpuidle.h          |    9 +++--
>  3 files changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/cpuidle/driver.txt b/Documentation/cpuidle=
/driver.txt
> index 7a9e09e..1b0d81d 100644
> --- a/Documentation/cpuidle/driver.txt
> +++ b/Documentation/cpuidle/driver.txt
> @@ -15,11 +15,17 @@ has mechanisms in place to support actual entry-e=
xit into CPU idle states.
>  cpuidle driver initializes the cpuidle_device structure for each CPU=
 device
>  and registers with cpuidle using cpuidle_register_device.
> =20
> +If all the idle states are the same, the wrapper function cpuidle_re=
gister
> +could be used instead.
> +
>  It can also support the dynamic changes (like battery <-> AC), by us=
ing
>  cpuidle_pause_and_lock, cpuidle_disable_device and cpuidle_enable_de=
vice,
>  cpuidle_resume_and_unlock.
> =20
>  Interfaces:
> +extern int cpuidle_register(struct cpuidle_driver *drv,
> +                            const struct cpumask *const coupled_cpus=
);
> +extern int cpuidle_unregister(struct cpuidle_driver *drv);
>  extern int cpuidle_register_driver(struct cpuidle_driver *drv);
>  extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
>  extern int cpuidle_register_device(struct cpuidle_device *dev);
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0da795b..49e8d30 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -24,6 +24,7 @@
>  #include "cpuidle.h"
> =20
>  DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> +DEFINE_PER_CPU(struct cpuidle_device, cpuidle_dev);
> =20
>  DEFINE_MUTEX(cpuidle_lock);
>  LIST_HEAD(cpuidle_detected_devices);
> @@ -453,6 +454,77 @@ void cpuidle_unregister_device(struct cpuidle_de=
vice *dev)
> =20
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
> =20
> +/*
> + * cpuidle_unregister: unregister a driver and the devices. This fun=
ction
> + * can be used only if the driver has been previously registered thr=
ough
> + * the cpuidle_register function.
> + *
> + * @drv: a valid pointer to a struct cpuidle_driver
> + */
> +void cpuidle_unregister(struct cpuidle_driver *drv)
> +{
> +	int cpu;
> +	struct cpuidle_device *device;
> +
> +	for_each_possible_cpu(cpu) {
> +		device =3D &per_cpu(cpuidle_dev, cpu);
> +		cpuidle_unregister_device(device);
> +	}
> +
> +	cpuidle_unregister_driver(drv);
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_unregister);
> +
> +/**
> + * cpuidle_register: registers the driver and the cpu devices with t=
he
> + * coupled_cpus passed as parameter. This function is used for all c=
ommon
> + * initialization pattern there are in the arch specific drivers. Th=
e
> + * devices is globally defined in this file.
> + *
> + * @drv         : a valid pointer to a struct cpuidle_driver
> + * @coupled_cpus: a cpumask for the coupled states
> + *
> + * Returns 0 on success, < 0 otherwise
> + */
> +int cpuidle_register(struct cpuidle_driver *drv,
> +		     const struct cpumask *const coupled_cpus)
> +{
> +	int ret, cpu;
> +	struct cpuidle_device *device;
> +
> +	ret =3D cpuidle_register_driver(drv);
> +	if (ret) {
> +		pr_err("failed to register cpuidle driver\n");
> +		return ret;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		device =3D &per_cpu(cpuidle_dev, cpu);
> +		device->cpu =3D cpu;
> +
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +		/*
> +		 * On multiplatform for ARM, the coupled idle states could
> +		 * enabled in the kernel even if the cpuidle driver does not
> +		 * use it. Note, coupled_cpus is a struct copy.
> +		 */
> +		if (coupled_cpus)
> +			device->coupled_cpus =3D *coupled_cpus;
> +#endif
> +		ret =3D cpuidle_register_device(device);
> +		if (!ret)
> +			continue;
> +
> +		pr_err("Failed to register cpuidle device for cpu%d\n", cpu);
> +
> +		cpuidle_unregister(drv);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_register);
> +
>  #ifdef CONFIG_SMP
> =20
>  static void smp_callback(void *v)
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 79e3811..3c86faa 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -123,7 +123,9 @@ extern void cpuidle_driver_unref(void);
>  extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
>  extern int cpuidle_register_device(struct cpuidle_device *dev);
>  extern void cpuidle_unregister_device(struct cpuidle_device *dev);
> -
> +extern int cpuidle_register(struct cpuidle_driver *drv,
> +			    const struct cpumask *const coupled_cpus);
> +extern void cpuidle_unregister(struct cpuidle_driver *drv);
>  extern void cpuidle_pause_and_lock(void);
>  extern void cpuidle_resume_and_unlock(void);
>  extern void cpuidle_pause(void);
> @@ -148,7 +150,10 @@ static inline void cpuidle_unregister_driver(str=
uct cpuidle_driver *drv) { }
>  static inline int cpuidle_register_device(struct cpuidle_device *dev=
)
>  {return -ENODEV; }
>  static inline void cpuidle_unregister_device(struct cpuidle_device *=
dev) { }
> -
> +static inline int cpuidle_register(struct cpuidle_driver *drv,
> +				   const struct cpumask *const coupled_cpus)
> +{return -ENODEV; }
> +static inline void cpuidle_unregister(struct cpuidle_driver *drv) { =
}
>  static inline void cpuidle_pause_and_lock(void) { }
>  static inline void cpuidle_resume_and_unlock(void) { }
>  static inline void cpuidle_pause(void) { }


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

