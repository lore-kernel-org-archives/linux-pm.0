From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [V3 patch 18/19] ARM: davinci: cpuidle: use init/exit common
 routine
Date: Tue, 16 Apr 2013 14:00:41 +0530
Message-ID: <516D0C31.2010403@ti.com>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-19-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34273 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab3DPIdM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Apr 2013 04:33:12 -0400
In-Reply-To: <1365770165-27096-19-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 4/12/2013 6:06 PM, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Tested on DA850 EVM.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
