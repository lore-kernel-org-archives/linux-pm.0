From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] power: sbs-manager: Add interrupt support and battery
 detect gpios
Date: Thu, 28 Jul 2016 10:45:14 -0500
Message-ID: <CAL_JsqL0+b5GRMMtK7PmECatR7aayiv-Of05HahGWSHHQ-vrYg@mail.gmail.com>
References: <1469433003-68564-1-git-send-email-preid@electromag.com.au>
 <1469433003-68564-2-git-send-email-preid@electromag.com.au>
 <20160727144609.GA12462@rob-hp-laptop> <1469653707.27666.22.camel@amnesix>
 <4553a3f5-55cc-807d-7f34-11b4c7e11a0b@electromag.com.au> <e2ca7188-03e4-978d-9c10-9498117acb8e@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40024 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757245AbcG1Ppj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jul 2016 11:45:39 -0400
In-Reply-To: <e2ca7188-03e4-978d-9c10-9498117acb8e@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Jul 28, 2016 at 4:01 AM, Phil Reid <preid@electromag.com.au> wrote:
> G'day Rob,
>
> Just another thought.
>
> On 28/07/2016 10:11, Phil Reid wrote:
>>
>> G'day Karl / Rob,
>>
>> On 28/07/2016 05:08, Karl-Heinz Schneider wrote:
>>>
>>> Am Mittwoch, den 27.07.2016, 09:46 -0500 schrieb Rob Herring:
>>>>
>>>> On Mon, Jul 25, 2016 at 03:50:03PM +0800, Phil Reid wrote:
>>>>>
>>>>> This patch added irq support for the SMBALERT pin and notification of
>>>>> the battery removal / insertion. The sbs manager would typically be
>>>>> used with the corresponding sbs-battery driver that currently uses a
>>>>> gpio input for battery presence and interrupt. To remain compatible
>>>>> with
>>>>> that existing driver this patch implements GPIO inputs with interrupt
>>>>> support. IRQ masking is performed in software as the hardware does not
>>>>> support masking of notifications from each battery.
>>>>> In addition a power_supply change notification is generated for the sbs
>>>>> manager device when the AC present flag is changed.
>>>>> Tested with LTC1760 and dual sbs compatible batteries.
>>>>
>>>>
>>>> Please don't submit a binding and immediately turn around and add to it.
>>>> While that is often preferred for drivers or kernel features, bindings
>>>> should be complete as possible and not evolve. Combine this with your
>>>> previous patch add sbs-mgr if that hasn't been accepted yet.
>>
>> That was from Karl. I'm happy to have this combined if he is.

Indeed it was. Still, it should be combined. You can leave the driver
implementation as multiple patches, just combine all the binding to a
single patch by itself.

>>>> IMO, the sbs-bat should just be a interrupt and making it and this
>>>> binding a GPIO is overkill. Since batteries nodes using this will be
>>>> new, there's no reason the driver can't be updated to support
>>>> interrupts.
>
> I did consider this and didn't go that way as:
> 1) the current sbs-battery driver didn't support it.
> 2) Then there's also the problem of reporting  the presence of the battery
> to the battery driver.
> Without the GPIO support you resort to polling and looking for a NACK. Which
> didn't seem that nice.

The ability to read the current irq signal state with the irq api
would be nice. Of course you can't really count on being able to on
all irqs. Anyway, we shouldn't really design the binding around kernel
limitations.

As I understand how SMBALERT works, you have to poll the devices
anyway to determine which device is asserting the irq and to ack the
irq. Of course, here you are doing point to point connections, but you
still need to know which batteries are present by reading the sbs-mgr
registers.

Wouldn't switching the driver to level irq allow you to get the state
immediately without a gpio read? After all, the gpio read and irq
handler are reading the same register.

Rob
