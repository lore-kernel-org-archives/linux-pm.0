From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 1/2] soc: imx: gpc: Use static platform_device instances
Date: Mon,  2 Jul 2018 14:52:34 +0300
Message-ID: <d6af4fbf666a01aea5831cf67f299390e632f698.1530530881.git.leonard.crestez@nxp.com>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530530881.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Andrey Smirnov <andrew.smirnov@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Simplify the code by doing less dynamic allocation.

This also allows easier direct manipulation of individual power domains.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748fd067..83cb275592e9 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -283,10 +283,24 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		.reg_offs = 0x200,
 		.cntr_pdn_bit = 6,
 	},
 };
 
+#define DEFINE_IMX_GPC_PDEV(_id) \
+	{ \
+		.name	= "imx-pgc-power-domain", \
+		.id	= _id, \
+		.dev	= { .platform_data = &imx_gpc_domains[_id] }, \
+	}
+
+static struct platform_device imx_pgc_pdev[] = {
+	DEFINE_IMX_GPC_PDEV(0),
+	DEFINE_IMX_GPC_PDEV(1),
+	DEFINE_IMX_GPC_PDEV(2),
+	DEFINE_IMX_GPC_PDEV(3),
+};
+
 struct imx_gpc_dt_data {
 	int num_domains;
 	bool err009619_present;
 };
 
@@ -441,35 +455,20 @@ static int imx_gpc_probe(struct platform_device *pdev)
 				return ret;
 			}
 			if (domain_index >= of_id_data->num_domains)
 				continue;
 
-			pd_pdev = platform_device_alloc("imx-pgc-power-domain",
-							domain_index);
-			if (!pd_pdev) {
-				of_node_put(np);
-				return -ENOMEM;
-			}
-
-			ret = platform_device_add_data(pd_pdev,
-						       &imx_gpc_domains[domain_index],
-						       sizeof(imx_gpc_domains[domain_index]));
-			if (ret) {
-				platform_device_put(pd_pdev);
-				of_node_put(np);
-				return ret;
-			}
-			domain = pd_pdev->dev.platform_data;
+			domain = &imx_gpc_domains[domain_index];
 			domain->regmap = regmap;
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
+			pd_pdev = &imx_pgc_pdev[domain_index];
 			pd_pdev->dev.parent = &pdev->dev;
 			pd_pdev->dev.of_node = np;
 
-			ret = platform_device_add(pd_pdev);
+			ret = platform_device_register(pd_pdev);
 			if (ret) {
-				platform_device_put(pd_pdev);
 				of_node_put(np);
 				return ret;
 			}
 		}
 	}
-- 
2.17.1
