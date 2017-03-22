From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [RFC 1/8] ARM: imx: gpc: Do not print error message for EPROBE_DEFER
Date: Wed, 22 Mar 2017 18:53:03 +0200
Message-ID: <3f579c378e1bbc2d78674e0846b937b8e69706ce.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1490199005.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The pu regulator request will return -EPROBE_DEFER if it has a supply
from PMIC and this supply is not yet registered. This does not represent
an error since the driver will call probe again later, so only print a
warning message in this case.

Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/mach-imx/gpc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 1dc2a34..ce64d11 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -466,7 +466,11 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		pu_reg = NULL;
 	if (IS_ERR(pu_reg)) {
 		ret = PTR_ERR(pu_reg);
-		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(&pdev->dev, "pu regulator not ready, retry\n");
+		else
+			dev_err(&pdev->dev, "failed to get pu regulator: %d\n",
+					ret);
 		return ret;
 	}
 
-- 
2.7.4
