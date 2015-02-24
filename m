From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH v2] leds: fix hibernation on arm when gpio-led used with
 CPU led trigger
Date: Tue, 24 Feb 2015 18:12:19 +0200
Message-ID: <54ECA2E3.8060401@linaro.org>
References: <1423147024-4744-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:40532 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbbBXQMW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 11:12:22 -0500
Received: by lbdu10 with SMTP id u10so25906154lbd.7
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2015 08:12:21 -0800 (PST)
In-Reply-To: <1423147024-4744-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Cc: sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Bryan, all,

On 02/05/2015 04:37 PM, grygorii.strashko@linaro.org wrote:
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
>    PM: noirq freeze of devices complete after 1.425 msecs
>    Disabling non-boot CPUs ...
>      ^ system may crash or stuck here with message (TI AM572x)
> 
>    WARNING: CPU: 0 PID: 3100 at drivers/bus/omap_l3_noc.c:148 l3_interrupt_handler+0x22c/0x370()
>    44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER1_P3 (Idle): Data Access in Supervisor mode during Functional access
> 
>    CPU1: shutdown
>      ^ or here
> 
> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
> assigns the suspend and hibernation callbacks and move
> led_suspend/led_resume under CONFIG_PM_SLEEP to avoid
> build warnings.
> 
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
> This patch actually fixes commit:
>   73e1ab4 "leds: Convert led class driver from legacy pm ops to dev_pm_ops"
> 
> Changes in v2:
> - fixed compile time warnings when !CONFIG_PM_SLEEP
> - updated commit message
> 
> v1:
> - https://lkml.org/lkml/2015/2/2/476
> 
>   drivers/leds/led-class.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index dbeebac..5033e0d 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -183,6 +183,7 @@ void led_classdev_resume(struct led_classdev *led_cdev)
>   }
>   EXPORT_SYMBOL_GPL(led_classdev_resume);
>   
> +#ifdef CONFIG_PM_SLEEP
>   static int led_suspend(struct device *dev)
>   {
>   	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> @@ -202,11 +203,9 @@ static int led_resume(struct device *dev)
>   
>   	return 0;
>   }
> +#endif
>   
> -static const struct dev_pm_ops leds_class_dev_pm_ops = {
> -	.suspend        = led_suspend,
> -	.resume         = led_resume,
> -};
> +static SIMPLE_DEV_PM_OPS(leds_class_dev_pm_ops, led_suspend, led_resume);
>   
>   /**
>    * led_classdev_register - register a new object of led_classdev class.
> 

Could you pay attention on this patch, pls? It fixes a real issue for me.

Actually, I'd like to note that it fixes regression introduced by commit
73e1ab41a80d36207e8ea7cc2c9897afdeeef387 
"leds: Convert led class driver from legacy pm ops to dev_pm_ops" from 
Shuah Khan <shuah.kh@samsung.com> (Jun 20 2013).

-- 
regards,
-grygorii
