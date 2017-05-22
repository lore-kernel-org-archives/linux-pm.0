From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 3/8] thermal: intel_bxt_pmic_thermal: use first level
 PMIC thermal irq
Date: Mon, 22 May 2017 12:08:24 -0700
Message-ID: <1af3aa9b-6772-1305-2635-a36ce6b2ba1c@linux.intel.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <fda73b083e5e67e8fcc9fc2d01a590f689a06c91.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170522101754.jngcdp5z5kfjycd2@dell>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45539 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdEVTMN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 May 2017 15:12:13 -0400
In-Reply-To: <20170522101754.jngcdp5z5kfjycd2@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, andy@infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com

Hi Rui/Valentin,

Do you have any comments on this patch ? If you agree with this patch, 
Can you please Ack it ?


On 05/22/2017 03:17 AM, Lee Jones wrote:
> On Fri, 14 Apr 2017, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> PMIC mfd driver only exports first level irq for thermal device.
>> But currently we are reading the irqs from the second level irq
>> chip, So this patch fixes this issue by adding support to use
>> first level PMIC thermal irq.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> This still needs a Maintainer Ack.
>
>> ---
>>   drivers/thermal/intel_bxt_pmic_thermal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Changes since v1:
>>   * None
>>
>> diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel_bxt_pmic_thermal.c
>> index 0f19a39..ef6b322 100644
>> --- a/drivers/thermal/intel_bxt_pmic_thermal.c
>> +++ b/drivers/thermal/intel_bxt_pmic_thermal.c
>> @@ -241,7 +241,7 @@ static int pmic_thermal_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	regmap = pmic->regmap;
>> -	regmap_irq_chip = pmic->irq_chip_data_level2;
>> +	regmap_irq_chip = pmic->irq_chip_data;
>>   
>>   	pmic_irq_count = 0;
>>   	while ((irq = platform_get_irq(pdev, pmic_irq_count)) != -ENXIO) {

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
