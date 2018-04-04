From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/3] adp5061: New driver for ADP5061 I2C battery charger
Date: Wed, 4 Apr 2018 10:33:56 -0700
Message-ID: <66d5534b-d383-733e-8e56-992dfec6ee90@infradead.org>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Popa <stefan.popa@analog.com>, sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: davem@davemloft.net, mchehab@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
one small typo below:

On 04/04/2018 01:17 AM, Stefan Popa wrote:

> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 428b426..761cc52 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -75,6 +75,17 @@ config BATTERY_88PM860X
>  	help
>  	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
>  
> +config CHARGER_ADP5061
> +	tristate "ADP5061 battery charger driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to enable support for the ADP5061 standalone battery
> +	  charger.
> +
> +	  This driver can be build as a module. If so, the module will be

	                     built

> +	  called adp5061.
> +
>  config BATTERY_ACT8945A
>  	tristate "Active-semi ACT8945A charger driver"
>  	depends on MFD_ACT8945A || COMPILE_TEST


-- 
~Randy
