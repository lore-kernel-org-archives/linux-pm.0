From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V5 2/2] thermal: imx: save one condition block for normal case
 of nvmem initialization
Date: Wed, 21 Nov 2018 05:49:40 +0000
Message-ID: <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

Put return value checks of calling imx_init_from_nvmem_cells()
into one block to save one condition block for normal case.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c924396..bb6754a 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -742,9 +742,10 @@ static int imx_thermal_probe(struct platform_device *p=
dev)
=20
 	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
 		ret =3D imx_init_from_nvmem_cells(pdev);
-		if (ret =3D=3D -EPROBE_DEFER)
-			return ret;
 		if (ret) {
+			if (ret =3D=3D -EPROBE_DEFER)
+				return ret;
+
 			dev_err(&pdev->dev, "failed to init from nvmem: %d\n",
 				ret);
 			return ret;
--=20
2.7.4
