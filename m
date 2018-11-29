From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Fix bad initialization
Date: Thu, 29 Nov 2018 22:43:58 +0100
Message-ID: <4f3b1c28-5a5f-8f0a-aa5f-321ab557ce44@linaro.org>
References: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
 <20181129193658.GA6844@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129193658.GA6844@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, vincent.guittot@linaro.org, john.stultz@linaro.org, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 29/11/2018 20:36, Eduardo Valentin wrote:
> On Thu, Nov 29, 2018 at 07:26:56PM +0100, Daniel Lezcano wrote:
>> Without this patch, the thermal driver on hi6220 and hi3660 is broken.
>>
>> That is due because part of the posted patchset was merged but a small
>> change in the DT was dropped.
>>
>> The hi6220 and hi3660 do not have an interrupt name in the DT, so
>> finding interrupt by name fails.
>>
>> In addition, the hi3660 only defines one thermal zone in the DT and we
>> are trying to register two sensors assuming we have two thermal zones
>> in the DT.
>>
>> Fix this by adding a couple of line of code to add back compatibility
>> with older DT and change the sensors number to 1 for the hi3660.
> 
> Is this a case of adding dt versioning for those nodes?

I'm not sure how to do that, can you point me to some code ?

>> Fixes: 2cffaeff083f (thermal/drivers/hisi: Use platform_get_irq_byname)
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/hisi_thermal.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
>> index c4111a9..3ab0e63 100644
>> --- a/drivers/thermal/hisi_thermal.c
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -424,7 +424,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
>>  	struct platform_device *pdev = data->pdev;
>>  	struct device *dev = &pdev->dev;
>>  
>> -	data->nr_sensors = 2;
>> +	data->nr_sensors = 1;
> 
> For bisectability (heh.. is that even a word?), would you please send
> one fix per patch?

I thought it was preferable to fix both into a single patch but if you
prefer two different patches, no problem.

>>  
>>  	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
>>  				    data->nr_sensors, GFP_KERNEL);
>> @@ -590,8 +590,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>>  		}
>>  
>>  		ret = platform_get_irq_byname(pdev, sensor->irq_name);
>> -		if (ret < 0)
>> -			return ret;
>> +		if (ret <= 0) {
> 
> Maybe a simple <  is enough? reading it seams awkward. From a glance, I
> dont think platform_get_irq* ever returns 0.
> 
>> +			ret = platform_get_irq(pdev, 0);
>> +			if (ret <=  0) {
> 
> Same here.

Actually, I'm not sure. of_irq_parse_and_map can return zero and it is
an error. Concerning platform_get_irq() I don't know, the last line is:

	return r ? r->start : -ENXIO;

Can 'start' be zero there?

The usage is also unclear:

git grep -C 1 platform_get_irq drivers/

drivers/ata/libahci_platform.c: irq = platform_get_irq(pdev, 0);
drivers/ata/libahci_platform.c- if (irq <= 0) {
--
drivers/ata/pata_arasan_cf.c-   /* if irq is 0, support only PIO */
drivers/ata/pata_arasan_cf.c:   acdev->irq = platform_get_irq(pdev, 0);
drivers/ata/pata_arasan_cf.c-   if (acdev->irq)
[...]

drivers/ata/pata_rb532_cf.c-
drivers/ata/pata_rb532_cf.c:    irq = platform_get_irq(pdev, 0);
drivers/ata/pata_rb532_cf.c-    if (irq <= 0) {
--
drivers/ata/sata_highbank.c-
drivers/ata/sata_highbank.c:    irq = platform_get_irq(pdev, 0);
drivers/ata/sata_highbank.c-    if (irq <= 0) {
--
drivers/base/platform.c:        while ((ret = platform_get_irq(dev, nr))
>= 0)
drivers/base/platform.c-                nr++;
--
drivers/char/hw_random/imx-rngc.c-
drivers/char/hw_random/imx-rngc.c:      irq = platform_get_irq(pdev, 0);
drivers/char/hw_random/imx-rngc.c-      if (irq <= 0) {
--
drivers/char/hw_random/omap-rng.c-
of_device_is_compatible(dev->of_node, "inside-secure,safexcel-eip76")) {
drivers/char/hw_random/omap-rng.c:              irq =
platform_get_irq(pdev, 0);
drivers/char/hw_random/omap-rng.c-              if (irq < 0) {

etc...

So in some places, if irq <= 0 (sata_highbank.c) it is considered an
error, if irq is different from zero it is correct (pata_arasan_cf.c)
and if it is >= 0 it is also correct (platform.c)

May be Linus can clarify ? (added in Cc)


>> +				dev_err(dev, "Failed get interrupt: %d\n", ret);
>> +				return ret;
>> +			}
>> +		}
>>  
>>  		ret = devm_request_threaded_irq(dev, ret, NULL,
>>  						hisi_thermal_alarm_irq_thread,
>> -- 
>> 2.7.4
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
