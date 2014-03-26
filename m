From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: clps711x: Switch CLPS711X subarch to use cpuidle
 driver
Date: Wed, 26 Mar 2014 12:03:16 +0100
Message-ID: <5332B3F4.4010408@linaro.org>
References: <1395467076-29462-1-git-send-email-shc_work@mail.ru> <1395467076-29462-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52095 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaCZLDR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 07:03:17 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so1316995lbg.25
        for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2014 04:03:15 -0700 (PDT)
In-Reply-To: <1395467076-29462-2-git-send-email-shc_work@mail.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>

On 03/22/2014 06:44 AM, Alexander Shiyan wrote:
> This patch removes old support for cpuidle and switches all current
> users to use new cpuidle driver.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Hi Alexander,

this patch does not apply. Could you respin it against 3.14-rc8.

Thanks
   -- Daniel

> ---
>   arch/arm/mach-clps711x/board-autcpu12.c |  1 -
>   arch/arm/mach-clps711x/board-cdb89712.c |  1 -
>   arch/arm/mach-clps711x/board-clep7312.c |  1 -
>   arch/arm/mach-clps711x/board-edb7211.c  |  1 -
>   arch/arm/mach-clps711x/board-p720t.c    |  1 -
>   arch/arm/mach-clps711x/common.c         | 12 ------------
>   arch/arm/mach-clps711x/common.h         |  1 -
>   arch/arm/mach-clps711x/devices.c        | 10 ++++++++++
>   8 files changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-=
clps711x/board-autcpu12.c
> index d62ca16..45abf6b 100644
> --- a/arch/arm/mach-clps711x/board-autcpu12.c
> +++ b/arch/arm/mach-clps711x/board-autcpu12.c
> @@ -266,7 +266,6 @@ MACHINE_START(AUTCPU12, "autronix autcpu12")
>   	/* Maintainer: Thomas Gleixner */
>   	.atag_offset	=3D 0x20000,
>   	.map_io		=3D clps711x_map_io,
> -	.init_early	=3D clps711x_init_early,
>   	.init_irq	=3D clps711x_init_irq,
>   	.init_time	=3D clps711x_timer_init,
>   	.init_machine	=3D autcpu12_init,
> diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-=
clps711x/board-cdb89712.c
> index e261a47..1ec378c 100644
> --- a/arch/arm/mach-clps711x/board-cdb89712.c
> +++ b/arch/arm/mach-clps711x/board-cdb89712.c
> @@ -140,7 +140,6 @@ MACHINE_START(CDB89712, "Cirrus-CDB89712")
>   	/* Maintainer: Ray Lehtiniemi */
>   	.atag_offset	=3D 0x100,
>   	.map_io		=3D clps711x_map_io,
> -	.init_early	=3D clps711x_init_early,
>   	.init_irq	=3D clps711x_init_irq,
>   	.init_time	=3D clps711x_timer_init,
>   	.init_machine	=3D cdb89712_init,
> diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-=
clps711x/board-clep7312.c
> index 221b9de..1f3b403 100644
> --- a/arch/arm/mach-clps711x/board-clep7312.c
> +++ b/arch/arm/mach-clps711x/board-clep7312.c
> @@ -38,7 +38,6 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
>   	.atag_offset	=3D 0x0100,
>   	.fixup		=3D fixup_clep7312,
>   	.map_io		=3D clps711x_map_io,
> -	.init_early	=3D clps711x_init_early,
>   	.init_irq	=3D clps711x_init_irq,
>   	.init_time	=3D clps711x_timer_init,
>   	.restart	=3D clps711x_restart,
> diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-c=
lps711x/board-edb7211.c
> index 0776098..fa4580f 100644
> --- a/arch/arm/mach-clps711x/board-edb7211.c
> +++ b/arch/arm/mach-clps711x/board-edb7211.c
> @@ -180,7 +180,6 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval b=
oard)")
>   	.fixup		=3D fixup_edb7211,
>   	.reserve	=3D edb7211_reserve,
>   	.map_io		=3D clps711x_map_io,
> -	.init_early	=3D clps711x_init_early,
>   	.init_irq	=3D clps711x_init_irq,
>   	.init_time	=3D clps711x_timer_init,
>   	.init_machine	=3D edb7211_init,
> diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clp=
s711x/board-p720t.c
> index 67b7337..4a2ec28 100644
> --- a/arch/arm/mach-clps711x/board-p720t.c
> +++ b/arch/arm/mach-clps711x/board-p720t.c
> @@ -365,7 +365,6 @@ MACHINE_START(P720T, "ARM-Prospector720T")
>   	.atag_offset	=3D 0x100,
>   	.fixup		=3D fixup_p720t,
>   	.map_io		=3D clps711x_map_io,
> -	.init_early	=3D clps711x_init_early,
>   	.init_irq	=3D clps711x_init_irq,
>   	.init_time	=3D clps711x_timer_init,
>   	.init_machine	=3D p720t_init,
> diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x=
/common.c
> index aee81fa..2a6323b 100644
> --- a/arch/arm/mach-clps711x/common.c
> +++ b/arch/arm/mach-clps711x/common.c
> @@ -193,15 +193,3 @@ void clps711x_restart(enum reboot_mode mode, con=
st char *cmd)
>   {
>   	soft_restart(0);
>   }
> -
> -static void clps711x_idle(void)
> -{
> -	clps_writel(1, HALT);
> -	asm("mov r0, r0");
> -	asm("mov r0, r0");
> -}
> -
> -void __init clps711x_init_early(void)
> -{
> -	arm_pm_idle =3D clps711x_idle;
> -}
> diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x=
/common.h
> index 7489139..f881899 100644
> --- a/arch/arm/mach-clps711x/common.h
> +++ b/arch/arm/mach-clps711x/common.h
> @@ -13,7 +13,6 @@ extern void clps711x_map_io(void);
>   extern void clps711x_init_irq(void);
>   extern void clps711x_timer_init(void);
>   extern void clps711x_restart(enum reboot_mode mode, const char *cmd=
);
> -extern void clps711x_init_early(void);
>
>   /* drivers/irqchip/irq-clps711x.c */
>   void clps711x_intc_init(phys_addr_t, resource_size_t);
> diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711=
x/devices.c
> index 2001488..0c689d3 100644
> --- a/arch/arm/mach-clps711x/devices.c
> +++ b/arch/arm/mach-clps711x/devices.c
> @@ -14,6 +14,15 @@
>
>   #include <mach/hardware.h>
>
> +static const struct resource clps711x_cpuidle_res __initconst =3D
> +	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + HALT, SZ_128);
> +
> +static void __init clps711x_add_cpuidle(void)
> +{
> +	platform_device_register_simple("clps711x-cpuidle", PLATFORM_DEVID_=
NONE,
> +					&clps711x_cpuidle_res, 1);
> +}
> +
>   static const phys_addr_t clps711x_gpios[][2] __initconst =3D {
>   	{ PADR, PADDR },
>   	{ PBDR, PBDDR },
> @@ -83,6 +92,7 @@ static void __init clps711x_add_uart(void)
>
>   void __init clps711x_devices_init(void)
>   {
> +	clps711x_add_cpuidle();
>   	clps711x_add_gpio();
>   	clps711x_add_syscon();
>   	clps711x_add_uart();
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

