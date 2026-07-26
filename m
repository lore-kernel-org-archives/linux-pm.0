Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB520E023
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038595; cv=none; b=RQJCXGDyBERTIpiFUORD313BP0famm1RPM/o05lkfgusJ2QD7YNc13/uRjk21rT8/e4dtc36kTksEp4r7pTarvuo+sV1TxSUK50HseOT/1wr7+eOAM99lJ9Vzn1ALwHO0Hxlhwj8VAXGthyovweqoae9v+8GUiXLWVbkRRBrd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038595; c=relaxed/simple;
	bh=Rcfs5xE1BKazurPU71g/CAnl+Vr3skpjOPoqgsEa66k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBYjxt7QWN2j2JpuzMC045hzgtkImQ1fIiwtWHNy4PqVXsB++YS814zcGkgZwkwREmnuFYviAYeStovGXs9zZWwOSF8gImd2zYdiZKTepSm9xGRymUHvu9RQMxZtAOIssWr7L1OK5zHA70WrQbp2DjHYqGCqJp3x7M0QlUPsPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxtbrJsf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxtbrJsf"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1708906a12.0
        for <linux-pm@vger.kernel.org>; Sat, 25 Jul 2026 21:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785038593; x=1785643393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TftBonCo65/KM8j4iUvNEUfLj3iQNRTb5idjXeff4V0=;
        b=YxtbrJsfVwQRrZt4y8aq8jvkb/IpCxFUcg7HCd0YDPf4kIRKlBuHSAxuw/7bnvYtKR
         YhSEfx0reu1JuaDbqQfQ34RHY1fyZeJK3Y+cv3yIgSVHgZOUz7F7CArOb2E9aUIwQOic
         1Zu1tnKO+/eRMhqbflBVw6yU0BKltKiYZQGi1KODRiU3nRaY+AgDo6xWAJJ9F+Rppw9s
         y4F1qIYFnR6ZoX1xqtdKYlTK9OPuKj+LFhjiC6iPZiD0ZBgBitZySEjLjmttbQY77zi6
         BLjpMxDLI/2LphWeVby0N9xgseTvW4GcSrKYcWb2a3rDtx08Rv3hQUIQYFWkW+EUhuj9
         1uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785038593; x=1785643393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TftBonCo65/KM8j4iUvNEUfLj3iQNRTb5idjXeff4V0=;
        b=D9+zL6nYS+S+jE4BzW9OUhjyH6w2JJxDTSLUNCsZkAv2yL/8BKikwK6OpNutri3pze
         EpgNfZ9RohP1tovs+LFIWTITXt+9caWD95KsLsp4qXrhGl9ymyjxvqj/AJ4VUfrCz+ig
         xmX9RLSS3qTJzKPJVjae9zZ8tIgBjtVk7Uhahfv9qU80+TBLtAMBHSbJJSH15prWkxuN
         Bi3nsZL9o6ONAkkdZQyv94qyUutNRL00on4JkOG8xNy6xwcssQcmq9Yw16MJBXWs/IMP
         GxOV+MNS1ymLrEWM37W+6/XjxFTegUz3sbVys2161PekMBtt5SxxevgSiWtCFz1/rmtJ
         qhww==
X-Forwarded-Encrypted: i=1; AHgh+RqiBGn80Fz+JcvZwa1hFByoh1YD3G3HmJZ03WyhK3c9tLgQSMuFAhmK1j9tZZPjN3QpuHv89ppphQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSdq0s/WQgMXJ3LQuQrqr4Lf15+YP9QwNfhbVN4Cq58YKHBVA
	yfJLnJPKDsruuvgP/duyR/DY4vNJw0BWLyBWRHVk5b2ki2rbO1QTjxNE
X-Gm-Gg: AR+sD13mHC82ej+Kxm8ifjqBL04nP5hD21HMaX23+dwBYi6kBk3kHv+IbOmUWSRu2Si
	fr5sQUt24XR25MzgImAfKny/Eih2z81kWBaANDTbMfT4xVrLyd8DHVuydgn4rx9jVolixbknyuD
	RjxjyeyQ4e/FpRH+/IoLZuMgIchy0fUHIINMQj1v6Y8aFrVlTO/pS7kvmgwqD2U50iqYAPQBACR
	Nl0q6g4jGuwhqIgrr3aF0BN29xsHOzBBoB41uDNi9bRU/kZ3X/SNPuILquyDeHhrfjEzVfm/EPs
	srPgbx4ARcUprqnoyH9dAcEjNmVeWQF5gk1gEOsVivOCvuRCuLNgH558sIiZbdbu99DTqX2LqmQ
	7vvbpzq9cRj7EXbUTLN3f9PMK9I84feP3Pb6tefSTEJyqa6ksJZhbCLmiuXqjx7iDBBKNUPHUsQ
	zK
X-Received: by 2002:a05:6a20:e291:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c67dd89f02mr3753060637.34.1785038592948;
        Sat, 25 Jul 2026 21:03:12 -0700 (PDT)
Received: from gmail.com ([58.84.62.138])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm27244599eec.13.2026.07.25.21.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 21:03:12 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: intel_rapl: Fix kernel panic during PMU unbind
Date: Sun, 26 Jul 2026 09:33:03 +0530
Message-ID: <20260726040303.280299-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rapl_package_add_pmu() fails internally at perf_pmu_register(),
and rapl_pmu_update() leaves the global rapl_pmu.pmu structure
zero-initialized via memset and returns an error. But any
previously probed packages retain has_pmu = true.

When the driver is subsequently unbound or removed,
rapl_package_remove_pmu_locked() sees has_pmu == true and
unconditionally calls perf_pmu_unregister(&rapl_pmu.pmu) on the
zeroed-out structure. This attempts a list_del_rcu() on a NULL
list head, immediately causing a kernel panic.

Fix this by checking if the PMU is actually registered before
attempting to unregister it.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/intel_rapl_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 1006d183d508..22100f1ca222 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1652,7 +1652,8 @@ void rapl_package_remove_pmu_locked(struct rapl_package *rp)
 			return;
 	}
 
-	perf_pmu_unregister(&rapl_pmu.pmu);
+	if (rapl_pmu.registered)
+		perf_pmu_unregister(&rapl_pmu.pmu);
 	memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
 }
 EXPORT_SYMBOL_NS_GPL(rapl_package_remove_pmu_locked, "INTEL_RAPL");
-- 
2.43.0

