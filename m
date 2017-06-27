From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: LTC3651 and other GPIO chargers
Date: Tue, 27 Jun 2017 08:59:17 +0200
Message-ID: <81719e77-05a6-f5a8-e62d-e12f0a0c8d55@topic.nl>
References: <20170626162105.rgewvl2z2ftbxqyn@lenoch>
 <5b439c7f-4401-5333-a45f-2d2e243902c8@topic.nl>
 <20170627063836.bp32zzxtf5ulu7dw@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx12-04.smtp.antispamcloud.com ([46.165.232.174]:42673 "EHLO
        mx12-04.smtp.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751716AbdF0HSR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 03:18:17 -0400
In-Reply-To: <20170627063836.bp32zzxtf5ulu7dw@lenoch>
Content-Language: nl
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>

﻿On 27-06-17 08:38, Ladislav Michl wrote:
> On Tue, Jun 27, 2017 at 07:39:21AM +0200, Mike Looijmans wrote:
>> ﻿On 26-06-17 18:21, Ladislav Michl wrote:
>>> Hi there!
>>>
>>> A driver for LTC3651 was recently added to -next
>>> https://patchwork.kernel.org/patch/9717049/
>>> which brings a question whenever we want to add separate driver
>>> (or vendor specific bindings) for ever growing list of similar
>>> chargers. For example those using the same status output lines
>>> are: BQ24232HA, LTC4007, LTM8061, RT9502, LT3651, LT3650, TP4056,
>>> MAX1737...
>>> Others for example BQ24032A and LM3658 (which I have to support)
>>> are using different status encoding, ie. LM3658:
>>>
>>> stat1	stat2		Condition
>>>     0	  0	Power-Down, charging is suspended or interrupted
>>>     1	  0	Pre-qualification mode, CC and CV charging
>>>     0	  1	Charge is completed
>>>     1	  1	Bad battery (Safety timer expired), or LDO mode
>>>
>>> What about extending gpio-charger instead?
>>> - allow gpio list fdt subnode
>>>     - consider each gpio line to represent bit in a word
>>> - provide per property subnodes
>>>     - each subnode holds a mask and mapping to property values
>>> This way we should be able to cover most chargers providing status
>>> using gpios. Comments welcome and appreciated - those will turn into
>>> implementation.
>>
>> It's an interesting idea, and while writing the ltc3651 driver, I was
>> thinking along those lines already. However, there are only two gpio charger
>> drivers now, so I didn't see the need yet.
>>
>> The table is an interesting approach. Something else to consider: Some gpio
>> chargers allow control as well, e.g. pulling the "charging" ping low
>> externally forces the charging to stop.
> 
> Yes, the aforementioned LM3658 chip is one of such chargers. We already
> have charger-manager and gpio-regulator, but this doesn't seem to solve
> this situation as it provides "software charger ic". So for now I'm
> just misusing led class to enable charger - something which indeed needs
> to be solved properly.

Yeah, LED is great for (mis)using for all kinds of generic GPIO switches. Been 
there, done that (controlling model trains through relais for example...)

The problem goes a bit deeper. There's a bit of support for everything, and 
laptops and tablets seem to have it worked out reasonably, but for embedded 
devices, we somehow always end up with some very bare drivers for the charger, 
fuel gauge, charge detector, monitors, controllers and whatnot, and we always 
need a dedicated user-mode application to stitch it all together, for example 
to reset the battery gauge to full when the charger reports that charge has 
completed, or changing the max charger current from 0.5 to 1.5A when a 
dedicated charger has been detected on the USB wires. would be nice if that 
application could get that information from the drivers so we could make a 
generic power manager...


>> Something that might help is to create a "GPIO charger" sub-menu in Kconfig,
>> to make hunting for these drivers a bit easier.
> 
> I hope number of these driver will stop rising after we have one to rule
> them all :-)

True.



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
