From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/9] POWERPC: pseries: cpuidle: use the common cpuidle_[un]register()
 routines
Date: Thu, 26 Sep 2013 12:47:42 +0200
Message-ID: <524410CE.2090807@linaro.org>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com> <1377008627-32691-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58144 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430Ab3IZKrt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 06:47:49 -0400
Received: by mail-wi0-f172.google.com with SMTP id hn9so6828774wib.11
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 03:47:48 -0700 (PDT)
In-Reply-To: <1377008627-32691-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

On 08/20/2013 04:23 PM, Bartlomiej Zolnierkiewicz wrote:
> It is now possible to use the common cpuidle_[un]register() routines
> (instead of open-coding them) so do it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/powerpc/platforms/pseries/processor_idle.c | 57 ++------------=
-----------
>   1 file changed, 3 insertions(+), 54 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/p=
owerpc/platforms/pseries/processor_idle.c
> index 23fc091..e4c1516 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -30,7 +30,6 @@ struct cpuidle_driver pseries_idle_driver =3D {
>   #define MAX_IDLE_STATE_COUNT	2
>
>   static int max_idle_state =3D MAX_IDLE_STATE_COUNT - 1;
> -static struct cpuidle_device __percpu *pseries_cpuidle_devices;
>   static struct cpuidle_state *cpuidle_state_table;
>
>   static inline void idle_loop_prolog(unsigned long *in_purr)
> @@ -193,7 +192,7 @@ static int pseries_cpuidle_add_cpu_notifier(struc=
t notifier_block *n,
>   {
>   	int hotcpu =3D (unsigned long)hcpu;
>   	struct cpuidle_device *dev =3D
> -			per_cpu_ptr(pseries_cpuidle_devices, hotcpu);
> +			per_cpu_ptr(cpuidle_devices, hotcpu);
>
>   	if (dev && cpuidle_get_driver()) {
>   		switch (action) {
> @@ -250,48 +249,6 @@ static int pseries_cpuidle_driver_init(void)
>   	return 0;
>   }
>
> -/* pseries_idle_devices_uninit(void)
> - * unregister cpuidle devices and de-allocate memory
> - */
> -static void pseries_idle_devices_uninit(void)
> -{
> -	int i;
> -	struct cpuidle_device *dev;
> -
> -	for_each_possible_cpu(i) {
> -		dev =3D per_cpu_ptr(pseries_cpuidle_devices, i);
> -		cpuidle_unregister_device(dev);
> -	}
> -
> -	free_percpu(pseries_cpuidle_devices);
> -	return;
> -}
> -
> -/* pseries_idle_devices_init()
> - * allocate, initialize and register cpuidle device
> - */
> -static int pseries_idle_devices_init(void)
> -{
> -	int i;
> -	struct cpuidle_device *dev;
> -
> -	pseries_cpuidle_devices =3D alloc_percpu(struct cpuidle_device);
> -	if (pseries_cpuidle_devices =3D=3D NULL)
> -		return -ENOMEM;
> -
> -	for_each_possible_cpu(i) {
> -		dev =3D per_cpu_ptr(pseries_cpuidle_devices, i);
> -		dev->cpu =3D i;
> -		if (cpuidle_register_device(dev)) {
> -			printk(KERN_DEBUG \
> -				"cpuidle_register_device %d failed!\n", i);
> -			return -EIO;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>   /*
>    * pseries_idle_probe()
>    * Choose state table for shared versus dedicated partition
> @@ -327,19 +284,12 @@ static int __init pseries_processor_idle_init(v=
oid)
>   		return retval;
>
>   	pseries_cpuidle_driver_init();
> -	retval =3D cpuidle_register_driver(&pseries_idle_driver);
> +	retval =3D cpuidle_register(&pseries_idle_driver, NULL);
>   	if (retval) {
>   		printk(KERN_DEBUG "Registration of pseries driver failed.\n");
>   		return retval;
>   	}
>
> -	retval =3D pseries_idle_devices_init();
> -	if (retval) {
> -		pseries_idle_devices_uninit();
> -		cpuidle_unregister_driver(&pseries_idle_driver);
> -		return retval;
> -	}
> -
>   	register_cpu_notifier(&setup_hotplug_notifier);
>   	printk(KERN_DEBUG "pseries_idle_driver registered\n");
>
> @@ -350,8 +300,7 @@ static void __exit pseries_processor_idle_exit(vo=
id)
>   {
>
>   	unregister_cpu_notifier(&setup_hotplug_notifier);
> -	pseries_idle_devices_uninit();
> -	cpuidle_unregister_driver(&pseries_idle_driver);
> +	cpuidle_unregister(&pseries_idle_driver);
>
>   	return;
>   }
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

