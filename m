From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] power: max17042_battery: add HEALTH and TEMP_*
 properties support
Date: Mon, 27 Jul 2015 10:27:10 +0900
Message-ID: <55B588EE.4060103@samsung.com>
References: <1432438918-31002-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPeUvdC5LwRLgsFfxz2=SZwkjq2soGius+j6kb76Ea940A@mail.gmail.com>
 <CAJKOXPepZ9gKtnKk7Z4BFjUk=_kv6j010dZWhhu9bf_OuVmrgQ@mail.gmail.com>
 <20150724144651.GE27569@earth>
 <D854C92F57B1B347B57E531E78D05EAD578B35A6@BGSMSX104.gar.corp.intel.com>
 <55B57C85.4070309@samsung.com> <20150727012235.GA24229@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:30236 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbbG0B1R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jul 2015 21:27:17 -0400
In-reply-to: <20150727012235.GA24229@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>

On 27.07.2015 10:22, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Jul 27, 2015 at 09:34:13AM +0900, Krzysztof Kozlowski wrote:
>>>> [...]
>>>
>>> I missed this email (may be overlooked it). To have the
>>> interrupts enabled we need the config registers(0x1Dh) bit's
>>> BIT(9), BIT(4) and BIT92) should be 1 and  BIT(8) should be 0.
>>>
>>> Can you dump the status(00h), Talrt(02H) Temp(08h) and
>>> config(1Dh) registers values and share?
>>
>> Thanks for responding. The issue was in BIT(8) which was set to default
>> value of 0x1. This would mean to use external sensor but the board does
>> not have it.
>>
>> This is a DT platform and there is no initial config data so all
>> registers are set to default values.
>>
>> Anyway everything seems to work as expected, thanks for explanation.
> 
> So I guess the bit should be set to 0 during probe. Maybe with a
> boolean DT property "maxim,has-external-sensor" for setting it
> to 1.

Yes, something like this but it may be not sufficient. Other
configuration register may also require tuning.

This tuning happens when platform data is provided. The driver overrides
sets whole configuration (the config register and even some more
settings). Since on ARM we moved to DT-only this functionality is
crippled for us but works for Intel.

I put it on my todo list (fixing the sensor or entire configuration)...
but if anyone would like to fix this, then go ahead. I can provide a
tested-by.

Best regards,
Krzysztof

