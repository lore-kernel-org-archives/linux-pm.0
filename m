Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC73A6F05
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706813; cv=none; b=nVDgcpuOUmXq5JiVxtRJWK/qLAsWa/Y0F0xBd9SI6U5iDtjqarK+LDPJceqHflptzmMk7eKcc6bAXsjvCVgIwJfmU18hp3r5PpgHnooWOBYcfY5D8/isfsyZP8Yar/+TegioFdjoPaT7kYGIB7dQgErMUURJml98vPYPrbqF9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706813; c=relaxed/simple;
	bh=49BtV4liclRnJ5e6tUfHwtwQp6Rtyy5+WI8PtQcjUpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ck0XG1W/2Bsgn/UBJkslqCxk6MQ+W0TKfevwCfTsDRF45nlwQXnyRynGNWVHUnX/RTnREobgyLsBAqqfKRooyn0HBhD03FsvZsmN3rJCEXmnW77dKhEjn8jRxghEc1wFGq0vP3F4SJlRH4GWYdR1QmD05DxQK5EBrS51IA9eCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pu2puW6w; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pu2puW6w"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488c2690057so33029905e9.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776706807; x=1777311607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIQGoy6fl4lhGyxodk/fSO9eXPaG/yS/b0aAUL+PrPk=;
        b=pu2puW6wiYhIQyvZ6Bv69jrBzkXu9fblMWyeUCZtxjjX0nVhoCrk6h7vWzfXcxaGBi
         /6VHvJDfMQTZ0vHjD2iNjly+XL9yAYF582FCduP8c9vbJehXi9jHZWLGDBDO2IuT7bfP
         xG2Zw6N/DZSjbl0TOEYdpQVtWSg4qhLL7qFYRpTc7lVvRbQ8QSLtSrX9uWy9NJY2Njbb
         KJijcabD1ruK3zh84hdh8Mi79RFYYdy40LuWt2I91abMLVUV5W7mhcUl4f+LzkQkS4Qb
         K7mFzDtV+ry5UF1qN54siF6hMlu6VYMbelQYlPX1qG41hKQEevCTFT6lvuZxVHO5sJ2i
         LK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706807; x=1777311607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIQGoy6fl4lhGyxodk/fSO9eXPaG/yS/b0aAUL+PrPk=;
        b=OwpkQ2qZA70iir3sZsHjDsGhGkHXvmYrX9ze50xxJwPLOQpUeNv20ofyqcL3ZwVW5C
         lI6O/r3fv5zHL3AeWX39tCwEOpEkHipp0TTBZU/1I1VRDk5zWWbAdG1dsNeA0cbEN1KN
         8k51cWO4geRDTT+tOXYnUdId4wet3Fw5ww9oFKGfYaoe9Bujd42osmAtg1b9jZHEaYAV
         igECSeZSc5TFwQ5Y+FsVyntoEHKxVWD/gWKgJ7bY0KAcVP1vGfcpXJ9sBuPoUPv+Ey0Y
         KZsyMXHY1oW1X/aTwvhrPWUR26pm1PnGcVYwHJKy1UEooj5Web9xnrsr9ls1QSTk0T57
         RjjA==
X-Forwarded-Encrypted: i=1; AFNElJ/ImrVVkUnujZMDmty4XXAMUFoqzzpzVEFK2+uLF7YmZqbF4R4sJaWdFZy+IdvCSkwi6/HinC7Uog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTd82sorV2toPcalbNWEPv1F6X0UsE3HNyo1urwqL/QLawFL9e
	41jhyw5y/zWTU11yyLVHwTmaPmsP7v2AsPyFkK5QJ19KAHIj0Bu9sO5c66tizZdtOyc=
X-Gm-Gg: AeBDieuUv55ze1bG/xi5zn/p4aPgF8lyVXfz6UbgLsCqssRKsiqxxQ8aQC/yu08X2C/
	OpdJ55+4ZcVjP9f8ECQknV0CC4+g3+M5bi5OTXKfmMEzPuSkwzUYnbhmmounc0PCEPLHbKPSEpO
	fu7Qv3eucEdpqFLze1MeNwCKwiUmpodKv+QXnCq8tGPp03IBTMPex5LpfrpWoyDOK0cy5N8B3gF
	ynbv8p064JDqQ2Trn+m72RG7DHnb5wk79HtxVYST1SOLq9hbXOignd2PglkSZKjL/5LE3Rm8VTk
	V6lzL31BbNO5ZepQyldb+7+JRF5DTitlPKX9G1fbhxpsRx4oHAW3/COUxR1FLnrHgvRMuypLQoM
	MrTosg6cjg2XUZO7M531oG3e4GJIyVl7pxQGHHHTNVH/OGls3/AFOWxVpbTSY9xsEfIs4HZ71qW
	eF/4/xuLTeXIJOX4WMwdkGD5pCAM7F0UJbbaLGxj3XlpZI4eA6lorl83pznz2UX5sNOj2/ZDy0/
	PGeXFrefWewxe1sMQ==
