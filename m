From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 7/8] ARM: tegra: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:24:09 -0600
Message-ID: <51CB31C9.7050505@wwwdotorg.org>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com> <1372241747-21083-8-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34659 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab3FZSYN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 14:24:13 -0400
In-Reply-To: <1372241747-21083-8-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com

On 06/26/2013 04:15 AM, Bartlomiej Zolnierkiewicz wrote:
> Compile tested only.

That's not a good patch description; it's more something that should be
below the --- line.

This would be a lot easier to review if "-M" had been passed to "git
format-patch" so that the move was actually represented as a move in the
patch.

This patch would need to move at least part of
arch/arm/mach-tegra/cpuidle.h to some common location, since core code
that's left in arch/arm/mach-tegra ends up calling functions in the
moved files to initialize the cpuidle driver.

You should probably move arch/arm/mach-tegra/cpuidle.c too.

Does it make sense to introduce a new Kconfig option into
drivers/cpuidle/Kconfig, so that cpuidle-tegra*.c isn't compiled if
ARCH_TEGRA is enabled, but rather if something more like CPU_IDLE_TEGRA
is enabled?
