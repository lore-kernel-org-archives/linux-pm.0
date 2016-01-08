From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
Date: Fri, 08 Jan 2016 16:02:45 +0900
Message-ID: <568F5F15.8050602@samsung.com>
References: <1452219225-10510-1-git-send-email-wenyou.yang@atmel.com>
 <1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
 <CAJKOXPdzYJP_9DZUTz3EXPu4Z-DwkzYOJKEiR8varKJP3RRymw@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D63E5A3E@penmbx01>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:27922 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcAHHCw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2016 02:02:52 -0500
In-reply-to: <B256D81BAE5131468A838E5D7A243641D63E5A3E@penmbx01>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 08.01.2016 15:43, Yang, Wenyou wrote:

[...]

>>> +static struct platform_driver act8945a_charger_driver = {
>>> +       .driver = {
>>> +               .name = "act8945a-charger",
>>> +       },
>>> +       .probe  = act8945a_charger_probe,
>>> +       .remove = act8945a_charger_remove, };
>>> +
>>> +static int __init act8945a_charger_init(void) {
>>> +       return platform_driver_register(&act8945a_charger_driver);
>>> +}
>>> +subsys_initcall(act8945a_charger_init);
>>
>> Why subsys_initcall? This should be regular module_platform_driver.
> 
> I want it to register early enough as MFD.  Maybe I am wrong.

No, you shouldn't manually order the probing by initcalls. This should
be registered as usual and, if needed, support deferred probing. In this
case I even can't find any reason to register it earlier than usual.


Best regards,
Krzysztof

