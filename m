From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the controller is idle
Date: Thu, 21 Feb 2019 17:48:26 +0530
Message-ID: <20190221121827.32427-3-rplsssn@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221121827.32427-1-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Allow the controller status be queried. The controller is busy if it is
actively processing request. Also allow the controller state be read by
platform drivers. This is useful for PM drivers which can choose to
disallow idle modes when the controller is busy.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh-rsc.c      | 24 ++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c          | 13 +++++++++++++
 include/soc/qcom/rpmh.h          |  5 +++++
 4 files changed, 43 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 2e3ffcdf220e..4b891c23b4cd 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -109,6 +109,7 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 int rpmh_rsc_invalidate(struct rsc_drv *drv);
 int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg);
+bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv);
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index d6b834eeeb37..9cc303e88a06 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
 	return ret;
 }
 
+/**
+ *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
+ *
+ *  @drv: The controller
+ *
+ *  Returns true if the TCSes are engaged in handling requests.
+ */
+bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
+{
+	int m;
+	struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
+
+	spin_lock(&drv->lock);
+	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
+		if (!tcs_is_free(drv, m)) {
+			spin_unlock(&drv->lock);
+			return false;
+		}
+	}
+	spin_unlock(&drv->lock);
+
+	return true;
+}
+
 /**
  * rpmh_rsc_write_ctrl_data: Write request to the controller
  *
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 297d6cc4e395..43eb9816041a 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -535,3 +535,16 @@ int rpmh_invalidate(const struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL(rpmh_invalidate);
+
+/**
+ * rpmh_ctrlr_idle: Return the controller idle status
+ *
+ * @dev: the device making the request
+ */
+int rpmh_ctrlr_idle(const struct device *dev)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	return rpmh_rsc_ctrlr_is_idle(ctrlr_to_drv(ctrlr));
+}
+EXPORT_SYMBOL(rpmh_ctrlr_idle);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index b05e31aaf047..4c4b013f0226 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -27,6 +27,8 @@ int rpmh_invalidate(const struct device *dev);
 int rpmh_write_pdc_data(const struct device *dev,
 			const struct tcs_cmd *cmd, u32 n);
 
+int rpmh_ctrlr_idle(const struct device *dev);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
@@ -53,6 +55,9 @@ static inline int rpmh_write_pdc_data(const struct device *dev,
 				      const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
 
+static inline int rpmh_ctrlr_idle(const struct device *dev)
+{ return -ENODEV; }
+
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
