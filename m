From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Runtime PM v17 - Platform Device Bus
	Support
Date: Sun, 16 Aug 2009 12:21:18 +0200
Message-ID: <200908161221.18288.rjw@sisk.pl>
References: <20090815032620.20925.21607.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090815032620.20925.21607.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>, gregkh@suse.de
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 15 August 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds default Runtime PM callbacks to the dev_pm_ops
> belonging to the platform bus. The callbacks are weak symbols
> that architecture specific code can override.
> 
> Allows Runtime PM even though CONFIG_PM_SLEEP=n.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Thanks for the patch.

Greg, is it fine with you?

Rafael


> ---
> 
>  Needed by the SuperH Mobile Runtime PM implementation. Depends on
>  "PM: Introduce core framework for run-time PM of I/O devices (rev. 17)"
> 
>  Changes since 20090812 (v15 -> v17):
>  - platform_pm_runtime_idle() now returns int
> 
>  Changes since 20090807:
>  - removed pm_runtime_enable()
> 
>  Changes since 20090731:
>  - Based on "Driver Core: Runtime PM callbacks for the Platform Bus V2"
>  - Reworked to handle CONFIG_PM_SLEEP=n case
> 
>  drivers/base/platform.c |   46 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 9 deletions(-)
> 
> --- 0001/drivers/base/platform.c
> +++ work/drivers/base/platform.c	2009-08-15 12:15:38.000000000 +0900
> @@ -17,6 +17,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "base.h"
>  
> @@ -680,6 +681,13 @@ static void platform_pm_complete(struct 
>  		drv->pm->complete(dev);
>  }
>  
> +#else /* !CONFIG_PM_SLEEP */
> +
> +#define platform_pm_prepare		NULL
> +#define platform_pm_complete		NULL
> +
> +#endif /* !CONFIG_PM_SLEEP */
> +
>  #ifdef CONFIG_SUSPEND
>  
>  static int platform_pm_suspend(struct device *dev)
> @@ -922,6 +930,31 @@ static int platform_pm_restore_noirq(str
>  
>  #endif /* !CONFIG_HIBERNATION */
>  
> +#ifdef CONFIG_PM_RUNTIME
> +
> +int __weak platform_pm_runtime_suspend(struct device *dev)
> +{
> +	return -ENOSYS;
> +};
> +
> +int __weak platform_pm_runtime_resume(struct device *dev)
> +{
> +	return -ENOSYS;
> +};
> +
> +int __weak platform_pm_runtime_idle(struct device *dev)
> +{
> +	return -ENOSYS;
> +};
> +
> +#else /* !CONFIG_PM_RUNTIME */
> +
> +#define platform_pm_runtime_suspend NULL
> +#define platform_pm_runtime_resume NULL
> +#define platform_pm_runtime_idle NULL
> +
> +#endif /* !CONFIG_PM_RUNTIME */
> +
>  static struct dev_pm_ops platform_dev_pm_ops = {
>  	.prepare = platform_pm_prepare,
>  	.complete = platform_pm_complete,
> @@ -937,22 +970,17 @@ static struct dev_pm_ops platform_dev_pm
>  	.thaw_noirq = platform_pm_thaw_noirq,
>  	.poweroff_noirq = platform_pm_poweroff_noirq,
>  	.restore_noirq = platform_pm_restore_noirq,
> +	.runtime_suspend = platform_pm_runtime_suspend,
> +	.runtime_resume = platform_pm_runtime_resume,
> +	.runtime_idle = platform_pm_runtime_idle,
>  };
>  
> -#define PLATFORM_PM_OPS_PTR	(&platform_dev_pm_ops)
> -
> -#else /* !CONFIG_PM_SLEEP */
> -
> -#define PLATFORM_PM_OPS_PTR	NULL
> -
> -#endif /* !CONFIG_PM_SLEEP */
> -
>  struct bus_type platform_bus_type = {
>  	.name		= "platform",
>  	.dev_attrs	= platform_dev_attrs,
>  	.match		= platform_match,
>  	.uevent		= platform_uevent,
> -	.pm		= PLATFORM_PM_OPS_PTR,
> +	.pm		= &platform_dev_pm_ops,
>  };
>  EXPORT_SYMBOL_GPL(platform_bus_type);
