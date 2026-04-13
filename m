Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB213BD62D;
	Mon, 13 Apr 2026 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077798; cv=none; b=P2ObehpAnrqg74AFHcGa8iBHtXXs6deTtsogvhiFXI5Fnzyp0tTA8+oVGn5sj02+pOW62qSh1B2O4zz27sBf2Hl9flLqnPUOwSkIXDIyYF+m1g1lHgYFGDvyGfSU/lZu2mFRN9HKyPkoBx0TQ4I7JgSJf3QYpa8nNABYBhLBByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077798; c=relaxed/simple;
	bh=+OPiaJJPEI4198UFVptwbMsLl2t7li0yawHDEA3XDzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwdbP2J/D+nVtSWH3bycd6ho1v2uSI7mnmc6UH3/qlahvgM7Qq3RBQjOp82Jj5tXAFiCHSnyk6Dg+AvHrQ466Z6E3e/dlJT+EDHtWvJZJ8/ZkxMU2KSlMz1CKhcZ2zYxRxCYwGPy3yvy7EdiTvH2GWjzxSy6OoAiNJjSEe3NR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=GHujh2hm; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="GHujh2hm"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776077795;
	bh=+OPiaJJPEI4198UFVptwbMsLl2t7li0yawHDEA3XDzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GHujh2hmFVMYidvCxm5fe/yepgdHFU++rbOxhQmDdgU03FbMOTu9qdeeVB6I9fRs0
	 pUWQhvfXEvnbUrKXarCa7+6LHsJJ3KeTs20OW/NsGKynIQyKEga6OBGmEorPLjDyJA
	 h7HbMaL9XicMo8zskm/UVuaBU5Le1ZKxpeAuyDtI=
Date: Mon, 13 Apr 2026 12:52:45 +0200
Subject: [PATCH v2 4/8] thermal: amlogic: Add support for secure monitor
 calibration readout
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-add-thermal-t7-vim4-v2-4-1002d90a0602@aliel.fr>
References: <20260413-add-thermal-t7-vim4-v2-0-1002d90a0602@aliel.fr>
In-Reply-To: <20260413-add-thermal-t7-vim4-v2-0-1002d90a0602@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1776077790; l=4382;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=+OPiaJJPEI4198UFVptwbMsLl2t7li0yawHDEA3XDzo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPwk6IMzZopyLjQ3ncpTCjLo+XSg/DFv9e+fOG+6wUwBWiSii301LkFGbH8Wdnxw1LKUmWclGMb
 6xP1ESrMxPQA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

Some SoCs (e.g. T7) expose thermal calibration data through the secure
monitor rather than a directly accessible eFuse register. Add a use_sm
flag to amlogic_thermal_data to select this path, and retrieve the
firmware handle and tsensor_id from the "amlogic,secure-monitor" DT
phandle with one fixed argument.

Also introduce the amlogic,t7-thermal compatible using this new path.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/thermal/amlogic_thermal.c | 58 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 5448d772db12a..11e3948cc0669 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/thermal.h>
+#include <linux/firmware/meson/meson_sm.h>
 
 #include "thermal_hwmon.h"
 
@@ -84,12 +85,14 @@ struct amlogic_thermal_soc_calib_data {
  * @u_efuse_off: register offset to read fused calibration value
  * @calibration_parameters: calibration parameters structure pointer
  * @regmap_config: regmap config for the device
+ * @use_sm: read data from secure monitor instead of efuse
  * This structure is required for configuration of amlogic thermal driver.
  */
 struct amlogic_thermal_data {
 	int u_efuse_off;
 	const struct amlogic_thermal_soc_calib_data *calibration_parameters;
 	const struct regmap_config *regmap_config;
+	bool use_sm;
 };
 
 struct amlogic_thermal {
@@ -100,6 +103,8 @@ struct amlogic_thermal {
 	struct clk *clk;
 	struct thermal_zone_device *tzd;
 	u32 trim_info;
+	struct meson_sm_firmware *sm_fw;
+	u32 tsensor_id;
 };
 
 /*
@@ -138,6 +143,12 @@ static int amlogic_thermal_initialize(struct amlogic_thermal *pdata)
 	int ret = 0;
 	int ver;
 
+	if (pdata->data->use_sm) {
+		return meson_sm_get_thermal_calib(pdata->sm_fw,
+						  &pdata->trim_info,
+						  pdata->tsensor_id);
+	}
+
 	regmap_read(pdata->sec_ao_map, pdata->data->u_efuse_off,
 		    &pdata->trim_info);
 
@@ -226,6 +237,12 @@ static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
 	.regmap_config = &amlogic_thermal_regmap_config_g12a,
 };
 
+static const struct amlogic_thermal_data amlogic_thermal_t7_param = {
+	.use_sm			= true,
+	.calibration_parameters	= &amlogic_thermal_g12a,
+	.regmap_config		= &amlogic_thermal_regmap_config_g12a,
+};
+
 static const struct of_device_id of_amlogic_thermal_match[] = {
 	{
 		.compatible = "amlogic,g12a-ddr-thermal",
@@ -239,6 +256,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
 		.compatible = "amlogic,a1-cpu-thermal",
 		.data = &amlogic_thermal_a1_cpu_param,
 	},
+	{
+		.compatible = "amlogic,t7-thermal",
+		.data = &amlogic_thermal_t7_param,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);
@@ -271,11 +292,38 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata->clk))
 		return dev_err_probe(dev, PTR_ERR(pdata->clk), "failed to get clock\n");
 
-	pdata->sec_ao_map = syscon_regmap_lookup_by_phandle
-		(pdev->dev.of_node, "amlogic,ao-secure");
-	if (IS_ERR(pdata->sec_ao_map)) {
-		dev_err(dev, "syscon regmap lookup failed.\n");
-		return PTR_ERR(pdata->sec_ao_map);
+	if (pdata->data->use_sm) {
+		struct device_node *sm_np;
+		struct of_phandle_args ph_args;
+
+		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+						       "amlogic,secure-monitor",
+						       1, 0, &ph_args);
+		if (ret)
+			return ret;
+
+		sm_np = ph_args.np;
+		if (!sm_np) {
+			dev_err(dev,
+				"Failed to parse secure monitor phandle\n");
+			return -ENODEV;
+		}
+
+		pdata->sm_fw = meson_sm_get(sm_np);
+		of_node_put(sm_np);
+		if (!pdata->sm_fw) {
+			dev_err(dev, "Failed to get secure monitor firmware\n");
+			return -EPROBE_DEFER;
+		}
+
+		pdata->tsensor_id = ph_args.args[0];
+	} else {
+		pdata->sec_ao_map = syscon_regmap_lookup_by_phandle
+			(pdev->dev.of_node, "amlogic,ao-secure");
+		if (IS_ERR(pdata->sec_ao_map)) {
+			dev_err(dev, "syscon regmap lookup failed.\n");
+			return PTR_ERR(pdata->sec_ao_map);
+		}
 	}
 
 	pdata->tzd = devm_thermal_of_zone_register(&pdev->dev,

-- 
2.49.0

