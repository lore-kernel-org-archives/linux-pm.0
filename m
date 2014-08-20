From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] thermal: samsung: Exynos5260 and Exynos5420 should not use
 TRIM_RELOAD flag
Date: Wed, 20 Aug 2014 15:57:20 +0200
Message-ID: <1633286.4v5Jz9xi2j@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:61837 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaHTN52 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Aug 2014 09:57:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Currently these SoCs claim TRIM_RELOAD support but don't have
triminfo_ctrl register address defined in their struct
exynos_tmu_registers entries.  This causes incorrect write of
value "1" to data->base + 0x00 address (which happens to be
TRIMINFO register).  Additionally according to the documentation
that I have neither Exynos5260 nor Exynos5420 support/require
TRIM_RELOAD feature.  Thus fix the aforementioned issue by
removing TMU_SUPPORT_TRIM_RELOAD flag for both Exynos5260 and
Exynos5420.

Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
v2:
- enhanced patch description per Eduardo's request

 drivers/thermal/samsung/exynos_tmu_data.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index aa8e0de..8c0ada2 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -359,9 +359,8 @@ static const struct exynos_tmu_registers exynos5260_tmu_registers = {
 #define EXYNOS5260_TMU_DATA \
 	__EXYNOS5260_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5260, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
-			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
-			TMU_SUPPORT_EMUL_TIME)
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
+			TMU_SUPPORT_READY_STATUS | TMU_SUPPORT_EMUL_TIME)
 
 struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 	.tmu_data = {
@@ -451,16 +450,15 @@ static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 #define EXYNOS5420_TMU_DATA \
 	__EXYNOS5420_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5250, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
-			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
-			TMU_SUPPORT_EMUL_TIME)
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
+			TMU_SUPPORT_READY_STATUS | TMU_SUPPORT_EMUL_TIME)
 
 #define EXYNOS5420_TMU_DATA_SHARED \
 	__EXYNOS5420_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5420_TRIMINFO, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
-			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
-			TMU_SUPPORT_EMUL_TIME | TMU_SUPPORT_ADDRESS_MULTIPLE)
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
+			TMU_SUPPORT_READY_STATUS | TMU_SUPPORT_EMUL_TIME | \
+			TMU_SUPPORT_ADDRESS_MULTIPLE)
 
 struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 	.tmu_data = {
-- 
1.8.2.3


