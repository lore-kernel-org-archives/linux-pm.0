From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: EXYNOS: Use wfi macro in platform_do_lowpower
Date: Thu, 22 May 2014 13:53:20 +0200
Message-ID: <537DE530.3050205@linaro.org>
References: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:51926 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbaEVLxI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 07:53:08 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so3283800wes.20
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2014 04:53:06 -0700 (PDT)
In-Reply-To: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leela Krishna Amudala <leela.krishna@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kgene.kim@samsung.com, amit.kucheria@linaro.org

On 05/22/2014 09:57 AM, Leela Krishna Amudala wrote:
> This patch is originally based on commit b3377d186572 ("ARM: 7064/1:
> vexpress: Use wfi macro in platform_do_lowpower.")
>
> Current Exynos CPU hotplug code includes a hardcoded WFI
> instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
> mode, this is invalid and causes the machine to hang hard when a CPU
> is offlined.
>
> Use wfi macro instead of the hardcoded WFI instruction.

Is it possible to change it for cpu_do_idle() ?

I guess, that should be backported to the previous kernel version, righ=
t=20
? (Cc stable@).

Thanks
   -- Daniel

> Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>
> ---
>   arch/arm/mach-exynos/hotplug.c |    8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/ho=
tplug.c
> index 69fa483..8a134d0 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -46,13 +46,7 @@ static inline void platform_do_lowpower(unsigned i=
nt cpu, int *spurious)
>   		if (cpu =3D=3D 1)
>   			exynos_cpu_power_down(cpu);
>
> -		/*
> -		 * here's the WFI
> -		 */
> -		asm(".word	0xe320f003\n"
> -		    :
> -		    :
> -		    : "memory", "cc");
> +		wfi();
>
>   		if (pen_release =3D=3D cpu_logical_map(cpu)) {
>   			/*
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

