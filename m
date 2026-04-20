Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3973A75B3
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706816; cv=none; b=pHidl6DtgUk3gxcQ/iPaLJZgWZs8A8iAxyy9IZFWs9K7XIpWJy8ZP5oLPaFpYzum36HjIaIbqfzxkpwf8qCSbUiP+WkIvlENpuHGtCqF2j0NzI6m01Vvs1VsMktHddL8DzHZc3yu5MZVKQ5cvjZai+9fP/kWHeMH2rZR/cARaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706816; c=relaxed/simple;
	bh=dBg2F8BGZZ9Mm5Km26Z5eGMyUNSTN1VtnuTwvVrkrps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhDgq8FWIDWO/hcPkWsoo6w0RE0FA0O6kzUxDKNgbaSVua6FnUWeBFD2mGkwhhhl5UQD4pX8khUt0ezrroCptWTaYb5qUGcVAa858mFpLreGyP619YUpsfq5PpzR/eb+nge+paQuuBeigwk2Y5mf4QR4IsNdkCiPji9Kkk6oT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XoutfUF9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoutfUF9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48896199cbaso35033935e9.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776706809; x=1777311609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O67orx5DZUm8BgsTcl5AUXZvqqdjzW17WuxDEAybQAY=;
        b=XoutfUF9J0q0jx7CLg5db6DEsZ2d/oVy4JiJR4vNcDcq/DW6bCfsGHf6j/8jaB1TZd
         eBXMWIQ0zNdCdg64Uz3gxpfPfvDGi3mN5ta6U8lvfhJJB+rHcwaHqpZIxEotoMXhGx4y
         nQTf7XawgQubFT5jcEm0DxA5wCBpQUhujRQCv5X6bMyExDst9+QmHIgB4tq2TEpQEDWg
         bclh3KHnMEGAU4Lt3xR0rg9Lal+jo8+vJkLu5eBGM1hOPnlQdG99tTqj+WiKkY8aanjU
         2tWZDwd6UNHXLgFC+Iz82s4wtbJQTqRBiJ08ypIAzK8HbPvGGk+XG9/sNKrUlJYdS9RA
         +1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706809; x=1777311609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O67orx5DZUm8BgsTcl5AUXZvqqdjzW17WuxDEAybQAY=;
        b=RJV2b9PfOrHmWGUDxFQ0jgFrSNvsmlt/34LCKbY3W7srtFpy4mChBgk9MFa9Yoe59N
         6y3XXv6bEepyGWPhIGRqgClJH4rqLixsJSRhj5ssSl2EQJqzRgNdQg2APIUA7+FjKOLt
         NYhxyQg4QuuEiCmrbE7eolpf2krQhq6err5QREwA3mGkYdujvzI2a2R/pCROdAw/QfEc
         4VDjjgWoYxZvL7+lh57/vz/4sULFFu7QQERHHPi2WWNIVpYrHoI62Mi2XxcK5ya1jB1G
         WrBSqBDocY9uDDUhI0CHieSnFGPRTW6FkhU4850ARgqGFWnVee1azRZ+3RTxEqAr9Nt4
         5coQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ujERo9mxeRE2ivDop1616K38PztyHMz7Knf4yJ7boAxtEHRiSZy6uA321vgEydmxya5FY7CSaIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWvm1rH9tmfrc//Cz41K8ygtLzdtM05DTScSRTiM2kF5mZ5vK
	E9OgLoqmAUz+zJGflxNkbpCb2ybZC0fEkfcXoME2EfQ2rXEBexMAg5EHLWX6GpxzNd0=
