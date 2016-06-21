From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 2/4] power: reset: add reboot mode driver
Date: Tue, 21 Jun 2016 13:39:45 +0200
Message-ID: <57692781.4070506@samsung.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646642-591-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPcKzGTAicbsXK-cC9WQT0vBhpSG_q2GCn37+72x2hdhsQ@mail.gmail.com>
 <57691E92.5090205@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:62243 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcFULjv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 07:39:51 -0400
In-reply-to: <57691E92.5090205@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com

On 06/21/2016 01:01 PM, Andy Yan wrote:

(...)

>>> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
>>> +MODULE_DESCRIPTION("System reboot mode driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/power/reset/reboot-mode.h
>>> b/drivers/power/reset/reboot-mode.h
>>> new file mode 100644
>>> index 0000000..44ed34f
>>> --- /dev/null
>>> +++ b/drivers/power/reset/reboot-mode.h
>>> @@ -0,0 +1,6 @@
>>> +#ifndef __REBOOT_MODE_H__
>>> +#define __REBOOT_MODE_H__
>>> +
>>> +int reboot_mode_register(struct device *dev, int (*write)(int));
>> Documentation would be appreciated. Although it is local header but
>> you decoupled them and you are exporting the function.
> 
>    You want this driver being a module in V9, so you may also want
>  I document this function when a exporting it. Where I should write the
>  documentation, and would you please give me some example?

Follow kernel-doc (kernel-doc-nano-HOWTO.txt). There is an example. Put
the documentation of functions next to them in source file (not header).

Best regards,
Krzysztof
