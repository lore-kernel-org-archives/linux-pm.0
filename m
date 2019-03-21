From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] PM / devfreq: exynos-bus: Suspend all devices on system
 shutdown
Date: Thu, 21 Mar 2019 10:29:19 +0100
Message-ID: <f41be303-0159-0730-501b-f465a1418861@samsung.com>
References: <CGME20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b@eucas1p1.samsung.com>
        <20190321090110.26506-1-m.szyprowski@samsung.com>
        <c2b39c36-a2f4-282e-1145-c61cfa18c6ce@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c2b39c36-a2f4-282e-1145-c61cfa18c6ce@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 2019-03-21 10:19, Chanwoo Choi wrote:
> On 19. 3. 21. 오후 6:01, Marek Szyprowski wrote:
>> Force all Exynos buses to safe operation points before doing the system
>> reboot operation. There are board on which some aggressive power saving
>> operation points are behind the capabilities of the bootloader to properly
>> reset the hardware and boot the board. This way one can avoid board crash
>> early after reboot.
>>
>> This fixes reboot issue on OdroidU3 board both with eMMC and SD boot.
>>
>> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> This is an alternative to https://patchwork.kernel.org/patch/10781433/
>> limited only to Exynos-bus driver.
>> ---
>>   drivers/devfreq/exynos-bus.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index c25658b26598..486cc5b422f1 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -514,6 +514,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>   	return ret;
>>   }
>>   
>> +static void exynos_bus_shutdown(struct platform_device *pdev)
>> +{
>> +	struct exynos_bus *bus = dev_get_drvdata(&pdev->dev);
>> +
>> +	devfreq_suspend_device(bus->devfreq);
>> +}
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   static int exynos_bus_resume(struct device *dev)
>>   {
>> @@ -556,6 +563,7 @@ MODULE_DEVICE_TABLE(of, exynos_bus_of_match);
>>   
>>   static struct platform_driver exynos_bus_platdrv = {
>>   	.probe		= exynos_bus_probe,
>> +	.shutdown	= exynos_bus_shutdown,
>>   	.driver = {
>>   		.name	= "exynos-bus",
>>   		.pm	= &exynos_bus_pm,
>>
> Actually, I already agreed the previous patch.
> Also, it looks good to me.

Yes, I know, but MyungJoo had some objections, that's why I prepared 
alternative version.

> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
