From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 1/2] soc: imx: gpc: Disable 6sl display power gating for
 ERR006287
Date: Mon,  9 Jul 2018 15:23:01 +0300
Message-ID: <a00303c5672b332d1d363b78926903187169b8cc.1531138446.git.leonard.crestez@nxp.com>
References: <cover.1531138446.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1531138446.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The imx6sl chip errata document describes ERR006287 like this:

"""
Upon resuming from power gating, the modules in the display power domain
(eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
correctly.

When the modules listed above are used, do not use power gating on the
display power domain.
"""

Link: https://www.nxp.com/docs/en/errata/IMX6SLCE.pdf#page=62

Handle this in linux in the same way as imx6qp ERR009619: make the DISP
domain return -EBUSY on power_off.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 526f2d02dc78..6b726dada560 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -339,30 +339,35 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 };
 
 struct imx_gpc_dt_data {
 	int num_domains;
 	bool err009619_present;
+	bool err006287_present;
 };
 
 static const struct imx_gpc_dt_data imx6q_dt_data = {
 	.num_domains = 2,
 	.err009619_present = false,
+	.err006287_present = false,
 };
 
 static const struct imx_gpc_dt_data imx6qp_dt_data = {
 	.num_domains = 2,
 	.err009619_present = true,
+	.err006287_present = false,
 };
 
 static const struct imx_gpc_dt_data imx6sl_dt_data = {
 	.num_domains = 3,
 	.err009619_present = false,
+	.err006287_present = true,
 };
 
 static const struct imx_gpc_dt_data imx6sx_dt_data = {
 	.num_domains = 4,
 	.err009619_present = false,
+	.err006287_present = false,
 };
 
 static const struct of_device_id imx_gpc_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
 	{ .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data },
@@ -467,10 +472,15 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	/* Disable PU power down in normal operation if ERR009619 is present */
 	if (of_id_data->err009619_present)
 		imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
 				PGC_DOMAIN_FLAG_NO_PD;
 
+	/* Disable DISP power down in normal operation if ERR006287 is present */
+	if (of_id_data->err006287_present)
+		imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].flags |=
+				PGC_DOMAIN_FLAG_NO_PD;
+
 	if (!pgc_node) {
 		ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
 					  of_id_data->num_domains);
 		if (ret)
 			return ret;
-- 
2.17.1
