Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980889;
	b=xBqOAomT6h0EOm+kd/0D7DoYVP3NmoYxg/lNxTupMnvOgt/IT9YuHEFD6fjM3UnMe9IC
	 CNcLRLuzYdlQIllbqWUGGkjtZpNYDR5E9PfUoWOJectv4b37TKgcfL1vtNCycpzHaWpEg
	 2rCYgi+04/f/u5Kzrje3ipNCiQXxuXfELstmSwaSGbtmOnOAPej8nEWnNpfGsC6ZEhJX0
	 bXuYzHDgJopeocowAxbXTbOKRGFbrEZ9gvvOhjuv1wAwmpLwSLS9npHwWRrpEC6szbeFk
	 vDEPWJiXz17yLTmz+SVYp5Jpb9nMCnA4Exp9CrhHU4MWHHjwZ20Fe5Uf+GgO8kpR/Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=stncjCpIcaZGwyCzQ3Mf39ygwW1cfGfLhkLPVcA4MfQ=;
	b=aiMz++SHAwgZeOjB2wDwzXPtk4VWPel6ttJljW+RCSfGx0aPlhlQ2f0pmefuMjlmXX4Z
	 eUr2G2SEn+vzVqNE2JuKtQr8AHDgytJ3LOXjZc4sag2zFBqxTmWpP7jCS8MFQfOUsd+R6
	 op3+F0+VnzRetStSxR6/Ur4C8nP2uS+hQ+VF2wC/Z4HdvXQuQShBJxS6DxsbZCJh0fryw
	 TrsgcZkYsGtF0J7TZfTBPq3dzbPRDfxjSq7nss5OH4mnavaglo706lr0bgz3YBfZloFIF
	 bU7N4MxrG2R5yRFq+EmjKIV/SCsUmMP0t/BwPmN10T+TzcFQ+s/sTINbi80X/JuW1LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JNYeCE/M";
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480AB606A32C
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480AB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNYeCE/M
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so495142b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980887; x=1794585687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stncjCpIcaZGwyCzQ3Mf39ygwW1cfGfLhkLPVcA4MfQ=;
        b=JNYeCE/Mxw8oxc53cwlDWJ8UWIHSWiegfRoY9rC99+LORNBuj3X4QhcO5CeIwu48Cs
         evXEjuSzZDMu74Y7n8Z086sfdrOKXCg5g15EumVHbPxFeTdIBDIIXhXp1c5vhs1z+3I6
         ntc2rSc/6GKLOX7IrjD2bhstX3lVtbsHihsIAQIIZHCZEk4T+7qyH0axLZnuNmUoolG9
         AV22BUo5isZUbdgBLgGRH9TNyOse5tIa38uEyy/JA6CuGfCzBouJr0owSTdPGbioUVef
         q0HYDL5WD7VfHcFkmYKoBMeTWAzLFLgimWcKquPCCuI9E0SJgFx5TJGnyFtcxQZz8xT+
         RHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980887; x=1794585687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=stncjCpIcaZGwyCzQ3Mf39ygwW1cfGfLhkLPVcA4MfQ=;
        b=mgG+pNTGD/zmo+Nt67j7YC3u3B76YJK17nAMKvigYZZVbGFqF3Y9rCo76gvfO8VilD
         MOXXZqAYZKvm5CGvPh+97lHLsyB/yiJNi4CpVSaoObUFWil01nC0A+mpJRnBLe3kpZUQ
         XPJ5J3chX6iUfdM3x/6RsgGdqdaFPtS4WUYDfnOabL6kZJVW5RE2FAN7Pz2hXUYtMpM3
         BLyq0y6OMCmcTwAT9SmwuGIepBohDPB+KhxPrrqNJaVlFXpAMK5XDkBKe3w9LzWeL2qj
         5BiqKfbjPqsyx3KYtRd4gYW563N+CqUVfvGqii/y+/HJ4kuOHQZxBnS+J0XWDDhacELy
         VaHw==
X-Forwarded-Encrypted: i=1; AKwUvBy2TyziEij/VWdZnm1iLgoEEw6CsoDgRgbHfMTTCGx13WIRQcELZnLw+5cC3TyZkqKGD2RLW6NlvA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8X+OGe5eWr1IlXs3qBvw06Gi6GLZEm4bYD2BTsWsyrGGboCCdb
	BHA+muorpDl41udXg1nKxYgfxGMjorfgT8cXXV2o59ch1BdApwZCNoCM
