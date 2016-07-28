From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH v3 4/6] usb: core: add power sequence handling for USB
 devices
Date: Thu, 28 Jul 2016 09:18:45 -0700
Message-ID: <579A3065.2080402@gmail.com>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
 <1469007629-31757-5-git-send-email-peter.chen@nxp.com>
 <5798E067.90207@gmail.com> <20160728014521.GB26186@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33419 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbcG1QSy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 12:18:54 -0400
In-Reply-To: <20160728014521.GB26186@shlinux2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Peter,

On 07/27/2016 06:45 PM, Peter Chen wrote:
> On Wed, Jul 27, 2016 at 09:25:11AM -0700, Joshua Clayton wrote:
>> Patch 4 does not apply for me
>> (The Makefile has  a "usbcore-$(CONFIG_OF) += of.o"
>> line which I don't see in 4.7 or linux/next master).
>> Is there another patch set this series depends on?
> It seems below patch has not been queued:
>
> https://git.kernel.org/cgit/linux/kernel/git/peter.chen/usb.git/commit/?h=add_pwrseq_for_usb&id=2efd73d0f935ffbc66135553da0ac807c0b4c3fe
>
> This pwrseq-lib patch set does not depend on it, I will send patch set
> on top of a clean mainline next time, sorry for confusing. 
>
Good to know.
I just wanted to make sure I wasn't missing something important.

Thanks,

Joshua Clayton
