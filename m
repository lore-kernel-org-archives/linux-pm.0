From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Thu, 24 Mar 2016 16:47:52 +0900
Message-ID: <56F39BA8.30104@samsung.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646592-540-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPdUW5f6_sz14NMU8LP+QoKStB9omXticMkQX4D866okWw@mail.gmail.com>
 <56F396FB.8030402@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:10178 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbcCXHsG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 03:48:06 -0400
In-reply-to: <56F396FB.8030402@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com

On 24.03.2016 16:27, Andy Yan wrote:
>>> +- mode-normal: Normal reboot mode, system reboot with command "reboot".
>>> +- mode-recovery: Android Recovery mode, it is a mode to format the
>>> device or update a new image.
>>> +- mode-bootloader: Android fastboot mode, it's a mode to re-flash
>>> partitions on the Android based device.
>>> +- mode-loader: A bootloader mode, it's a mode used to download image
>>> on Rockchip platform,
>>> +              usually used in development.
>> The "bootloader" and "loader" examples are very confusing. Maybe just
>> name the first one as "mode-fastboot" and second as
>> "rockchip-download"? The term "loader" does not look for me as
>> anything related to uploading/downloading new firmware.
> 
>     About these two modes, we have a long discussion with Rob and John [0]
>     We keep them as what you see now to keep compatibility with exiting
> devices.
> 
>  [0] https://lkml.org/lkml/2016/2/2/128

To me these names are non-obvious and I would rather expect choosing
meaningful names when putting something into the mainline. The user
(Android) will use this mainline kernel release in a year or more (3
years for vendors?), so it will have plenty of time to adopt. :)

But this was already discussed and you got ack from Rob, so let's move
on. I don't mind.

Best regards,
Krzysztof

