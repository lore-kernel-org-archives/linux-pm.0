From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after cmd_db API change
Date: Fri,  7 Dec 2018 17:29:17 +0200
Message-ID: <20181207152917.4862-9-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, dianders@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Recently the cmd_db_read_aux_data() function was changed to avoid using
memcpy and return a pointer instead. Update the code to the new API and
fix the build failure.

Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f594dd6f500f..06dbc99766ee 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -487,7 +487,9 @@ static struct qcom_icc_desc sdm845_rsc_hlos = {
 static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 {
 	struct qcom_icc_node *qn;
-	int ret, i;
+	const struct bcm_db *data;
+	size_t data_count;
+	int i;
 
 	bcm->addr = cmd_db_read_addr(bcm->name);
 	if (!bcm->addr) {
@@ -496,22 +498,22 @@ static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 		return -EINVAL;
 	}
 
-	if (cmd_db_read_aux_data_len(bcm->name) < sizeof(struct bcm_db)) {
+	data = cmd_db_read_aux_data(bcm->name, &data_count);
+	if (IS_ERR(data)) {
+		dev_err(dev, "%s command db read error (%ld)\n",
+			bcm->name, PTR_ERR(data));
+		return PTR_ERR(data);
+	}
+	if (!data_count) {
 		dev_err(dev, "%s command db missing or partial aux data\n",
 			bcm->name);
 		return -EINVAL;
 	}
 
-	ret = cmd_db_read_aux_data(bcm->name, (u8 *)&bcm->aux_data,
-				   sizeof(struct bcm_db));
-	if (ret < 0) {
-		dev_err(dev, "%s command db read error (%d)\n",
-			bcm->name, ret);
-		return ret;
-	}
-
-	bcm->aux_data.unit = le32_to_cpu(bcm->aux_data.unit);
-	bcm->aux_data.width = le16_to_cpu(bcm->aux_data.width);
+	bcm->aux_data.unit = le32_to_cpu(data->unit);
+	bcm->aux_data.width = le16_to_cpu(data->width);
+	bcm->aux_data.vcd = data->vcd;
+	bcm->aux_data.reserved = data->reserved;
 
 	/*
 	 * Link Qnodes to their respective BCMs
