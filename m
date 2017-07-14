From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2 1/5] thermal: imx: Add nvmem-cells alternate binding for OCOTP access
Date: Fri, 14 Jul 2017 17:11:06 +0300
Message-ID: <79ad86fbce37b169342704c397f0a1dbae0cfb75.1500041281.git.leonard.crestez@nxp.com>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1500041281.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On newer imx SOCs accessing OCOTP directly is wrong because the ocotp
clock needs to be enabled first. Add a binding for accessing the same
values through the imx-ocotp nvmem driver using nvmem-cells. This is
similar to other thermal drivers.

The old binding is preserved for compatibility and because it still
works fine on imx6qdl series chips.

In theory this problem could be solved by adding a reference to the
OCOTP clock instead but it is better to hide such details in a specific
nvmem driver.

Signed-off-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
---
 Documentation/devicetree/bindings/thermal/imx-thermal.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
index 3c67bd5..28be51a 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
@@ -7,10 +7,17 @@ Required properties:
   is higher than panic threshold, system will auto reboot by SRC module.
 - fsl,tempmon : phandle pointer to system controller that contains TEMPMON
   control registers, e.g. ANATOP on imx6q.
+- nvmem-cells: A phandle to the calibration cells provided by ocotp.
+- nvmem-cell-names: Should be "calib", "temp_grade".
+
+Deprecated properties:
 - fsl,tempmon-data : phandle pointer to fuse controller that contains TEMPMON
   calibration data, e.g. OCOTP on imx6q.  The details about calibration data
   can be found in SoC Reference Manual.
 
+Direct access to OCOTP via fsl,tempmon-data is incorrect on some newer chips
+because it does not handle OCOTP clock requirements.
+
 Optional properties:
 - clocks : thermal sensor's clock source.
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
