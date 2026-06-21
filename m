Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AB2459FE
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782054300; cv=none; b=iHWalVvHD4pp67Jc4EEQ6UX5/bE6aiXoHF6aCdB1fO21mV/4piSdAvHhuTBFMEr3MSKZwAX8KYZkPdo0+K9x2YKBIUvZlCPZ6ZWjZp4w5toTvRw8w0MOM+7mfrst3qxnGqAteAQQJrcCZdIDeWc8oRgNuoQ/yLqSNfQp9sCu0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782054300; c=relaxed/simple;
	bh=8PF4fbu6RFzIOwEP61yL3779C7DDNQg/5dAaIN8t5gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnt6MmGXdGzG5eHl4r4UOK8xg1Bl7jnmhdGyldMmK8+gQUP9nzx36RBLOdV88WBVPADo1cMWCL7EuCcjduA00wNxIYoinhwtfIkqWpDEvbmeno55zuSbnY8RbkYyQW+Zcuu93OTQUNvoGuY4to6TElxayTPNtznA4irIBzj6eaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9vx97Dr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9vx97Dr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4633193af19so2457956f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782054298; x=1782659098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJJwiNPFILjfamubqJVIHOb544iHR6Dw5Qy3X1SEgUA=;
        b=F9vx97DrCBmnG3fEN9WQ0/XS/YcsHD3kn7wBRksmCP5jQRqiC2FLpJ4YouzktSkNJZ
         Ij1+rhe2vGHPycmWRb4JlMay+nlJAkhjkAYlKdW/iasFPrCMagi4WIKpiaZyX+lvN32X
         NVnBUY27Br8jdpB77Tr7+Rkjwb7YJwU+xgRMorM7+S2Itp6LGudbub8TpakvNHYqCF2+
         KRVXrLnk11I5/2SHz1bbvfbYCa2bniKj+rBRZy4kqSxb1DFjo97kl77FJ/pQ5u5nlgCI
         jmiowEzuds+iGMSp734OioL4zjw8AFtchFFfREdpUsLz4JIBDFvCVRxuzF3tgjPHByVc
         GjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782054298; x=1782659098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJJwiNPFILjfamubqJVIHOb544iHR6Dw5Qy3X1SEgUA=;
        b=AjacL/u7n2DoCcpjjJ+xUCxD6dzW1nAP9Kh4TNUfVccoKFIkbElJBPBJDk85E1SSEx
         U8wzmFL/RatIVFclUmTknaa47L1NF6T9qNNpPSSp/tGDS4HC1fur3cSKH2RGKrOZDhSs
         nW13Qkv+VEuVgLC3B6XHbNCDxGTCWcSYGK69s/ie6bJc6eTME8Ck+TK7ksG2i7cZ41t8
         JFpK98wBruAy0lFHYB6+DfS1lC+p8oF4e+/LFM6YQfG432NO6cTNcQAYsWvFvZ/7oT/0
         GU5C/z9NSVmlSvH4U2S94SzKsb2mDpcTCrBRWkZz/V2uOyigJWn/770PwrcoAlYjuS7t
         LYjA==
X-Gm-Message-State: AOJu0YxJW9uUGC4m31UYqAzkk0xlylChu+UDYQdYyEcdAxepaGdqw+Ns
	6aONdIR4pbejt6k8WtorSzZ7D/XTxjiruQUIxADmy86p8eQqS1IVFE+E
X-Gm-Gg: AfdE7cnUvUy+vic79lAtLq2BcHWNvSivu+viPY06zm9dPZScLn+cGOYmrrx7HZ9FAlb
	5dZN32BgqQGypuHHTXPu2OP8OhJDF+OTDJxc8XD4yCwyrgOl+zUoHI7oyPJ5Kd++dI5zGArjRoY
	CxawZLNGXzfGRc2WaXE762wv2H2XBJydz/tcjYeaQlYsntR95RQ/pEvfXNlcta50wsC8tBXp0Zi
	I+CpC4gqHOLRN3lR2iUSn4DvCjmvK7altIsiOSMSYCVjzWVY6V/afhR/KU09vxsG4Ca7v/Vo+Ju
	IeWnTUBwB4yEP+QpCFcdq7dI61a8+rp4foLZORNhKEE9aWfHybnoUCq2UWpCehZrIKFq/K73U3g
	iDoIFeneM1LPX+/RnfEHXcpVJcWMzvnhBmiQ3I5wOFtrTvpPUDqwoISHxggghKTQUwdA5/aDdUb
	eDzvbEHIFlTaJdOw==
X-Received: by 2002:a05:6000:401e:b0:454:a12c:6cdb with SMTP id ffacd0b85a97d-4666074448bmr9464237f8f.2.1782054297400;
        Sun, 21 Jun 2026 08:04:57 -0700 (PDT)
Received: from beast.lan ([2a00:c281:118c:d100:7798:6e18:1b39:c2ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e93sm19542931f8f.7.2026.06.21.08.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 08:04:57 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH] power: supply: sbs-battery: Add PbAc, NiZn, RAM, and ZnAr support
Date: Sun, 21 Jun 2026 17:59:52 +0300
Message-ID: <20260621145952.56720-1-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PbAc, NiZn, RAM, and ZnAr chemistries as defined in the
Smart Battery Data Specification v1.1 (Section 5.1.30 DeviceChemistry).

Currently, the sbs-battery driver only handles LION, LiP, NiCd and NiMH.
The Smart Battery specification defines 8 possible values:
 - Lead Acid (PbAc)
 - Lithium Ion (LION)
 - Nickel Cadmium (NiCd)
 - Nickel Metal Hydride (NiMH)
 - Nickel Zinc (NiZn)
 - Rechargeable Alkaline-Manganese (RAM)
 - Zinc Air (ZnAr)
 - Lithium Polymer (LiP)

Map the missing specification values to their respective core kernel
POWER_SUPPLY_TECHNOLOGY definitions.

Link: https://sbs-forum.org/specs/sbdat110.pdf
Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 8 ++++++++
 include/linux/power_supply.h       | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 43c48196c167..42a941e99155 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -860,6 +860,14 @@ static int sbs_get_chemistry(struct sbs_info *chip,
 		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
 	else if (!strncasecmp(chemistry, "NiMH", 4))
 		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiMH;
+	else if (!strncasecmp(chemistry, "PbAc", 4))
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_PbAc;
+	else if (!strncasecmp(chemistry, "NiZn", 4))
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiZn;
+	else if (!strncasecmp(chemistry, "RAM", 3))
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_RAM;
+	else if (!strncasecmp(chemistry, "ZnAr", 4))
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_ZnAr;
 	else
 		chip->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7a5e4c3242a0..034800cd21da 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -83,6 +83,10 @@ enum {
 	POWER_SUPPLY_TECHNOLOGY_LiFe,
 	POWER_SUPPLY_TECHNOLOGY_NiCd,
 	POWER_SUPPLY_TECHNOLOGY_LiMn,
+	POWER_SUPPLY_TECHNOLOGY_PbAc,
+	POWER_SUPPLY_TECHNOLOGY_NiZn,
+	POWER_SUPPLY_TECHNOLOGY_RAM,
+	POWER_SUPPLY_TECHNOLOGY_ZnAr,
 };
 
 enum {
-- 
2.47.3

