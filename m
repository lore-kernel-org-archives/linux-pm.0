From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 10/18] ARM: tegra1: cpuidle: use init/exit common routine
Date: Wed, 10 Apr 2013 11:29:09 -0600
Message-ID: <5165A165.3000105@wwwdotorg.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org> <1365603743-5618-11-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54650 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964866Ab3DJR3P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 13:29:15 -0400
In-Reply-To: <1365603743-5618-11-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/10/2013 08:22 AM, Daniel Lezcano wrote:
> Subject: ARM: tegra1: cpuidle: use init/exit common routine

The tag there should be just ARM: tegra: - Tegra1 isn't something that's
supported upstream. Same comment for the other two Tegra patches.

> Remove the duplicated code and use the cpuidle common code for initialization.

Other than that, the 3 Tegra patches look reasonable assuming the
patches that implement the new common APIs are accepted, so the 3 Tegra
patches,

Acked-by: Stephen Warren <swarren@nvidia.com>
