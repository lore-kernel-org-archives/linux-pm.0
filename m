Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39092330328;
	Tue,  7 Jul 2026 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413486; cv=none; b=Lkl+ultJTbVo4zrQyWhGgdp0cBn0INVHyvx+LuIu5VeTWHGJK2RcZl/JRXEyHucoXTLd4v3UhknrOC3sI0Jue8JPZI8xsMsKYSkKpVWKG8TI6ZBK7gjPt5V2skkEYLRvQ8B5PWIEuocPF7Q1uc2HZCInvY0/T1bor09lA2tIDT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413486; c=relaxed/simple;
	bh=NGoIwaMCO4dQVDqoxpNEjBLTDRrH9MnuHgpYvcWn8s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpoGuc0tvv6zh8/iF59jCJb0I22YWrtriiqhNEZ6CT5J/NGY++zSjDFscAcrAP221hbq9ZLh8D4xdcqIsh+IesfaKaJzNOMTASDf6I0rYs75ayI1CxTg1ju2vTN54x1NvNcmoABa3BTXBUEgAz86CxBFVJVWGX2FDyitSk8K9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bEXavzCw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bEXavzCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783413467;
	bh=NGoIwaMCO4dQVDqoxpNEjBLTDRrH9MnuHgpYvcWn8s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEXavzCwASYwwKHwciwWijirtSRAMkdLjafD1IXLAQcICB2QVJ5uDWfwyiq5rn5Rd
	 4RoEUKSMIpY+GzomCN3swwUN3BUaCo7l94+uWhH9IMysXul6XoIe73V+RFGs6DKBlT
	 Cn7y1oixqlel0NhVv1z9OZSghmr13ldsfac8hISTN1Q5RvQbSvDSMTTk9JKFaTM2++
	 K0zuZm1gYE3ttdxkTDZNG4OCEvSasqPlKAvmC4lIDNVnuCXmvzt5j5gZgwOAULador
	 +aDohqCZ57lFcIySStzikOI5polLtUmCFb6XDEV8dzJ5DqiCxqJ951uk2AWOBgL5VZ
	 fc3XA44GWvgFQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D76E917E0EF3;
	Tue, 07 Jul 2026 10:37:46 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org,
	sboyd@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v10 07/11] power: reset: qcom-pon: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Tue,  7 Jul 2026 10:37:26 +0200
Message-ID: <20260707083730.33977-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707083730.33977-1-angelogioacchino.delregno@collabora.com>
References: <20260707083730.33977-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm PMICs integrates a Power On device supporting pwrkey
and resin along with the Android reboot reason action identifier.

Instead of using the parent SPMI device (the main PMIC) as a kind
of syscon in this driver, register a new SPMI sub-device for PON
and initialize its own regmap with this sub-device's specific base
address, retrieved from the devicetree.

This allows to stop manually adding the register base address to
every R/W call in this driver, as this can be, and is now, handled
by the regmap API instead.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/power/reset/qcom-pon.c | 36 +++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582..f94aaecd6ed6 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -11,6 +11,7 @@
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
 #include <linux/regmap.h>
+#include <linux/spmi.h>
 
 #define PON_SOFT_RB_SPARE		0x8f
 
@@ -22,7 +23,6 @@
 struct qcom_pon {
 	struct device *dev;
 	struct regmap *regmap;
-	u32 baseaddr;
 	struct reboot_mode_driver reboot_mode;
 	long reason_shift;
 };
@@ -35,7 +35,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
 	int ret;
 
 	ret = regmap_update_bits(pon->regmap,
-				 pon->baseaddr + PON_SOFT_RB_SPARE,
+				 PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
 				 magic << pon->reason_shift);
 	if (ret < 0)
@@ -46,27 +46,44 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
 
 static int qcom_pon_probe(struct platform_device *pdev)
 {
+	struct regmap_config qcom_pon_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = 0xff,
+		.fast_io = true,
+	};
+	struct device *dev = &pdev->dev;
+	struct spmi_subdevice *sub_sdev;
+	struct spmi_device *sparent;
 	struct qcom_pon *pon;
 	long reason_shift;
 	int error;
 
+	if (!dev->parent)
+		return -ENODEV;
+
 	pon = devm_kzalloc(&pdev->dev, sizeof(*pon), GFP_KERNEL);
 	if (!pon)
 		return -ENOMEM;
 
 	pon->dev = &pdev->dev;
 
-	pon->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!pon->regmap) {
-		dev_err(&pdev->dev, "failed to locate regmap\n");
-		return -ENODEV;
-	}
+	sparent = spmi_find_device_by_of_node(dev->parent->of_node);
+	if (!sparent)
+		return ERR_PTR(-ENODEV);
+
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
 
-	error = of_property_read_u32(pdev->dev.of_node, "reg",
-				     &pon->baseaddr);
+	error = device_property_read_u32(dev, "reg", &qcom_pon_regmap_config.reg_base);
 	if (error)
 		return error;
 
+	pon->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &qcom_pon_regmap_config);
+	if (IS_ERR(pon->regmap))
+		return PTR_ERR(pon->regmap);
+
 	reason_shift = (long)of_device_get_match_data(&pdev->dev);
 
 	if (reason_shift != NO_REASON_SHIFT) {
@@ -106,3 +123,4 @@ module_platform_driver(qcom_pon_driver);
 
 MODULE_DESCRIPTION("Qualcomm Power On driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("SPMI");
-- 
2.54.0

