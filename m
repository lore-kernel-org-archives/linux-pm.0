From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Input: matrix-keypad - switch to using
	dev_pm_ops
Date: Thu, 3 Dec 2009 22:43:36 +0100
Message-ID: <200912032243.36737.rjw__32162.508639931$1259876717$gmane$org@sisk.pl>
References: <20091203061200.GG9121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091203061200.GG9121@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 03 December 2009, Dmitry Torokhov wrote:
> Input: matrix-keypad - switch to using dev_pm_ops
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Looks good.

Thanks,
Rafael


> ---
> 
>  drivers/input/keyboard/matrix_keypad.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> index a1152ba..d3c8b61 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -215,8 +215,9 @@ static void matrix_keypad_stop(struct input_dev *dev)
>  }
>  
>  #ifdef CONFIG_PM
> -static int matrix_keypad_suspend(struct platform_device *pdev, pm_message_t state)
> +static int matrix_keypad_suspend(struct device *dev)
>  {
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
>  	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
>  	int i;
> @@ -237,8 +238,9 @@ static int matrix_keypad_suspend(struct platform_device *pdev, pm_message_t stat
>  	return 0;
>  }
>  
> -static int matrix_keypad_resume(struct platform_device *pdev)
> +static int matrix_keypad_resume(struct device *dev)
>  {
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
>  	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
>  	int i;
> @@ -257,9 +259,9 @@ static int matrix_keypad_resume(struct platform_device *pdev)
>  
>  	return 0;
>  }
> -#else
> -#define matrix_keypad_suspend	NULL
> -#define matrix_keypad_resume	NULL
> +
> +static const SIMPLE_DEV_PM_OPS(matrix_keypad_pm_ops,
> +				matrix_keypad_suspend, matrix_keypad_resume);
>  #endif
>  
>  static int __devinit init_matrix_gpio(struct platform_device *pdev,
> @@ -432,11 +434,12 @@ static int __devexit matrix_keypad_remove(struct platform_device *pdev)
>  static struct platform_driver matrix_keypad_driver = {
>  	.probe		= matrix_keypad_probe,
>  	.remove		= __devexit_p(matrix_keypad_remove),
> -	.suspend	= matrix_keypad_suspend,
> -	.resume		= matrix_keypad_resume,
>  	.driver		= {
>  		.name	= "matrix-keypad",
>  		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm	= &matrix_keypad_pm_ops,
> +#endif
>  	},
>  };
