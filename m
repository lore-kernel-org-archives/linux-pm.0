Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783745;
	b=2Z4ao+6nU3PH8GO0xoZkbxCr1QwpZW4rzYTgOIbXyVLGVzOJCC2hNt8F5GJgJ841Bspw
	 u37AXX1Mbc+1FMB2jPJkmq/gU2fEOxh4rGLXx2+oMRXGk/fJnI0fIB/7JLuAK6y3SqWhV
	 8zn9pjyXVCuOgrYU/8a+OrMrShupfpPH4ZGSiG/TZdu2rr0OQ306VPM889gXJk1vJASLa
	 YsLObnxdyFHpNfelX34MgBlfnBdUzrpEtuIRkPT0hiV342nSugzswGAA01oPQcqpH/oS2
	 dM3YJX0u3QEBdnlsa8eVLc0uKSZeCghFByOI7AWm2XMiyhBrswAwoSC8m1QqzGxbmBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783745;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=OmPpVCd1cEeyOHtBZFTBek13c8a3tHRtErjPxTkBgVg=;
	b=wmv88ZsXB04IIL1R4lbq5P/lnbRcDCHPe1r53wQpwBnpNiAdeQ+5Lbtm2zTmweFXOAVn
	 SleJoF3R2d8KZaJfn8xd7gwBNz+Oc6BHrP2orEn5cHo4de/8flKz6MrzzJRNt54W5AtbM
	 wij7uzGHvfVgHOHXoo0+KghU+FdeC1LS9Bnt8G6wLg+RVe/HZa80TLZfT7/nvdm/E+0oM
	 8KJ5L5YYAbI19r0VEUbI+p4J+x4OagfKjRrRMZ7bc6XHkku4TnFNJibeGQSHfrCDlBDxZ
	 7ht2X14S9llncImcYRlJOOCn4Zr8XZOp3z+U1CxFjgCw6ieGSxapQUfu4BKuTzS1PqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlWB+MVx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2F606A323;
	Sun, 15 Nov 2026 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlWB+MVx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D35E1F000C4;
	Sun, 15 Nov 2026 23:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794783744;
	bh=OmPpVCd1cEeyOHtBZFTBek13c8a3tHRtErjPxTkBgVg=;
	h=From:Date:Subject:To:Cc;
	b=dlWB+MVxKVso8/2amHfxrbBXqZBfj01wHQbiGaI82BW7gDbu3eN+9YgTda5ojqaUB
	 szbDXmX1Th87QSLx3E9w28xKYwv3yeJzUuahRbmp6xvGQB8efPnvyqS2uzkeDRNAWU
	 6GAkrGTB34NcXBCTsJh+D9y2TgET7stNClBkYuxOrx8otsBOqOzxKzIiMFmplqHeB6
	 yxLADk1leM+urnwuvhI+XuK8yCbJM5QNzpxjNJecruxwaL+1rujrFJgdUTe/islM67
	 8xwXUQ4xEzLK1OpDB2YvQyIIcHMArfpxYkeY8boNCBQ3VFOyhz4I0WblZP/Ph4v3X9
	 CT1pix9iCw0Yg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 00:02:21 +0100
Subject: [PATCH] misc: sram: Enable runtime PM
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ux500-sram-runtime-pm-v1-1-c554831d6b12@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQrCMBAF0KsMf92BTGqq5iriIuios0gsEyuF0
 rsLvgO8DV3dtCPTBtevdXs3ZJKBcHuV9lS2OzIhhjiJSOJlTSFw91LZl/axqjxXjirpeDqM5zK
 NGAiz68PW/3u57vsPsR5W8WcAAAA=
X-Change-ID: 20261115-ux500-sram-runtime-pm-2e1578439a63
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Enable runtime PM for generic SRAM devices after probe has initialized
the SRAM mappings and partitions.

This lets SRAM devices with attached power domains be managed through
runtime PM references from their consumers.

Keep sysfs-exported SRAM and SRAM requiring platform initialization
powered while the driver is bound. This preserves exported contents
and avoids unpowered sysfs accesses or an unsupported resume sequence.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Enable runtime PM for SRAM suppliers so consumers can manage their power
domains through runtime PM device links. Keep sysfs-exported SRAM and
SRAM with platform initialization powered while the driver is bound.

The Ux500 genpd prerequisites have been merged into the powerdomain tree.

Arnd/Greg: you can either apply this directly (if it checks out) or ask
me to send it to the SoC tree.
---
 drivers/misc/sram.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index c8990e83a65a..4d2477bb5cd9 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
@@ -380,6 +381,8 @@ static int sram_probe(struct platform_device *pdev)
 	int ret;
 	struct resource *res;
 	struct clk *clk;
+	bool keep_active;
+	unsigned int i;
 
 	config = of_device_get_match_data(&pdev->dev);
 
@@ -425,6 +428,24 @@ static int sram_probe(struct platform_device *pdev)
 			goto err_free_partitions;
 	}
 
+	/*
+	 * Sysfs users need retained contents; init-only platforms have no
+	 * runtime resume support. Keep both powered while the driver is bound.
+	 */
+	keep_active = config && config->init;
+	for (i = 0; i < sram->partitions; i++)
+		keep_active |= sram->partition[i].battr.size != 0;
+
+	if (keep_active) {
+		ret = devm_pm_runtime_get_noresume(sram->dev);
+		if (ret)
+			goto err_free_partitions;
+	}
+
+	ret = devm_pm_runtime_set_active_enabled(&pdev->dev);
+	if (ret)
+		goto err_free_partitions;
+
 	if (sram->pool)
 		dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
 			gen_pool_size(sram->pool) / 1024, sram->virt_base);

---
base-commit: 9ae477db090b44816741fd9c49a3c459fc7d407b
change-id: 20261115-ux500-sram-runtime-pm-2e1578439a63

Best regards,
--  
Linus Walleij <linusw@kernel.org>

