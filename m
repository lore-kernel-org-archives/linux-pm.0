From: Chris Lapa <chris@lapa.com.au>
Subject: Re: [PATCH v3 3/7] max8903: cleans up confusing relationship between
 dc_valid, dok and dcm.
Date: Sun, 19 Jun 2016 23:48:47 +1000
Message-ID: <a1e6e5ee-ed4a-823f-909d-262e9cde5b1e@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
 <1466139626-51434-4-git-send-email-chris@lapa.com.au>
 <57639832.6000201@samsung.com>
Reply-To: chris@lapa.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32831 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcFSNsz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jun 2016 09:48:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id c74so9671079pfb.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Jun 2016 06:48:55 -0700 (PDT)
In-Reply-To: <57639832.6000201@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 17/06/2016 4:26 PM, Krzysztof Kozlowski wrote:
> On 06/17/2016 07:00 AM, Chris Lapa wrote:
>> From: Chris Lapa <chris@lapa.com.au>
>>
>> The max8903_charger.h file indicated that dcm and dok were not optional
>> when dc_valid is set.
>>
>> It makes sense to have dok as a compulsory pin when dc_valid is given.
>> However dcm can be optionally wired to a fixed level especially when the
>> circuit is configured for dc power exclusively.
>>
>> The previous implementation already allowed for this somewhat, however no
>> error was given if dok wasn't given whilst dc_valid was.
>>
>> The new implementation enforces dok presence when dc_valid is given. Whilst
>> allowing dcm to be optional.
>>
>> Signed-off-by: Chris Lapa <chris@lapa.com.au>
>> ---
>>  drivers/power/max8903_charger.c       | 23 ++++++++++-------------
>>  include/linux/power/max8903_charger.h |  6 +++---
>>  2 files changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
>> index 0a5b0e1..dbd911c4 100644
>> --- a/drivers/power/max8903_charger.c
>> +++ b/drivers/power/max8903_charger.c
>> @@ -211,27 +211,24 @@ static int max8903_probe(struct platform_device *pdev)
>>  	}
>>
>>  	if (pdata->dc_valid) {
>> -		if (pdata->dok && gpio_is_valid(pdata->dok) &&
>> -				pdata->dcm && gpio_is_valid(pdata->dcm)) {
>> +		if (pdata->dok && gpio_is_valid(pdata->dok)) {
>>  			gpio = pdata->dok; /* PULL_UPed Interrupt */
>>  			ta_in = gpio_get_value(gpio) ? 0 : 1;
>> +		} else {
>> +			dev_err(dev, "When DC is wired, DOK should"
>> +					" be wired as well.\n");
>
> Just found one nit. Don't split the strings.
>         dev_err(dev,
>                 "When DC is wired, DOK should be wired as well.\n");
>
> Best regards,
> Krzysztof
>

Fixed in v4

Thanks,
Chris
