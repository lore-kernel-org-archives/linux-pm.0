From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 07/21] thermal: dts: trats: Enable TMU on the Exynos4210 trats
 device
Date: Thu, 09 Oct 2014 18:38:43 +0200
Message-ID: <1412872737-624-8-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65357 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbaJIQji (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:39:38 -0400
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

The thermal IP block (Thermal Management Unit) called TMU has been enabled
in this device.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index f516da9..b59019c 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -424,6 +424,10 @@
 		status = "okay";
 	};
 
+	tmu@100C0000 {
+		status = "okay";
+	};
+
 	camera {
 		pinctrl-names = "default";
 		pinctrl-0 = <>;
-- 
2.0.0.rc2

