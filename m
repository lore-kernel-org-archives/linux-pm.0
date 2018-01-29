From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH] power: reset: Add Spreadtrum SC27xx PMIC power off support
Date: Mon, 29 Jan 2018 16:37:10 +0800
Message-ID: <CAMz4kuKOpWJhjd645GPAqnnY=6WuapvEX4wveJ+nHGbv9HJ6eg@mail.gmail.com>
References: <5822b56a4e65e27183f8bf712d5889b11f90111e.1515118527.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5822b56a4e65e27183f8bf712d5889b11f90111e.1515118527.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On 15 January 2018 at 15:58, Baolin Wang <baolin.wang@linaro.org> wrote:
> On Spreadtrum platform, we need power off system through external SC27xx
> series PMICs including the SC2720, SC2721, SC2723, SC2730 and SC2731 chips.
> Thus this patch adds SC27xx series PMICs power-off support.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Do you have any comments for this patch? Thanks.

> ---
>  drivers/power/reset/Kconfig           |    9 +++++
>  drivers/power/reset/Makefile          |    1 +
>  drivers/power/reset/sc27xx-poweroff.c |   65 +++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 drivers/power/reset/sc27xx-poweroff.c
>
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index ca0de1a..611ae56 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -227,5 +227,14 @@ config SYSCON_REBOOT_MODE
>           register, then the bootloader can read it to take different
>           action according to the mode.
>
> +config POWER_RESET_SC27XX
> +       tristate "Spreadtrum SC27xx PMIC power-off driver"
> +       depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +       help
> +         This driver supports powering off a system through
> +         Spreadtrum SC27xx series PMICs. The SC27xx series
> +         PMICs includes the SC2720, SC2721, SC2723, SC2730
> +         and SC2731 chips.
> +
>  endif
>
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index aeb65ed..225d645 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -27,3 +27,4 @@ obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
>  obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
>  obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
> +obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
> diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
> new file mode 100644
> index 0000000..8e4b6a0
> --- /dev/null
> +++ b/drivers/power/reset/sc27xx-poweroff.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 Spreadtrum Communications Inc.
> + * Copyright (c) 2017 Linaro Ltd.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/syscore_ops.h>
> +
> +#define SC27XX_PWR_PD_HW       0xc2c
> +#define SC27XX_PWR_OFF_EN      BIT(0)
> +
> +static struct regmap *regmap;
> +
> +/*
> + * On Spreadtrum platform, we need power off system through external SC27xx
> + * series PMICs, and it is one similar SPI bus mapped by regmap to access PMIC,
> + * which is not fast io access.
> + *
> + * So before stopping other cores, we need release other cores' resource by
> + * taking cpus down to avoid racing regmap or spi mutex lock when poweroff
> + * system through PMIC.
> + */
> +void sc27xx_poweroff_shutdown(void)
> +{
> +       int cpu = smp_processor_id();
> +
> +       freeze_secondary_cpus(cpu);
> +}
> +
> +static struct syscore_ops poweroff_syscore_ops = {
> +       .shutdown = sc27xx_poweroff_shutdown,
> +};
> +
> +static void sc27xx_poweroff_do_poweroff(void)
> +{
> +       regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
> +}
> +
> +static int sc27xx_poweroff_probe(struct platform_device *pdev)
> +{
> +       regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!regmap)
> +               return -ENODEV;
> +
> +       pm_power_off = sc27xx_poweroff_do_poweroff;
> +       register_syscore_ops(&poweroff_syscore_ops);
> +       return 0;
> +}
> +
> +static struct platform_driver sc27xx_poweroff_driver = {
> +       .probe = sc27xx_poweroff_probe,
> +       .driver = {
> +               .name = "sc27xx-poweroff",
> +       },
> +};
> +module_platform_driver(sc27xx_poweroff_driver);
> +
> +MODULE_DESCRIPTION("Spreadtrum SC27xx PMIC Poweroff Driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.9.5
>



-- 
Baolin.wang
Best Regards
