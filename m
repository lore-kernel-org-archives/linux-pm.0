Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15979346E57
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508504; cv=none; b=qZwfaXuat+pg/xHwGFxyp8D5MZVAS64n9vIIMDE0MSW6i7gpai2WTrLo9NuqtD+JXxkYdPJxUjVtP/Jyd5azvtGO4b38DdB8SJtJK14xleTJm4UqG8I6zC0AjXNbBq7hH6360bFxlN9vf9/Vb3jeVAbJnS48RyBHJvZeKO4/f9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508504; c=relaxed/simple;
	bh=YTaaWjYSXf37/O64vVOJlMn6uJ3wzTPz6MyKhGkDpCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gh/R1lX0GoP8i3V/iBTnXItWo05adU+uzyFWplk29zyFXbJqjHfDcleh2xFIYJKrz8SWgsC1CPnBiDVpHf/icRZC/RkaIQUpPz++iZkeAojsY4G1z/fODnkRDD9kwWsjHLfmhgNm2ev+Jjxql/qQulhKNgQbMAD/scicGkdsaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRw3o+AT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRw3o+AT"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-847a5528b33so301097b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783508501; x=1784113301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZbH5XcFqp9SWE5IMtoeIvw8DFbEAEc+msM3hD5f1Yc=;
        b=FRw3o+AT1kmL95FExRgF3VcvUS1cLKt0DNysQBIv6Bne85Dt8uMPVII0A4k4tiYTOC
         GO0WkwPAO8c6eNqHSN+Wf489nZcgd8Jrfn/TcDxGdsYUj0C7KwYGjT1S+NRsBAJSCfz9
         b8jTAESoIj1sWrTQ2lJAhQ21EDg82kiRXLzQ6Pl21W8VRxEPBP7EfufZyrTLMmTHXrku
         FrcDIhWhpI6Wg/+3363BICnxhM1G3AyOiOKagpH8+BaSP3qxW/85zXGPd9G5KBvJqBBJ
         zU9XrElGo+O2HQqiTYd218QguyqPChoxetDlXjzw1V5A7vLBNkA2IvBhVo15sKm64RhA
         jKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508501; x=1784113301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZbH5XcFqp9SWE5IMtoeIvw8DFbEAEc+msM3hD5f1Yc=;
        b=lfhqQ3K/UGPl4sTk7sRyobQrmfHNrqqTaYjty23Q1mKZsXKSN3hwV0nlR2z4vIOIt+
         P1FqAHGtpKTNOPrT7GRyFnzIOdDw/Wce7r3qwJucws+l+9T/qRuLqJQN4BqFsz3s6bOL
         yFZmduV5UIjayLE4yxLmSgRkfxNMOvKl0GZ/OwngzqaiyqioIj/cm3P4B6FIVWlnl9IK
         L1mniCHbX5zqWOn25iw4R4zAUQa88QZ0mmlX2/e4qZGwuAzqvf5c1eZvFohtcqqVkLLR
         q6n+yX/vR0nm+/t+nVLJrqdtMrFnT1rPEbDj6EgYk6sMyuzB8KJ/wTPCCOpOA13PbSAi
         rRJg==
X-Forwarded-Encrypted: i=1; AHgh+RpyCB2i9QXr1smXEWWMirgF2EsrU1Ju/8y018BpGQKVExGBn4Se/GEUmMZvK/ybarrN7VqabY85bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJsCTjm2cckGDXSNHIw5cxv3GpavJSFJ+qMPlmUlHDXprR88l
	Dy7OzK7B8yAiTHs1zKKjMxReTlSk2d+6mGIoUB5lhmbHcjVb9j+D140F
X-Gm-Gg: AfdE7cnOS7z/C23JLB0BihfCp0d6QsjhRPmIVvkQLJSb8JyWcgrNpnc/RMnhAz7zbxV
	jaD7QuOUDkZU9EQmWINetqI22hv+2xwg8UAz0z9E2FEjEBMQu8pB5rUvvvJAjwSdZ9qzrqnJVKs
	OpTqhPsJmJTGx3GjygKhJAorISUZHZObea/NadmxTpZ1yDZEOSWbG4PDPrLhdkLOC0hzYDgm8aW
	dLdw39bcjFSdeO10MfaPVVeLbRV7JPBZMCzdbKlHM3adCcENjSJ36kZrlQhbw8XURrLB++aCmtl
	ttdPuYRu2vqtL8yM4h/p+jihQNFXlX6Vq4CoWCfJQOuL2nu2dKeSovKq307NjW8qK87WIVR95Oy
	1088PrCAJdGB3kvTfaOUda+YR6KgWZNwd42XPkzNQoplNGpXjwpP+Mj/kJYhS8FT1cWbs/P1D61
	TRR/Cx29Zrik8e5g==
X-Received: by 2002:a05:6a00:92a8:b0:847:438f:500c with SMTP id d2e1a72fcca58-8484368e384mr1919809b3a.60.1783508500785;
        Wed, 08 Jul 2026 04:01:40 -0700 (PDT)
Received: from lgs.. ([152.32.133.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484c32ee5esm259488b3a.29.2026.07.08.04.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:01:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] cpufreq: nforce2: put PCI device on driver register failure
Date: Wed,  8 Jul 2026 19:01:31 +0800
Message-ID: <20260708110131.748268-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nforce2_detect_chipset() stores a PCI device returned by
pci_get_subsys() in the global nforce2_dev pointer. That reference is
kept for the lifetime of the loaded module and is released from
nforce2_exit().

However, nforce2_init() gets the PCI device reference before registering
the cpufreq driver. If cpufreq_register_driver() fails, nforce2_init()
returns an error and the module exit path is not run. The reference held
in nforce2_dev is then leaked.

Drop the PCI device reference before returning from the registration
failure path. Clear the global pointer as well so the failed
initialization leaves no stale reference behind.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/cpufreq/cpufreq-nforce2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index 831102522ad6..5a101c69c47a 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -409,6 +409,8 @@ static int nforce2_detect_chipset(void)
  */
 static int __init nforce2_init(void)
 {
+	int ret;
+
 	/* TODO: do we need to detect the processor? */
 
 	/* detect chipset */
@@ -417,7 +419,13 @@ static int __init nforce2_init(void)
 		return -ENODEV;
 	}
 
-	return cpufreq_register_driver(&nforce2_driver);
+	ret = cpufreq_register_driver(&nforce2_driver);
+	if (ret) {
+		pci_dev_put(nforce2_dev);
+		nforce2_dev = NULL;
+	}
+
+	return ret;
 }
 
 /**
-- 
2.43.0

