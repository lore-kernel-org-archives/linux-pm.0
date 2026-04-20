Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100F39D6D9
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706815; cv=none; b=KMOyc6TuVi85JTIhwbKW3eQWDU9qhfiCrthln8aSfOrrWThQ+9+248nW2zBu7EFCmqydlGGCrhyfkVtx6iSoyNturMs+EmoGqGKlAZ8iZSPMqo88jiyXk0f8k/ZIImIoj3qkn1LsIYqNjKDInRtU2SmSnbAv/NJUQazbAV+F5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706815; c=relaxed/simple;
	bh=TKfgOUvv2UcX7X0tyk1IsalC6JmJHiID4ANvKVR4gGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQJAiLsu9qiBi7vIWbY5fDXhJR12iR9GDdQQbBY1mAk/7L9LwUvnnb42m3oKXEV5Jzg0GLQCdZFlV9DvlWPY5xvXoByU2pgWx6BdWHSrg6QT/Z9833CVybZgw5kydlr9BrdWPQH+jz5RGgdkJErEyaVpkPRdCr5CzktREP/RCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GiX7I7HB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiX7I7HB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso35033665e9.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776706808; x=1777311608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxBc/M4G+txQiEXs+oWY+3uh4E2qPUY9zSyWwwZhU0Q=;
        b=GiX7I7HBKiBuzrFsItzQKeknAEBgGUs4GzGywYgVSVNMXUEzClxEXCwvARkAb2ZuBh
         9JzD03x2ljAIjHOvpRPK/+V4ApLBMq1cz8YFbbon0LK8pnqeY0fROMLCMlodEMlufOb6
         daXhEyDTbbc44lqj2Z87bP/ZSsGL6LKutKgGzUIqUWxeJU8HLuzhG62b/fQVN5tRT9YP
         nVQbGSg2bWc6e9TO3L3GmLYfjT1n6SbI/6mWjHOU+ZvyNwXyecmBQTJzdCVt7GFPcGBj
         3EdO6fNKCZroKN9q1erd4uBRllE+JBKFBxiHcee7XHSF7/Ok7oQVUQDVRMotfSOLJ1FP
         M4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706808; x=1777311608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vxBc/M4G+txQiEXs+oWY+3uh4E2qPUY9zSyWwwZhU0Q=;
        b=i6nBA9WVGyQnL+y3Y0brFVsGApukjy9+1ue6uqk1nuhD2nwf5tDDCww0nPDlap4tRz
         gmcIGINOvxJgO6TYjsdKUeY06sgg9vo59WhgcJ/TR9hodDxTT1y9vJ/47HCxgPSSU1wj
         mv1bXDZyxQ/ecikmOcC6PkPa/xy7MY0gxXnUtxqVGBUltOABhdtN2ecukyx0ELwCZjL2
         WS30Uk41K5Idu4u8PvaIRzgB+QnYblOP/JbkLY7QhJv9Kjf02p4+RbLzx3UJHYYYY7Bq
         ZtHjTfja8d7HeVbgE7jSxFbXR4S1KjUDyp5F0NwhD20SPTUtJW7r4V7Smrxb6TZqAjmo
         G4bA==
X-Forwarded-Encrypted: i=1; AFNElJ9e6kAcZ2UXT76xrAZ9dhx5QKs6NF8mrI4YxmIN7xnSHI7BbZvl0HnbZzZQiPl+5zgnwGWWUwcDqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdXZmcresrA9IIV7d0fF+aWDxDmPCxWe75OuAv/9ZYRqRZ77N
	07Qn4Wk0e3PiwLIzAx9J1An22l1w2o0jP1ZlovUrHxCFp3lmO6i7q/x62MsO79qIGH8=
