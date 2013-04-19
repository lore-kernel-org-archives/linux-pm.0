From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [V3 patch 00/19] cpuidle: code consolidation
Date: Fri, 19 Apr 2013 15:44:19 -0700
Message-ID: <8761ziw37g.fsf@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:64147 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934051Ab3DSWoY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2013 18:44:24 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so321781dad.29
        for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2013 15:44:23 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Fri, 12 Apr 2013 14:35:46 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> This patchset series provide some code consolidation across the different
> cpuidle drivers. It contains two parts, the first one is the removal of
> the time keeping flag and the second one, is a common initialization routine.

[...]

> Tested-on: u8500
> Tested-on: at91
> Tested-on: intel i5
> Tested-on: OMAP4

Tested-by: Kevin Hilman <khilman@linaro.org> # OMAP3, OMAP4

Kevin
