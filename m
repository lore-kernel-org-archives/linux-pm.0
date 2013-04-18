From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [V3 patch 13/19] ARM: OMAP4: cpuidle: use init/exit common routine
Date: Thu, 18 Apr 2013 14:20:42 +0530
Message-ID: <516FB3E2.30106@ti.com>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-14-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34686 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965897Ab3DRIto (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Apr 2013 04:49:44 -0400
In-Reply-To: <1365770165-27096-14-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

