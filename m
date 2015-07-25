From: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Subject: RE: [PATCH v2] power: max17042_battery: add HEALTH and TEMP_*
 properties support
Date: Sat, 25 Jul 2015 13:23:30 +0000
Message-ID: <D854C92F57B1B347B57E531E78D05EAD578B35A6@BGSMSX104.gar.corp.intel.com>
References: <1432438918-31002-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPeUvdC5LwRLgsFfxz2=SZwkjq2soGius+j6kb76Ea940A@mail.gmail.com>
 <CAJKOXPepZ9gKtnKk7Z4BFjUk=_kv6j010dZWhhu9bf_OuVmrgQ@mail.gmail.com>
 <20150724144651.GE27569@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56598 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbbGYNXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2015 09:23:35 -0400
In-Reply-To: <20150724144651.GE27569@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>

Hi Krzysztof Kozlowski,

>On Tue, Jun 23, 2015 at 09:58:41AM +0900, Krzysztof Kozlowski wrote:
>> 2015-06-08 10:22 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>> > 2015-05-24 12:41 GMT+09:00 Ramakrishna Pallala <ramakrishna.pallala@intel.com>:
>> >> This patch adds the support for following battery properties to 
> >> max17042 fuel gauge driver.
>> >>
>> >> POWER_SUPPLY_PROP_TEMP_ALERT_MIN
> >> POWER_SUPPLY_PROP_TEMP_ALERT_MAX
>> >> POWER_SUPPLY_PROP_TEMP_MIN
>> >> POWER_SUPPLY_PROP_TEMP_MAX
>> >> POWER_SUPPLY_PROP_HEALTH
>> >
>> > I wonder, have you tested the patch? After booting on Trats2 device
>> > (max77693 which identifies itself as 17047-like) the values are:
>> > POWER_SUPPLY_TEMP_ALERT_MIN=1280
>> > POWER_SUPPLY_TEMP_ALERT_MAX=1270
>> > POWER_SUPPLY_TEMP=257
>> > This is okay, datasheet says that register after booting will have 
>> > value of 0x7f80.
>> >
>> > However setting them to some value which should trigger interrupts 
>> > (like 300 for MIN or 200 for MAX) does not trigger the interrupt. I 
>> > added a printk in max17042_thread_handler().
>> >
>> > Is the temperature alert feature working?
>> 
>> Can you reply to my question above?
>> If this feature is not working, then it should be removed.

>What's the status of this? I cannot test the feature, since I don't have the hardware. I agree, that this should be removed, if it's not working.

I missed this email (may be overlooked it). To have the interrupts enabled we need the config registers(0x1Dh) bit's BIT(9), BIT(4) and BIT92) should be 1 and  BIT(8) should be 0.

Can you dump the status(00h), Talrt(02H) Temp(08h) and config(1Dh) registers values and share?

Thanks,
Ram
