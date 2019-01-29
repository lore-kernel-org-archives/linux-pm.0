From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date: Tue, 29 Jan 2019 10:52:56 +0100
Message-ID: <d4a3e7b3-ed86-ca74-0e46-9b3b5f9cbef7@linaro.org>
References: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29/01/2019 10:10, Phil Elwell wrote:
> "cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
> dereference in bcm2835_thermal_debugfs. The driver makes use of the
> implementation details of the thermal framework to retrieve a pointer
> to its private data from a struct thermal_zone_device, and gets it
> wrong - leading to the crash. Instead, store its private data as the
> drvdata and retrieve the thermal_zone_device pointer from it.
> 
> Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

One question: do you really want the thermal driver to be loaded as a
module ? Don't you want to have it operational as soon as possible
instead of waiting the OS to boot and load the kernel module?

If a module format is not needed, then the thermal_zone field won't be
needed anymore because the 'remove' ops can be removed and the need of
the tz field to unregister it disappears.

> ---
>  drivers/thermal/broadcom/bcm2835_thermal.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index 720760c..ba39647 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -119,8 +119,7 @@ static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
>  
>  static void bcm2835_thermal_debugfs(struct platform_device *pdev)
>  {
> -	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
> -	struct bcm2835_thermal_data *data = tz->devdata;
> +	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
>  	struct debugfs_regset32 *regset;
>  
>  	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
> @@ -266,7 +265,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>  
>  	data->tz = tz;
>  
> -	platform_set_drvdata(pdev, tz);
> +	platform_set_drvdata(pdev, data);
>  
>  	/*
>  	 * Thermal_zone doesn't enable hwmon as default,
> @@ -290,8 +289,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>  
>  static int bcm2835_thermal_remove(struct platform_device *pdev)
>  {
> -	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
> -	struct bcm2835_thermal_data *data = tz->devdata;
> +	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
> +	struct thermal_zone_device *tz = data->tz;
>  
>  	debugfs_remove_recursive(data->debugfsdir);
>  	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
