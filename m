Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457B2E542C
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551129; cv=none; b=Ri1Rr/pQwsUIuHBFJHN9FvgmaYID0D237yT6EFCWlIboOX1XfkkmkTSNTzB9ay+biphOAo5nyhCpWtQKy0znbqYyJbJlyiuQNgIFzkUrA2SCjIMlEoWHH2Cn7OvSclApJEc/R3y98Lc5+FASUYlQoMwHrq/2tlWDO2g6s6KAOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551129; c=relaxed/simple;
	bh=EsFscuq/rKHvP1kvqG1imaWa8lweNrWNs2cRDGD5fWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VIjq1vDT1EG1RZWgrxHgMYqCJmT3dmK37ZAqhIR3413VdssIwpdSauqxAohcbt7FpcgP07xMNFoZG/S4BOo+DTZS1cdpTTqflXb9PmdEP1ZFNicftRR9USc2L29bWER6Uagkr2wwCZ+jq327DF1dsOIv/841jgWhuC2O5sQ3MLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRVjZUw2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRVjZUw2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so29415215e9.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781551127; x=1782155927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce59CZ/wo8bg5tup1lsd9Jvhc+Q72pDly1/kfgJQ7Hw=;
        b=RRVjZUw2HUBXlsAGkOSzZEx4W3dbveSxKuksUSebZQ+4lGcw9fk3uwqNnQZaajZNeO
         IhAGRpaA8e7aVrCSHnCmXCFI4oV46uIiiGolfafiCkBeCje4hWB47BpPqIx/xOyHd+cH
         H0PAA2Clc0BZ3hMCVlMoLKFIoZtYVBaFnExf65db7UrDIjLpC2i/8qMDbqow1qU+aI/r
         I+8Nc2zztFLCowxuD6wB9xC13HwAJr8V6oM31sSLCrY6TuBQk61l04NmVIB0tmJgVk3h
         a8MFuD7vVnU2MxTmSLDm0IHM04SKqErCi5Ddg2g/byoVyvL+C4cSH/YHr3OzEKzZNAMB
         ItpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781551127; x=1782155927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce59CZ/wo8bg5tup1lsd9Jvhc+Q72pDly1/kfgJQ7Hw=;
        b=jl/MgOZl46LDVJXVL1LNtn/l2QmyG/bMTqv330F1p5SRYSTOxJj7nAczBPqoihZLvh
         y6EDP8xgkJ6hpowcUo1yhAdsrmMH9lzuVuIq7LsyHlTq6xfXZqLSoxf9d3WJdLKb0wy4
         VhtV8yxMkjKVr7k63KiPxYcNV74dx9WeTAqiSIzWKhEyU5reQE+9FwUFpNFNNblsOv8B
         Ld1Su/Ioc1SmE3NPI4VRPM6FclZkOaFZuKwsg8G9wgxNSF1qOJ0nOJrpqbUMKFYVG/2r
         JKUfdW1S2woLu8y/vZP28XorOpc9PGnfM+D1dd5l9DjEs1SjM5msBwScM4Qp/DeH/mgV
         BMYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mBbwNcfpVJOmetRZcDFbekm0SymYvX2X7UK7EZLnxPe1Gw2YVBmOF7TtvJvTSw4QW7wOdeRVCcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7iO+jy/I7+jZXyDSJb/Xn5OM2UBWehmcXKFA/NBIX36QGdOve
	stnBjUZWwFEBgGFLjPu4o7oJwaftsfHyyiKUe47+al0tQVUav1iGQyKH
X-Gm-Gg: Acq92OGrTxQpraZXu13wyVm7kJloHkxs6MVZkTjP8QlcdblNQPaMAEnQl7CIhS0eE8R
	hhYyoNEksdXiv29uIcZQSZ9YuX9YhCr6Y/71kCyhTPaLSoop9o0GzvRngS451vbYDnEVrUE413Z
	YBgFQOmrml3JRMH42AGkPcGeGTg4rFV1TvzhGLPqDlpCwi/2rAk9JqN8dZgT4sSLDnxG4Pqa+OZ
	vWFdxP5qGl43NUA6C0cBh3OrTvedgHiebXgNRqELzULVgyeiLOM0HPcCkTjyZIG9J68gEkuS4bA
	rB5jXAhqdaHqufniucwXqu54gW+wNcIjCD0Gvm+7ZPBS8Cnq5FY+h/nag1gCaiYe1lfz9qRprNA
	1pkvF6AZsSdtm4XzUqQA2uEQjvzLiJ5vFuM84c1T2s9Dtae11OvhDjDPmTNMrssnP6pHtTwnj7j
	gUnGVT0n/mC4Q3nw3PqnrKnuir5iXI5t8dqZ1+Bmc4Q+NBAD6El3khXifv/N2jziTP0Xq1K2jey
	w==
X-Received: by 2002:a05:600c:468e:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-4922ff8f13emr8052265e9.1.1781551125551;
        Mon, 15 Jun 2026 12:18:45 -0700 (PDT)
Received: from DESKTOP-80V9C1H (89-93-105-162.hfc.dyn.abo.bbox.fr. [89.93.105.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c35sm38248370f8f.22.2026.06.15.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:18:45 -0700 (PDT)
From: Ronan Marchal <ronanmarchal29@gmail.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ronan Marchal <ronanmarchal29@gmail.com>
Subject: [PATCH] kernel/power/swap: Use %pe to print PTR_ERR()
Date: Mon, 15 Jun 2026 21:18:32 +0200
Message-ID: <20260615191832.75923-1-ronanmarchal29@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %pe format specifier instead of %ld with PTR_ERR() to print
error pointers as a symbolic error name (e.g. -ENOMEM) instead
of a raw integer value.

Signed-off-by: Ronan Marchal <ronanmarchal29@gmail.com>
---
 kernel/power/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 2e64869bb5a0..d86a343dbdb5 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -746,7 +746,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 		data[thr].cc = crypto_alloc_acomp(hib_comp_algo, 0, CRYPTO_ALG_ASYNC);
 		if (IS_ERR_OR_NULL(data[thr].cc)) {
-			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));
+			pr_err("Could not allocate comp stream %pe\n", data[thr].cc);
 			ret = -EFAULT;
 			goto out_clean;
 		}
@@ -1250,7 +1250,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 
 		data[thr].cc = crypto_alloc_acomp(hib_comp_algo, 0, CRYPTO_ALG_ASYNC);
 		if (IS_ERR_OR_NULL(data[thr].cc)) {
-			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));
+			pr_err("Could not allocate comp stream %pe\n", data[thr].cc);
 			ret = -EFAULT;
 			goto out_clean;
 		}
-- 
2.53.0

