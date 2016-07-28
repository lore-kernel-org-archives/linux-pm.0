From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 1/1] power: sbs-manager: Add interrupt support and battery
 detect gpios
Date: Thu, 28 Jul 2016 17:01:15 +0800
Message-ID: <e2ca7188-03e4-978d-9c10-9498117acb8e@electromag.com.au>
References: <1469433003-68564-1-git-send-email-preid@electromag.com.au>
 <1469433003-68564-2-git-send-email-preid@electromag.com.au>
 <20160727144609.GA12462@rob-hp-laptop> <1469653707.27666.22.camel@amnesix>
 <4553a3f5-55cc-807d-7f34-11b4c7e11a0b@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:53511 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752186AbcG1JBW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 05:01:22 -0400
In-Reply-To: <4553a3f5-55cc-807d-7f34-11b4c7e11a0b@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

G'day Rob,

Just another thought.

On 28/07/2016 10:11, Phil Reid wrote:
> G'day Karl / Rob,
>
> On 28/07/2016 05:08, Karl-Heinz Schneider wrote:
>> Am Mittwoch, den 27.07.2016, 09:46 -0500 schrieb Rob Herring:
>>> On Mon, Jul 25, 2016 at 03:50:03PM +0800, Phil Reid wrote:
>>>> This patch added irq support for the SMBALERT pin and notification of
>>>> the battery removal / insertion. The sbs manager would typically be
>>>> used with the corresponding sbs-battery driver that currently uses a
>>>> gpio input for battery presence and interrupt. To remain compatible with
>>>> that existing driver this patch implements GPIO inputs with interrupt
>>>> support. IRQ masking is performed in software as the hardware does not
>>>> support masking of notifications from each battery.
>>>> In addition a power_supply change notification is generated for the sbs
>>>> manager device when the AC present flag is changed.
>>>> Tested with LTC1760 and dual sbs compatible batteries.
>>>
>>> Please don't submit a binding and immediately turn around and add to it.
>>> While that is often preferred for drivers or kernel features, bindings
>>> should be complete as possible and not evolve. Combine this with your
>>> previous patch add sbs-mgr if that hasn't been accepted yet.
> That was from Karl. I'm happy to have this combined if he is.
>
>>>
>>> IMO, the sbs-bat should just be a interrupt and making it and this
>>> binding a GPIO is overkill. Since batteries nodes using this will be
>>> new, there's no reason the driver can't be updated to support
>>> interrupts.
I did consider this and didn't go that way as:
1) the current sbs-battery driver didn't support it.
2) Then there's also the problem of reporting  the presence of the battery to the battery driver.
Without the GPIO support you resort to polling and looking for a NACK. Which didn't seem that nice.


>>>
>>> Also, I'm not even convinced you need the sbs-mgr to be an
>>> interrupt-controller. Is this anything more that just wire-OR'ed
>>> interrupt lines which can be handled as shared irq? Does reading
>>> SBSM_CMD_BATSYSSTATE have a side effect for example?
>> Yes, according to the Datasheed it clears SMBALERT#.
>
> Yes you need to service the Ltc1760 for the irq to clear. reading the batteries does nothing.
> Even without any batteries present  you may get an irq and need to service it.
> eg: I have a system with 2 ltc1760 with a total of 4 batteries.
> So if only one battery is present and AC power is connected then both ltc1760 will generate
> a notification on SMBALERT. One which has no batteries present.
>
>>>
>>> Rob
>> SMBALERT is electrically an active low line which is pulled down by one
>> or more devices needing attention, isn't it? The I2C host driver or some
>> other instance need to implement support for it, the device driver may
>> register some sort of handler function (e.g by implementing struct
>> i2c_driver.alert function)
>>
>> That's my understanding of the SMBALERT.
>>
>> I once tried to implement the alert function and see if it get's called.
>> It didn't. At that point I didn't investigate further.
>>
>> So, do I miss something or is that part incomplete/broken? I can only
>> find lm90 and ipmi_ssif which implement the callback.
>>
> I wasn't aware of that functionality. Most devices seem to use a GPIO to
> obtain irq support. Which I guess is the most flexible solution.
> I think SMBALERT also support a mechanism to query all devices on the bus to determine
> which device address is asserting the irq. Not sure how this would work with multiplexed
> address buses (eg dual ltc1760) and devices with the same address.
>
> Open to suggestions
>


-- 
Regards
Phil Reid

