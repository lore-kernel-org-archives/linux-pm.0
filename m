From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 2/3] power: supply: Add driver for Microchip UCS1002
Date: Tue, 30 Apr 2019 20:43:24 -0700
Message-ID: <7002fe8e-7686-fe84-374f-766f99f8317d@infradead.org>
References: <20190501033434.18548-1-andrew.smirnov@gmail.com>
 <20190501033434.18548-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501033434.18548-3-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 4/30/19 8:34 PM, Andrey Smirnov wrote:
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..c614c8a196f3 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
>  	 Say Y here to enable support for fuel gauge with SC27XX
>  	 PMIC chips.
>  
> +config CHARGER_UCS1002
> +        tristate "Microchip UCS1002 USB Port Power Controller"

Please indent the tristate line with a tab instead of spaces.

> +	depends on I2C
> +	depends on OF
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for Microchip UCS1002 Programmable
> +	  USB Port Power Controller with Charger Emulation.
> +
>  endif # POWER_SUPPLY


thnx.
-- 
~Randy
