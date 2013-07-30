From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
Date: Tue, 30 Jul 2013 11:28:15 +0200
Message-ID: <51F7872F.30101@linaro.org>
References: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:53848 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab3G3J2P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 05:28:15 -0400
Received: by mail-wi0-f175.google.com with SMTP id hq12so2487161wib.14
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2013 02:28:14 -0700 (PDT)
In-Reply-To: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 07/30/2013 08:55 AM, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> After __cpuidle_register_device, the cpu incs are added up, but decs
> are not, thus the module refcount is not match. So the module "exit"
> function can not be executed when we do remove operation. Move
> module_put into __cpuidle_register_device to fix it.

Sorry, I still don't get it :/

register->module_get
unregister->module_put

you change it by:

register->module_get
register->module_put
unregister->none

which is wrong.

Can you describe the problem you are facing ? (a bit more than "I can't
unload the module").

> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index d75040d..e964ada 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -351,11 +351,8 @@ EXPORT_SYMBOL_GPL(cpuidle_disable_device);
> =20
>  static void __cpuidle_unregister_device(struct cpuidle_device *dev)
>  {
> -	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> -
>  	list_del(&dev->device_list);
>  	per_cpu(cpuidle_devices, dev->cpu) =3D NULL;
> -	module_put(drv->owner);
>  }
> =20
>  static int __cpuidle_device_init(struct cpuidle_device *dev)
> @@ -384,6 +381,8 @@ static int __cpuidle_register_device(struct cpuid=
le_device *dev)
>  	per_cpu(cpuidle_devices, dev->cpu) =3D dev;
>  	list_add(&dev->device_list, &cpuidle_detected_devices);
> =20
> +	module_put(drv->owner);
> +
>  	ret =3D cpuidle_coupled_register_device(dev);
>  	if (ret) {
>  		__cpuidle_unregister_device(dev);
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

