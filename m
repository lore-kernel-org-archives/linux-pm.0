From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v13 8/8] interconnect: Revert to previous config if any request fails
Date: Wed, 16 Jan 2019 18:11:03 +0200
Message-ID: <20190116161103.6937-9-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, dianders@chromium.org, abailon@baylibre.com, maxime.ripard@bootlin.com, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, henryc.chen@mediatek.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

When consumers report their bandwidth needs with icc_set_bw(), it's
possible that the requested amount of bandwidth is not available or just
the new configuration fails to apply on some path. In this case revert to
the previous configuration and propagate the error back to the consumers
to let them know that bandwidth is not available, hardware is busy or
whatever error is returned by the interconnect platform driver.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8091d998549a..6005a1c189f6 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -414,14 +414,18 @@ EXPORT_SYMBOL_GPL(of_icc_get);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	struct icc_node *node;
+	u32 old_avg, old_peak;
 	size_t i;
 	int ret;
 
-	if (!path)
+	if (!path || !path->num_nodes)
 		return 0;
 
 	mutex_lock(&icc_lock);
 
+	old_avg = path->reqs[0].avg_bw;
+	old_peak = path->reqs[0].peak_bw;
+
 	for (i = 0; i < path->num_nodes; i++) {
 		node = path->reqs[i].node;
 
@@ -434,10 +438,19 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	}
 
 	ret = apply_constraints(path);
-	if (ret)
+	if (ret) {
 		pr_debug("interconnect: error applying constraints (%d)\n",
 			 ret);
 
+		for (i = 0; i < path->num_nodes; i++) {
+			node = path->reqs[i].node;
+			path->reqs[i].avg_bw = old_avg;
+			path->reqs[i].peak_bw = old_peak;
+			aggregate_requests(node);
+		}
+		apply_constraints(path);
+	}
+
 	mutex_unlock(&icc_lock);
 
 	return ret;
