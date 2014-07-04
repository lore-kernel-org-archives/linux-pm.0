From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 7/8] ARM: mvebu: allow enabling of cpufreq on Armada XP
Date: Fri,  4 Jul 2014 11:45:02 +0200
Message-ID: <1404467103-29644-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56905 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755361AbaGDJp1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jul 2014 05:45:27 -0400
In-Reply-To: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Now that all the pieces to enable cpufreq on Armada XP are in place,
we can make MACH_ARMADA_XP select ARCH_HAS_CPUFREQ to allow the usage
of dynamic frequency scaling on this platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index b9bc599..1ff60ef 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -66,6 +66,7 @@ config MACH_ARMADA_XP
 	select CPU_PJ4B
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_XP
+	select ARCH_HAS_CPUFREQ
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada XP SoC with device tree.
-- 
2.0.0

