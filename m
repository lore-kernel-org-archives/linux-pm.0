From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v4 2/2] soc: imx: gpc: Use GENPD_FLAG_NO_RUNTIME_OFF for
 ERR009619
Date: Fri, 26 Apr 2019 21:38:16 +0000
Message-ID: <f0bf98cc6ef4cc42101092965b1e4f34375915d3.1556313614.git.leonard.crestez@nxp.com>
References: <cover.1556313614.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1556313614.git.leonard.crestez@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arulpandiyan Vadivel <Arulpandiyan_Vadivel@mentor.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

This allows PU to be turned off in suspend and save power.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index a8f1e47ce698..4dd493eccc98 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -427,14 +427,23 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to init regmap: %d\n",
 			ret);
 		return ret;
 	}
 
-	/* Disable PU power down in normal operation if ERR009619 is present */
+	/*
+	 * Disable PU power down by runtime PM if ERR009619 is present.
+	 *
+	 * The PRE clock will be paused for several cycles when turning on the
+	 * PU domain LDO from power down state. If PRE is in use at that time,
+	 * the IPU/PRG cannot get the correct display data from the PRE.
+	 *
+	 * This is not a concern when the whole system enters suspend state, so
+	 * it's safe to power down PU in this case.
+	 */
 	if (of_id_data->err009619_present)
 		imx_gpc_domains[GPC_PGC_DOMAIN_PU].base.flags |=
-				GENPD_FLAG_ALWAYS_ON;
+				GENPD_FLAG_NO_RUNTIME_OFF;
 
 	/* Keep DISP always on if ERR006287 is present */
 	if (of_id_data->err006287_present)
 		imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
 				GENPD_FLAG_ALWAYS_ON;
-- 
2.17.1
