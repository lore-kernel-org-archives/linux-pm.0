Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E073B8BBB
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309549; cv=none; b=qs0TPVEg0DjiQPFe31sNvEDUVmaCL9jflnG10XC3v42g06iYLptV9lLr9yvIKIx+rI8uoDrzplDeBgcbO5U+ioL6FPdaYF2nrWtRkC14X1Zf/1HeL/tlJF2Fc7TU7xgcQ8kPuS5thwSmgzN/eHNpRu0kMWmF8c/MUHiyJGQtORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309549; c=relaxed/simple;
	bh=jLHVNY6cQEgKL3Q7WFwqzYEQ72tquerqepTpM8X9NFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVQlDBssaqhlKfTkmSwNWJX7RtTuie1yAoMDe7DhqGd7KFfkrnwr6cyn5YtQP0s3x0kuwT2fNEwXXgU41+Q5LP0CY2Epp0bXdTdNRUT8n3BEqZfRV4XxKgRG1xCtxx+xkCjmYNJlTdvRmJlz8QX0YDvgEAeBwm1DT8u7219TLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtPmQPIA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtPmQPIA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so11116305e9.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309546; x=1782914346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke4xsnfQvAtj9HUGdRHxC0rQqe0tdop+3YHmyiDVwDY=;
        b=BtPmQPIAdMiU0GA4mRA5grwqXptR6kXOHRDahxG3rnTyXIRRHN6dqPx7pnTnQqjRs9
         IybfJKG++3yQn19zhAOFdu6BBaOP9RQkj/7Sx1jI9M92O8f8biP10UAzK+adSKAT+mgT
         zZgggYo8pnrFzUFif16yo+05Uis7ufmKfCfQkNddaEFACzkayUsVZvocMsIfoNJjurtm
         rOR8tdbJ6bEOTC5UCuucFHXNCT17eb9syJpTW4KeTsOvSV40esplm6pEPeyNWDm6befQ
         0d6Wo1U6pBGhvicAY+g9e2qSFcolquIQXmHRhEnjEy6Zp7/bFFlZFAJZP2OxszIsviDg
         aFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309546; x=1782914346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ke4xsnfQvAtj9HUGdRHxC0rQqe0tdop+3YHmyiDVwDY=;
        b=pCvuUsSz0M9mh1Hd/3lTBQuixKsdb/I6rBRPYVpgOWxEHdcdj36ofk85CVtk7ZHA8q
         u0KSVbhwdY/hXSrfeZ2zG4OUsDmT1mBE6x0Y9KBni6U72lbGy9NqqcUreNpc3x85gjPx
         Ou7DC+U0oYJTuRc8N59z2ztpDSiAVMsFUNyFy8DgOPyMIl/LjL4L5HZYrORCL2Dp7ZS5
         Fwn8+vvyW2JViGtrZFA7U5zZGSgvnu0NfO0I+DE+NGs7RsLcAwRH97KnWxffwDtauINd
         gEKQ3+7Rij784cw97XUzoMpPlwndcT5DJgeghPUemHKhwntiAQjyBg6UPvvWO1vAzdQZ
         mwaA==
X-Gm-Message-State: AOJu0YwkIWX5g82NFLO1CCz9uE9cCSAXzSaI7Ybct9zps3tfahXGiXYX
	EbKeX57QQk3gmn2P8Yrtj96CeqDpLq6DfnsEGh6F0OZYeRCmTaNbRJ3oP/tb89nK7zkRCFsg
X-Gm-Gg: AfdE7cnww1Kc1BVH1y4f9wz/31XPYkRX78mTMV5sFqoOut/rwOtNlWcrN5XMX+Ijpid
	BuGc+XjL7qCecIVsMc0H7FEl3P+1I12IiNLVrqIGO1SCEwgbv7psVQQh5hbEhNbQXZ8GgSWXpnw
	CJAl0ZlUcFmVMgWiRarR3MUSxm6sYiRuqNKlsTN9veEiumwlSK5WCO+vE9LBOo2uBCVU2lSu8Sj
	ZzxdXwKreQ9tQLIP30T4fZ5TB7V/9yMpYWKrhHlIXKnROOPEhF6nf09eyzqJabanVOPQXpMyw+U
	g9ys2u9FL8fFeMi1wrPqXdT+xgEfAihJDZW0hG7uEDWo0LybNnLv1Hfo5Y84Uo1uxAHt29bb7/0
	Cezez8NGBx4HsxEojsi/Km6yAVCBRvSu223eGjKS4BNg7M50kMAaWewYmhYJLuun4vAeUdQFSbX
	8dCBGwJjv8DkiNsgZ56MZ+O+I=
X-Received: by 2002:a05:600c:83c5:b0:492:3fc4:bd6b with SMTP id 5b1f17b1804b1-4925b34eab6mr121375675e9.7.1782309545981;
        Wed, 24 Jun 2026 06:59:05 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93eesm6734311f8f.20.2026.06.24.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:59:05 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH v2 2/2] power: supply: sbs-battery: Add PbAc, NiZn, RAM, and ZnAr support
Date: Wed, 24 Jun 2026 16:57:18 +0300
Message-ID: <20260624135718.286771-3-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624135718.286771-1-borissh1983@gmail.com>
References: <20260624135718.286771-1-borissh1983@gmail.com>
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

Link: https://sbs-forum.org/specs/sbdat110.pdf
Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
 
-- 
2.47.3

