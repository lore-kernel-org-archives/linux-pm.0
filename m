From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 6/9] intel_idle: do C1E promotion disable quirk for hotplugged
 CPUs
Date: Tue, 20 Aug 2013 16:23:44 +0200
Message-ID: <1377008627-32691-7-git-send-email-b.zolnierkie@samsung.com>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59166 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3HTO0R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 10:26:17 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU000D32RPTMI0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 23:26:17 +0900 (KST)
In-reply-to: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, Len Brown <lenb@kernel.org>

If the system is booted with some CPUs offline C1E promotion disable quirk
won't be applied because on_each_cpu() in intel_idle_cpuidle_driver_init()
operates only on online CPUs. Fix it by adding the C1E promotion disable
handling to intel_idle_cpu_init() (which is also called during CPU_ONLINE
operation).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/idle/intel_idle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index fa6964d..3d0e11f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -661,6 +661,9 @@ static int intel_idle_cpu_init(int cpu)
 	if (icpu->auto_demotion_disable_flags)
 		smp_call_function_single(cpu, auto_demotion_disable, NULL, 1);
 
+	if (icpu->disable_promotion_to_c1e)
+		smp_call_function_single(cpu, c1e_promotion_disable, NULL, 1);
+
 	return 0;
 }
 
-- 
1.8.2.3

