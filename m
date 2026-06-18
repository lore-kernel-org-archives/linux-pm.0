Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E7286425
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788929; cv=none; b=e0Or0E/Ed0WpiIC1A+Dx8TTsqCZd9F9gkqES77OtfOtlBQAjIt/YHJvVlLqE0wejEZBnFD3pETSe7oELsNrixOFIG91sHJcQQbsr02Hkb/QiRV+cxNfcoS6+vjZibThY9gjOnb9U//FWrZu0LX/kxB8P/DSMIseaKxcW4VFuUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788929; c=relaxed/simple;
	bh=BGIMdY+BpmmjmZ4TIdEoyEkva2q/zTGScjhkoDDsMe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkb8aGAtkMiYQz+5aVBh7y0Q1o/iaxoO1dvfUPUb/aJGZUvqYtdkSNSL6oU5b+gti8LKjcgfTARwkHOtfrYYdy/wD0bPHXeUKqNA6ubI0ApOXR3BcUA9oOxQw6Fjdxh66tJEQKPIODf6xyen2kEYfKSlXB9D0DmTETwllszkvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkJhtYhv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkJhtYhv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6c57c5c07so6950825ad.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781788927; x=1782393727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XVvHbJqdZHb/4cb/FwFwMm/ZDveL4XIpgo7MfE2NUc=;
        b=QkJhtYhvd21GQfklg338uR9nuAPtl/rISvA2ccdaIsxezaRzyxyVIe/wdtB4EAhDuF
         MpNw/Jr/0YZJHLO42dzA1JCJw7qn99hkOM0HW7QVWp3hZ+pg1ZbF6mHPM54A4Wy9lm1F
         ve5WFwzawBVBdSGKRHzmK5dQJD+fh/252AUwvrdmToT8nmTrZEUzjqDczlzaht2k8NPT
         tKOY09eCB9Lv32HUpBSI958Qz5uffNxtJFsNT2K48SiiStYQrG2iCMmfy8baPIC5LRQN
         mJkHATdGjnmRTbe402Q+ufp3bW2kanvB+N4riXO5OddFjfPIjtjclSsDm/SK/pF4nPij
         mBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788927; x=1782393727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XVvHbJqdZHb/4cb/FwFwMm/ZDveL4XIpgo7MfE2NUc=;
        b=EBzXXqtsZPnlDncW/lIbnRvPHxp6PQRtODVq9RBdAEbo1Anqx/f3qjq/Og9V/CCPBO
         gUI7k4cuNBFUerekPtygMp6+tdkddi1/i9SBiiMGhBQg3kIdHgzpuQjEobchiz0KF69Q
         l3WmwS8micO97fA14dUp4ufFIRWC9baPFnT4MJxQAfkCxJ4qgHFRIilbve4iHWDZrQ7R
         Y3bDME8xaxIW7pQTTqm8cb/CouzVwXMTi3A2uDqod7fZThwCUQYz+SdNIGijv6ftRrgE
         F3FodD2pLGPs1hjNKUPSUii7wewGys7b14S7DrLK6QBct9FFVNIiQVMqY1xgGdC8B8Sc
         zAaA==
X-Gm-Message-State: AOJu0YykwF8mtX3Rj02/IS3pOLG8Tgp8C/bqertq8lsHKn520sMLnC29
	+Y+jsRvi/42dG68XDbJsZIpw21yFsnTgUUrWoO4psinHAxvGcx+NXOfp
X-Gm-Gg: AfdE7cl69IkG+duft7B3RlLNrU4Ud58YqHYdfVNFcPpj0IJ/Y/p8FgQTL31xCfpo69S
	PKmk5dNyzbY8CEF8I65kZB5qqglm2Zw9oOVhW6d6vqq132v/2vXpAXLduD5HSK62k3YaEB7y319
	WUozo32kQ6VKcsDJ4XzJVYzp98s+OCZ9M5l+Tsljji9W8lgxQzUZj0hz2Jkcl6RAWJuoLdRY4oN
	yE+1n/Y62ITK8hfVSVau6MlVeKDMTPlHoUJ+GYnuffxANGrxp4j0kOI40dtzb7M6r1J2F7XXgYD
	Orl1NrCyXPjyHHPlU4vjptDvJ4nXXrDD1fEtxufh34vhkuZofIqh3KJXAmOxmVZsKyczeCiwzlZ
	ibwl+p3SvN4q0P87/53FBVo71W4rP9ivM4wmKFkViaPj8area7Rifkzu3qPZOkLm7uNoH9GJwEh
	/zMvaq2Z7lZw+z5fSD24WH+kybtGiAUvqKOnNn4EZ8
X-Received: by 2002:a17:903:2a83:b0:2c6:9758:9db2 with SMTP id d9443c01a7336-2c6bbf8d3a0mr98050185ad.3.1781788927499;
        Thu, 18 Jun 2026 06:22:07 -0700 (PDT)
Received: from steellegend.taila75641.ts.net ([2401:4900:1c19:e45:6f99:fe25:8bbb:3a22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5876sm202442795ad.8.2026.06.18.06.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:22:06 -0700 (PDT)
From: Uday Khare <udaykhare77@gmail.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Uday Khare <udaykhare77@gmail.com>
Subject: [PATCH 3/4] power: supply: rk817: Fix battery info memory leak on error paths
Date: Thu, 18 Jun 2026 18:51:51 +0530
Message-ID: <20260618132151.11227-1-udaykhare77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rk817_charger_probe(), power_supply_get_battery_info() is called to
retrieve battery info. However, if the sanity check for required battery
properties fails, or if rk817_battery_init() returns an error, the
function returns immediately without calling
power_supply_put_battery_info() to release the allocated battery info
structure, causing a memory leak.

Fix this by introducing an error label 'err_put_bat_info' that calls
power_supply_put_battery_info() before returning the error code, and
jumping to it from both error paths.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Signed-off-by: Uday Khare <udaykhare77@gmail.com>
---
 drivers/power/supply/rk817_charger.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 9436c6bbf51f..a2ca2b46b2f2 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1156,8 +1156,10 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	    (bat_info->constant_charge_voltage_max_uv <= 0) ||
 	    (bat_info->constant_charge_current_max_ua <= 0) ||
 	    (bat_info->charge_term_current_ua <= 0)) {
-		return dev_err_probe(dev, -EINVAL,
-				     "Required bat info missing or invalid\n");
+		dev_err_probe(dev, -EINVAL,
+			      "Required bat info missing or invalid\n");
+		ret = -EINVAL;
+		goto err_put_bat_info;
 	}
 
 	charger->bat_charge_full_design_uah = bat_info->charge_full_design_uah;
@@ -1170,7 +1172,7 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	 */
 	ret = rk817_battery_init(charger, bat_info);
 	if (ret)
-		return ret;
+		goto err_put_bat_info;
 
 	power_supply_put_battery_info(charger->bat_ps, bat_info);
 
@@ -1209,6 +1211,10 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	mod_delayed_work(system_percpu_wq, &charger->work, 0);
 
 	return 0;
+
+err_put_bat_info:
+	power_supply_put_battery_info(charger->bat_ps, bat_info);
+	return ret;
 }
 
 static int __maybe_unused rk817_suspend(struct device *dev)
-- 
2.54.0

