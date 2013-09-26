From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/9] ARM: EXYNOS: cpuidle: fix AFTR mode check
Date: Thu, 26 Sep 2013 12:42:26 +0200
Message-ID: <52440F92.7070101@linaro.org>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com> <1377008627-32691-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:49723 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab3IZKma (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 06:42:30 -0400
Received: by mail-we0-f173.google.com with SMTP id w62so919658wes.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 03:42:29 -0700 (PDT)
In-Reply-To: <1377008627-32691-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, Kukjin Kim <kgene.kim@samsung.com>

On 08/20/2013 04:23 PM, Bartlomiej Zolnierkiewicz wrote:
> The EXYNOS cpuidle driver code assumes that cpuidle core will handle
> dev->state_count smaller than drv->state_count but currently this is
> untrue (dev->state_count is used only for handling cpuidle state sysf=
s
> entries and drv->state_count is used for all other cases) and will no=
t
> be fixed in the future as dev->state_count is planned to be removed.
>
> Fix the issue by checking for the max supported idle state in AFTR
> state's ->enter handler (exynos4_enter_lowpower()) and entering AFTR
> mode only when cores other than CPU0 are offline.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-exynos/cpuidle.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cp=
uidle.c
> index 225ee84..bb8c4e0 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -150,8 +150,8 @@ static int exynos4_enter_lowpower(struct cpuidle_=
device *dev,
>   {
>   	int new_index =3D index;
>
> -	/* This mode only can be entered when other core's are offline */
> -	if (num_online_cpus() > 1)
> +	/* AFTR can only be entered when cores other than CPU0 are offline =
*/
> +	if (num_online_cpus() > 1 || dev->cpu !=3D 0)
>   		new_index =3D drv->safe_state_index;
>
>   	if (new_index =3D=3D 0)
> @@ -210,10 +210,6 @@ static int __init exynos4_init_cpuidle(void)
>   		device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
>   		device->cpu =3D cpu_id;
>
> -		/* Support IDLE only */
> -		if (cpu_id !=3D 0)
> -			device->state_count =3D 1;
> -
>   		ret =3D cpuidle_register_device(device);
>   		if (ret) {
>   			printk(KERN_ERR "CPUidle register device failed\n");
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