X-Gm-Gg: AeBDieuVoR3g6Gk1wUPMAhHVamojTbvLqtYEK8nLpgDhCrEiT9ASy5CgjpFGp5gIArL
	rmPZX7Nidc1QmPeFmBp2wkd45yp0+m9iKOGwqrhYVANfVRyIrXtc2ZBDbk8gWzmU0IbSY+OBDoW
	Tl1YSAqLu8uxYYA5ZLPU7Ak8u7iW3qkT7gGzEVRNCpWuC/60Qf0+U+92mcyORfErnklwSbULFP4
	w6fsuof4TChR9o2kpe8V8JZjuqBg294AjcYMotSTQHN8nNx4Q8/AOEm4Jhle1gwKOBI3Uoo3z7J
	brzpsw7nx2vizz333vb5OEqNx3xn1GwCN69Tm8j3MRE4rq47eQJa+MsQ7YrMlvRU5/xxMNrWXRg
	XPKOVFJ2jTp5334m+ippLW/Q0ZTjlfBdRYkVgFgaIJuhcrQ2lvCkLMAV1l/zZ6n/TiRZF/WlbYu
	hH2JZ+VqhGQwVrFGr3VJP6t834KhePTe7j7/Ioeb8AIJACCTTrfFoZPjb6dHbKvqMt7lVO2clPV
	ZPS2+Fh3HX+cjgwyQ==
X-Received: by 2002:a05:600c:4f92:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48a0f18edf7mr39490595e9.24.1776706809215;
        Mon, 20 Apr 2026 10:40:09 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm144280285e9.1.2026.04.20.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:40:08 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 20 Apr 2026 17:39:52 +0000
Subject: [PATCH v3 06/10] firmware: samsung: acpm: Add
 devm_acpm_get_by_phandle helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-acpm-tmu-v3-6-3dc8e93f0b26@linaro.org>
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
In-Reply-To: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776706804; l=3004;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=dBg2F8BGZZ9Mm5Km26Z5eGMyUNSTN1VtnuTwvVrkrps=;
 b=UOAj8gd0XgQFhm1iCBDvFWh9DJ+oBh0oq0XfmalIeylHgCDrLUj+FnH+1NXZyoFoKkD5UBjgB
 DQ3XgDUmwZzDRFlKtsI8+P4vVI/i2hj8MZGg/O8O5oANp006hjIzhqw
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Introduce devm_acpm_get_by_phandle() to standardize how consumer
drivers acquire a handle to the ACPM IPC interface. Enforce the
use of the "samsung,acpm-ipc" property name across the SoC and
simplify the boilerplate code in client drivers.

The first consumer of this helper is the Exynos ACPM Thermal Management
Unit (TMU) driver. The TMU utilizes a hybrid management approach: direct
register access from the Application Processor (AP) is restricted to the
interrupt pending (INTPEND) registers for event identification.
High-level functional tasks, such as sensor initialization, threshold
programming, and temperature reads, are delegated to the ACPM firmware
via this IPC interface.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c             | 23 ++++++++++++++++++++++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index d4afd6b535e4..15c10fbb2920 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -797,6 +797,29 @@ struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_acpm_get_by_node);
 
+/**
+ * devm_acpm_get_by_phandle - Resource managed lookup of the standardized
+ * "samsung,acpm-ipc" handle.
+ * @dev: consumer device
+ *
+ * Returns a pointer to the acpm_handle on success, or an ERR_PTR on failure.
+ */
+struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev)
+{
+	struct acpm_handle *handle;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "samsung,acpm-ipc", 0);
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	handle = devm_acpm_get_by_node(dev, np);
+	of_node_put(np);
+
+	return handle;
+}
+EXPORT_SYMBOL_GPL(devm_acpm_get_by_phandle);
+
 static const struct acpm_match_data acpm_gs101 = {
 	.initdata_base = ACPM_GS101_INITDATA_BASE,
 	.acpm_clk_dev_name = "gs101-acpm-clk",
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 8511c3c3983b..9df4c514ebde 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -70,6 +70,7 @@ struct device;
 #if IS_ENABLED(CONFIG_EXYNOS_ACPM_PROTOCOL)
 struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 					  struct device_node *np);
+struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev);
 #else
 
 static inline struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
@@ -77,6 +78,11 @@ static inline struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 {
 	return NULL;
 }
+
+static inline struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __EXYNOS_ACPM_PROTOCOL_H */

-- 
2.54.0.rc1.555.g9c883467ad-goog

