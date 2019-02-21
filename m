From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 1/2] drivers: qcom: rpmh: avoid sending sleep/wake sets immediately
Date: Thu, 21 Feb 2019 18:10:35 +0530
Message-ID: <20190221124036.30535-2-rplsssn@codeaurora.org>
References: <20190221124036.30535-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221124036.30535-1-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Fix the redundant call being made to send the sleep and wake requests
immediately to the controller.

As per the patch[1], the sleep and wake request votes are cached in rpmh
controller and sent during rpmh_flush(). These requests needs to be sent
only during entry of deeper system low power modes or suspend.

[1] https://patchwork.kernel.org/patch/10477533/

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/soc/qcom/rpmh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index e6e98d461121..877fe78199a3 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -228,9 +228,8 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 		WARN_ON(irqs_disabled());
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 	} else {
-		ret = rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr),
-				&rpm_msg->msg);
 		/* Clean up our call by spoofing tx_done */
+		ret = 0;
 		rpmh_tx_done(&rpm_msg->msg, ret);
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
