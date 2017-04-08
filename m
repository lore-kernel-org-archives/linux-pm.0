From: Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/5] cpufreq: dt: Add support for some new Allwinner SoCs
Date: Sun,  9 Apr 2017 02:50:23 +0800
Message-ID: <20170408185025.53841-4-icenowy@aosc.io>
References: <20170408185025.53841-1-icenowy@aosc.io>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:42634 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbdDHSwl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Apr 2017 14:52:41 -0400
In-Reply-To: <20170408185025.53841-1-icenowy@aosc.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>

Some new Allwinner SoCs get supported in the kernel after the
compatibles are added to cpufreq-dt-platdev driver.

Add their compatible strings in the cpufreq-dt-platdev driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 921b4a6c3d16..2180e509e383 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -24,7 +24,12 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "allwinner,sun8i-a23", },
 	{ .compatible = "allwinner,sun8i-a33", },
 	{ .compatible = "allwinner,sun8i-a83t", },
+	{ .compatible = "allwinner,sun8i-h2-plus", },
 	{ .compatible = "allwinner,sun8i-h3", },
+	{ .compatible = "allwinner,sun8i-v3s", },
+	{ .compatible = "allwinner,sun50i-a64", },
+	{ .compatible = "allwinner,sun50i-h5", },
+	{ .compatible = "nextthing,gr8", },
 
 	{ .compatible = "apm,xgene-shadowcat", },
 
-- 
2.12.2
