From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 04/17] thermal: dts: exynos: Add LD010 regulator node
 necessary for TMU on Odroid
Date: Wed, 10 Dec 2014 13:09:43 +0100
Message-ID: <1418213396-743-5-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22955 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbaLJMLZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 07:11:25 -0500
In-reply-to: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index c697ff0..9366f5a 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -205,6 +205,13 @@
 					regulator-always-on;
 				};
 
+				ldo10_reg: LDO10 {
+					regulator-name = "VDD18_MIPIHSI_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
 				ldo11_reg: LDO11 {
 					regulator-name = "VDD18_ABB1_1.8V";
 					regulator-min-microvolt = <1800000>;
-- 
2.0.0.rc2

