From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 6/6] drivers: soc: system_pm: Add suspend notifier
Date: Sat, 25 Aug 2018 01:36:28 +0530
Message-ID: <1535141188-29731-7-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

The order of suspending different devices, which is part of device
suspend, during pm suspend can't be guaranteed. So once system PM device
flushes the cached sleep/wake requests, other client devices may send
new sleep or wake requests in their device suspend operations. The rpmh
controller needs to manage such new requests if any. A notification is
sent to controller to indicate the same.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/system_pm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/system_pm.c b/drivers/soc/qcom/system_pm.c
index 1451bf8..6524f7e 100644
--- a/drivers/soc/qcom/system_pm.c
+++ b/drivers/soc/qcom/system_pm.c
@@ -133,6 +133,7 @@ static int sys_pm_suspend(struct device *dev)
 		/* Flush the sleep/wake sets in RSC controller */
 		rpmh_flush(dev);
 		setup_pdc_wakeup_timer(true);
+		rpmh_notify_suspend(sys_pm_dev, true);
 	} else {
 		pr_err("%s:rpmh controller is busy\n", __func__);
 		return -EBUSY;
@@ -141,8 +142,14 @@ static int sys_pm_suspend(struct device *dev)
 	return 0;
 }
 
+static int sys_pm_resume(struct device *dev)
+{
+	rpmh_notify_suspend(sys_pm_dev, false);
+	return 0;
+}
+
 static const struct dev_pm_ops sys_pm_dev_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(sys_pm_suspend, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(sys_pm_suspend, sys_pm_resume)
 };
 
 static const struct of_device_id sys_pm_drv_match[] = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
