From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 5/6] drivers: qcom: rpmh: force flush new sleep/wake requests during suspend
Date: Sat, 25 Aug 2018 01:36:27 +0530
Message-ID: <1535141188-29731-6-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

During pm suspend, newer sleep/wake requests may come as it can't be
guaranteed that system PM device suspend will be called only in the end.
After system PM does rpmh_flush, the suspend_in_progress flag is set to
enable rpmh controller to manage new sleep/wake requests if any.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh.c          | 17 +++++++++++++++++
 include/soc/qcom/rpmh.h          |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index f5359be..45bab3b 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -80,6 +80,7 @@ struct rpmh_ctrlr {
 	bool dirty;
 	struct list_head batch_cache;
 	bool in_solver_mode;
+	bool suspend_in_progress;
 };
 
 /**
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 390e779..a9bd1a0 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -237,6 +237,8 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 		WARN_ON(irqs_disabled());
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 	} else {
+		if (ctrlr->suspend_in_progress)
+			rpmh_flush(dev);
 		/* Clean up our call by spoofing tx_done */
 		ret = 0;
 		rpmh_tx_done(&rpm_msg->msg, ret);
@@ -434,6 +436,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 	if (state != RPMH_ACTIVE_ONLY_STATE) {
 		cache_batch(ctrlr, req);
+		if (ctrlr->suspend_in_progress)
+			rpmh_flush(dev);
 		return 0;
 	}
 
@@ -610,3 +614,16 @@ int rpmh_ctrlr_idle(const struct device *dev)
 	return rpmh_rsc_ctrlr_is_idle(ctrlr_to_drv(ctrlr));
 }
 EXPORT_SYMBOL(rpmh_ctrlr_idle);
+
+/**
+ * rpmh_notify_suspend: Set suspend in progress flag
+ *
+ * @suspend: boolean to indicate the supend mode
+ */
+void rpmh_notify_suspend(const struct device *dev, bool suspend)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	ctrlr->suspend_in_progress = suspend;
+}
+EXPORT_SYMBOL(rpmh_notify_suspend);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index d5e736e..2e79bee 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -31,6 +31,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 int rpmh_write_pdc_data(const struct device *dev,
 			const struct tcs_cmd *cmd, u32 n);
 
+void rpmh_notify_suspend(const struct device *dev, bool suspend);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
@@ -62,6 +64,9 @@ static inline int rpmh_mode_solver_set(const struct device *dev, bool enable)
 static inline int rpmh_write_pdc_data(const struct device *dev,
 				      const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
+
+static inline void rpmh_notify_suspend(const struct device *dev, bool suspend)
+{ }
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
