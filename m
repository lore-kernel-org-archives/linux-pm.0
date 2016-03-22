From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] intel_idle: make intel_idle_state_table_update() static
Date: Tue, 22 Mar 2016 22:32:50 +0800
Message-ID: <1458657170-2394-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50655 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756376AbcCVOgq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 10:36:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

intel_idle_state_table_update() is only used internally in intel_idle,
so make it static.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cd4510a..2e0341e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1001,7 +1001,7 @@ static void intel_idle_cpuidle_devices_uninit(void)
  * Currently used to access tuned IVT multi-socket targets
  * Assumption: num_sockets == (max_package_num + 1)
  */
-void intel_idle_state_table_update(void)
+static void intel_idle_state_table_update(void)
 {
 	/* IVT uses a different table for 1-2, 3-4, and > 4 sockets */
 	if (boot_cpu_data.x86_model == 0x3e) { /* IVT */
-- 
2.8.0.rc3

