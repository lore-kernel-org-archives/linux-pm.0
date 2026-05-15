Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142193E16B2
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870588; cv=none; b=hPpkiNI2UhG7QKkhLZp29yzaTYnd3BECPVeJdkkZb9XRProIB+a8ugSQ4l66bXuBKCsbTqZdSO+gKK3vP4efK+8yatBeezUFOkqkbOwJVbVkBY7Y7xSmyEQBqUjhTYFAB3lAIL08UCgxJl15JPeB1+F8tO8it84TPtvhYUegRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870588; c=relaxed/simple;
	bh=QH9FJvwVzG3kwhmgx+COL9mP2nHm1UlLgbekHxUB6dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GM8g8u0UvVRkud49QsPMELPoUwzoygLjhYflZQBgnVlA7BizJD/rQaii6vnlDU0KyDEh3E2Qmhkva1J8wdp4drIbmOjWr4X7r14aJytZV3QWW4SNuOFIKVd1Sm1amkUkoset1RUEW3XFStkHsgFPb1y4UY61KMjwQA1Kh4oyymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX6CAtpp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX6CAtpp"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so57880a91.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778870584; x=1779475384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx+lhp6XxON2YOyCdm1ChngOqSePZVBarBxt/yXA8c8=;
        b=TX6CAtppauCYGpQNbOcCyrwgBiWs3/VypzNOssPTKX9/O1Rc4N2kJ4esBNwrQmK4ee
         san7jdd5ryGMcMoinsNzXvZCmlfSKZc+B+BsX6goYSYmTPC2TiYK8UeKYJi7BkGDiKW9
         dCjkOOvQidyvtX1Wh30xJoqM0ioUmmYLlzdbsdMymCYcC7Y4rcWaTNRRNi5o0NxR9RFb
         TUzBS/97VEVSihPZuH5isQnwesyb4QkI83RS8C91zobabaLhBcq8SV7mBUzlquqk9x/7
         pDqLCDgBbGtxB05Tn0yRj/apA/r5z2O5X4HXLu7Z81lNsXtUbqicmaRlTflL2OknhlGw
         A04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778870584; x=1779475384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vx+lhp6XxON2YOyCdm1ChngOqSePZVBarBxt/yXA8c8=;
        b=nO7b0JsUvY7Nvhew/9Hk1J5ImNKyXqhdEeBpfyE96XyST2QKzqYCn9IOTRP+KS1R2N
         eol+67DucAgzhmPbxBChWdcCkqGSB7QOp7YNWKDaYvGM9cFjkSd09Ydes2uWRquktdXA
         lT6JJ+aE0NyImFmx1oA7roBD15REaBWM5V13OEeaaNme/aqcGAlM25v7fezLmIRZwHvJ
         sg0QoZWBJOZiRGOk5AB9tsQ8kxzk5JeYMbtdxGBlBoeLwGgA7RIj2maNGmi3n2jFDecA
         ZLE7oz347k8o6BRQaAy0THyn2gYjFjcKt3wtGIFZj6MWo1lH8mcXuYCvXmVtn57aI9Zq
         FfHw==
X-Forwarded-Encrypted: i=1; AFNElJ/fYb2PheqPZXrQFUOIYCKW1HHFUa86mXMVlquCf0vogYPXSo+iqe7z0FwBHadIomB0SvG6yNigQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnkq587/p0C9KogZu2qQMGi0rCEmzmk3nkpZB8PMZYcbVRTIt3
	4UTMDTEaviW6UcrTuMMK2j9gPOj2q7i9bdUfSGgkjzQWvRLdjdmgktsH
X-Gm-Gg: Acq92OFI7mX0VxpmSIrExTt3fu/o0LEUKNQnvjX+H1UEqJsf+sO6uhpWAS+vBU9TDJU
	Bq3F/SzzqD51vBblPKqXcJRZ+Jxaj0CyY/Vla8V5yuPJOGeVxkXtkVTG5dloHMvimPdSRRbdH/D
	29viRjGYTAzsh3fsV7KKTb3cu+sQFBkP7B0jAJ6dcIjy8xj/LT9VetgqGiKQIztylwlhLbcSqFU
	3VKCfPrIqCX+3rkd/B+4KUykOgQQl2ve+hRYfDQ3QxC6Dk0GxPruoQcoE6ZUrBQXKmtr9a8ZA27
	qbSMDREe67OJfXKuqpi89fAX3Wz34N25NfN6x/WzK45jxRZM4CN6QW33dNZKQuYeKOSIjL3Yxg4
	fozly7ZyuUHQzLO/kcHUM/hyeX2X7pFo8SxIeSIYYeZYXUQ9fIV5qdFgSBuWyKPCri3JpVQGOSP
	3HyoGziwcRW+g5NV3tlpCJQ2fSSyvCq7qE
X-Received: by 2002:a17:90b:5788:b0:368:4cb2:17b8 with SMTP id 98e67ed59e1d1-36951b9ad6amr5283785a91.21.1778870583733;
        Fri, 15 May 2026 11:43:03 -0700 (PDT)
Received: from gmail.com ([58.84.60.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695155a0d7sm3315930a91.2.2026.05.15.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:43:03 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: intel_rapl_tpmi: Handle PMU registration failure during probe
Date: Sat, 16 May 2026 00:12:50 +0530
Message-ID: <20260515184250.228062-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_rapl_tpmi_probe() invokes rapl_package_add_pmu() but it ignores
the return value, so a PMU registration failure may leave the driver
reporting probe success despite the PMU being absent, with no log
trace. Worse case scenario, the previously-added RAPL package would
not be torn down.

Add check for the return value, log the failure, undo the package
addition with rapl_remove_package() and fail the probe.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 7f41491d9cd1..8bc95310b542 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -414,7 +414,14 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 		goto err;
 	}
 
-	rapl_package_add_pmu(trp->rp);
+	ret = rapl_package_add_pmu(trp->rp);
+	if (ret) {
+		dev_err(&auxdev->dev, "Failed to add RAPL PMU for Package%d, %d\n",
+			info->package_id, ret);
+		rapl_remove_package(trp->rp);
+		trp->rp = NULL;
+		goto err;
+	}
 
 	auxiliary_set_drvdata(auxdev, trp);
 
-- 
2.43.0

