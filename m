From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] power: supply: ucs1002: Fix build error without
 CONFIG_REGULATOR
Date: Fri, 10 May 2019 06:05:06 -0700
Message-ID: <9b37be09-c323-94c6-8bba-44e854597e95@roeck-us.net>
References: <20190510071823.2984-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510071823.2984-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, sre@kernel.org, andrew.smirnov@gmail.com, sebastian.reichel@collabora.com, enric.balletbo@collabora.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 5/10/19 12:18 AM, YueHaibing wrote:
> Fix gcc build error while CONFIG_REGULATOR is not set
> 
> drivers/power/supply/ucs1002_power.o: In function `ucs1002_probe':
> drivers/power/supply/ucs1002_power.c:593: undefined reference to `devm_regulator_register'
> drivers/power/supply/ucs1002_power.o:(.rodata+0x3b8): undefined reference to `regulator_enable_regmap'
> drivers/power/supply/ucs1002_power.o:(.rodata+0x3c0): undefined reference to `regulator_disable_regmap'
> drivers/power/supply/ucs1002_power.o:(.rodata+0x3c8): undefined reference to `regulator_is_enabled_regmap'
> 
> Add Kconfig dependency to CONFIG_REGULATOR.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 9a2688e42638 ("power: supply: Add driver for Microchip UCS1002")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/power/supply/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index ef36bd2..26dacda 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -682,6 +682,7 @@ config CHARGER_UCS1002
>   	tristate "Microchip UCS1002 USB Port Power Controller"
>   	depends on I2C
>   	depends on OF
> +	depends on REGULATOR
>   	select REGMAP_I2C
>   	help
>   	  Say Y to enable support for Microchip UCS1002 Programmable
> 
