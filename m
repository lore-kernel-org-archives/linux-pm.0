From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 01/15] thermal: consistently use int for temperatures
Date: Wed, 20 May 2015 11:42:31 +0300
Message-ID: <555C48F7.4050009@kapsi.fi>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de> <1431507163-19933-2-git-send-email-s.hauer@pengutronix.de> <555C33EC.7050906@kapsi.fi> <20150520083454.GM6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520083454.GM6325@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 05/20/15 11:34, Sascha Hauer wrote:
> On Wed, May 20, 2015 at 10:12:44AM +0300, Mikko Perttunen wrote:
>> On 05/13/15 11:52, Sascha Hauer wrote:
>>> The thermal code uses int, long and unsigned long for temperatures
>>> in different places. Using an unsigned type limits the thermal framework
>>> to positive temperatures without need. 'long' is 64bit on several
>>> architectures which is not needed. Consistently use a plain 'int'
>>> for temperatures.
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> ---
>>> ...
>>
>> It looks like some longs remain in db8500_thermal.c, int340x_thermal/*,
>> intel_soc_dts_thermal.c, kirkwood_thermal.c, rockchip_thermal.c and
>> samsung/exynos_tmu.c. (found by 'grep -R long drivers/thermal/*)
>
> I looked over it again and found the following. Sorry, I really thought
> I had compile tested all drivers. I found nothing in db8500_thermal.c,
> intel_soc_dts_thermal.c and rockchip_thermal.c though. There are some
> (unsigned)longs used as temperatures in these files, but I haven't
> changed them on purpose to not make the patch bigger as necessary. I
> only changed the places where (unsigned)longs are used as pointers.
> Do you think it's necessary to change all temperatures, even the ones
> only used internally in drivers?
>
> Sascha

I guess changing just the framework interface would be fine for now,
though I don't think there are that many internal uses remaining either.

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

Cheers,
Mikko.

>
> -----------------------8<------------------
>
>>From 4cf8fe3b3ef1bd9db6090305ea2b9995f0dbffa4 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Wed, 20 May 2015 10:28:39 +0200
> Subject: [PATCH] fixup! thermal: consistently use int for temperatures
>
> ---
>   drivers/thermal/int340x_thermal/int3400_thermal.c          | 4 ++--
>   drivers/thermal/int340x_thermal/processor_thermal_device.c | 4 ++--
>   drivers/thermal/kirkwood_thermal.c                         | 2 +-
>   drivers/thermal/samsung/exynos_tmu.c                       | 2 +-
>   4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index 96bdf8a..5836e55 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -186,7 +186,7 @@ static int int3400_thermal_run_osc(acpi_handle handle,
>   }
>
>   static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
> -			unsigned long *temp)
> +			int *temp)
>   {
>   	*temp = 20 * 1000; /* faked temp sensor with 20C */
>   	return 0;
> @@ -231,7 +231,7 @@ static int int3400_thermal_set_mode(struct thermal_zone_device *thermal,
>   	return result;
>   }
>
> -static const struct thermal_zone_device_ops int3400_thermal_ops = {
> +static struct thermal_zone_device_ops int3400_thermal_ops = {
>   	.get_temp = int3400_thermal_get_temp,
>   };
>
> diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
> index 5e8d8e9..c8afd34 100644
> --- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
> @@ -139,7 +139,7 @@ static int get_tjmax(void)
>   	return -EINVAL;
>   }
>
> -static int read_temp_msr(unsigned long *temp)
> +static int read_temp_msr(int *temp)
>   {
>   	int cpu;
>   	u32 eax, edx;
> @@ -171,7 +171,7 @@ err_ret:
>   }
>
>   static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
> -					 unsigned long *temp)
> +					 int *temp)
>   {
>   	int ret;
>
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index abba3e2..5bcdbd6 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -33,7 +33,7 @@ struct kirkwood_thermal_priv {
>   };
>
>   static int kirkwood_get_temp(struct thermal_zone_device *thermal,
> -			  unsigned long *temp)
> +			  int *temp)
>   {
>   	unsigned long reg;
>   	struct kirkwood_thermal_priv *priv = thermal->devdata;
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 29eaf4d..ed55fd9 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -812,7 +812,7 @@ out:
>   #else
>   #define exynos4412_tmu_set_emulation NULL
>   #define exynos5440_tmu_set_emulation NULL
> -static int exynos_tmu_set_emulation(void *drv_data,	unsigned long temp)
> +static int exynos_tmu_set_emulation(void *drv_data, int temp)
>   	{ return -EINVAL; }
>   #endif /* CONFIG_THERMAL_EMULATION */
>
>
