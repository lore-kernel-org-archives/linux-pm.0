From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: LTC3651 and other GPIO chargers
Date: Tue, 27 Jun 2017 07:39:21 +0200
Message-ID: <5b439c7f-4401-5333-a45f-2d2e243902c8@topic.nl>
References: <20170626162105.rgewvl2z2ftbxqyn@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx42-out3.antispamcloud.com ([138.201.61.179]:33374 "EHLO
        mx42-out3.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751473AbdF0F4G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 01:56:06 -0400
In-Reply-To: <20170626162105.rgewvl2z2ftbxqyn@lenoch>
Content-Language: nl
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>

﻿On 26-06-17 18:21, Ladislav Michl wrote:
> Hi there!
> 
> A driver for LTC3651 was recently added to -next
> https://patchwork.kernel.org/patch/9717049/
> which brings a question whenever we want to add separate driver
> (or vendor specific bindings) for ever growing list of similar
> chargers. For example those using the same status output lines
> are: BQ24232HA, LTC4007, LTM8061, RT9502, LT3651, LT3650, TP4056,
> MAX1737...
> Others for example BQ24032A and LM3658 (which I have to support)
> are using different status encoding, ie. LM3658:
> 
> stat1	stat2		Condition
>    0	  0	Power-Down, charging is suspended or interrupted
>    1	  0	Pre-qualification mode, CC and CV charging
>    0	  1	Charge is completed
>    1	  1	Bad battery (Safety timer expired), or LDO mode
> 
> What about extending gpio-charger instead?
> - allow gpio list fdt subnode
>    - consider each gpio line to represent bit in a word
> - provide per property subnodes
>    - each subnode holds a mask and mapping to property values
> This way we should be able to cover most chargers providing status
> using gpios. Comments welcome and appreciated - those will turn into
> implementation.

It's an interesting idea, and while writing the ltc3651 driver, I was thinking 
along those lines already. However, there are only two gpio charger drivers 
now, so I didn't see the need yet.

The table is an interesting approach. Something else to consider: Some gpio 
chargers allow control as well, e.g. pulling the "charging" ping low 
externally forces the charging to stop.

Something that might help is to create a "GPIO charger" sub-menu in Kconfig, 
to make hunting for these drivers a bit easier.


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
