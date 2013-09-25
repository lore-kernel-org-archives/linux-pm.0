From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 19/21] cpuidle: create list of registered drivers
Date: Thu, 26 Sep 2013 00:30:51 +0200
Message-ID: <5243641B.6050604@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <7e9565e323c1e065eeb2a2a1075967bd21ee6066.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:65469 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab3IYWay (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 18:30:54 -0400
Received: by mail-wg0-f45.google.com with SMTP id y10so337513wgg.24
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 15:30:53 -0700 (PDT)
In-Reply-To: <7e9565e323c1e065eeb2a2a1075967bd21ee6066.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> Currently we have multiple definitions of few routines based on follo=
wing config
> option: CONFIG_CPU_IDLE_MULTIPLE_DRIVERS.
>=20
> These are present to save space by not creating per-cpu variable for =
platforms
> which need only one cpuidle driver to be registered for all CPUs.
>=20
> But this setup has a problem. For ARM multi-platform kernel use case =
this option
> will get enabled and so we will have per-cpu variables even for platf=
orms that
> don't need it.
>=20
> The bigger problem is two separate code paths for such platforms for =
single &
> multi platform kernels. Which doesn't sound good.
>=20
> A better way of solving this problem would be to create cpuidle drive=
r's list
> that can be used to manage all information we need. Then we don't rea=
lly have to
> write any special code for handling platforms with
> CONFIG_CPU_IDLE_MULTIPLE_DRIVERS option set.
>=20
> This patch does it.

If you introduce a list, you will have to introduce a lock to protect
it. This lock will be in the fast path cpuidle_idle_call with the
get_driver function and conforming to the comment: "NOTE: no locks or
semaphores should be used here".

A lock has been introduced in this function already and the system hang=
s
with 1024 cpus.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpuidle/driver.c | 106 ++++++++++++-------------------------=
----------
>  include/linux/cpuidle.h  |   1 +
>  2 files changed, 27 insertions(+), 80 deletions(-)
>=20
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index a4a93b4..320b4ec 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -18,10 +18,19 @@
>  #include "cpuidle.h"
> =20
>  DEFINE_SPINLOCK(cpuidle_driver_lock);
> +static LIST_HEAD(cpuidle_detected_drivers);
> =20
> -#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
> +static inline struct cpuidle_driver *
> +__cpuidle_get_driver(const struct cpumask *cpumask)
> +{
> +	struct cpuidle_driver *drv;
> +
> +	list_for_each_entry(drv, &cpuidle_detected_drivers, driver_list)
> +		if (cpumask_intersects(drv->cpumask, cpumask))
> +			return drv;
> =20
> -static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
> +	return NULL;
> +}
> =20
>  /**
>   * __cpuidle_get_cpu_driver - return the cpuidle driver tied to a CP=
U.
> @@ -32,103 +41,39 @@ static DEFINE_PER_CPU(struct cpuidle_driver *, c=
puidle_drivers);
>   */
>  static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cp=
u)
>  {
> -	return per_cpu(cpuidle_drivers, cpu);
> +	return __cpuidle_get_driver(cpumask_of(cpu));
>  }
> =20
>  /**
> - * __cpuidle_unset_driver - unset per CPU driver variables.
> + * __cpuidle_add_driver - adds a cpuidle driver to list.
>   * @drv: a valid pointer to a struct cpuidle_driver
>   *
> - * For each CPU in the driver's CPU mask, unset the registered drive=
r per CPU
> - * variable. If @drv is different from the registered driver, the co=
rresponding
> - * variable is not cleared.
> - */
> -static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv=
)
> -{
> -	int cpu;
> -
> -	for_each_cpu(cpu, drv->cpumask) {
> -
> -		if (drv !=3D __cpuidle_get_cpu_driver(cpu))
> -			continue;
> -
> -		per_cpu(cpuidle_drivers, cpu) =3D NULL;
> -	}
> -}
> -
> -/**
> - * __cpuidle_set_driver - set per CPU driver variables for the given=
 driver.
> - * @drv: a valid pointer to a struct cpuidle_driver
> - *
> - * For each CPU in the driver's cpumask, unset the registered driver=
 per CPU
> - * to @drv.
> + * Adds cpuidle driver to cpuidle_detected_drivers list if no driver=
 is already
> + * registered for any CPUs present in drv->cpumask.
>   *
>   * Returns 0 on success, -EBUSY if the CPUs have driver(s) already.
>   */
> -static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
> -{
> -	int cpu;
> -
> -	for_each_cpu(cpu, drv->cpumask) {
> -
> -		if (__cpuidle_get_cpu_driver(cpu)) {
> -			__cpuidle_unset_driver(drv);
> -			return -EBUSY;
> -		}
> -
> -		per_cpu(cpuidle_drivers, cpu) =3D drv;
> -	}
> -
> -	return 0;
> -}
> -
> -#else
> -
> -static struct cpuidle_driver *cpuidle_curr_driver;
> -
> -/**
> - * __cpuidle_get_cpu_driver - return the global cpuidle driver point=
er.
> - * @cpu: ignored without the multiple driver support
> - *
> - * Return a pointer to a struct cpuidle_driver object or NULL if no =
driver was
> - * previously registered.
> - */
> -static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cp=
u)
> -{
> -	return cpuidle_curr_driver;
> -}
> -
> -/**
> - * __cpuidle_set_driver - assign the global cpuidle driver variable.
> - * @drv: pointer to a struct cpuidle_driver object
> - *
> - * Returns 0 on success, -EBUSY if the driver is already registered.
> - */
> -static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
> +static inline int __cpuidle_add_driver(struct cpuidle_driver *drv)
>  {
> -	if (cpuidle_curr_driver)
> +	if (__cpuidle_get_driver(drv->cpumask))
>  		return -EBUSY;
> =20
> -	cpuidle_curr_driver =3D drv;
> +	list_add(&drv->driver_list, &cpuidle_detected_drivers);
> =20
>  	return 0;
>  }
> =20
>  /**
> - * __cpuidle_unset_driver - unset the global cpuidle driver variable=
=2E
> - * @drv: a pointer to a struct cpuidle_driver
> + * __cpuidle_remove_driver - remove cpuidle driver from list.
> + * @drv: a valid pointer to a struct cpuidle_driver
>   *
> - * Reset the global cpuidle variable to NULL.  If @drv does not matc=
h the
> - * registered driver, do nothing.
> + * Removes cpuidle driver from cpuidle_detected_drivers list.
>   */
> -static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv=
)
> +static inline void __cpuidle_remove_driver(struct cpuidle_driver *dr=
v)
>  {
> -	if (drv =3D=3D cpuidle_curr_driver)
> -		cpuidle_curr_driver =3D NULL;
> +	list_del(&drv->driver_list);
>  }
> =20
> -#endif
> -
>  /**
>   * cpuidle_setup_broadcast_timer - enable/disable the broadcast time=
r
>   * @arg: a void pointer used to match the SMP cross call API
> @@ -158,6 +103,7 @@ static void __cpuidle_driver_init(struct cpuidle_=
driver *drv)
>  	int i;
> =20
>  	drv->refcnt =3D 0;
> +	INIT_LIST_HEAD(&drv->driver_list);
> =20
>  	/*
>  	 * Use all possible CPUs as the default, because if the kernel boot=
s
> @@ -244,7 +190,7 @@ static int __cpuidle_register_driver(struct cpuid=
le_driver *drv)
> =20
>  	__cpuidle_driver_init(drv);
> =20
> -	ret =3D __cpuidle_set_driver(drv);
> +	ret =3D __cpuidle_add_driver(drv);
>  	if (ret)
>  		return ret;
> =20
> @@ -277,7 +223,7 @@ static void __cpuidle_unregister_driver(struct cp=
uidle_driver *drv)
>  				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
>  	}
> =20
> -	__cpuidle_unset_driver(drv);
> +	__cpuidle_remove_driver(drv);
>  }
> =20
>  /**
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 0f0da17..81b74d2 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -129,6 +129,7 @@ struct cpuidle_driver {
> =20
>  	/* the driver handles the cpus in cpumask */
>  	struct cpumask		*cpumask;
> +	struct list_head	driver_list;
>  };
> =20
>  #ifdef CONFIG_CPU_IDLE
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

