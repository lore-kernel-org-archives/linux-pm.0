From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/6] ARM: cpuidle: Remove duplicate header inclusion
Date: Fri, 13 Mar 2015 17:54:18 +0000
Message-ID: <20150313175418.GB1763@e102568-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425385777-14766-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 03, 2015 at 12:29:32PM +0000, Daniel Lezcano wrote:
> The cpu_do_idle() function is always used by the cpuidle drivers.
> 
> That led to have each driver including cpuidle.h and proc-fns.h, they are
> always paired. That makes a lot of duplicate headers inclusion. Instead of
> including both in each .c file, move the proc-fns.h header inclusion in the
> cpuidle.h header file directly, so we can save some line of code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> ---
>  arch/arm/include/asm/cpuidle.h        | 2 ++
>  arch/arm/kernel/cpuidle.c             | 2 +-
>  arch/arm/mach-davinci/cpuidle.c       | 1 -
>  arch/arm/mach-imx/cpuidle-imx6q.c     | 1 -
>  arch/arm/mach-imx/cpuidle-imx6sl.c    | 1 -
>  arch/arm/mach-imx/cpuidle-imx6sx.c    | 1 -
>  arch/arm/mach-omap2/cpuidle44xx.c     | 1 -
>  arch/arm/mach-tegra/cpuidle-tegra20.c | 1 -
>  arch/arm/mach-tegra/cpuidle-tegra30.c | 1 -
>  drivers/cpuidle/cpuidle-at91.c        | 1 -
>  drivers/cpuidle/cpuidle-exynos.c      | 1 -
>  drivers/cpuidle/cpuidle-kirkwood.c    | 1 -
>  drivers/cpuidle/cpuidle-ux500.c       | 1 -
>  drivers/cpuidle/cpuidle-zynq.c        | 1 -
>  14 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> index af319ac..348dc81 100644
> --- a/arch/arm/include/asm/cpuidle.h
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -1,6 +1,8 @@
>  #ifndef __ASM_ARM_CPUIDLE_H
>  #define __ASM_ARM_CPUIDLE_H
>  
> +#include <asm/proc-fns.h>
> +
>  #ifdef CONFIG_CPU_IDLE
>  extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>  		struct cpuidle_driver *drv, int index);
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index 89545f6..45969f8 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -10,7 +10,7 @@
>   */
>  
>  #include <linux/cpuidle.h>
> -#include <asm/proc-fns.h>
> +#include <asm/cpuidle.h>
>  
>  int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>  		struct cpuidle_driver *drv, int index)
> diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
> index e365c1b..306ebc5 100644
> --- a/arch/arm/mach-davinci/cpuidle.c
> +++ b/arch/arm/mach-davinci/cpuidle.c
> @@ -17,7 +17,6 @@
>  #include <linux/cpuidle.h>
>  #include <linux/io.h>
>  #include <linux/export.h>
> -#include <asm/proc-fns.h>
>  #include <asm/cpuidle.h>
>  
>  #include <mach/cpuidle.h>
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> index d76d086..8e21ccc 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -9,7 +9,6 @@
>  #include <linux/cpuidle.h>
>  #include <linux/module.h>
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
>  
>  #include "common.h"
>  #include "cpuidle.h"
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
> index 7d92e65..5742a9f 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sl.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
> @@ -9,7 +9,6 @@
>  #include <linux/cpuidle.h>
>  #include <linux/module.h>
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
>  
>  #include "common.h"
>  #include "cpuidle.h"
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
> index 5a36722..2c9f1a8 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> @@ -10,7 +10,6 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/module.h>
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
>  #include <asm/suspend.h>
>  
>  #include "common.h"
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index 01e398a..7622dbb 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -17,7 +17,6 @@
>  #include <linux/clockchips.h>
>  
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
>  
>  #include "common.h"
>  #include "pm.h"
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> index 4f25a7c..e22b0d9 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
> @@ -27,7 +27,6 @@
>  #include <linux/module.h>
>  
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
> index f8815ed..a2400ab4 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra30.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
> @@ -27,7 +27,6 @@
>  #include <linux/module.h>
>  
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  
> diff --git a/drivers/cpuidle/cpuidle-at91.c b/drivers/cpuidle/cpuidle-at91.c
> index aae7bfc..f2446c7 100644
> --- a/drivers/cpuidle/cpuidle-at91.c
> +++ b/drivers/cpuidle/cpuidle-at91.c
> @@ -19,7 +19,6 @@
>  #include <linux/cpuidle.h>
>  #include <linux/io.h>
>  #include <linux/export.h>
> -#include <asm/proc-fns.h>
>  #include <asm/cpuidle.h>
>  
>  #define AT91_MAX_STATES	2
> diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
> index 26f5f29..0c06ea2 100644
> --- a/drivers/cpuidle/cpuidle-exynos.c
> +++ b/drivers/cpuidle/cpuidle-exynos.c
> @@ -19,7 +19,6 @@
>  #include <linux/of.h>
>  #include <linux/platform_data/cpuidle-exynos.h>
>  
> -#include <asm/proc-fns.h>
>  #include <asm/suspend.h>
>  #include <asm/cpuidle.h>
>  
> diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
> index cea0a6c..d23d8f4 100644
> --- a/drivers/cpuidle/cpuidle-kirkwood.c
> +++ b/drivers/cpuidle/cpuidle-kirkwood.c
> @@ -21,7 +21,6 @@
>  #include <linux/cpuidle.h>
>  #include <linux/io.h>
>  #include <linux/export.h>
> -#include <asm/proc-fns.h>
>  #include <asm/cpuidle.h>
>  
>  #define KIRKWOOD_MAX_STATES	2
> diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
> index 66f81e4..8bf895c 100644
> --- a/drivers/cpuidle/cpuidle-ux500.c
> +++ b/drivers/cpuidle/cpuidle-ux500.c
> @@ -19,7 +19,6 @@
>  #include <linux/platform_device.h>
>  
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
>  
>  static atomic_t master = ATOMIC_INIT(0);
>  static DEFINE_SPINLOCK(master_lock);
> diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
> index 002b8c9..543292b 100644
> --- a/drivers/cpuidle/cpuidle-zynq.c
> +++ b/drivers/cpuidle/cpuidle-zynq.c
> @@ -28,7 +28,6 @@
>  #include <linux/init.h>
>  #include <linux/cpuidle.h>
>  #include <linux/platform_device.h>
> -#include <asm/proc-fns.h>
>  #include <asm/cpuidle.h>
>  
>  #define ZYNQ_MAX_STATES		2
> -- 
> 1.9.1
> 
> 
