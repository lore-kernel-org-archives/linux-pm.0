From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/9] POWERPC: pseries: cpuidle: remove superfluous dev->state_count
 initialization
Date: Thu, 26 Sep 2013 12:45:53 +0200
Message-ID: <52441061.8090704@linaro.org>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com> <1377008627-32691-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:42685 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab3IZKp4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 06:45:56 -0400
Received: by mail-we0-f173.google.com with SMTP id w62so941915wes.32
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 03:45:55 -0700 (PDT)
In-Reply-To: <1377008627-32691-3-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

On 08/20/2013 04:23 PM, Bartlomiej Zolnierkiewicz wrote:
> pseries cpuidle driver sets dev->state_count to drv->state_count so
> the default dev->state_count initialization in cpuidle_enable_device(=
)
> (called from cpuidle_register_device()) can be used instead.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/powerpc/platforms/pseries/processor_idle.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/p=
owerpc/platforms/pseries/processor_idle.c
> index 14899b1..23fc091 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -273,7 +273,6 @@ static void pseries_idle_devices_uninit(void)
>   static int pseries_idle_devices_init(void)
>   {
>   	int i;
> -	struct cpuidle_driver *drv =3D &pseries_idle_driver;
>   	struct cpuidle_device *dev;
>
>   	pseries_cpuidle_devices =3D alloc_percpu(struct cpuidle_device);
> @@ -282,7 +281,6 @@ static int pseries_idle_devices_init(void)
>
>   	for_each_possible_cpu(i) {
>   		dev =3D per_cpu_ptr(pseries_cpuidle_devices, i);
> -		dev->state_count =3D drv->state_count;
>   		dev->cpu =3D i;
>   		if (cpuidle_register_device(dev)) {
>   			printk(KERN_DEBUG \
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

