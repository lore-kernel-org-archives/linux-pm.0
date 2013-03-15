From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
Date: Fri, 15 Mar 2013 14:47:05 +0000
Message-ID: <201303151447.06150.arnd@arndb.de>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org> <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58539 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab3COOuo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:50:44 -0400
In-Reply-To: <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, andrew@lunn.ch, magnus.damm@gmail.com, ben-linux@fluff.org, nsekhar@ti.com, nicolas.ferre@atmel.com, rob.herring@calxeda.com, rjw@sisk.pl, kevin.hilman@linaro.org, horms@verge.net.au, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, jason@lakedaemon.net, lenb@kernel.org

On Friday 15 March 2013, Daniel Lezcano wrote:
> The cpuidle drivers are duplicating a lot of code and in most
> of the case there is a common pattern we can factor out:
> 
>         * setup the broadcast timers
>         * register the driver
>         * register the devices
> 
> This arm driver is the common part between all the ARM cpuidle drivers,
> with the code factored out.
> 
> It does not handle the coupled idle state for now but it is the first
> step to have everyone to converge to the same code pattern.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Unfortunately, I missed the session in Hong Kong, but I'd like to understand
what part of this driver is actually ARM specific. I assume there is nothing
in it that depends on 32 bit ARM hardware, right?

Would the same code be used with arch/arm64?

What about other architectures that want to share a cpuidle driver
with and ARM SoC using the same hardware? We have a lot of examples
of SoC vendors that use similar components on ARM and non-ARM SoCs
based on SH, AVR32, Hexagon, C6x, MIPS or PowerPC.

	Arnd
