From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH V11 2/6] thermal: of-thermal: Implement signed coefficient
 support
Date: Fri, 24 Mar 2017 10:23:24 -0700
Message-ID: <58D5560C.7040503@gmail.com>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-3-git-send-email-stefan.wahren@i2se.com>
 <58D45B0A.5050500@gmail.com> <872776681.149555.1490340443231@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33665 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdCXRXm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 13:23:42 -0400
In-Reply-To: <872776681.149555.1490340443231@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, kernel@martin.sperl.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 03/24/17 00:27, Stefan Wahren wrote:
> 
>> Frank Rowand <frowand.list@gmail.com> hat am 24. März 2017 um 00:32 geschrieben:
>>
>>
>> On 03/12/17 15:11, Stefan Wahren wrote:
>>> Use the new function of_property_read_s32_array() to prepare
>>> of-thermal for negative coefficients. These are used by
>>> the upcoming bcm2835_thermal driver.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>>>  drivers/thermal/of-thermal.c |    5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>>> index d04ec3b..491d58a 100644
>>> --- a/drivers/thermal/of-thermal.c
>>> +++ b/drivers/thermal/of-thermal.c
>>> @@ -821,7 +821,8 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>>>  	struct device_node *child = NULL, *gchild;
>>>  	struct __thermal_zone *tz;
>>>  	int ret, i;
>>> -	u32 prop, coef[2];
>>> +	u32 prop;
>>> +	s32 coef[2];
>>>  
>>>  	if (!np) {
>>>  		pr_err("no thermal zone np\n");
>>> @@ -851,7 +852,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>>>  	 * one sensor per thermal zone. Thus, we are considering
>>>  	 * only the first two values as slope and offset.
>>>  	 */
>>> -	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
>>> +	ret = of_property_read_s32_array(np, "coefficients", coef, 2);
>>>  	if (ret == 0) {
>>>  		tz->slope = coef[0];
>>>  		tz->offset = coef[1];
>>>
>>
>> Since you are doing so much work to fix reading the array of s32 property, you
>> might also want to do the same for the s32 properties, "polling-delay-passive"
>> and "polling-delay".  Just change of_property_read_u32() to of_property_read_s32()
>> and change the type of prop to match.
>>
> 
> The intension behind this patch series is adding a new thermal driver
> not fixing of-thermal. Since the initial version of this series was
> posted by Martin in May 2016 i do not want to wait much longer.

Not my driver, your choice, I was just pointing out some compile warnings
(without thinking enough about the context of the warnings - see below).

> 
> Btw changing polling-delay-passive and polling-delay into a signed
> doesn't make any sense to me. Why do we need negative delays?

Good point.  I did not actually look at what the meaning of the two
properties is, and whether it makes sense for them to have a negative
value.  I also did not check the binding description (doing so now,
it clearly states that these property values are unsigned), I just
noted that there is a mismatch between the type of the properties
(u32) and the variables they are assigned to.  As the compile warnings
below indicate, if the property value is large enough, it will be a
negative value after assignment to the int variable.  The proper
answer is probably to change the variables to unsigned.

> 
> I suggest to send a separate patch for this issue.

It would be good if someone did.

Not a critical issue, just a trap waiting to catch someone who puts
a very large value for one of those properties in a device tree source
file and does not realize it will be a negative number in the driver.

> 
> Thanks for the review.
> 
>>
>> drivers/thermal/of-thermal.c: In function 'thermal_of_build_thermal_zone':
>> drivers/thermal/of-thermal.c:841:2: warning: conversion to 'int' from 'u32' may change the sign of the result [-Wsign-conversion]
>> drivers/thermal/of-thermal.c:848:2: warning: conversion to 'int' from 'u32' may change the sign of the result [-Wsign-conversion]
>>
>>
>>  836         ret = of_property_read_u32(np, "polling-delay-passive", &prop);
>>  837         if (ret < 0) {
>>  838                 pr_err("missing polling-delay-passive property\n");
>>  839                 goto free_tz;
>>  840         }
>>  841         tz->passive_delay = prop;
>>  842
>>  843         ret = of_property_read_u32(np, "polling-delay", &prop);
>>  844         if (ret < 0) {
>>  845                 pr_err("missing polling-delay property\n");
>>  846                 goto free_tz;
>>  847         }
>>  848         tz->polling_delay = prop;
>>
>>
>> -Frank
> 
