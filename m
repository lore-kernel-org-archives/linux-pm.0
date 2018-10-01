From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 1/3] soc: imx: gpc: Increase GPC_CLK_MAX to 7
Date: Mon,  1 Oct 2018 23:56:16 +0300
Message-ID: <f224bad2c4bf8d09faded5fe557463e313e368de.1538426534.git.leonard.crestez@nxp.com>
References: <cover.1538426534.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538426534.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

The DISPLAY power domain on imx6sx has 7 clocks.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index c1d0ffdac6dd..51cbfe63ec12 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -39,11 +39,11 @@
 #define GPC_PGC_DISP_SR		0x24c
 
 #define GPU_VPU_PUP_REQ		BIT(1)
 #define GPU_VPU_PDN_REQ		BIT(0)
 
-#define GPC_CLK_MAX		6
+#define GPC_CLK_MAX		7
 
 #define PGC_DOMAIN_FLAG_NO_PD		BIT(0)
 
 struct imx_pm_domain {
 	struct generic_pm_domain base;
-- 
2.17.1
