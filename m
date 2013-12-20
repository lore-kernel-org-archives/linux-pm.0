From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 6/9] intel_idle: do C1E promotion disable quirk for
 hotplugged CPUs
Date: Fri, 20 Dec 2013 19:47:28 +0100
Message-ID: <1387565251-7051-7-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

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
index 92d1206..38da3fb 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -683,6 +683,9 @@ static int intel_idle_cpu_init(int cpu)
 	if (icpu->auto_demotion_disable_flags)
 		smp_call_function_single(cpu, auto_demotion_disable, NULL, 1);
 
+	if (icpu->disable_promotion_to_c1e)
+		smp_call_function_single(cpu, c1e_promotion_disable, NULL, 1);
+
 	return 0;
 }
 
-- 
1.8.2.3
