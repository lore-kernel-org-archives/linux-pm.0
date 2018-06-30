From: Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: [PATCH v2] thermal: i.MX: Allow thermal probe to fail gracefully in
 case of bad calibration.
Date: Sun,  1 Jul 2018 00:10:50 +0200
Message-ID: <20180630221050.1474-1-jcd@tribudubois.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawnguo@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
List-Id: linux-pm@vger.kernel.org

Without this fix, the thermal probe on i.MX6 might trigger a division
by zero exception later in the probe if the calibration does fail.

Note: This linux behavior (Division by zero in kernel) has been triggered
on a Qemu i.MX6 emulation where parameters in nvmem were not set. With this
fix the division by zero is not triggeed anymore as the thermal probe does
fail early.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
v2 changes:
 - improved subject line
 - added thermal maintainers in the destination list.

 drivers/thermal/imx_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 334d98be03b9..b1f82d64253e 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -604,7 +604,10 @@ static int imx_init_from_nvmem_cells(struct platform_device *pdev)
 	ret = nvmem_cell_read_u32(&pdev->dev, "calib", &val);
 	if (ret)
 		return ret;
-	imx_init_calib(pdev, val);
+
+	ret = imx_init_calib(pdev, val);
+	if (ret)
+		return ret;
 
 	ret = nvmem_cell_read_u32(&pdev->dev, "temp_grade", &val);
 	if (ret)
-- 
2.17.1
