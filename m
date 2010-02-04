From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: Hook up runtime PM support
Date: Thu, 4 Feb 2010 22:57:27 +0100
Message-ID: <201002042257.27145.rjw__41483.1708920703$1265325742$gmane$org@sisk.pl>
References: <1265203367-21344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1265203367-21344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jean Delvare <khali@linux-fr.org>, pm list <linux-pm@lists.linux-foundation.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 February 2010, Mark Brown wrote:
> Allow I2C drivers to make use of the runtime PM framework by adding
> bus implementations of the runtime PM operations. These simply
> immediately suspend when the device is idle.

Perhaps it would be a good idea to give the driver a chance to veto
the suspend by calling its _idle callback?  We do that for PCI and turns out to
be quite useful.

> The runtime PM framework provides drivers with off the shelf refcounts for
> enables and sysfs control for managing runtime suspend from userspace so is
> useful even without meaningful input from the bus.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/i2c/i2c-core.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 10be7b5..985eaac 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -34,6 +34,7 @@
>  #include <linux/hardirq.h>
>  #include <linux/irqflags.h>
>  #include <linux/rwsem.h>
> +#include <linux/pm_runtime.h>
>  #include <asm/uaccess.h>
>  
>  #include "i2c-core.h"
> @@ -184,6 +185,43 @@ static int i2c_device_pm_resume(struct device *dev)
>  #define i2c_device_pm_resume	NULL
>  #endif
>  
> +#ifdef CONFIG_PM_RUNTIME
> +static int i2c_device_runtime_suspend(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm;
> +
> +	if (!dev->driver)
> +		return 0;
> +	pm = dev->driver->pm;
> +	if (!pm || !pm->runtime_suspend)
> +		return 0;
> +	return pm->runtime_suspend(dev);
> +}
> +
> +static int i2c_device_runtime_resume(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm;
> +
> +	if (!dev->driver)
> +		return 0;
> +	pm = dev->driver->pm;
> +	if (!pm || !pm->runtime_resume)
> +		return 0;
> +	return pm->runtime_resume(dev);
> +}
> +
> +static int i2c_device_runtime_idle(struct device *dev)
> +{
> +	/* I2C devices are very independent of each other so we
> +	 * suspend them immediately. */
> +	return pm_runtime_suspend(dev);
> +}
> +#else
> +#define i2c_device_runtime_suspend	NULL
> +#define i2c_device_runtime_resume	NULL
> +#define i2c_device_runtime_idle		NULL
> +#endif
> +
>  static int i2c_device_suspend(struct device *dev, pm_message_t mesg)
>  {
>  	struct i2c_client *client = i2c_verify_client(dev);
> @@ -251,6 +289,9 @@ static const struct attribute_group *i2c_dev_attr_groups[] = {
>  static const struct dev_pm_ops i2c_device_pm_ops = {
>  	.suspend = i2c_device_pm_suspend,
>  	.resume = i2c_device_pm_resume,
> +	.runtime_suspend = i2c_device_runtime_suspend,
> +	.runtime_resume = i2c_device_runtime_resume,
> +	.runtime_idle = i2c_device_runtime_idle,
>  };
>  
>  struct bus_type i2c_bus_type = {
> 

Rafael
