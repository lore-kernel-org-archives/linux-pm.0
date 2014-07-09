From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 1/7] ARM: mvebu: ensure CPU clocks are enabled
Date: Wed,  9 Jul 2014 17:45:09 +0200
Message-ID: <1404920715-19834-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49248 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756187AbaGIPpU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 11:45:20 -0400
In-Reply-To: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

In the Armada XP SMP support code, we are reading the clock frequency
of the booting CPU, and use that to assign the same frequency to the
other CPUs, and we do this while the clocks are disabled.

However, the CPU clocks are in fact never prepared/enabled, and to
support cpufreq, we now have two code paths to change the frequency of
the CPU clocks in the CPU clock driver: one when the clock is enabled
(dynamic frequency scaling), one when the clock is disabled (adjusting
the CPU frequency before starting the CPU). In order for this to work,
the CPU clocks now have to be prepared and enabled after the initial
synchronization of the clock frequencies is done, so that all future
rate changes of the CPU clocks will trigger a dynamic frequency
scaling transition.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 88b976b3..4880b0f 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -67,6 +67,7 @@ static void __init set_secondary_cpus_clock(void)
 		if (!cpu_clk)
 			return;
 		clk_set_rate(cpu_clk, rate);
+		clk_prepare_enable(cpu_clk);
 	}
 }
 
-- 
2.0.0

