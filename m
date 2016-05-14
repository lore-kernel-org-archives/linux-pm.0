From: Michael Haas <haas@computerlinguist.org>
Subject: Re: [PATCH v4 1/4] power: Add an axp20x-ac-power driver
Date: Sat, 14 May 2016 09:31:27 +0200
Message-ID: <f6aa4530-d033-824a-1122-437919500d63@computerlinguist.org>
References: <1462511991-1911-1-git-send-email-haas@computerlinguist.org>
 <1462511991-1911-2-git-send-email-haas@computerlinguist.org>
 <CAGb2v674DpbHHx-ra6N4QMVDPfGbT30rn8hPt=X-f1no7jM4Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:51177 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbcENHbq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 14 May 2016 03:31:46 -0400
In-Reply-To: <CAGb2v674DpbHHx-ra6N4QMVDPfGbT30rn8hPt=X-f1no7jM4Xg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Hans De Goede <hdegoede@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, devicetree <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sunxi <linux-sunxi@googlegroups.com>

On 05/09/2016 06:33 PM, Chen-Yu Tsai wrote:

>> +
>> +       power->supply = devm_power_supply_register(&pdev->dev,
>> +                                       &axp20x_ac_power_desc, &psy_cfg);
>> +       if (IS_ERR(power->supply))
>> +               return PTR_ERR(power->supply);
>> +
>> +       /* Request irqs after registering, as irqs may trigger immediately */
>> +       for (i = 0; i < ARRAY_SIZE(irq_names); i++) {
>> +               irq = platform_get_irq_byname(pdev, irq_names[i]);
>> +               if (irq < 0) {
>> +                       dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
>> +                                irq_names[i], irq);
>> +                       continue;
>> +               }
>> +               irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>> +               r = devm_request_any_context_irq(&pdev->dev, irq,
>> +                               axp20x_irq_ac_handler, 0, DRVNAME, power);
>> +               if (r < 0)
>> +                       dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
>> +                                irq_names[i], r);
> 
> Won't missing IRQs hinder the usage of this driver / hardware?
> A power supply isn't much use if the system isn't told when
> it's gone.
> 

That's a good point. The real question is: how would you handle missing
IRQs? I have looked at other uses of devm_request_any_context_irq, e.g.
in rtc-pm8xxx.c [0]. These other users often return an error code in the
probe function. That doesn't help the system, though: it still won't
notice if the power is unplugged in addition to missing the driver
completely.

It's probably best to provide the remaining (functional) parts of the
driver (reading from /sys/class..) even if the IRQs cannot be
registered. The code is pretty much the same in  the axp20x-usb-power.

Michael

[0] http://lxr.free-electrons.com/source/drivers/rtc/rtc-pm8xxx.c#L490

