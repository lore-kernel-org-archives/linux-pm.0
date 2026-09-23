Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35840419FCC
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161669; cv=none; b=AA+SRt+zwaUSTy8q+Y8X8QQ+O4jWl3UkUCgMvPMpPfGVDcPeH5EBpoBHikwNozRQIbBMY1a6uH4++qA6g0N3ivHGcdt+eu4oJy18aFT1JmeJIeIFuHzAgVWZhGZg/UukBSEdnPs4euPIi/2r+rlDKIAjj0D+w7PFdYj/mgmtl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161669; c=relaxed/simple;
	bh=Lp05HvS7MlHdv0hfaKJnvCR0qiPp//Pn4+6+M3Ynev4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tB4RegnsARO4y1jP88ePMo5zX7NcQ/D3i45jK0OtIWlFv6h90hREFKI+taFLwMWaa7PvJR/6cmGFCF0fLUWfqCoVDjbhhimZsfw0c0crVwoDx5fTwciAzaZ+mglzCPGUjd9mfu2YpONTkFsBfvbxPVtVVD92jN74QRmFDZRLgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFnlHplM; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFnlHplM"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302c06eceso6565461fa.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790161666; x=1790766466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z7/IdbLY9gftiE1cMDmaoR65MCls8WYbgHoLCd/1QnA=;
        b=bFnlHplMhPHGY0NTkD68DscIKi410Go9xX5uZu20N5oK5M423zAW79ZncI74eXpLHS
         ox9AMo+B50MO+fVm4ah9F5YtCWEehBE33t9yxAUgLtAE3vmrJs/0a5sHj/KEdGT218A+
         ZCiOmPwWHkZ6dK+cHs0acz3eq8OG68ZNtHCxDV92Dz5kI9u43OETMQ/FF68p4bF2lQUb
         s7ra/MM9vh5rShd0bBsthyuA+o/21+G26e9NBLaIxDDXY+ojFRpqCFrKpXNsO3vzFhlc
         G2pkXegWUWhAW77jANhK5wn7w5KNxRP6SYe4+ACTwGno7fZ22pA7OpbaL0xOitnqNtnP
         ZqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161666; x=1790766466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7/IdbLY9gftiE1cMDmaoR65MCls8WYbgHoLCd/1QnA=;
        b=OG0RZv70pl6CGYqzrlNHym6npxdk0mqi42v6TKmtyP5ES+Bv+NB8pvgyuHdUfKdxRv
         adA4vTnr8Q72+AOirUJGYhmf+soQ1NPQNkymTQCeyoB74wWukZQacFy5dq8R0Kc/L+7P
         txHt1kqKYkL9SShBKZs/rgS5cTZj5CziBZ0rN1s6IM4IsxvINJP6kFg85pQsvSXK4bp6
         9ie22X2bEFHrKVIinsK84EsE2g2A40Jn9zIvq5a8oGJsPuc+d8JKAR0x01wH0foAqIDa
         UoyJqNfmuA6xH+/WWCRycUYFThPDTMKBgyfYXE7jc7vQoOlSwocuyXy2eqOp/P2UYFD7
         Arvw==
X-Forwarded-Encrypted: i=1; AKwUvByT88r7e/S6eu4y4zFOTMBht8DJqB2qbNJc8pAWC1DR/4D56reBjIA9/vGH8B540kDWGdvxIbk+Lg==@vger.kernel.org
X-Gm-Message-State: AFuF++m0jPZDHyFA4F9FQ693wtmXtyRl5VZM6XUrz7NQcruGzCX12Jp0
	mFADu6FQMt+V++BzZ3T32q1jLTW0GKo60wDbj1G6tsVR04RTFw0HqvNg
