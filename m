From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 2/2] drivers: soc: qcom: rpmh-rsc: Correct check for slot number
Date: Thu, 21 Feb 2019 18:10:36 +0530
Message-ID: <20190221124036.30535-3-rplsssn@codeaurora.org>
References: <20190221124036.30535-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221124036.30535-1-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Maulik Shah <mkshah@codeaurora.org>

The return index value from bitmap_find_next_zero_area can be higher
than available slot. So correct the check to return error in such case.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 10b3102298c7..3ff3bebd4d71 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -491,7 +491,7 @@ static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
 	do {
 		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
 						  i, msg->num_cmds, 0);
-		if (slot == tcs->num_tcs * tcs->ncpt)
+		if (slot >= tcs->num_tcs * tcs->ncpt)
 			return -ENOMEM;
 		i += tcs->ncpt;
 	} while (slot + msg->num_cmds - 1 >= i);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
