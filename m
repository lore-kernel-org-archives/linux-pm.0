Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773A3D5C31
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245547; cv=none; b=Z659EhGhFXVLC+LrWgCvHvLt8sn6LLXV4ukFvb/BymcPPfQxmg+OkPMl02vgtfpzkCYxn3Xs7yDYN1VFFJdh68+oOSKb22RhK3o5/+0v4LhcU8gRupIeMTFMMQM70VHmpHuJXI1L14uQst9MzKp27lYhSldPF1pwOxaN/gqfJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245547; c=relaxed/simple;
	bh=9zRTwh/oT7OfPuLBs7JpNpjtDyvkA9KMNxzdFUbclY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bol01yyRZSJmz/6BWOLl/vkfTvniAON/PdJ2woNAYa7lFlAhSCqeaAcbGbHNLnHYzlVBhT2/n66nfTOk3wbjmaMvGwP916ucBgomI5mjyL5TBJdx5whnLZp/TtFHuZSeh720KtSKNdZFyZmVlNHALaemk8l5vD1kvBAWt1kTAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJYT7UM1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJYT7UM1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso4290565e9.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781245544; x=1781850344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea+G8aT+A4yVDP0/fjfLMx1jjQZCCBPqq+kDDC4wMTQ=;
        b=gJYT7UM1L9Dc483POZ3sT+zWmTT4l3AQYLkiAII6K3326lESLI/MpqpTEroCf6XEbk
         DUjgQkkwqQB78P0Kgj9Il/2PJR9qyRRBe2Tsxto6jOavL7KAplr4ZRiC4kAfZ9tJPMCv
         Z0neEyQSqG9oXNdfuYQ4VhnA83eV9MsO4XMwYYObNGNbr2SCi+S/9Arex8oWK6bH6lq3
         qDbkuw+CLrH+DOgSeUUr5XGRE9j5gv+lVPuQoNLt0/dnXG2d3p4RmMS9zyMfFHSiY5VO
         R8opGaGR0JbAzoWqGcpvKKO2zxSuc36emtH6onnl/huQeltLoQf1R8vzYYTQd77F3HWx
         iVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245544; x=1781850344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ea+G8aT+A4yVDP0/fjfLMx1jjQZCCBPqq+kDDC4wMTQ=;
        b=XXXm7NlFWfCxkUXZZtJMNh91LmlCuSmNSvaHtwGNq0EA2ga30E4BIN6a6hpAnXGYQs
         KsGX3+6Ptp/Vr4Idcbf9Ez91xOCb/xd45JmkOT3Pah4yYcUKvO9MAIyV07bwlvxEhNRX
         i0oGEae11/5CZSrBDjTQDg6ornv2GH21wT3EySkbZJyD3FmMel17IFfYvYwKWInnSfKC
         ku6Yml+otWUIX5fa4f0HP2WIFY/hXSDdb/cSDxmHZ7x0fnMteKXd1AYP5tTi3nlggQph
         Y2Y35kD5ahCj/8wDY41V1tw8OB3Rb+GM4B0ze5ts+/DtGEG5hiITRwC7o4oHq9j6pYkn
         lLlA==
X-Gm-Message-State: AOJu0YxDLl56tkRy+RwfUHigLI00Yby5+ku0m988FYXbtJ0EuxcKcHM0
	9z1XwSmppEFfMZtZqxz4gwOsc/lS+4f91KtMFwhntLbfcFBGBOELJBrOhsbiGacc8Nc=
X-Gm-Gg: Acq92OHWuP1uo9bQlsVHpGzk4vFCsaKyQPZxSaV8MywfmValfdtvIowFp1wWc2om2RQ
	kXw7qQYH3rZIQ3NAQEZlkhuEDfCKuiDvZca8XPUf2Eg+4OsIMCNfSSTPXoTe0NSPans1OXsgD+8
	EN0Q9p95542F2uHw44evHvmC2h+5Gu2865Yah2cd3jZoJefuiYsF4ajiKnu/qhENjYgd6jN9gfz
	sOWzngDkjrDDBzBaFOfp7BCJnytzb0Ep7ckTvBmIWqA36broAbhhOZ5T/ZrZDU2+I/k1rm3wCSA
	yN5zD1A2kLsmJhtOYXLXCS4exTjCMNauishqGeGuTCItQenlHR8TfOcbXjGDRWWsSHalJmhhVmW
	O7/ofF9Z78MUisrPYUZey575zjIqUyT4xOE+4ydN9i9vU8DaJ3GWUlv+RG35Af9vzV+oTV2i6Xx
	nSDiRz/RoLMN2NeyfukhuJofknAKBK03tHFgY64DAOvPwAKRw4oCuS9wB8BK3EkF5x3fT6VF5Dw
	LeCBqX0BX/Kj205GyPDt6dLrx4AC9dmCZBPxHUulcu05Q==
X-Received: by 2002:a05:600c:3548:b0:490:e196:e8e3 with SMTP id 5b1f17b1804b1-490ec501a29mr15344375e9.18.1781245543525;
        Thu, 11 Jun 2026 23:25:43 -0700 (PDT)
Received: from MBP-Elazar-Leibovich.civet-hops.ts.net (bzq-85-130-200-168.static-ip.bezeqint.net. [85.130.200.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83d8dasm52501375e9.11.2026.06.11.23.25.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 23:25:42 -0700 (PDT)
From: Elazar Leibovich <elazarl@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org,
	Sivan Zohar-Kotzer <sivany32@gmail.com>,
	Elazar Leibovich <elazarl@gmail.com>
Subject: [PATCH 2/2] powercap: dtpm_devfreq: Fix out-of-bounds read in set_pd_power_limit()
Date: Fri, 12 Jun 2026 09:25:36 +0300
Message-ID: <20260612062536.9147-3-elazarl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612062536.9147-1-elazarl@gmail.com>
References: <20260612062536.9147-1-elazarl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sivan Zohar-Kotzer <sivany32@gmail.com>

The loop in set_pd_power_limit() looks for the first perf state whose
power exceeds the requested limit, then uses table[i - 1]. If the very
first perf state already exceeds the limit, the loop breaks at i == 0
and table[-1] is read out of bounds.

The powercap core clamps the requested limit to dtpm->power_min, but
power_min is only captured by update_pd_power_uw() at setup time. If
the energy model table is updated at runtime via
em_dev_update_perf_domain() and the power of the lowest perf state
grows past the stale power_min, the clamped limit can still be below
table[0].power, making the underflow reachable.

Start the scan at index 1 so the lowest perf state is used as the
fallback when even it exceeds the requested limit.

Fixes: e44655617317 ("powercap/drivers/dtpm: Add dtpm devfreq with energy model support")
Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
Co-developed-by: Elazar Leibovich <elazarl@gmail.com>
Signed-off-by: Elazar Leibovich <elazarl@gmail.com>
---
 drivers/powercap/dtpm_devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index cf16e2756481..1afaae234c01 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -68,7 +68,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
 	rcu_read_lock();
 	table = em_perf_state_from_pd(pd);
-	for (i = 0; i < pd->nr_perf_states; i++) {
+	for (i = 1; i < pd->nr_perf_states; i++) {
 		if (table[i].power > power_limit)
 			break;
 	}
-- 
2.50.1 (Apple Git-155)

