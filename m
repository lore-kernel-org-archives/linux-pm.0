From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC v2 6/7] ARM: dts: exynos4x12: add suspend OPP for DMC and leftbus
Date: Mon, 19 Dec 2016 03:16:26 +0100
Message-ID: <1482113787-28422-7-git-send-email-tjakobi@math.uni-bielefeld.de>
References: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:43829 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762074AbcLSCSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Dec 2016 21:18:38 -0500
In-Reply-To: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Both DMC and leftbus adjust regulator voltages (MIF and INT
respectively), which have to be in a safe range to allow the
BL0 to operate correctly.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 46c2ada..35cbe40 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -378,6 +378,7 @@
 		opp@400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1050000>;
+			opp-suspend;
 		};
 	};
 
@@ -466,6 +467,7 @@
 		opp@200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <1000000>;
+			opp-suspend;
 		};
 	};
 
-- 
2.7.3

