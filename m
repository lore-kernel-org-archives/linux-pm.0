From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v5 9/9] drivers: soc: Add support for Exynos PMU driver
Date: Fri, 13 Nov 2015 19:28:55 +0900
Message-ID: <5645BB67.8050102@samsung.com>
References: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
 <1447406983-27835-10-git-send-email-pankaj.dubey@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1447406983-27835-10-git-send-email-pankaj.dubey@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: amitdanielk@gmail.com, kgene.kim@samsung.com, arnd@arndb.de, thomas.ab@samsung.com, olof@lixom.net, khilman@linaro.org
List-Id: linux-pm@vger.kernel.org

On 13.11.2015 18:29, Pankaj Dubey wrote:
> This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
> to "drivers/soc/samsung". This driver is mainly used for setting misc
> bits of register from PMU IP of Exynos SoC which will be required to
> configure before Suspend/Resume. Currently all these settings are done
> in "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC
> support, there is a need of this PMU driver in driver/* folder.
> 
> This driver uses existing DT binding information and there should
> be no functionality change in the supported platforms.
> 
> Signed-off-by: Amit Daniel Kachhap <amitdanielk@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                                   | 1 +
>  arch/arm/mach-exynos/Makefile                                  | 4 +---
>  drivers/soc/samsung/Kconfig                                    | 4 ++++
>  drivers/soc/samsung/Makefile                                   | 4 ++++
>  arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos-pmu.h     | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos3250-pmu.c | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos4-pmu.c    | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5250-pmu.c | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5420-pmu.c | 0
>  10 files changed, 10 insertions(+), 3 deletions(-)
>  rename arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos-pmu.h (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos3250-pmu.c (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos4-pmu.c (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5250-pmu.c (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5420-pmu.c (100%)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 83c85f5..874cb38 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -16,6 +16,7 @@ menuconfig ARCH_EXYNOS
>  	select ARM_GIC
>  	select COMMON_CLK_SAMSUNG
>  	select EXYNOS_THERMAL
> +	select EXYNOS_PMU
>  	select EXYNOS_SROM if PM
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_S3C2410_I2C if I2C
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 2d58063..34d29df 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -9,9 +9,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
>  
>  # Core
>  
> -obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o \
> -					exynos3250-pmu.o exynos4-pmu.o \
> -					exynos5250-pmu.o exynos5420-pmu.o
> +obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
>  
>  obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
>  obj-$(CONFIG_PM_SLEEP)		+= suspend.o
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 2833b5b..f545d6c 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -10,4 +10,8 @@ config EXYNOS_SROM
>  	bool
>  	depends on ARM && ARCH_EXYNOS && PM
>  
> +config EXYNOS_PMU
> +	bool
> +	depends on ARCH_EXYNOS
> +
>  endmenu
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 9c554d5..26fb489 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -1 +1,5 @@
>  obj-$(CONFIG_EXYNOS_SROM)	+= exynos-srom.o
> +ifdef CONFIG_ARM
> +obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o exynos3250-pmu.o exynos4-pmu.o \
> +					exynos5250-pmu.o exynos5420-pmu.o
> +endif

Why ifdef CONFIG_ARM? This already depends on ARCH_EXYNOS. If you want
to limit to ARMv7 then add the dependency to Kconfig (just like
EXYNOS_SROM).

Rest looks ok - nice renames.

Best regards,
Krzysztof

> diff --git a/arch/arm/mach-exynos/pmu.c b/drivers/soc/samsung/exynos-pmu.c
> similarity index 100%
> rename from arch/arm/mach-exynos/pmu.c
> rename to drivers/soc/samsung/exynos-pmu.c
> diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
> similarity index 100%
> rename from arch/arm/mach-exynos/exynos-pmu.h
> rename to drivers/soc/samsung/exynos-pmu.h
> diff --git a/arch/arm/mach-exynos/exynos3250-pmu.c b/drivers/soc/samsung/exynos3250-pmu.c
> similarity index 100%
> rename from arch/arm/mach-exynos/exynos3250-pmu.c
> rename to drivers/soc/samsung/exynos3250-pmu.c
> diff --git a/arch/arm/mach-exynos/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
> similarity index 100%
> rename from arch/arm/mach-exynos/exynos4-pmu.c
> rename to drivers/soc/samsung/exynos4-pmu.c
> diff --git a/arch/arm/mach-exynos/exynos5250-pmu.c b/drivers/soc/samsung/exynos5250-pmu.c
> similarity index 100%
> rename from arch/arm/mach-exynos/exynos5250-pmu.c
> rename to drivers/soc/samsung/exynos5250-pmu.c
> diff --git a/arch/arm/mach-exynos/exynos5420-pmu.c b/drivers/soc/samsung/exynos5420-pmu.c
> similarity index 100%
> rename from arch/arm/mach-exynos/exynos5420-pmu.c
> rename to drivers/soc/samsung/exynos5420-pmu.c
> 
