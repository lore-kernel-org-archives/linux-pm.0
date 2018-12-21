From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 4/5] drivers: qcom: rpmh-pdc-timer: Add power management ops
Date: Fri, 21 Dec 2018 17:29:45 +0530
Message-ID: <20181221115946.10095-5-rplsssn@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221115946.10095-1-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add suspend power management ops so that the PDC timer is programmed
to highest match value when system is suspended.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig          |  2 +-
 drivers/soc/qcom/rpmh-pdc-timer.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index d04724ea5490..c6ef41a06c97 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -105,7 +105,7 @@ config QCOM_RPMH
 
 config QCOM_RPMH_PDC_TIMER
 	bool "Qualcomm PDC Timer for RPM-Hardened based SoCs"
-	depends on CPU_PM
+	depends on CPU_PM && PM_SLEEP
 	help
 	  Support for QCOM platform next wakeup timer programming when
 	  application processor enters SoC level deepest low power mode.
diff --git a/drivers/soc/qcom/rpmh-pdc-timer.c b/drivers/soc/qcom/rpmh-pdc-timer.c
index 108ea4a2df89..ebb643924a3e 100644
--- a/drivers/soc/qcom/rpmh-pdc-timer.c
+++ b/drivers/soc/qcom/rpmh-pdc-timer.c
@@ -23,6 +23,7 @@ static resource_size_t cmd0_data_offset;
 static resource_size_t cmd1_data_offset;
 static uint64_t pdc_wakeup = ~0ULL;
 static raw_spinlock_t pdc_wakeup_lock;
+static int suspended;
 
 /* convert micro sec to ticks or clock cycles
  *
@@ -102,6 +103,9 @@ static int cpu_pm_notifier(struct notifier_block *b,
 {
 	uint64_t cpu_next_wakeup;
 
+	if (suspended)
+		return NOTIFY_DONE;
+
 	switch (cmd) {
 	case CPU_PM_ENTER:
 		cpu_next_wakeup = get_next_wakeup_cycles(smp_processor_id());
@@ -130,6 +134,25 @@ static struct notifier_block cpu_pm_notifier_block = {
 	.priority = -1, /* Should be last in the order of notifications */
 };
 
+static int pdc_timer_suspend(struct device *dev)
+{
+	suspended = true;
+	raw_spin_lock(&pdc_wakeup_lock);
+	pdc_wakeup = ~0ULL;
+	setup_pdc_wakeup_timer(pdc_wakeup);
+	raw_spin_unlock(&pdc_wakeup_lock);
+	return 0;
+}
+
+static int pdc_timer_resume(struct device *dev)
+{
+	suspended = false;
+	return 0;
+}
+static const struct dev_pm_ops pdc_timer_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pdc_timer_suspend, pdc_timer_resume)
+};
+
 static int pdc_timer_probe(struct platform_device *pdev)
 {
 	struct device *pdc_timer_dev = &pdev->dev;
@@ -176,6 +199,7 @@ static struct platform_driver pdc_timer_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = pdc_timer_drv_match,
+		.pm = &pdc_timer_dev_pm_ops,
 	},
 };
 builtin_platform_driver(pdc_timer_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