X-Received: by 2002:a05:600c:c0c8:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-488fb787bfdmr160240165e9.26.1776706807433;
        Mon, 20 Apr 2026 10:40:07 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm144280285e9.1.2026.04.20.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:40:07 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 20 Apr 2026 17:39:49 +0000
Subject: [PATCH v3 03/10] firmware: samsung: acpm: Drop redundant _ops
 suffix in acpm_ops members
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-acpm-tmu-v3-3-3dc8e93f0b26@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776706804; l=4439;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=49BtV4liclRnJ5e6tUfHwtwQp6Rtyy5+WI8PtQcjUpM=;
 b=Pb4Ofrj7eCzqfvbfC4jlUZiTiFA9g6OyHFVOMPAZ6LNGAdtEXvx8niESMIV34rfDTzWwZ5BSc
 ToF6YjPTTDyBqda5yHWVBCS1dGST4FFpBxbq6/jLClzYXE6tQ6i/abx
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Rename the `dvfs_ops` and `pmic_ops` members of `struct acpm_ops` to
`dvfs` and `pmic` respectively.

Since these members are housed within the `acpm_ops` structure and
utilize the `acpm_*_ops` types, the `_ops` suffix on the variable names
creates unnecessary redundancy (e.g., `handle.ops.dvfs_ops`).

This cleanup removes the stuttering, leading to cleaner consumer code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk-acpm.c                        | 8 ++++----
 drivers/firmware/samsung/exynos-acpm.c                | 4 ++--
 drivers/mfd/sec-acpm.c                                | 6 +++---
 include/linux/firmware/samsung/exynos-acpm-protocol.h | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-acpm.c b/drivers/clk/samsung/clk-acpm.c
index d8944160793a..93667777094c 100644
--- a/drivers/clk/samsung/clk-acpm.c
+++ b/drivers/clk/samsung/clk-acpm.c
@@ -68,8 +68,8 @@ static unsigned long acpm_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct acpm_clk *clk = to_acpm_clk(hw);
 
-	return clk->handle->ops.dvfs_ops.get_rate(clk->handle,
-					clk->mbox_chan_id, clk->id);
+	return clk->handle->ops.dvfs.get_rate(clk->handle, clk->mbox_chan_id,
+					      clk->id);
 }
 
 static int acpm_clk_determine_rate(struct clk_hw *hw,
@@ -89,8 +89,8 @@ static int acpm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct acpm_clk *clk = to_acpm_clk(hw);
 
-	return clk->handle->ops.dvfs_ops.set_rate(clk->handle,
-					clk->mbox_chan_id, clk->id, rate);
+	return clk->handle->ops.dvfs.set_rate(clk->handle, clk->mbox_chan_id,
+					      clk->id, rate);
 }
 
 static const struct clk_ops acpm_clk_ops = {
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 8b2529e50328..39d3d2317659 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -616,8 +616,8 @@ static int acpm_channels_init(struct acpm_info *acpm)
  */
 static void acpm_setup_ops(struct acpm_info *acpm)
 {
-	struct acpm_dvfs_ops *dvfs_ops = &acpm->handle.ops.dvfs_ops;
-	struct acpm_pmic_ops *pmic_ops = &acpm->handle.ops.pmic_ops;
+	struct acpm_dvfs_ops *dvfs_ops = &acpm->handle.ops.dvfs;
+	struct acpm_pmic_ops *pmic_ops = &acpm->handle.ops.pmic;
 
 	dvfs_ops->set_rate = acpm_dvfs_set_rate;
 	dvfs_ops->get_rate = acpm_dvfs_get_rate;
diff --git a/drivers/mfd/sec-acpm.c b/drivers/mfd/sec-acpm.c
index 0e23b9d9f7ee..9e15b260b8df 100644
--- a/drivers/mfd/sec-acpm.c
+++ b/drivers/mfd/sec-acpm.c
@@ -391,7 +391,7 @@ static int sec_pmic_acpm_bus_write(void *context, const void *data,
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
 	size_t val_count = count - BITS_TO_BYTES(ACPM_ADDR_BITS);
 	const u8 *d = data;
 	const u8 *vals = &d[BITS_TO_BYTES(ACPM_ADDR_BITS)];
@@ -411,7 +411,7 @@ static int sec_pmic_acpm_bus_read(void *context, const void *reg_buf, size_t reg
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
 	const u8 *r = reg_buf;
 	u8 reg;
 
@@ -430,7 +430,7 @@ static int sec_pmic_acpm_bus_reg_update_bits(void *context, unsigned int reg, un
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
 
 	return pmic_ops->update_reg(acpm, ctx->shared->acpm_chan_id, ctx->type, reg & 0xff,
 				    ctx->shared->speedy_channel, val, mask);
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 13f17dc4443b..62a3eb450067 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -35,8 +35,8 @@ struct acpm_pmic_ops {
 };
 
 struct acpm_ops {
-	struct acpm_dvfs_ops dvfs_ops;
-	struct acpm_pmic_ops pmic_ops;
+	struct acpm_dvfs_ops dvfs;
+	struct acpm_pmic_ops pmic;
 };
 
 /**

-- 
2.54.0.rc1.555.g9c883467ad-goog

