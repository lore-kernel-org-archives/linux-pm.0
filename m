From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261 charger
Date: Thu, 10 Sep 2015 08:49:26 +0900
Message-ID: <55F0C586.3010003@samsung.com>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
 <20150909022617.GA32255@beast> <55EFB2C7.30800@samsung.com>
 <20150909173147.GA9887@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:14094 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbIIXt3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 19:49:29 -0400
In-reply-to: <20150909173147.GA9887@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, laurentiu.palcu@intel.com
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Jenny TC <jenny.tc@intel.com>

On 10.09.2015 02:31, Andreas Dannenberg wrote:
> On Wed, Sep 09, 2015 at 01:17:11PM +0900, Krzysztof Kozlowski wrote:
>> On 09.09.2015 11:26, Andreas Dannenberg wrote:
>>> Krzysztof, good observation! In bq2425x_charger.c (formerly known as
>>> bq24257_charger.c :) that I worked on the unit used was uA. At that time
>>> I did a quick check and there didn't seem to be a clear standard whether
>>> to use the "micro" or "milli" units - different drivers use different
>>> units. However there seems to be a tendency for the TI drivers to prefer
>>> "milli" (bq2415x_charger.c, bq24735-charger.c)
>>>
>>> Personally I think "milli" units are more appropriate for chargers since
>>> they provide sufficient granularity and the numbers don't become too big
>>> (try typing a voltage in the Volt-range in uV, it's very easy to get the
>>> number of 0s wrong). However since the driver was already there I left
>>> that aspect alone to preserve compatibility.
>>
>> I am fine with both units but milli indeed seems easier to judge by fast
>> looking and less error-prone. Whatever you choose - choose the same one. :)
> 
> Ok sounds good. If so, I could go ahead and change the units in the
> bq2425x_charger.c over to mA and mV?

Wait, these are existing bindings (for bq24257). You cannot change
existing binding.

Best regards,
Krzysztof

> It would be a bit labor some and I
> also want to see what Laurentiu thinks but this way we could have most
> of those TI charger drivers use the same units (the new bq24261 driver
> Ram posted also uses mA/mV). Except bq25890_charger.c.... that would
> still use uA/uV....
> 
> Laurentiu -- what made you chose the "micro" units for bq24257_charger.c
> and bq25890_charger.c?



