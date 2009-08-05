From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] w1_gpio: switch to new dev_pm_ops
Date: Wed, 5 Aug 2009 20:44:01 +0200
Message-ID: <200908052044.02103.rjw__5018.75399281761$1249497890$gmane$org@sisk.pl>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ville Syrjala <syrjala@sci.fi>
List-Id: linux-pm@vger.kernel.org

On Wednesday 05 August 2009, Daniel Mack wrote:
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Ville Syrjala <syrjala@sci.fi>
> Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> ---
>  drivers/w1/masters/w1-gpio.c |   23 +++++++++++++++--------
>  1 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
> index 6f8866d..7099b11 100644
> --- a/drivers/w1/masters/w1-gpio.c
> +++ b/drivers/w1/masters/w1-gpio.c
> @@ -106,9 +106,9 @@ static int __exit w1_gpio_remove(struct platform_device *pdev)
>  
>  #ifdef CONFIG_PM
>  
> -static int w1_gpio_suspend(struct platform_device *pdev, pm_message_t state)
> +static int w1_gpio_suspend(struct device *dev)
>  {
> -	struct w1_gpio_platform_data *pdata = pdev->dev.platform_data;
> +	struct w1_gpio_platform_data *pdata = dev->platform_data;
>  
>  	if (pdata->enable_external_pullup)
>  		pdata->enable_external_pullup(0);
> @@ -116,9 +116,9 @@ static int w1_gpio_suspend(struct platform_device *pdev, pm_message_t state)
>  	return 0;
>  }
>  
> -static int w1_gpio_resume(struct platform_device *pdev)
> +static int w1_gpio_resume(struct device *dev)
>  {
> -	struct w1_gpio_platform_data *pdata = pdev->dev.platform_data;
> +	struct w1_gpio_platform_data *pdata = dev->platform_data;
>  
>  	if (pdata->enable_external_pullup)
>  		pdata->enable_external_pullup(1);
> @@ -126,19 +126,26 @@ static int w1_gpio_resume(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static struct dev_pm_ops w1_gpio_pm_ops = {
> +	.suspend	= w1_gpio_suspend,
> +	.freeze		= w1_gpio_suspend,
> +	.resume		= w1_gpio_resume,
> +	.thaw		= w1_gpio_resume,

You need

+	.poweroff	= w1_gpio_suspend,
+	.restore		= w1_gpio_resume,

in addition to these, which seems to be the case with the rest of the patches
too.

If you wait for a little while with the patchset, we're going to have a
convenience macro for defining such 'standard' dev_pm_ops objects.

> +};
> +
> +#define W1_GPIO_PM_OPS (&w1_gpio_pm_ops)
> +
>  #else
> -#define w1_gpio_suspend	NULL
> -#define w1_gpio_resume	NULL
> +#define W1_GPIO_PM_OPS NULL
>  #endif
>  
>  static struct platform_driver w1_gpio_driver = {
>  	.driver = {
>  		.name	= "w1-gpio",
>  		.owner	= THIS_MODULE,
> +		.pm	= W1_GPIO_PM_OPS,
>  	},
>  	.remove	= __exit_p(w1_gpio_remove),
> -	.suspend = w1_gpio_suspend,
> -	.resume = w1_gpio_resume,
>  };
>  
>  static int __init w1_gpio_init(void)

Best,
Rafael
