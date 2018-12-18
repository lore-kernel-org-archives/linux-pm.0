From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 3/3] firmware: imx: scu-pd: add fallback compatible string
 support
Date: Tue, 18 Dec 2018 16:01:29 +0000
Message-ID: <1545148524-658-4-git-send-email-aisheng.dong@nxp.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
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
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

SCU power domain can be used in the same way by IMX8QXP and IMX8QM SoCs.
Make the driver support the fallback compatible string "fsl,scu-pd" to
allow other SoCs to reuse the common part.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 407245f..1aaae98 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -321,6 +321,7 @@ static int imx_sc_pd_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_sc_pd_match[] = {
+	{ .compatible = "fsl,scu-pd", &imx8qxp_scu_pd},
 	{ .compatible = "fsl,imx8qxp-scu-pd", &imx8qxp_scu_pd},
 	{ /* sentinel */ }
 };
-- 
2.7.4
