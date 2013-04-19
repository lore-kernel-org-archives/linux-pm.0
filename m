From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [V3 patch 04/19] cpuidle: remove en_core_tk_irqen flag
Date: Fri, 19 Apr 2013 15:21:54 -0700
Message-ID: <87fvymw48t.fsf@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
	<1365770165-27096-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:64184 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934044Ab3DSWV7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2013 18:21:59 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so2113820daj.22
        for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2013 15:21:58 -0700 (PDT)
In-Reply-To: <1365770165-27096-5-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Fri, 12 Apr 2013 14:35:50 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> The en_core_tk_irqen flag is set in all the cpuidle driver which
> means it is not necessary to specify this flag.
>
> Remove the flag and the code related to it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>  # for mach-omap2/*
