From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] power: reset: add driver for Hardkernel's Odroid boards
Date: Tue, 27 Jan 2015 09:16:23 +0100
Message-ID: <54C74957.2000600@samsung.com>
References: <1414588409-8065-1-git-send-email-m.szyprowski@samsung.com>
 <20150122010631.GL13715@earth.universe> <54C05373.60308@samsung.com>
 <54C22C5A.9050701@samsung.com> <20150125143207.GD2719@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:24519 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbA0IQ0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:16:26 -0500
In-reply-to: <20150125143207.GD2719@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Tobias Jakobi <Liquid.Acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>

Hello,

On 2015-01-25 15:32, Sebastian Reichel wrote:
> On Fri, Jan 23, 2015 at 12:11:22PM +0100, Marek Szyprowski wrote:
>> Frankly, I analyzed this case once again and I came to conclusion
>> that there is no need to make a separate reset driver for Odroid
>> boards. There is nothing special, specific to whole board about
>> this gpio. It is rather a property of MMC host controller and eMMC
>> card that is connected to it. When only gpio toggling code is
>> moved to reset handler registered from mmc controller, the board
>> properly performs reboot with a generic exynos4 code.
> OK, so I guess this will be fixed independently via mmc subsystem.

I've posted an updated patch.

>
>> The poweroff code in above driver is just a generic Exynos4 code,
>> so again there is no need to duplicate it.
> OK. It seems there is a driver for that in arch/arm/mach-exynos.
> Otherwise I would have suggest to create something like
> syscon-reboot for shutdown.
>
>> By moving the code to mmc driver, the same approach can be used for other
>> Odroid boards (XU/XU3) and maybe even other boards which need manual
>> resetting of eMMC cards to properly perform reboot procedure.
> I suggest to start a new thread for discussing this, which includes
> linux-mmc. It might be interesting to provide some more details about
> eMMC_nDET, since MMC already contain a reset signal (which seems to
> be used according to the odroid schematics I found).

My fault. The documentation for this initial driver was incorrect. The 
reboot
fix has noting to eMMC_nDET signal. It should be eMMC nreset, which is 
routed
directly to SoC GPIO line with external pull-up resistor. I really have no
idea why I wrote eMMC_nDET instead of nreset.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