X-Gm-Gg: AeBDietVr1fZqvBk5HAEl7DUKOpSVCVzkkn6rs0ht3sjDZMLYsmKZGJHESIhKy0CK9v
	QCwUOQ7ZO0yydardzqZYhNMg3yFDnIF1CQkAGaDqMIdngYNgxBqa41emimS5gYv21QtvlNblNWb
	3v6C1nGXNc7SNQbnX9L9GWqA2bGl/2MT5eyqVgg366e7InHEHHPlLLJnY9cFh/587meolDmH804
	1YiTgqoAyrbaVMvWgASrTT2o6PPNoLan6DRow+nG1AJCSwia3WTxz2Pr4QfmKSi2Lqdkf85gCHL
	fjDZv1y/tUT5LrdsPDHfynsyr2fxL70n+1xmRtzabwAinC2TTpaSQAiVXJy8Z4ikxfCoDkqGr95
	nNxOy7Rnkm7wcLzcELbg3kgGrGaDT9vjrbXOn7gUBBognvkGU/FiUNop3MSVZ/O4RoQ8MykIoqz
	gUO6e7JKqILE4Jc1otMzOXp241CKrcWkFEw9M4tdDjmyHxxtBbBY7OwatAK9d40Lih2BEl1CsFY
	PmDVdDuYhNDuhQ1QQ==
X-Received: by 2002:a05:600c:154e:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488fb74fc02mr205225595e9.10.1776706807908;
        Mon, 20 Apr 2026 10:40:07 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm144280285e9.1.2026.04.20.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:40:07 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 20 Apr 2026 17:39:50 +0000
Subject: [PATCH v3 04/10] firmware: samsung: acpm: Make acpm_ops const and
 access via pointer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-acpm-tmu-v3-4-3dc8e93f0b26@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776706804; l=6069;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=TKfgOUvv2UcX7X0tyk1IsalC6JmJHiID4ANvKVR4gGI=;
 b=yPHNYBxf7QnMWUXaEk9LWCsOzM8jHb2VsWtybvDRQxbO69Xt+rNMUJo0MncsB/iNRhmSVWg67
 oAcDAwgi6d0A7mvuDSXLbfmXaFZoou+EEXxq9wDSnbLCykXmuPaYAB6
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Replace the embedded `struct acpm_ops` inside `struct acpm_handle` with
a pointer to a `const struct acpm_ops`.

Previously, the operations structure was embedded directly within the
handle and populated dynamically at runtime via `acpm_setup_ops()`.
This resulted in mutable function pointers and unnecessary per-instance
memory overhead.

By defining `exynos_acpm_driver_ops` statically as a `const` structure,
the function pointers are now safely housed in the read-only `.rodata`
section. This improves security by preventing function pointer
overwrites, saves memory, and slightly reduces initialization overhead
in `acpm_probe()`.

Consequently, update all consumer drivers (clk, mfd) to access the
operations via the new pointer indirection (`->ops->`). Finally, fix
the previously empty kernel-doc description for the ops member to
reflect its new pointer nature.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk-acpm.c                     |  8 ++---
 drivers/firmware/samsung/exynos-acpm.c             | 36 ++++++++++------------
 drivers/mfd/sec-acpm.c                             |  6 ++--
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  4 +--
 4 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/samsung/clk-acpm.c b/drivers/clk/samsung/clk-acpm.c
index 93667777094c..953ca8d5720a 100644
--- a/drivers/clk/samsung/clk-acpm.c
+++ b/drivers/clk/samsung/clk-acpm.c
@@ -68,8 +68,8 @@ static unsigned long acpm_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct acpm_clk *clk = to_acpm_clk(hw);
 
-	return clk->handle->ops.dvfs.get_rate(clk->handle, clk->mbox_chan_id,
-					      clk->id);
+	return clk->handle->ops->dvfs.get_rate(clk->handle, clk->mbox_chan_id,
+					       clk->id);
 }
 
 static int acpm_clk_determine_rate(struct clk_hw *hw,
@@ -89,8 +89,8 @@ static int acpm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct acpm_clk *clk = to_acpm_clk(hw);
 
-	return clk->handle->ops.dvfs.set_rate(clk->handle, clk->mbox_chan_id,
-					      clk->id, rate);
+	return clk->handle->ops->dvfs.set_rate(clk->handle, clk->mbox_chan_id,
+					       clk->id, rate);
 }
 
 static const struct clk_ops acpm_clk_ops = {
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 39d3d2317659..4f2ad84cd783 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -610,30 +610,26 @@ static int acpm_channels_init(struct acpm_info *acpm)
 	return 0;
 }
 
