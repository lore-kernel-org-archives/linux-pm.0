From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 09/10] drivers: qcom: spm: Use hwspinlock to serialize entry into SCM
Date: Wed,  5 Aug 2015 10:32:45 -0600
Message-ID: <1438792366-2737-10-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33394 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbbHEQdS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 12:33:18 -0400
Received: by pabyb7 with SMTP id yb7so8038609pab.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 09:33:18 -0700 (PDT)
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: agross@codeaurora.org, msivasub@codeaurora.org, sboyd@codeaurora.org, robh@kernel.org, Lina Iyer <lina.iyer@linaro.org>

When the last CPU enters idle, the state of L2 is determined and the
power controller for the L2 is programmed to power down. The power
controllers' state machine is only triggered when all the CPUs have
executed their WFI instruction. Multiple CPUs may enter SCM to power
down at the same time. Linux identifies the last man down and determines
the state of the cluster, but an FIQ could have kept another CPU busy.
The last CPU to enter SCM may not be the last CPU as determined by
Linux. So the state of the cluster would not be correctly relayed to the
SCM. To ensure that the last CPU in Linux is the same in SCM, serialize
the entry into SCM. Linux is responsible for flushing non-secure L2,
while SCM flushes only the secure lines of L2. Invalidation for secure
and non-secure L2 is done by the SCM when the first CPU resumes from
idle.

An example of the last man race -

Say there are two cores powering down - CoreA and CoreB

CoreA enters idle is not the last core and about to call into SCM
CoreB enters idle and is the last core, determines L2 should be flushed
CoreB receives an FIQ and gets busy handling the FIQ
CoreA has an pending IRQ, bails out of SCM and cpuidle
CoreB is still busy
CoreA enters cpuidle again and now is the last core
CoreA determines L2 should *not* be flushed and calls SCM
CoreB finishes FIQ, enters SCM with a stale L2 state (L2 to be flushed)
SCM records L2 as flushed and invalidates L2 when a core comes up.

To avoid this race, serialize all entry from Linux to SCM for cpuidle. A
hwspinlock is locked by Linux and released by the SCM when the context
switches to Secure. This way, the last man view of both Linux and SCM,
match with that of the L2 power controller configuration. A raw
hwspinlock would not use s/w spinlocks around the hwspinlock.
Since there is no possiblity of preemption in cpuidle, it is safe to
use the raw variant of the hwspinlock.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/Kconfig |  1 +
 drivers/soc/qcom/spm.c   | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index b6c2e5d..cb50efb 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -18,6 +18,7 @@ config QCOM_PM
 	select PM_GENERIC_DOMAINS
 	select PM_GENERIC_DOMAINS_SLEEP
 	select PM_GENERIC_DOMAINS_OF
+	select HWSPINLOCK_QCOM
 	help
 	  QCOM Platform specific power driver to manage cores and L2 low power
 	  modes. It interface with various system drivers to put the cores in
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b6d75db..bd09514 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -26,6 +26,8 @@
 #include <linux/cpu_pm.h>
 #include <linux/pm_domain.h>
 #include <linux/qcom_scm.h>
+#include <linux/pm_domain.h>
+#include <linux/hwspinlock.h>
 
 #include <asm/arm-pd.h>
 #include <asm/cacheflush.h>
@@ -38,6 +40,7 @@
 #define SPM_CTL_INDEX		0x7f
 #define SPM_CTL_INDEX_SHIFT	4
 #define SPM_CTL_EN		BIT(0)
+#define QCOM_PC_HWLOCK		7
 
 enum pm_sleep_mode {
 	PM_SLEEP_MODE_STBY,
@@ -139,6 +142,7 @@ static int l2_flush_flag;
 
 typedef int (*idle_fn)(int);
 static DEFINE_PER_CPU(idle_fn*, qcom_idle_ops);
+static struct hwspinlock *remote_lock;
 
 static inline void spm_register_write(struct spm_driver_data *drv,
 					enum spm_reg reg, u32 val)
@@ -198,6 +202,24 @@ static int qcom_pm_collapse(unsigned long int unused)
 	if (l2_flush_flag == QCOM_SCM_CPU_PWR_DOWN_L2_OFF)
 		flush_cache_all();
 
+	/*
+	 * Wait and acquire the hwspin lock to synchronize
+	 * the entry into SCM. The view of the last core in Linux
+	 * should be same for SCM so the l2_flush_flag is correct.
+	 *
+	 * * IMPORTANT *
+	 * 1. SCM unlocks this lock.
+	 * 2. We do not want to call api that would spinlock before
+	 *    acquiring the hwspin lock. It will not be unlocked.
+	 *    So call raw variant
+	 * 3. Every core needs to acquire this lock and the entry into
+	 *    SCM would be serialized after this point.
+	 */
+	if (remote_lock) {
+		while (hwspin_trylock_raw(remote_lock))
+			;
+	}
+
 	qcom_scm_cpu_power_down(l2_flush_flag);
 
 	/*
@@ -439,6 +461,10 @@ static int spm_dev_probe(struct platform_device *pdev)
 	else
 		per_cpu(cpu_spm_drv, index) = drv;
 
+	/* Initialize hwspinlock, to serialize entry into secure */
+	if (!remote_lock && of_match_node(cache_spm_table, pdev->dev.of_node))
+		remote_lock = hwspin_lock_request_specific(QCOM_PC_HWLOCK);
+
 	dev_dbg(&pdev->dev, "SPM device probed.\n");
 	return 0;
 }
-- 
2.1.4

