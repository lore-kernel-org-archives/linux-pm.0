From: Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date: Tue, 29 Jan 2019 10:16:12 +0000
Message-ID: <4f424b94-f871-08b2-03c7-d3e28c534785@raspberrypi.org>
References: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
 <d4a3e7b3-ed86-ca74-0e46-9b3b5f9cbef7@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d4a3e7b3-ed86-ca74-0e46-9b3b5f9cbef7@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On 29/01/2019 09:52, Daniel Lezcano wrote:
> On 29/01/2019 10:10, Phil Elwell wrote:
>> "cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
>> dereference in bcm2835_thermal_debugfs. The driver makes use of the
>> implementation details of the thermal framework to retrieve a pointer
>> to its private data from a struct thermal_zone_device, and gets it
>> wrong - leading to the crash. Instead, store its private data as the
>> drvdata and retrieve the thermal_zone_device pointer from it.
>>
>> Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> One question: do you really want the thermal driver to be loaded as a
> module ? Don't you want to have it operational as soon as possible
> instead of waiting the OS to boot and load the kernel module?
> 
> If a module format is not needed, then the thermal_zone field won't be
> needed anymore because the 'remove' ops can be removed and the need of
> the tz field to unregister it disappears.

Thanks for the review. The general approach for Pi drivers has been to make them
tristate to allow minimal kernels to be built - important when the smallest
Pis have 256M - and the delayed startup isn't a problem because the firmware
is running a thermal limiter from before the kernel is loaded. However, this
driver is very small, and I wouldn't object if somebody decided it was better
to make it built-in.

> 
>> ---
>>  drivers/thermal/broadcom/bcm2835_thermal.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
>> index 720760c..ba39647 100644
>> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
>> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
>> @@ -119,8 +119,7 @@ static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
>>  
>>  static void bcm2835_thermal_debugfs(struct platform_device *pdev)
>>  {
>> -	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
>> -	struct bcm2835_thermal_data *data = tz->devdata;
>> +	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
>>  	struct debugfs_regset32 *regset;
>>  
>>  	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
>> @@ -266,7 +265,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>>  
>>  	data->tz = tz;
>>  
>> -	platform_set_drvdata(pdev, tz);
>> +	platform_set_drvdata(pdev, data);
>>  
>>  	/*
>>  	 * Thermal_zone doesn't enable hwmon as default,
>> @@ -290,8 +289,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>>  
>>  static int bcm2835_thermal_remove(struct platform_device *pdev)
>>  {
>> -	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
>> -	struct bcm2835_thermal_data *data = tz->devdata;
>> +	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
>> +	struct thermal_zone_device *tz = data->tz;
>>  
>>  	debugfs_remove_recursive(data->debugfsdir);
>>  	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
>>
> 
> 
