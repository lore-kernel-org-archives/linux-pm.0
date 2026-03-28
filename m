Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393BF2836AF
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725504; cv=none; b=usgxDBQjdh82tm0F1c7LiBVhex29ysDmDNVyYOJbQGLWf2QGYoU+dwWU0aGshDE5o6AcGw411sUDplCeWDoQu3J3KQxvFj0RyYfpV3JOlRciYSRe1sGktqndtRmksRXktiqTnmtXVcAP48uh2p5cBcjU3octj7qrZrgopihotyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725504; c=relaxed/simple;
	bh=TIUrJlohH7zzcX5wL9kNLLx0H8njEDL4nmQhrrq1NaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXkNDVtv+l2pN8///AGiUUpZwrHuQhdMg3NqGUCWQMyLD9OnC6RjD4HLqUcEeZGHFbXUCLgnZvl1kbJBK0AKBgFZFPk5WHs5tksXSTsFP6hdrMd+mwGILU2jDB7nAdqfsgkuxDQV0Hj9vWoFIhvHidU4t25IZn+8UiyyvV8rXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoDqehKT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoDqehKT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1598086a91.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725502; x=1775330302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/Kc/rqS3O8FcnFqoMXkBJLowbwjhPQjCnPmNyfgP7g=;
        b=ZoDqehKTM7Df0VULo5ckJhalU41/QfXu2ZetmY57DoxkSTTpvY2b2Vjxftu1ZeCy3v
         7a9N6ocwFKkokOfCZjpbg9mIQ+2DALjvDARimaD93CPa8S4o+9Yz8+SpHsLogU6kEkuN
         UroEfSFiDjSJbT5bIaiGm74k7ErbmeeguQZbeY7JcMyxF+4HwW4FAW5WvVoGR5whM6DK
         k43K9Uengqga4EgPANop7eb8L4hs1Zn3dKqGQU0jxVPfkUNEsANibblCv69Gavg44hsp
         3AKvs04xGfmnxlHPD2bnULN5QcRH2xOgEWJzK+Q5f99q/a923BvP6V2uFJWczN1RNgUd
         mUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725502; x=1775330302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/Kc/rqS3O8FcnFqoMXkBJLowbwjhPQjCnPmNyfgP7g=;
        b=Pm4Sdapo7YHeUxZbmK1QYrrMPJezNpqGYJknD80rQ+W7SDdSe+nmgpuMoBwoeEgl9f
         3CSjKJmQEBR+OPk8ewkQPWOQeaPX5tccH8gEWrOnk3Uj3sKKqNSaj8pI7S27JVrBSH4P
         b8fFlslEaXsAeEIopqLmkyx3Ajc5fl22pp1MhdAVVnarSwPm1jXVwykBEBzTHd0QP1xc
         Z5NbseUCL67I6GmR5Cpy2syHUFXv3QgMuqEWwiauRpAp3dgI/wY3a+uINW0Q/1G++4Ot
         V7/jcxRgapPfB80OmocFPF/ODG53l2IHORXeOUV4XqtXkozQsUmKOJZD8b551u8EmOrv
         myGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDXWpOIap4oM6VtJ1TQZLCv4JDLK/ZNJ4mc+rGgIDrp9fiRbolWhJ2bxPgj+ISZJel+KW9E/hSkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJU6OL8GeO+etNJPvMMJK4pT7KSUQKlfurj4GjowQZEYJSn+8
	PzcSS/24iXjHxRw+/uLvnyYH+Ai9Hc/03qFw8U4WYSJ2RB4wOVaMis0nE8eF2DA5
X-Gm-Gg: ATEYQzxyVwbF8DGtSftMTPYl0NQR9q0sJ0++C4R/CO7q9k6259fsJAOhc4ziv6x0+tI
	xmyHgAN2k5rIdCWcgoUdhOHgEGL9X5RXBgEx/ZYddiP7H3iMFCH4J9zIMrhUEBoxcbuFuBiyO2M
	zY/DfKYGGuzOYaCWq1aBt/0A2x0JG+VJ0ViuhKhMUNZFqUKo6ErPIbNihWkJBCjmHlTeauzEPjr
	1AQ44eOCUnyk2oG/Pa0TwC4uje0UH3U/55HNkVVwGxBssr9Rp/t2oBE31EOIJatXJ4pNs9Ji8mi
	n9h6kVEQNGzGsgsVIXzAQ8N7yhTXN95HPKNk6Gc+0i4z1MP7Dh9FCMVx8dP1FeZfBZrxrb77QrW
	JfH6C1Y/algzSQ1AV/LVwDZNvEikwghiYTdShMd2q+Rwcj54trV1Gg/pLzdOhL2WFxHhBqrS3w8
	iR/U2Gx70w5m9d/BAZukAhmqRRfALcHeSmD+wUf5P6AMldAlNrO8Ugsg==
X-Received: by 2002:a17:90b:3e81:b0:35b:a8cf:7969 with SMTP id 98e67ed59e1d1-35c30000104mr7222978a91.11.1774725502396;
        Sat, 28 Mar 2026 12:18:22 -0700 (PDT)
Received: from debian.killsync.com ([103.38.13.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d9507d739sm2684165a91.11.2026.03.28.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 12:18:22 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH 1/2] thermal: intel: int340x: Fix potential shift overflow in ptc_mmio_write
Date: Sat, 28 Mar 2026 15:18:05 -0400
Message-ID: <20260328191806.8675-2-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328191806.8675-1-aravindanilraj0702@gmail.com>
References: <20260328191806.8675-1-aravindanilraj0702@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

The value parameter is u32 but is shifted into a u64 register value
without casting first. If the shift amount pushes bits beyond 32, they
are lost. Cast value to u64 before shifting to ensure all bits are
preserved.

Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
---
 .../intel/int340x_thermal/platform_temperature_control.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index 0ccc72c93499..18ac5014d8dc 100644
--- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -138,7 +138,7 @@ static void ptc_mmio_write(struct pci_dev *pdev, u32 offset, int index, u32 valu
 
 	reg_val = readq((void __iomem *) (proc_priv->mmio_base + offset));
 	reg_val &= ~mask;
-	reg_val |= (value << ptc_mmio_regs[index].shift);
+	reg_val |= ((u64)value << ptc_mmio_regs[index].shift);
 	writeq(reg_val, (void __iomem *) (proc_priv->mmio_base + offset));
 }
 
-- 
2.47.3

