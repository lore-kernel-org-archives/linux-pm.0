From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 3/4] OPP: Update the bandwidth on OPP frequency changes
Date: Wed, 13 Mar 2019 11:00:09 +0200
Message-ID: <20190313090010.20534-4-georgi.djakov@linaro.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313090010.20534-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

If the OPP bandwidth values are populated, we want to switch also the
interconnect bandwidth in addition to frequency and voltage.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/opp/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4b019cecaa07..99e7c4cf6c34 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -781,6 +781,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
 
+	if (!ret && !IS_ERR_OR_NULL(opp_table->path) && opp->bandwidth)
+		icc_set_bw(opp_table->path, opp->bandwidth->avg,
+			   opp->bandwidth->peak);
+
 	/* Scaling down? Configure required OPPs after frequency */
 	if (!ret && freq < old_freq) {
 		ret = _set_required_opps(dev, opp_table, opp);
