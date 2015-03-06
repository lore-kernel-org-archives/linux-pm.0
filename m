From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 6/9] ARM: at91: time: move the system timer driver
 to drivers/clocksource
Date: Fri, 06 Mar 2015 09:36:01 +0100
Message-ID: <54F966F1.4090900@linaro.org>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com> <1425570594-13124-7-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425570594-13124-7-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/05/2015 04:49 PM, Alexandre Belloni wrote:
> Import at91rm9200_time.c from mach-at91 as timer-atmel-st.c. Further =
cleanup is
> required to get rid of the mach-at91 headers.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTGGXanvQGlWp@public.gmane.org=
m>
> Acked-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>   arch/arm/mach-at91/Makefile                                        =
   | 2 +-
>   drivers/clocksource/Kconfig                                        =
   | 4 ++++
>   drivers/clocksource/Makefile                                       =
   | 1 +
>   .../at91rm9200_time.c =3D> drivers/clocksource/timer-atmel-st.c    =
     | 0
>   4 files changed, 6 insertions(+), 1 deletion(-)
>   rename arch/arm/mach-at91/at91rm9200_time.c =3D> drivers/clocksourc=
e/timer-atmel-st.c (100%)
>
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefil=
e
> index 827fdbcce1c7..963c29169242 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -7,7 +7,7 @@ obj-y		:=3D setup.o
>   obj-$(CONFIG_SOC_AT91SAM9)	+=3D sam9_smc.o
>
>   # CPU-specific support
> -obj-$(CONFIG_SOC_AT91RM9200)	+=3D at91rm9200.o at91rm9200_time.o
> +obj-$(CONFIG_SOC_AT91RM9200)	+=3D at91rm9200.o
>   obj-$(CONFIG_SOC_AT91SAM9)	+=3D at91sam9.o
>   obj-$(CONFIG_SOC_SAMA5)		+=3D sama5.o
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> index 1c2506f68122..d1d15985a4ec 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -138,6 +138,10 @@ config ATMEL_PIT
>   	select CLKSRC_OF if OF
>   	def_bool SOC_AT91SAM9 || SOC_SAMA5
>
> +config ATMEL_ST
> +	select CLKSRC_OF if OF
> +	def_bool SOC_AT91RM9200
> +

H Alexandre,

the global policy is to enable the timer from the platform Kconfig.

So it should be:

config ATMEL_ST
	bool
	select CLKSRC_OF if OF

and change the mach's Kconfig to select this driver for the=20
corresponding platform.

>   config CLKSRC_METAG_GENERIC
>   	def_bool y if METAG
>   	help
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makef=
ile
> index 752d5c70b0ef..5b85f6adb258 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -1,5 +1,6 @@
>   obj-$(CONFIG_CLKSRC_OF)	+=3D clksrc-of.o
>   obj-$(CONFIG_ATMEL_PIT)		+=3D timer-atmel-pit.o
> +obj-$(CONFIG_ATMEL_ST)		+=3D timer-atmel-st.o
>   obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+=3D tcb_clksrc.o
>   obj-$(CONFIG_X86_PM_TIMER)	+=3D acpi_pm.o
>   obj-$(CONFIG_SCx200HR_TIMER)	+=3D scx200_hrt.o
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/drivers/clocksour=
ce/timer-atmel-st.c
> similarity index 100%
> rename from arch/arm/mach-at91/at91rm9200_time.c
> rename to drivers/clocksource/timer-atmel-st.c
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