X-Gm-Gg: AYBFou0euffCFkDvAzI5JKGZzdsgAvsHK4pwpxwuT0wISAAuEqH1lQNzB9c3noAWswX
	5mVRuxckA9KBt7xv5xzGlnnFMCzjpc+yrVQ0D3vLOBQIeXBZGAwI9sxMGJjbZ0zlr3TC2yD5m3j
	hnJ2I463DuRc33Dnd5/yY10yUtcRrdDMQrbbeefV/e+05Ud+6BjiPnQObTmnI+QirM1DlFN8umQ
	qYgALd8QxsIK0r5mifqfkHFtvvjK3AnZ6i4+5Cg0e7qzzlyVxhQP1yq4ibU71JNcfurKXXWOLH9
	zRXr4Yr3NW7CL5cIJKZ30Ngg3xycLiIF1LF5vONGsLJYZZx+hoXndvrh3Gka5zzoC2dI3vdGmXi
	IluvlR/AoHPcEYk4HAVRX5BbmuIyRV6BQbge6fbCunA4qzXIzEygiDlvVnSZ7/6w8OyDsIDYkwS
	0nF8k6N47zhRpguVlS4sCiJAYh4gsFpYZLMdNrDB2UqzgSXdxZqV+Yl0x8qgbMBNp/2WR9E/UhK
	nPVLKcZ5Nv8T8NO/QhT2SUSFcK0IPX0/KWn2/2ZhkYvubI8TrFquFOInIzr3I7aKSYOUbuTPBPv
	RCknZKVmZNYDxx0fCBNAy9yzUBTCazo81RAAwT7wTeH/58Wa
X-Received: by 2002:a05:6a21:599:b0:3eb:aa33:e586 with SMTP id adf61e73a8af0-3ebb29c72f3mr3246747637.32.1793980887506;
        Fri, 06 Nov 2026 08:01:27 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm727930a12.25.2026.11.06.08.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:01:26 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] power: supply: mt6360_charger: drain chrdet_work before the power supply is freed
Date: Sat,  7 Nov 2026 01:00:57 +0900
Message-ID: <20261106160057.2754689-4-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106160057.2754689-1-hj351016@gmail.com>
References: <20261106160057.2754689-1-hj351016@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

mt6360_charger_probe() registers the chrdet_work cancellation via
devm_work_autocancel() *before* devm_power_supply_register(), so devres
(which unwinds in reverse) frees the power supply device first and only
then cancels the work:

	devm_work_autocancel(..., &mci->chrdet_work, ...);   /* registered 1st */
	...
	mci->psy = devm_power_supply_register(...);          /* registered 2nd */
	...
	schedule_work(&mci->chrdet_work);

The work handler mt6360_chrdet_work() runs mt6360_handle_chrdet_ext_evt(),
which calls power_supply_changed(mci->psy). chrdet_work is scheduled at
the end of probe, so on an unbind that races that work, devres tears down
in reverse order: devm_power_supply_register()'s release frees the power
supply device before the devm_work_autocancel action drains chrdet_work,
and the work then dereferences the freed mci->psy -> use-after-free.

Register the work cancellation after devm_power_supply_register() (and
after the other devm resources), so reverse-order devres cleanup drains
chrdet_work while mci->psy is still valid. chrdet_work is only scheduled
later in probe, so moving the devm_work_autocancel() (which also
initialises the work) down is safe.

Found by code review; not runtime-reproduced (requires MT6360 PMIC
hardware and a charger-detect event racing device unbind).

[USER: add a Fixes: tag. SHA not verifiable in this graft-at-7.3 worktree.
 Blame the devm_work_autocancel() introduction in mt6360_charger.c on a
 full-history tree and confirm the 12-char SHA + subject before send.]
Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/power/supply/mt6360_charger.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index b4d4623..e382db4 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -790,9 +790,6 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	mci->vinovp = 6500000;
 	mutex_init(&mci->chgdet_lock);
 	platform_set_drvdata(pdev, mci);
-	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
 
 	ret = device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt", &mci->vinovp);
 	if (ret)
@@ -828,6 +825,16 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	if (IS_ERR(mci->otg_rdev))
 		return PTR_ERR(mci->otg_rdev);
 
+	/*
+	 * Register the work cancellation only after the power supply is
+	 * registered.  devres unwinds in reverse, so this guarantees the
+	 * work (which calls power_supply_changed(mci->psy)) is drained
+	 * before the power supply device is freed on unbind.
+	 */
+	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
+
 	schedule_work(&mci->chrdet_work);
 
 	return 0;
-- 
2.43.0

