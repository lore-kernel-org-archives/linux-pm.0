Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2818CBE1
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306196; cv=none; b=TjWrLpnu7gLIZrLT1atJ/AKv4yJLOt5U57flQ+95PItv36pq72jNx0Z1n+aYIS5Jyhc59KVZCeJPKI84aDI4F1JRtaQRF+m2Lp+0rawHK/4FkSLJwLyBH5Lp3wi55ByfL2ekSNuOj4przS6xgN9xhG5eeyOtnLoELajWWElZE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306196; c=relaxed/simple;
	bh=4wmUG9+jETW1+KM0ZXFsMsDz7lw3gBvAJtfCC3yXuug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tXaRpKa5H+PeGcEXS31Qhs+XQiV//PCiQHG0187oGjQpLfKHgqC0XAfGScJHLuh9a0ReYs+H1f4VHONjGXFcFdT1xh+p/mVkasAK6E5wwDOOXZICZ/z5z5gFf95yXkgbbBekk7qfnAVJjo83IdTkl+S7ppZIPmcwJ749TkulPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPenzY8G; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPenzY8G"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so1728418a12.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782306194; x=1782910994; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqbffuHROsrMfivcmxl/a0WRNEEypXicIfc5X1ORIW4=;
        b=TPenzY8G603F2SfksgutFmXYP8R0NY6G/BLUwo5OsLTTpwrkAnUD5pFaGsGcH5cy6p
         kh2lanK3JMuqDY5qK8Lg9K/Iccff7GNX2kKqGMC8onUe0KR3yrv+S506z0eur199+9ZN
         tU4xcJXuQVakabMkXAEd9F30kAZ7QsXBojikXUi+aFQSdqlfjoVCygPbk/sKXNPCoaOU
         fgKbS/BUbOs0itTRvXBnPIlaNkWQUB5Gp2KPb6fzKtX522bzT2mzd5a80BOmhiHQ3asO
         KlYgLtjN8QUeAEqYuFjWu+rSbhoE4sqJxkx3uxYeLZmNJyx0eeFBLLbZSSbRxigQXLPf
         sW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782306194; x=1782910994;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqbffuHROsrMfivcmxl/a0WRNEEypXicIfc5X1ORIW4=;
        b=M9GcpXhnaw4sXhbmBUnYFtTsHSUchYRNaN/a1lrUx3sCJiX9c0hGj087k7+btiU61B
         J1P444SOgw4XWOtKG98XzPTAV0vjYsah7ijZy0csr3yGXCJJlRp4MWToCC9e0vt4s2Mx
         YCuF+nj9gbiUcOEFTqFGl2QRbS2wU6DwO3wDCSqnRxQFJ2QAdb7bs/W3WdWB5MzeXqku
         Q+UF6u2hhrJQnDnaBld8wG2RRyO0oH/B6zbkLWOMyVNcjsaxyz8b2CR59zVpHQQTjcvw
         jEg/vidEFrnHLxFi0f69G9x+SnAwU6rQt7rpR6mT0Gj6OlijOU8gO98B4JqPl4cRBMw3
         henQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QJ68EN2wnUqDpiVw85HlctkhM9GVl+JihXZy33GfCCB9B0LkaDplqMUqgwvWuBXRz4d+iRVIO/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0GxPWiGAs1i/W5Dpt2IIjzdsAtqx6MIdlTiIgYF/CfrhwqPF
	ZK2ZqiyO127rJCHAsVbsDuu2SRemBWhoKSh0S+4p1C5ECEIgvVhSkGe2
X-Gm-Gg: AfdE7clScjiWuyVFqCF6DhiTIt2vBfYoa73GMWgouNktyjEBI43PqqR2HGiToY79FPL
	gWvCnyqrPgt1nrjpshKlo+I35Tsh/DcTRwlx+bR+vU3zGTThrD44xnP401UQ4lwGnN3VO9UxTXR
	I1bMgz1v4sZnMZ5ka33ExLhw3LJkiyHetnXXsMQKJa2eyTIhuMJoa8weOwMtyx0YOm79QRTN/SW
	kvvM73v7ykf+0TcUWj5ZzCYVZzpREaO9HosU9iaJ+aK6XvhCZGtazSzPPbEjfkI3EgBckjArVBK
	f5Kyt5NaKKUVHFouLp2y26jnoQm6KnqJc1DlLsA2JSxdCMFHoHCPmxbblQuXZSAX+f+1o9FAxO8
	bCK2B8D8Ib+0PRpH00y/R5CmsPC7Bq4BUJJnmxobNFdW/pOY7ucwOuQs6nTEtTT2eSLQbCXdDg1
	qlLSp9fU4g
X-Received: by 2002:a17:906:2081:b0:c11:f023:8414 with SMTP id a640c23a62f3a-c11f0238ac8mr89463366b.22.1782306193376;
        Wed, 24 Jun 2026 06:03:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e497e7dsm651298766b.5.2026.06.24.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:03:12 -0700 (PDT)
Date: Wed, 24 Jun 2026 16:02:53 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] thermal/drivers/rcar: fix error checking in probe()
Message-ID: <ajvVfSusxZfjNxVN@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code accidentally calls thermal_zone_device_enable() before checking
whether thermal_zone_device_register_with_trips() failed.  Move the call
until later to avoid an error pointer dereference of "priv->zone".

The driver works differently depending on if we are using OF thermal or
not.  We use thermal_add_hwmon_sysfs() if we are using OF thermal and
call thermal_zone_device_enable() if not.

Moving the thermal_zone_device_enable() call is a bit cleaner as well.
The original code used a three step process to cleanup:
1. Call thermal_zone_device_unregister() to cleanup.
2. Set priv->zone to an error pointer to preserve the error code.
3. Set priv->zone to NULL to avoid a second call to
   thermal_zone_device_unregister() in the rcar_thermal_remove()
   function.

Now we can just do a direct goto error_unregister and rcar_thermal_remove()
handles the cleanup properly.

Fixes: bbcf90c0646a ("thermal: Explicitly enable non-changing thermal zone devices")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2: Use the correct fixes tag and re-write the check in a cleaner way.

 drivers/thermal/renesas/rcar_thermal.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index 6e5dcac5d47a..f8865b03ed23 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -492,12 +492,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 				"rcar_thermal", trips, ARRAY_SIZE(trips), priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
-
-			ret = thermal_zone_device_enable(priv->zone);
-			if (ret) {
-				thermal_zone_device_unregister(priv->zone);
-				priv->zone = ERR_PTR(ret);
-			}
 		}
 		if (IS_ERR(priv->zone)) {
 			dev_err(dev, "can't register thermal zone\n");
@@ -510,6 +504,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			ret = thermal_add_hwmon_sysfs(priv->zone);
 			if (ret)
 				goto error_unregister;
+		} else {
+			ret = thermal_zone_device_enable(priv->zone);
+			if (ret)
+				goto error_unregister;
 		}
 
 		rcar_thermal_irq_enable(priv);
-- 
2.53.0

