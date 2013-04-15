From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC patch 2/2] ARM: at91: cpuidle: move the driver to
 drivers/cpuidle directory
Date: Mon, 15 Apr 2013 16:20:47 +0200
Message-ID: <20130415142047.GE15139@game.jcrosoft.org>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org>
 <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org>
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
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, rjw@sisk.pl, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 15:29 Mon 15 Apr     , Daniel Lezcano wrote:
> We don't have any dependency with the SoC specific code.
> 
> Move the driver to the drivers/cpuidle directory.
> 
> Add Nicolas Ferre as author of the driver, so it will be in copy of the emails.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
please use -M when generating the patch
> ---
>  arch/arm/mach-at91/Makefile  |    1 -
>  arch/arm/mach-at91/cpuidle.c |   55 ----------------------------------------
>  drivers/cpuidle/Makefile     |    1 +
>  drivers/cpuidle/at91.c       |   57 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 56 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/cpuidle.c
>  create mode 100644 drivers/cpuidle/at91.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 39218ca..3c7fca1 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -99,7 +99,6 @@ obj-y				+= leds.o
>  # Power Management
>  obj-$(CONFIG_PM)		+= pm.o
>  obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
> -obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
>  
>  ifeq ($(CONFIG_PM_DEBUG),y)
>  CFLAGS_pm.o += -DDEBUG
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> deleted file mode 100644
> index b2bec92..0000000
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -/*
> - * based on arch/arm/mach-kirkwood/cpuidle.c
> - *
> - * CPU idle support for AT91 SoC
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - *
> - * The cpu idle uses wait-for-interrupt and RAM self refresh in order
> - * to implement two idle states -
> - * #1 wait-for-interrupt
> - * #2 wait-for-interrupt and RAM self refresh
> - */
> -
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/cpuidle.h>
> -#include <asm/cpuidle.h>
> -
> -#define AT91_MAX_STATES	2
> -
> -extern void (*at91_standby_ops)(void);
> -
> -/* Actual code that puts the SoC in different idle states */
> -static int at91_enter_idle(struct cpuidle_device *dev,
> -			struct cpuidle_driver *drv,
> -			       int index)
> -{
> -	at91_standby_ops();
> -	return index;
> -}
> -
> -static struct cpuidle_driver at91_idle_driver = {
> -	.name			= "at91_idle",
> -	.owner			= THIS_MODULE,
> -	.states[0]		= ARM_CPUIDLE_WFI_STATE,
> -	.states[1]		= {
> -		.enter			= at91_enter_idle,
> -		.exit_latency		= 10,
> -		.target_residency	= 100000,
> -		.flags			= CPUIDLE_FLAG_TIME_VALID,
> -		.name			= "RAM_SR",
> -		.desc			= "WFI and DDR Self Refresh",
> -	},
> -	.state_count = AT91_MAX_STATES,
> -};
> -
> -/* Initialize CPU idle by registering the idle states */
> -static int __init at91_init_cpuidle(void)
> -{
> -	return cpuidle_register(&at91_idle_driver, NULL);
> -}
> -
> -device_initcall(at91_init_cpuidle);
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 0d8bd55..ba4e977 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  
>  obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
>  obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
> +obj-$(CONFIG_ARCH_AT91) += at91.o
> diff --git a/drivers/cpuidle/at91.c b/drivers/cpuidle/at91.c
> new file mode 100644
> index 0000000..2bc745b
> --- /dev/null
> +++ b/drivers/cpuidle/at91.c
> @@ -0,0 +1,57 @@
> +/*
> + * based on arch/arm/mach-kirkwood/cpuidle.c
> + *
> + * CPU idle support for AT91 SoC
> + *
> + * Author: Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * The cpu idle uses wait-for-interrupt and RAM self refresh in order
> + * to implement two idle states -
> + * #1 wait-for-interrupt
> + * #2 wait-for-interrupt and RAM self refresh
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/cpuidle.h>
> +#include <asm/cpuidle.h>
> +
> +#define AT91_MAX_STATES	2
> +
> +extern void (*at91_standby_ops)(void);
really don't like can we pass it via the pm?
> +
> +/* Actual code that puts the SoC in different idle states */
> +static int at91_enter_idle(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv,
> +			       int index)
> +{
> +	at91_standby_ops();
> +	return index;
> +}
> +
> +static struct cpuidle_driver at91_idle_driver = {
> +	.name			= "at91_idle",
> +	.owner			= THIS_MODULE,
> +	.states[0]		= ARM_CPUIDLE_WFI_STATE,
> +	.states[1]		= {
> +		.enter			= at91_enter_idle,
> +		.exit_latency		= 10,
> +		.target_residency	= 100000,
> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
> +		.name			= "RAM_SR",
> +		.desc			= "WFI and DDR Self Refresh",
> +	},
> +	.state_count = AT91_MAX_STATES,
> +};
> +
> +/* Initialize CPU idle by registering the idle states */
> +static int __init at91_init_cpuidle(void)
> +{
> +	return cpuidle_register(&at91_idle_driver, NULL);
> +}
> +
> +device_initcall(at91_init_cpuidle);
> -- 
> 1.7.9.5
> 
