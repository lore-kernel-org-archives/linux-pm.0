From: Sebastian Frias <sf84@laposte.net>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Thu, 9 Jun 2016 10:52:12 +0200
Message-ID: <57592E3C.8020005@laposte.net>
References: <Pine.LNX.4.44L0.1606081340050.2191-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtpoutz299.laposte.net ([178.22.154.199]:45771 "EHLO
	smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752067AbcFIIwW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 04:52:22 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
	by lpn-prd-vrout011 (Postfix) with ESMTP id 0E4D752A9BF
	for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2016 10:52:20 +0200 (CEST)
Received: from lpn-prd-vrin004 (lpn-prd-vrin004.prosodie [10.128.63.5])
	by lpn-prd-vrout011 (Postfix) with ESMTP id 3DAC952A9C8
	for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2016 10:52:14 +0200 (CEST)
Received: from lpn-prd-vrin004 (localhost [127.0.0.1])
	by lpn-prd-vrin004 (Postfix) with ESMTP id 28D3E710036
	for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2016 10:52:14 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1606081340050.2191-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Mark Rutland <mark.rutland@arm.com>

Hi Alan,

On 06/08/2016 07:45 PM, Alan Stern wrote:
>> I guess the thermal driver is platform-specific, but most devices
>> are third-party IP blocks, so there is a "common" driver upstream.
>> But I would need a platform-specific suspend/resume sequence,
>> just for my platform.
> 
> Why?  What sort of platform-specific things do you need to do?
> 
>>> For another, the driver should be written in a way that doesn't require
>>> this sort of code.  The ops pointer (not any of the structure's members
>>> -- a pointer to the structure) should be set by the platform-dependent
>>> part of the driver that handles initialization.
>>
>> I don't understand. If my platform loses context on suspend, then
>> I must save/restore it. But this wasteful operation should not be
>> imposed on other platforms.
> 
> More details, please.

In addition to what Marc already replied, allow me to put a small (and hopefully self-contained) example:

- There's a SoC with a HW IP (UART, ethernet, usb or whatever else) for which a generic driver exists.
- The generic driver only needs to know the base address of the block, and it will just work.
- It'll just work, provided that when Linux boots the HW IP is enabled.
- Indeed, the SoC may have other registers controlling if the HW IP is enabled/powered up.
- Those registers are SoC specific, even if the HW IP is generic.

So the question is:
=> Does the use of a generic driver indirectly implies that any SoC specific registers are to be setup outside Linux?
In other words, does Linux expects the HW IP to be powered up/enabled and ready to use? (ie: setup by the bootloader)

If that is not the case, what is the recommended way to handle those registers?
In other words, do the generic drivers provide with an API to handle SoC specific enable/clockgating/powerup registers?

Thanks in advance,

Sebastian
