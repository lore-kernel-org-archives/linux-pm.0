From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle - fix lock contention in the idle path
Date: Sat, 29 Dec 2012 11:03:03 +0100
Message-ID: <50DEBFD7.5000104@linaro.org>
References: <1356516108-11191-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:62855 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab2L2KZY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 29 Dec 2012 05:25:24 -0500
Received: by mail-ea0-f182.google.com with SMTP id a14so4703033eaa.13
        for <linux-pm@vger.kernel.org>; Sat, 29 Dec 2012 02:25:22 -0800 (PST)
In-Reply-To: <1356516108-11191-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, rja@sgi.com
Cc: linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org


Hi Russ,

Is it possible you try this patch on your 2048 cpus ?

Thanks

  -- Daniel

On 12/26/2012 11:01 AM, Daniel Lezcano wrote:
> The commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 introduces
> a lock in the cpuidle_get_cpu_driver function. This function
> is used in the idle_call function.
>=20
> The problem is the contention with a large number of cpus because
> they try to access the idle routine at the same time.
>=20
> The lock could be safely removed because of how is used the
> cpuidle api. The cpuidle_register_driver is called first but
> until the cpuidle_register_device is not called we don't
> enter in the cpuidle idle call function because the device
> is not enabled.
>=20
> The cpuidle_unregister_driver function, leading the a NULL driver,
> is not called before the cpuidle_unregister_device.
>=20
> This is how is used the cpuidle api from the different drivers.
>=20
> However, a cleanup around the lock and a proper refcounting
> mechanism should be used to ensure the consistency in the api,
> like cpuidle_unregister_driver should failed if its refcounting
> is not 0.
>=20
> These modifications will need some code reorganization and rewrite
> which does not fit with a fix.
>=20
> The following patch is a hot fix by returning to the initial behavior
> by removing the lock when getting the driver.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/driver.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 3af841f..c2b281a 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -235,16 +235,10 @@ EXPORT_SYMBOL_GPL(cpuidle_get_driver);
>   */
>  struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device =
*dev)
>  {
> -	struct cpuidle_driver *drv;
> -
>  	if (!dev)
>  		return NULL;
> =20
> -	spin_lock(&cpuidle_driver_lock);
> -	drv =3D __cpuidle_get_cpu_driver(dev->cpu);
> -	spin_unlock(&cpuidle_driver_lock);
> -
> -	return drv;
> +	return __cpuidle_get_cpu_driver(dev->cpu);
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

