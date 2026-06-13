Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9E3812FB
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333918; cv=none; b=QiTtpuXBUZV6q3CbbHrHuXhhHOreJ1/rM8tvhl83ntF2sSGXugZGYxUJu2RWhwa+kLXk1wDHArvmrum8KngCOOqrSHmnuoFujaEU14KCHdmMIlCUH0KsrC1zsNatJi/WFb1GuGJCTmgfL0r61dIUVbtWk5y6IfT4Z8UMlvU+nxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333918; c=relaxed/simple;
	bh=tLGf4/Fx611dZ3uiJyqt+wb9ZRWGswCt3ouClEW4dU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9eApVWJKtBqUFXS5Kpaut//kOyuspuD0FJ4o4ISvfiG0b4EdiCjFyZhTxq/NUDGOWGaVrRCvWZCjGfq9NKk9QU+yKS4b+xzjTthRIR6CIye/4DePSZ7L+FpjkaXsGftJqrK2+WsaWs2em4PFmRkGhet0fPTPGagp+gvvD0Aq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDrAHKbS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDrAHKbS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490a76757e5so12300805e9.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333915; x=1781938715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKXNGySjUJiX6/3GllpQ7O9YCp87EzXF/WJp8p9p0Qc=;
        b=DDrAHKbSPhFe1kYr4Fr7RWEbE6SDb+Knn7PM+PApC6teQFAEXMAv+mwx49hw4z5oY+
         mQqiduUB65p14pdxJZbrvE+6C0K8ywRkJo6M638EOyflrIbFHcPeBdSCxprCOA/QehTU
         gJ3m083C67AgIDpLTKP6D5u7EgXXYnF6UTI9VYwFkA185WZg1d1f9pFqHViRrSvkFOiL
         POVrJLDovIheeY3K5igfGw8Rtzrs86/5WmNVsn6Ecqtzc9+KalghSTRjVdzsuPlGaSnC
         qs8bptfeFjktaqIaxY44h5m59wpEgkhRt3ZaeK0wzgzgrmWd3FQ/s+hspq44DYmDDTIX
         1EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333915; x=1781938715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKXNGySjUJiX6/3GllpQ7O9YCp87EzXF/WJp8p9p0Qc=;
        b=plg2dyqik2RUqw2yLFQwYSbJ5S99zpzIDe4KTXvJd/1iZ6tooW+xxZHq5KL6RrPH2V
         yFPtjGPNi8wtaVESTNpoE3Z894vxKbQ5LluyiATYNB7kI+sf3YnHMLko5PQ4/rz/8SDW
         90KSsebOMb9i1aAhXB7D3PHI8/pEZSkuKWL1i5BvoLJDQ8JQ4hXhoo+etrNSmvb3MVry
         hWdVPNH5CY8x8VoniodmnUwkn4sdKRq5gjJJaZolUPZ7BNDbNbf1Sh62pyisNTQL6mMr
         ecvenJadyvS6CdwiYslD0Eac1eRY9/bjm9Xy9aJknL6iSkVFumodIzy9hBJGiTVV/Nvr
         6IoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mOn0DXZH/+XCWusMv/IQIhKbPs0qGB2/2gXqQWUfTIhab5wURSBT5cYnNEIn/LfmfRQ7JBPatSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFdautwAeN5Y/5dlZ+K79iGc9caxU1UFYP4nQiUgdTXhGiQy9
	GqPRypHpTJUIGH470gDazw354zq6+nxIDlvW8cMbsMaVDmdKAPzgTtY6
X-Gm-Gg: Acq92OGbx/DXrJPNAYOxffGQ30u9evAqLdthBwsp3vNU/AY6EKKlefNZY7//rdSAAkz
	UFgqseGf+O5fO8Y3xEW/aPlcFpBpXwmS+f6prEdhtsnw7Epa+UWGVaKZMrmZpkJHjC5xYjQvrzH
	O8kBfy5VXI3Rb3BUW3UhbzebqYm7cW9/QZ0BGCo3dl3v2anrKbm8a0pEmaGOJEfq098axFRclRd
	1PB1PtcKa6QSUxxlljFh/6f/1XZfuFW6wfguo5CtTUW5owoIEoUIgha+1VWOjckJZoACFbHxMvm
	nBLIRpId/4/cAPEqfesZA1LUUkFQpDPDF6UwrWDFSS+uKBJutV9m4yjsYwQNgU6VyXwlz2Fsz6G
	cNMQTefPKoc8SdsxDZGb0i8GVbKTRXIpFH9B23cHCA+KpGQONN9a7D6ia8j1/n0Xbg/6Wzg4Jja
	7HleYjQyam80X/yrWPoM+Yb8LmIzfBAZt1xkOvebvKGE1xx0H8Foz5
X-Received: by 2002:a05:600c:6287:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-492200516d4mr27804035e9.8.1781333915366;
        Fri, 12 Jun 2026 23:58:35 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:34 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 4/9] accel: rocket: Reset the NPU before detaching the IOMMU on timeout
Date: Sat, 13 Jun 2026 09:01:11 +0200
Message-Id: <20260613070116.438906-5-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

On a job timeout the NPU AXI master can be left wedged with
outstanding transactions. rocket_reset() detached the IOMMU group
before resetting the hardware, so iommu_detach_group() ->
__iommu_group_set_core_domain() asked the rk_iommu to stall and wait
for the in-flight transactions to drain. They never did, the stall
request timed out (-ETIMEDOUT) and the IOMMU core WARNed:

  WARNING: drivers/iommu/iommu.c:157 __iommu_group_set_core_domain
    iommu_detach_group
    rocket_reset
    rocket_job_timedout

Assert the core reset first: it quiesces the AXI master so the
following IOMMU detach completes cleanly. Move the detach after
rocket_core_reset() and out of the job_lock (it does not touch
in_flight_job).

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833f..e25234261536b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -364,14 +364,20 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 		if (core->in_flight_job)
 			pm_runtime_put_noidle(core->dev);
 
-		iommu_detach_group(NULL, core->iommu_group);
-
 		core->in_flight_job = NULL;
 	}
 
-	/* Proceed with reset now. */
+	/*
+	 * Reset the NPU hardware before detaching the IOMMU. A timed-out job
+	 * leaves the NPU AXI master wedged; detaching the IOMMU then issues a
+	 * stall request that never drains and times out (warning in the IOMMU
+	 * core). Asserting the core reset first quiesces the master so the
+	 * detach completes cleanly.
+	 */
 	rocket_core_reset(core);
 
+	iommu_detach_group(NULL, core->iommu_group);
+
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
 
-- 
2.39.5

