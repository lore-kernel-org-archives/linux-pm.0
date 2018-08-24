From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 3/6] drivers: qcom: system_pm: Add power management ops
Date: Sat, 25 Aug 2018 01:36:25 +0530
Message-ID: <1535141188-29731-4-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add suspend power management ops so that the sleep & wake resource
requests are flushed to corresponding TCS. The firmware would ensure
that the buffered requests in TCS are sent to Resource Power Manager
during entry to deepest low power modes.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig     |  2 +-
 drivers/soc/qcom/system_pm.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a52abe9..ac0e413 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -88,7 +88,7 @@ config QCOM_RPMH
 
 config QCOM_SYSTEM_PM
 	bool "Qualcomm System PM"
-	depends on CPU_PM && QCOM_RPMH
+	depends on CPU_PM && PM_SLEEP && QCOM_RPMH
 	help
 	  Support for QCOM platform system power management to perform tasks
 	  necessary while application processor votes for deeper modes so that
diff --git a/drivers/soc/qcom/system_pm.c b/drivers/soc/qcom/system_pm.c
index 40e5aa7..8810b84 100644
--- a/drivers/soc/qcom/system_pm.c
+++ b/drivers/soc/qcom/system_pm.c
@@ -67,6 +67,23 @@ static int sys_pm_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int sys_pm_suspend(struct device *dev)
+{
+	if (rpmh_ctrlr_idle(dev)) {
+		/* Flush the sleep/wake sets in RSC controller */
+		rpmh_flush(dev);
+	} else {
+		pr_err("%s:rpmh controller is busy\n", __func__);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops sys_pm_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(sys_pm_suspend, NULL)
+};
+
 static const struct of_device_id sys_pm_drv_match[] = {
 	{ .compatible = "qcom,system-pm", },
 	{ }
@@ -77,6 +94,7 @@ static int sys_pm_probe(struct platform_device *pdev)
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = sys_pm_drv_match,
+		.pm = &sys_pm_dev_pm_ops,
 	},
 };
 builtin_platform_driver(sys_pm_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
