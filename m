Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B45378806
	for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784451078; cv=none; b=btxep/Oiks3XwBdCv0zT5CK2arHOAYLeDiT2p69XzXJGDWYv6FPYJfOaxRjcJ5eeWBMmOEQSI62G9rZFRV7nit+9uIqUe0TUTr0ncFuUiNs0p2PJuXOgyFLv/3aN/2vadV3UXYgXDE1QQuzsPaIp7cxhAzdU+7nWPTod/QA9u0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784451078; c=relaxed/simple;
	bh=ULkEzKgd3xGiRR2agZhshXQt8AHLqFg8bpQwn0FoXq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/6okuCOPmUzpdRyi5G5hx+sqX0SKZZrQ2I+nYzO38cLljFwRe239lcRHRRwPc5D9gzSzjbb3F0mvbjNtgKB0Eqgjayubt/LwTpi75r2kUbHVMmphxGCul31SjPmFDoV4PAYzhmmCh2wQgZNm/Cy5efy8IuVh4UUnpRn8WIOG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTonoDYW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTonoDYW"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so7184537a12.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2026 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784451074; x=1785055874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6gIhz0RnnzBJMwFWCdOqu4dcEl507nyEs5TW2S/nD58=;
        b=MTonoDYWs0hSjiMBZe1m4iCiDy9sA634BIn6uhDllQz9Kvmkqj3IzP66S0BeUwUl7F
         IZbNTLQZw+dRJxkABlYRMtkyW3R8v8IgBe6XuwmL7QPc7SxOxJqXWSEjWGC2s3TFmBEv
         9VAZjlmW41cbvTQTcTHIsMTGgPwbrJS3PiSM0CuAFgIH9Tc4MiUQmnnYJ66GWQoK5XZ0
         4jmW14b09ZVcGCahFWHQHL0tSVsJev0o/vQi0VoNOy0U9DRmpsTm2UrxKyEDc7LbZmPL
         meMldsbaGBEVaHpUVS3/v5gm1HC7DKfL8MpfmapUq0s9V2VnQPTSR6jRWB/JcIgKodRB
         Z0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784451074; x=1785055874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gIhz0RnnzBJMwFWCdOqu4dcEl507nyEs5TW2S/nD58=;
        b=CX6EBqgcg4DJCkrDWRcKcZ3oL9bRo8WAmq44pzpfzKDZZXW54qtz8wm+wyx4E1uA4s
         CQJmFnhoP+WloxB6AtQj4tVhxmPJLg6WD/jS0JLnXBN+kapMxPJzrrBKSmqxmGQbK9DQ
         ah1Byyvad45wnPRC/D7m6dBhTGo10RswBvtyY6CT6xQk3iodbEQ01wkDLN/ku/NRZ3MU
         wiOoRI8hdsdpLtjpNd3s28OtL9N+dQoJIX3rdT9gVMx058zHFljiFRM9FHjYW8p6jYfc
         2zDYq6zoxYlD9cIH6+dlvRNlTQR+6ttqEhIKnWrfxwpzp5Pvq7LwHzhf08di/egwo+yu
         /TVw==
X-Forwarded-Encrypted: i=1; AHgh+RqiMSCclqqa5PMf0gJAUrjyj0fdnaHbtFm2ckCR5z6E5CtxrbzLX0gWoZgiM7VmyzrnRlI1NuDEMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZqEll1w2ZBSHQ9At9s9EW9+V/xhO3urzdkEUr9ongATymCV7s
	aHpWgjH/ljFXJ4N95tVzFjFb/gXK+nyiIUwYPzoRhePxX5lkQyqRASmH
X-Gm-Gg: AfdE7ckB5CBneudQTfh7Vu0vsxd8NwtJmzrerK0dW+mIinTq4oLkW82NIDzJ8UFR0M6
	kWtaOsPockwnJ6CHYZBeEhe3LhbSWFRE7GtlkjmBw3Wd+cDLDoUObbg5l9uzTpNaCqYr9sBHbKv
	H/emWPywCPKDXiJRAj9Wr2iy9EfGNvNVVET/EUFkdcQlbkhaj2GBAk/tWFnbx2B3iy3odzm2mtS
	XZA9ZlowcJz8/Kn3aCMzUdY+azw4e40ai240RCC8PP8V4kftfhAHmLYauwMVRI7Qu1dUD/991wg
	Mq2dKw+hCiDB7KLfJVSJTfw/fQ5qVO7+M1+mJAxL75UoD5nu3IJqjeGjOjBPuix3TGKmRKXkOAU
	uHDbBPFH26OOlPn063nJa0HUEB8wl5pSec0JzV0V+HMYtvpEMfwJVLhOrHziGBdnoXpb38HDeCm
	lLwXVI/cP+e3A=
X-Received: by 2002:a05:6a21:1506:b0:3c3:9a7f:7309 with SMTP id adf61e73a8af0-3c3ad6779d4mr10584459637.26.1784451074509;
        Sun, 19 Jul 2026 01:51:14 -0700 (PDT)
Received: from gmail.com ([58.84.62.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d444sm28544079eec.6.2026.07.19.01.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 01:51:14 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH v2] powercap: intel_rapl_tpmi: Handle PMU registration failure during probe
Date: Sun, 19 Jul 2026 14:20:59 +0530
Message-ID: <20260719085100.145555-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_rapl_tpmi_probe() invokes rapl_package_add_pmu() but ignores
its return value, so a PMU registration failure would leave the driver
reporting probe success despite the PMU being absent, with no log
trace.

Since PMU registration is an optional auxiliary feature for perf energy
counters, its failure should not break the primary powercap functionality.
Check the return value and log a warning to ensure graceful degradation.

Fixes: 963a9ad3c589 ("powercap: intel_rapl_tpmi: Enable PMU support")
Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
v1->v2: 
  * Since PMU registration is an optional auxiliary feature here,
    treat it's failure as a non fatal error and log a warning
    and continue, similar to other RAPL drivers like intel_rapl_msr,
    to ensure graceful degradation (Based on Sashiko feedback:
    https://sashiko.dev/#/patchset/20260515184250.228062-1-sumeet4linux%40gmail.com)
  * Add Fixes tag in changelog.
---
 drivers/powercap/intel_rapl_tpmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 7f41491d9cd1..078a85158ce4 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -414,7 +414,10 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 		goto err;
 	}
 
-	rapl_package_add_pmu(trp->rp);
+	ret = rapl_package_add_pmu(trp->rp);
+	if (ret)
+		dev_warn(&auxdev->dev, "Failed to add RAPL PMU for Package%d, %ld\n",
+			info->package_id, ret);
 
 	auxiliary_set_drvdata(auxdev, trp);
 
-- 
2.43.0

