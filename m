From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Revert "Remove unneeded
 dependency in Kconfig"
Date: Mon, 9 Nov 2015 10:56:13 -0600
Message-ID: <5640D02D.6040601@ti.com>
References: <3819790.E2ziFviWmU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <3819790.E2ziFviWmU@wuerfel>
Sender: linux-i2c-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Pali Rohar <pali.rohar@gmail.com>, Xiong Zhou <jencce.kernel@gmail.com>, linux-i2c@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 11/09/2015 07:50 AM, Arnd Bergmann wrote:
> The dependency was clearly needed, without it it is possible to
> build the core i2c driver as a loadable module and the bq27xxx
> driver built-in, which results in link errors:
>
> drivers/built-in.o: In function `bq27xxx_battery_i2c_read':
> binder.c:(.text+0x360bf0): undefined reference to `i2c_transfer'
> binder.c:(.text+0x360c10): undefined reference to `i2c_transfer'
> drivers/built-in.o: In function `bq27xxx_battery_init':
> binder.c:(.init.text+0xe668): undefined reference to `i2c_register_driver'
> drivers/built-in.o: In function `bq27xxx_battery_exit':
> binder.c:(.exit.text+0x1a0c): undefined reference to `i2c_del_driver'
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6bd03ce3c12a ("power: bq27xxx_battery: Remove unneeded dependency in Kconfig")
> ---
> The bug was originally found and fixed by Xiong Zhou, but Andrew Davis
> broke it again by reverting the fix.
>
> I found it today on my ARM randconfig builds.
>
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 237d7aa73e8c..9f53fb74ae6f 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -159,6 +159,7 @@ config BATTERY_SBS
>
>   config BATTERY_BQ27XXX
>   	tristate "BQ27xxx battery driver"
> +	depends on I2C || I2C=n
>   	help
>   	  Say Y here to enable support for batteries with BQ27xxx (I2C/HDQ) chips.
>
>

Nothing enabled by BATTERY_BQ27XXX depends on I2C, this workaround is not
correct as it prevents BATTERY_BQ27XXX from being built-in when I2C is a
module, there is no reason for this limitation.

The undefined references are caused by BATTERY_BQ27XXX being built-in AND
its I2C functionality being enabled (BATTERY_BQ27XXX_I2C) while I2C is a
module. Reorganizing this driver is being discussed anyway, but in the
meantime a more correct fix would be along the lines of:

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 6de6ec2..d1d32f9 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -167,6 +167,7 @@ config BATTERY_BQ27XXX_I2C
         bool "BQ27xxx I2C support"
         depends on BATTERY_BQ27XXX
         depends on I2C
+       depends on !(I2C=m && BATTERY_BQ27XXX=y)
         default y
         help
           Say Y here to enable support for batteries with BQ27xxx (I2C) chips.