X-Gm-Gg: AYBFou1jdtBNqccVtA/m5e5YV0xW6Cgcbsf0uMnPLU4bGBDATLfKjJx7FLf8Wji2pyz
	Mgo6g5TAKn6mzpZWxaOYDue9FwI8ze/sGSX3BIx2e68YJ08lxseQRsF9L9vQ8a6DdyaU4f/jdS7
	lgfHRMxzDk2YHceC9deSmUTwNbIrlgNkartxfABH9WWrV3zLrGVPhPukEPgBCSt37tAkb1KMOyw
	2RpMOwmZIInovSji53xgnDh70afXz6StY2ckMkOtsQBO8ppG62bF69Oo1T1QZGVHjP0tMETrpOw
	SWi6FynayO+Je18O0oeeb44MLexHOdCSSBqJcKxbaRS/W9VKbiGr2qypRWFwwNDIs95wEK1HJ7l
	e46wWQRpQkhalxXbkfzcRJoOZJDvz9Pf5QIoYhAd0e8K7e0Qeoznskz27tNBD7eNVOxkiiOUdi+
	aW0p2ZXMURbXlg51osQTjlQtDvljHuEtpK/D0k6ioAZBUAwncVWKTDOM8iJi7Qj6q36G6t0uOfF
	xNguvn2hKJqL8+lPomYUEZy0r3po/NNTyQ/oJZq
X-Received: by 2002:a2e:bea8:0:b0:3a5:b1f7:a7bf with SMTP id 38308e7fff4ca-3a63063d280mr5098451fa.21.1790161664609;
        Wed, 23 Sep 2026 04:07:44 -0700 (PDT)
Received: from DESKTOP-7GRJKK0 ([188.226.104.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a62f5285b0sm6063071fa.35.2026.09.23.04.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:07:44 -0700 (PDT)
From: Vladimir <anykey196@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2] Input: axp20x-pek - add AXP313a support
Date: Wed, 23 Sep 2026 16:07:41 +0500
Message-ID: <20260923110741.1880-1-anykey196@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AXP313a MFD driver registers its power button cell as "axp313a-pek",
but the axp20x-pek platform id table only matches "axp20x-pek" and
"axp221-pek".  The power button therefore never probes on boards using the
AXP313a PMIC (e.g. the OrangePi Zero 2W).

Add the missing id table entry.  Unlike the other variants the AXP313a has
no PEK key/startup/shutdown registers - AXP20X_PEK_KEY (0x36) lies beyond
its register map (max_register = AXP313A_IRQ_STATE, 0x21) - so give it its
own axp20x_info without start-up/shutdown times and hide the corresponding
sysfs attributes, instead of exposing files that always fail with -EIO.

Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a), kernel 7.1.13.

Signed-off-by: Vladimir <anykey196@gmail.com>
---
 drivers/input/misc/axp20x-pek.c | 39 ++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 24f9e9d893d..b912f13b607 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -85,6 +85,16 @@ static const struct axp20x_info axp221_info = {
 	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
 };
 
+static const struct axp20x_info axp313a_info = {
+	/*
+	 * The AXP313a has no PEK key/startup/shutdown registers: AXP20X_PEK_KEY
+	 * (0x36) lies beyond the end of its register map (max_register =
+	 * AXP313A_IRQ_STATE, 0x21).  Leaving startup_time/shutdown_time unset
+	 * keeps the matching sysfs attributes from being created, so they
+	 * cannot fail with -EIO.
+	 */
+};
+
 static ssize_t axp20x_show_attr(struct device *dev,
 				const struct axp20x_time *time,
 				unsigned int mask, char *buf)
@@ -188,12 +198,35 @@ static DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup,
 static DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown,
 		   axp20x_store_attr_shutdown);
 
+static umode_t axp20x_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	if (attr == &dev_attr_startup.attr && !axp20x_pek->info->startup_time)
+		return 0;
+	if (attr == &dev_attr_shutdown.attr && !axp20x_pek->info->shutdown_time)
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *axp20x_attrs[] = {
 	&dev_attr_startup.attr,
 	&dev_attr_shutdown.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(axp20x);
+
+static const struct attribute_group axp20x_group = {
+	.attrs = axp20x_attrs,
+	.is_visible = axp20x_attr_is_visible,
+};
+
+static const struct attribute_group *axp20x_groups[] = {
+	&axp20x_group,
+	NULL,
+};
 
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 {
@@ -393,6 +426,10 @@ static const struct platform_device_id axp_pek_id_match[] = {
 		.name = "axp221-pek",
 		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
+	{
+		.name = "axp313a-pek",
+		.driver_data = (kernel_ulong_t)&axp313a_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
-- 
2.55.0.windows.3

