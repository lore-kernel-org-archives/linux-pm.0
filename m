From: Phil Reid <preid@electromag.com.au>
Subject: Re: RFI: devm_power_supply_register and sys/class name
Date: Thu, 9 Jun 2016 23:45:37 +0800
Message-ID: <122dc217-0257-1f76-3db8-e4d90d7bedae@electromag.com.au>
References: <44d06e13-714a-c91a-6d7c-1aaa83758e7f@electromag.com.au>
 <CAJKOXPdJ=9gKs=HrmaxxbRMSw6Q6PqZJ-RFuUQ=YSmJKUfy9Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:53376 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751344AbcFIPpm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 11:45:42 -0400
In-Reply-To: <CAJKOXPdJ=9gKs=HrmaxxbRMSw6Q6PqZJ-RFuUQ=YSmJKUfy9Sg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org

On 9/06/2016 18:22, Krzysztof Kozlowski wrote:
> On Thu, Jun 9, 2016 at 11:39 AM, Phil Reid <preid@electromag.com.au> wrote:
>> G'day All,
>>
>> I'm implementing a driver for a sbs manager chip (ltc1760) and running into
>> a problem.
>> This is a dual smart battery charger ic.
>>
>> Our hard has two of these connected via a i2c / smbus mux.
>>
>> One registering the second device with devm_power_supply_register  I am
>> getting a warning
>> in regards duplicate sysfs entries.
>> The first device creates this entry
>> /sys/class/power_supply/sbs-manager/
>>
>> The second device also creates the same entry.
>>
>> This name appears to come from power_supply_desc .name field.
>>
>> Which needs to exists for the lifetime of the driver.
>> So I'm assuming I need to allocate local memory for this struct in the
>> driver and set a unique name.
>>
>> Is this the correct way to go or should devm_power_supply_register be made
>> more
>> flexible to ensure unique names?
>
> Hi,
>
> You need to provide one power_supply_desc per power supply instance.
> So in your case - you need two of them (with different names). Look at
> other drivers doing this.
>

G'day Krzysztof,

The driver I was following max8998_charger.c used a static struct power_supply_desc.
So I wasn't 100% sure.
Thanks for clarifying.


-- 
Regards
Phil Reid

