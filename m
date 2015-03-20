From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] ARM64: cpuidle: Rename cpu_init_idle to a common
 function name
Date: Fri, 20 Mar 2015 17:01:00 +0100
Message-ID: <550C443C.8060305@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org> <1425385777-14766-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425385777-14766-5-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Catalin.Marinas-5wv7dgnIgG8@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/03/2015 01:29 PM, Daniel Lezcano wrote:
> With this change the cpuidle-arm64.c file calls the same function nam=
e
> for both ARM and ARM64.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Hi Catalin,

do you mind to ack the ARM64 if you agree with these changes ?

Thanks.

   -- Daniel

> ---
>   arch/arm64/include/asm/cpuidle.h | 4 ++--
>   arch/arm64/kernel/cpuidle.c      | 2 +-
>   drivers/cpuidle/cpuidle-arm64.c  | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/as=
m/cpuidle.h
> index 1bee287..2bc2732 100644
> --- a/arch/arm64/include/asm/cpuidle.h
> +++ b/arch/arm64/include/asm/cpuidle.h
> @@ -2,10 +2,10 @@
>   #define __ASM_CPUIDLE_H
>
>   #ifdef CONFIG_CPU_IDLE
> -extern int cpu_init_idle(unsigned int cpu);
> +extern int arm_cpuidle_init(unsigned int cpu);
>   extern int cpu_suspend(unsigned long arg);
>   #else
> -static inline int cpu_init_idle(unsigned int cpu)
> +static inline int arm_cpuidle_init(unsigned int cpu)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.=
c
> index 5c08966..a78143a 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -15,7 +15,7 @@
>   #include <asm/cpuidle.h>
>   #include <asm/cpu_ops.h>
>
> -int cpu_init_idle(unsigned int cpu)
> +int arm_cpuidle_init(unsigned int cpu)
>   {
>   	int ret =3D -EOPNOTSUPP;
>   	struct device_node *cpu_node =3D of_cpu_device_node_get(cpu);
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidl=
e-arm64.c
> index 0cea244..6ef291c7 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -110,7 +110,7 @@ static int __init arm64_idle_init(void)
>   	 * idle states suspend back-end specific data
>   	 */
>   	for_each_possible_cpu(cpu) {
> -		ret =3D cpu_init_idle(cpu);
> +		ret =3D arm_cpuidle_init(cpu);
>   		if (ret) {
>   			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>   			return ret;
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
