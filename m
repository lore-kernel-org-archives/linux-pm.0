From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 01/21] ARM: pxa: magician: Fix Kconfig for magician to always include htc-egpio
Date: Tue, 18 Aug 2015 20:31:31 +0200
Message-ID: <87zj1o8n3w.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25880.3030507@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:29520 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbHRSfm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 14:35:42 -0400
In-Reply-To: <55D25880.3030507@tul.cz> (Petr Cvek's message of "Mon, 17 Aug
	2015 23:56:16 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> The htc-egpio driver should be always included in the kernel as it
> controls MMC/charging/IrDA power, which is the only way to get
> an useful rootfs.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
It's already defined in magician_defconfig, why enforce it in Kconfig ?

And if it's enforced and I want to build a kernel for magician without
MMC/charging/IrDA, why should I be forced to build in HTC_EGPIO ?

Or said differently, does a kernel without HTC_EGPIO is proven to fail 100%
without this option ?

Cheers.

-- 
Robert
