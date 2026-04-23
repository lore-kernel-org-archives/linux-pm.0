Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDF371040
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957788; cv=none; b=hEosHjqiNmLI+uUCCGgY7p8J7ncFcDzibu/72MPf5QLB5tuEttDPYqPfvbPPrnBUYkfnpw/EHTUhBD8snIo6EUxYlF9p2QnowiI7g6CxYTEqfwGTk63S+0AoV+kKWcsh+QEwu0rmn64qXaQmWLSeIIjyLT96m+tDKNlNfk/4yz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957788; c=relaxed/simple;
	bh=wmSJ4leNLyELML627FEDTONj947cYs+EgV6hiLIWw+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrWSyakFvTkfF1KLjyriqs+SzE7t7kFT4jQO5RQ1KSGf1b9RDZkTJ9h30YRnTN9jlUbJbh+OT+ygvXJu/ddg7dSS7mpiqOgw7NSRvLqPb5wHaAqza+PXwDKCgSuWJoWYnCiWNIB/s46kPplvod5T27KJMHreQ1X68h8iVQDtSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O3CEo/To; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3CEo/To"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso56734425e9.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957783; x=1777562583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoK1C2zStDqs2HDGBFigq8hHFdAU01w+3goGRavdu6k=;
        b=O3CEo/ToVAe550MkMX20OXgGItWnsi5C5GBxQu4FHSrTgJJ/Sx+ucUqhqzXyNpU2OT
         /6R8cgSNEoUlFygmJxtsIS0y0+Mg9DcWGP95FlPTG0uYhrVDn5SfMKWCjS86QbU0LAjU
         yPGh8GgmTOpzX1E0ibfLrRF1kg2G8Sgu1/c1yZXHzlic5bmU3MXDEMIu/RkhaGFGxpH1
         MYMOdOnFHUjCkiPo8xb7NUzCDTCWpT/mPLM+tIK0LjFmICFFqhIxiPrFrgvIRsspUlwf
         YbENrgmBOy019ff8jdE13pnCgg3nunMF+td3V5Ce+z6W4rM3bP8qSSnjSj1klMe1X1WK
         dYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957783; x=1777562583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uoK1C2zStDqs2HDGBFigq8hHFdAU01w+3goGRavdu6k=;
        b=UTWOlQ3ge/rFJ9OJ0ON6+nDLj2BujqeYOdJxgCk4qZ/x+OTz59lJQ04PkazA2dGhRw
         /yUG5tE8KJKIROHtrRWikPg+qBdK2Uz/Lsv2rx25buR+49aiRutRGn40U9PyGdWvVYDL
         FBESNVBwR1kGK+VuNkJL/i9D1H6291mDPfSNsIZYLYDeb5o9i0+F03n9sPZRwAfxe/eK
         bcir7UIi8seieY+BULw0TV7BG51vRQVHv7/rdb9QoeWwyRb3aoOXr9y4ztrYs72+3CXX
         q4pWgxUj/wVYV88s1RJykGbrLnzRakWrEdyaJcB3bE/3htMTWRJj0b9eD9+tII4cY8i9
         m0JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hexiiHM614d/lYBcGFCFvHBdJ1rOL+EhCJrHTGIczMcGqMlSUBBK2rK3s5qDFgUX7vl7ykZZG6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAtcC9+tr/alGojW5ucNnVWHx0ho43T1PDoheyqXhp04mx4GH6
	o8n9zQp6d+LL9VsCxhXZ4Ypn4DHCspITL//tsltGSZHwhhL0j1cfkHzI+3ZIXUspT3I=
X-Gm-Gg: AeBDieticvny3pQWC8TGcJE0LM5SakdoGZ5YP2hwg71eWrIz8rO+FM6nVciE5Lu1fqT
	q1UoxUSu7kpRyGK0lWetw651TEV3WLcFWa9cqndX/LrY+NGH8O53NdasLsOAvqiJTy0rKLDIfRE
	atYzcrIArAJ0Yx/VfAG6N4AxhZbYjWJLJdFrht8gZv3ZtpVL2XHtaKdtFQj4BcaVJfZi/6xxEBr
	TZZIFNfdKG6f8/liKuI21q41ALSk/JHLZvLvEVjQDM6/cLh7Y+qFgAFyGr/d6hrmsfvvj8OsgKy
	ENLeebQeJmGsY1K7Kvg3poBEoNHBM4R3l50eNBDworekHp+tKwnYMxC4sUm3sV1Kra/yG+Dg12A
	w47zrJJO5gI6WiCVw7BO9iKr12L710hSYsYhUuDpL8yT0TezTKsuDNVd8lFSnd5qBtmOJfJb6NV
	H2ZgIC2mYSxaCKOmGPvittV/jQ848t5sr3tpUrc5EFoJBh2PO8YxwcemtCLqWC+x56KSpuUR5SU
	ni75id4jn4bkXfeBw==
X-Received: by 2002:a05:600c:6289:b0:488:f941:aab2 with SMTP id 5b1f17b1804b1-488fb78a561mr382038865e9.30.1776957782397;
        Thu, 23 Apr 2026 08:23:02 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:23:01 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:53 +0000
Subject: [PATCH v4 05/11] firmware: samsung: acpm: Make acpm_ops const and
 access via pointer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-5-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=6122;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=wmSJ4leNLyELML627FEDTONj947cYs+EgV6hiLIWw+Q=;
 b=BNyvDPIvGqa6/baxNysPZ0qCl8LZAy+enzTQt4VLh7RQ3zyZPXe3Jc6F07To8ReEXWUrzZgfV
 t25sgONY5DyCjkQDnN05QW80Bd/6kpW4iksNcx/rOZfje6/YKiWr21x
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
index a2cd54ee4589..38f40fb67ea7 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -621,30 +621,26 @@ static int acpm_channels_init(struct acpm_info *acpm)
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
@@ -689,7 +685,7 @@ static int acpm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add mbox free action.\n");
 
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
index b206efa62be6..fbf1829b33db 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -42,10 +42,10 @@ struct acpm_ops {
 
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
2.54.0.545.g6539524ca2-goog

