From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/4] ARM: exynos: cpuidle: Use the common cpuidle register
 routine
Date: Mon, 22 Jul 2013 06:36:46 +0200
Message-ID: <51ECB6DE.9060701@linaro.org>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org> <1374152070-21008-2-git-send-email-daniel.lezcano@linaro.org> <4097491.3y6BBYmzze@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47335 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3GVEgt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2013 00:36:49 -0400
Received: by mail-wg0-f44.google.com with SMTP id l18so627859wgh.23
        for <linux-pm@vger.kernel.org>; Sun, 21 Jul 2013 21:36:47 -0700 (PDT)
In-Reply-To: <4097491.3y6BBYmzze@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kgene.kim@samsung.com, rjw@sisk.pl, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 07/19/2013 06:03 PM, Bartlomiej Zolnierkiewicz wrote:
>=20
> Hi,
>=20
> On Thursday, July 18, 2013 02:54:28 PM Daniel Lezcano wrote:
>> Now we have the same routine than the one handled by the cpuidle fra=
mework.
>=20
> Small nitpick:
>=20
> To be exact the routine is not the same, on error cpuidle_register() =
does
> complete unregister operation of the cpuidle driver, exynos4_init_cpu=
idle()
> just stops the registration procedure.=20
>=20
> The change itself is okay but the patch description could be better.

Ok, I will fix the changelog.

> Anyway all patches (#1-4) look fine to me. Thanks for this work.

Thanks for the review. I assume it is an acked-by right ?

> Best regards,

Kukjin,

shall I take the patchset in my tree ?

Thanks
  -- Daniel

> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> =20
>> Let's use it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/mach-exynos/cpuidle.c |   24 +-----------------------
>>  1 file changed, 1 insertion(+), 23 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/c=
puidle.c
>> index cc4b097..d8fc1a2 100644
>> --- a/arch/arm/mach-exynos/cpuidle.c
>> +++ b/arch/arm/mach-exynos/cpuidle.c
>> @@ -41,8 +41,6 @@ static int exynos4_enter_lowpower(struct cpuidle_d=
evice *dev,
>>  				struct cpuidle_driver *drv,
>>  				int index);
>> =20
>> -static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device=
);
>> -
>>  static struct cpuidle_driver exynos4_idle_driver =3D {
>>  	.name			=3D "exynos4_idle",
>>  	.owner			=3D THIS_MODULE,
>> @@ -188,29 +186,9 @@ static void __init exynos5_core_down_clk(void)
>> =20
>>  static int __init exynos4_init_cpuidle(void)
>>  {
>> -	int cpu_id, ret;
>> -	struct cpuidle_device *device;
>> -
>>  	if (soc_is_exynos5250())
>>  		exynos5_core_down_clk();
>> =20
>> -	ret =3D cpuidle_register_driver(&exynos4_idle_driver);
>> -	if (ret) {
>> -		printk(KERN_ERR "CPUidle failed to register driver\n");
>> -		return ret;
>> -	}
>> -
>> -	for_each_online_cpu(cpu_id) {
>> -		device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
>> -		device->cpu =3D cpu_id;
>> -
>> -		ret =3D cpuidle_register_device(device);
>> -		if (ret) {
>> -			printk(KERN_ERR "CPUidle register device failed\n");
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	return 0;
>> +	return cpuidle_register(&exynos4_idle_driver, NULL);
>>  }
>>  device_initcall(exynos4_init_cpuidle);
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

