From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND v2] leds: fix hibernation on arm when gpio-led used with CPU led trigger
Date: Fri, 15 May 2015 02:07:16 +0200
Message-ID: <1812053.91OoSt4Bq7@vostro.rjw.lan>
References: <1429876630-15952-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57029 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422828AbbENXmE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 19:42:04 -0400
In-Reply-To: <1429876630-15952-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Kevin Hilman <khilman@deeprootsystems.com>, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <Grygorii.Strashko@linaro.org>

On Friday, April 24, 2015 02:57:10 PM grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> 
> Setting a dev_pm_ops suspend/resume pair of callbacks but not a set of
> hibernation callbacks means those pm functions will not be
> called upon hibernation - that leads to system crash on ARM during
> freezing if gpio-led is used in combination with CPU led trigger.
> It may happen after freeze_noirq stage (GPIO is suspended)
> and before syscore_suspend stage (CPU led trigger is suspended)
> - usually when disable_nonboot_cpus() is called.
> 
> Log:
>   PM: noirq freeze of devices complete after 1.425 msecs
>   Disabling non-boot CPUs ...
>     ^ system may crash or stuck here with message (TI AM572x)
> 
>   WARNING: CPU: 0 PID: 3100 at drivers/bus/omap_l3_noc.c:148 l3_interrupt_handler+0x22c/0x370()
>   44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER1_P3 (Idle): Data Access in Supervisor mode during Functional access
> 
>   CPU1: shutdown
>     ^ or here
> 
> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
> assigns the suspend and hibernation callbacks and move
> led_suspend/led_resume under CONFIG_PM_SLEEP to avoid
> build warnings.
> 
> Fixes: 73e1ab41a80d (leds: Convert led class driver from legacy pm ops to dev_pm_ops)
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
> 
> Hi All,
> 
> Could you pls pay attention on this patch?
> 
> This trivial patch was posted at Feb 2015 and
> it's missed two merge windows already ((.
> 
> Rebased on top of next (4.1).
> 
> Changes in v2:
> - fixed compile time warnings when !CONFIG_PM_SLEEP
> - updated commit message
> 
> v2:
>   https://lkml.org/lkml/2015/2/5/323
> v1:
>   https://lkml.org/lkml/2015/2/2/476
> 
>  drivers/leds/led-class.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 728681d..7fb2a19 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -187,6 +187,7 @@ void led_classdev_resume(struct led_classdev *led_cdev)
>  }
>  EXPORT_SYMBOL_GPL(led_classdev_resume);
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int led_suspend(struct device *dev)
>  {
>  	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> @@ -206,11 +207,9 @@ static int led_resume(struct device *dev)
>  
>  	return 0;
>  }
> +#endif
>  
> -static const struct dev_pm_ops leds_class_dev_pm_ops = {
> -	.suspend        = led_suspend,
> -	.resume         = led_resume,
> -};
> +static SIMPLE_DEV_PM_OPS(leds_class_dev_pm_ops, led_suspend, led_resume);
>  
>  static int match_name(struct device *dev, const void *data)
>  {

Queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
