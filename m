From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH] thermal/drivers/core: Remove the module Kconfig's option
Date: Wed, 3 Apr 2019 12:45:47 +0700
Message-ID: <CAHLCerNx6vM_H72mWA14Avg9WcE6ugOcaxw1C1hQHeTaPsY21w@mail.gmail.com>
References: <20190401032425.18647-1-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401032425.18647-1-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Linux PM list <linux-pm@vger.kernel.org>, James Hogan <jhogan@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Paul Burton <paul.burton@mips.com>, Krzysztof Kozlowski <krzk@kernel.org>, Guenter Roeck <groeck@chromium.org>, Zhang Rui <rui.zhang@intel.com>, "open list:MIPS" <linux-mips@vger.kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, Andrew Morton <akpm@linux-foundation.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 1, 2019 at 10:24 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The module support for the thermal subsystem does have a little sense:
>  - some subsystems relying on it are not modules, thus forcing the
>    framework to be compiled in
>  - it is compiled in for almost every configs, the remaining ones
>    are a few platforms where I don't see why we can not switch the thermal
>    to 'y'. The drivers can stay in tristate.
>  - platforms need the thermal to be ready as soon as possible at boot time
>    in order to mitigate
>
> Usually the subsystems framework are compiled-in and the plugs are as module.
>
> Remove the module option. The removal of the module related dead code will
> come after this patch gets in or is acked.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm/configs/mini2440_defconfig        | 2 +-
>  arch/arm/configs/pxa_defconfig             | 2 +-
>  arch/mips/configs/ip22_defconfig           | 2 +-
>  arch/mips/configs/ip27_defconfig           | 2 +-
>  arch/unicore32/configs/unicore32_defconfig | 2 +-
>  drivers/thermal/Kconfig                    | 4 ++--
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
> index d95a8059d30b..0cf1c120c4bb 100644
> --- a/arch/arm/configs/mini2440_defconfig
> +++ b/arch/arm/configs/mini2440_defconfig
> @@ -152,7 +152,7 @@ CONFIG_SPI_S3C24XX=y
>  CONFIG_SPI_SPIDEV=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_SENSORS_LM75=y
> -CONFIG_THERMAL=m
> +CONFIG_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_FB=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index d4654755b09c..d4f9dda3a52f 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -387,7 +387,7 @@ CONFIG_SENSORS_LM75=m
>  CONFIG_SENSORS_LM90=m
>  CONFIG_SENSORS_LM95245=m
>  CONFIG_SENSORS_NTC_THERMISTOR=m
> -CONFIG_THERMAL=m
> +CONFIG_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_XILINX_WATCHDOG=m
>  CONFIG_SA1100_WATCHDOG=m
> diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
> index ff40fbc2f439..21a1168ae301 100644
> --- a/arch/mips/configs/ip22_defconfig
> +++ b/arch/mips/configs/ip22_defconfig
> @@ -228,7 +228,7 @@ CONFIG_SERIAL_IP22_ZILOG=m
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_RAW_DRIVER=m
>  # CONFIG_HWMON is not set
> -CONFIG_THERMAL=m
> +CONFIG_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_INDYDOG=m
>  # CONFIG_VGA_CONSOLE is not set
> diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
> index 81c47e18131b..54db5dedf776 100644
> --- a/arch/mips/configs/ip27_defconfig
> +++ b/arch/mips/configs/ip27_defconfig
> @@ -271,7 +271,7 @@ CONFIG_I2C_PARPORT_LIGHT=m
>  CONFIG_I2C_TAOS_EVM=m
>  CONFIG_I2C_STUB=m
>  # CONFIG_HWMON is not set
> -CONFIG_THERMAL=m
> +CONFIG_THERMAL=y
>  CONFIG_MFD_PCF50633=m
>  CONFIG_PCF50633_ADC=m
>  CONFIG_PCF50633_GPIO=m
> diff --git a/arch/unicore32/configs/unicore32_defconfig b/arch/unicore32/configs/unicore32_defconfig
> index aebd01fc28e5..360cc9abcdb0 100644
> --- a/arch/unicore32/configs/unicore32_defconfig
> +++ b/arch/unicore32/configs/unicore32_defconfig
> @@ -119,7 +119,7 @@ CONFIG_I2C_PUV3=y
>  #      Hardware Monitoring support
>  #CONFIG_SENSORS_LM75=m
>  #      Generic Thermal sysfs driver
> -#CONFIG_THERMAL=m
> +#CONFIG_THERMAL=y
>  #CONFIG_THERMAL_HWMON=y
>
>  #      Multimedia support
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 653aa27a25a4..ccf5b9408d7a 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -3,7 +3,7 @@
>  #
>
>  menuconfig THERMAL
> -       tristate "Generic Thermal sysfs driver"
> +       bool "Generic Thermal sysfs driver"
>         help
>           Generic Thermal Sysfs driver offers a generic mechanism for
>           thermal management. Usually it's made up of one or more thermal
> @@ -11,7 +11,7 @@ menuconfig THERMAL
>           Each thermal zone contains its own temperature, trip points,
>           cooling devices.
>           All platforms with ACPI thermal support can use this driver.
> -         If you want this support, you should say Y or M here.
> +         If you want this support, you should say Y here.
>
>  if THERMAL
>
> --
> 2.17.1
>
