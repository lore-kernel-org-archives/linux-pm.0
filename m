From: Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH][V2] cpuidle : use percpu cpuidle in the core code
Date: Mon, 2 Apr 2012 15:59:19 +0300
Message-ID: <CAP245DVgy_-bROb+-RwpobCXJk-cg5fbtqRPBrHAu=rC=sjo8g@mail.gmail.com>
References: <1333370928-1930-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1333370928-1930-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, srivatsa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 2, 2012 at 3:48 PM, Daniel Lezcano
<daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> The usual cpuidle initialization routines are to register the

s/are to//

> driver, then register a cpuidle device per cpu.
>
> With the device's state count default initialization with the
> driver's state count, the code initialization remains mostly the
> same in the different drivers.

The following is a bit easier to read and captures your point, I think:

By default, most drivers initialize the device state count with the
driver state count.

> We can then add a new function 'cpuidle_register' where we register
> the driver and the devices. These devices can be defined in a global
> static variable in cpuidle.c. We will be able to factor out and
> remove a lot of duplicate lines of code.
>
> As we still have some drivers, with different initialization routines,
> we keep 'cpuidle_register_driver' and 'cpuidle_register_device' as low
> level initialization routines to do some specific operations on the
> cpuidle devices.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> =A0drivers/cpuidle/cpuidle.c | =A0 42 +++++++++++++++++++++++++++++++++++=
+++++++
> =A0include/linux/cpuidle.h =A0 | =A0 =A03 +++
> =A02 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 87411ce..151c55a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -23,6 +23,7 @@
> =A0#include "cpuidle.h"
>
> =A0DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> +DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
>
> =A0DEFINE_MUTEX(cpuidle_lock);
> =A0LIST_HEAD(cpuidle_detected_devices);
> @@ -419,6 +420,47 @@ int cpuidle_register_device(struct cpuidle_device *d=
ev)
>
> =A0EXPORT_SYMBOL_GPL(cpuidle_register_device);
>
> +/*
> + * cpuidle_register : register cpuidle driver and devices
> + * Note this function must be called after smp_init.
> + * @drv : the cpuidle driver
> + * Returns 0 on success, < 0 otherwise
> + */
> +int cpuidle_register(struct cpuidle_driver *drv)
> +{
> + =A0 =A0 =A0 int ret, cpu, i;
> + =A0 =A0 =A0 struct cpuidle_device *dev;
> +
> + =A0 =A0 =A0 ret =3D cpuidle_register_driver(drv);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 for_each_online_cpu(cpu) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D &per_cpu(cpuidle_device, cpu);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cpu =3D cpu;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cpuidle_register_device(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unregister;
> + =A0 =A0 =A0 }
> +
> +out:
> + =A0 =A0 =A0 return ret;
> +
> +out_unregister:
> + =A0 =A0 =A0 for_each_online_cpu(i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D cpu)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D &per_cpu(cpuidle_device, cpu);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_unregister_device(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cpuidle_unregister_driver(drv);
> +
> + =A0 =A0 =A0 goto out;
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_register);
> +
> =A0/**
> =A0* cpuidle_unregister_device - unregisters a CPU's idle PM feature
> =A0* @dev: the cpu
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 6c26a3d..3475294 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -135,6 +135,7 @@ struct cpuidle_driver {
> =A0#ifdef CONFIG_CPU_IDLE
> =A0extern void disable_cpuidle(void);
> =A0extern int cpuidle_idle_call(void);
> +extern int cpuidle_register(struct cpuidle_driver *drv);
> =A0extern int cpuidle_register_driver(struct cpuidle_driver *drv);
> =A0struct cpuidle_driver *cpuidle_get_driver(void);
> =A0extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
> @@ -154,6 +155,8 @@ extern int cpuidle_play_dead(void);
> =A0#else
> =A0static inline void disable_cpuidle(void) { }
> =A0static inline int cpuidle_idle_call(void) { return -ENODEV; }
> +static inline int cpuidle_register(struct cpuidle_driver *drv)
> +{return -ENODEV; }
> =A0static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
> =A0{return -ENODEV; }
> =A0static inline struct cpuidle_driver *cpuidle_get_driver(void) {return =
NULL; }
> --
> 1.7.5.4
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