-/**
- * acpm_setup_ops() - setup the operations structures.
- * @acpm:	pointer to the driver data.
- */
-static void acpm_setup_ops(struct acpm_info *acpm)
-{
-	struct acpm_dvfs_ops *dvfs_ops = &acpm->handle.ops.dvfs;
-	struct acpm_pmic_ops *pmic_ops = &acpm->handle.ops.pmic;
-
-	dvfs_ops->set_rate = acpm_dvfs_set_rate;
-	dvfs_ops->get_rate = acpm_dvfs_get_rate;
-
-	pmic_ops->read_reg = acpm_pmic_read_reg;
-	pmic_ops->bulk_read = acpm_pmic_bulk_read;
-	pmic_ops->write_reg = acpm_pmic_write_reg;
-	pmic_ops->bulk_write = acpm_pmic_bulk_write;
-	pmic_ops->update_reg = acpm_pmic_update_reg;
-}
-
 static void acpm_clk_pdev_unregister(void *data)
 {
 	platform_device_unregister(data);
 }
 
+static const struct acpm_ops exynos_acpm_driver_ops = {
+	.dvfs = {
+		.set_rate = acpm_dvfs_set_rate,
+		.get_rate = acpm_dvfs_get_rate,
+	},
+
+	.pmic = {
+		.read_reg = acpm_pmic_read_reg,
+		.bulk_read = acpm_pmic_bulk_read,
+		.write_reg = acpm_pmic_write_reg,
+		.bulk_write = acpm_pmic_bulk_write,
+		.update_reg = acpm_pmic_update_reg,
+	},
+};
+
 static int acpm_probe(struct platform_device *pdev)
 {
 	const struct acpm_match_data *match_data;
@@ -674,7 +670,7 @@ static int acpm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	acpm_setup_ops(acpm);
+	acpm->handle.ops = &exynos_acpm_driver_ops;
 
 	platform_set_drvdata(pdev, acpm);
 
diff --git a/drivers/mfd/sec-acpm.c b/drivers/mfd/sec-acpm.c
index 9e15b260b8df..3397d13d3b7f 100644
--- a/drivers/mfd/sec-acpm.c
+++ b/drivers/mfd/sec-acpm.c
@@ -391,7 +391,7 @@ static int sec_pmic_acpm_bus_write(void *context, const void *data,
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops->pmic;
 	size_t val_count = count - BITS_TO_BYTES(ACPM_ADDR_BITS);
 	const u8 *d = data;
 	const u8 *vals = &d[BITS_TO_BYTES(ACPM_ADDR_BITS)];
@@ -411,7 +411,7 @@ static int sec_pmic_acpm_bus_read(void *context, const void *reg_buf, size_t reg
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops->pmic;
 	const u8 *r = reg_buf;
 	u8 reg;
 
@@ -430,7 +430,7 @@ static int sec_pmic_acpm_bus_reg_update_bits(void *context, unsigned int reg, un
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops->pmic;
 
 	return pmic_ops->update_reg(acpm, ctx->shared->acpm_chan_id, ctx->type, reg & 0xff,
 				    ctx->shared->speedy_channel, val, mask);
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 62a3eb450067..e13d9ac73ff6 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -41,10 +41,10 @@ struct acpm_ops {
 
 /**
  * struct acpm_handle - Reference to an initialized protocol instance
- * @ops:
+ * @ops:	pointer to the constant ACPM protocol operations.
  */
 struct acpm_handle {
-	struct acpm_ops ops;
+	const struct acpm_ops *ops;
 };
 
 struct device;

-- 
2.54.0.rc1.555.g9c883467ad-goog

