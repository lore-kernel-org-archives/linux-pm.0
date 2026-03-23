Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCF386C14
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258835; cv=none; b=iFQ4/8c59avwjx2ijIO01WzysbgKouBqt7rQRvj22jsrydhTJGDdUEdynW1BdIJCS8uadGJc0cQw1GuqiISTrccDPbcgBhVaHH6O3y65hvTn1wchh8im/EtCpFB7tEWRhWv28JUBj2CY90YdJCxEFcnR7TJeOaBFSBvs3w7y5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258835; c=relaxed/simple;
	bh=InFf+pZHROpxHQ0YFMA7CyIrioqbD8SqYfZclS1XbEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW8anzNr9jhEBlbhQnWISRK4+wpFK0MjZK99s4Zxp8d7e690DEjtjWC7//LzXG/L9L9L/ta7LJ7rmAtqMqFjfYXwGEdB4fICbbHijmj7tI050FXvRpsfs4cRreAK/mDDRQ3Twr2L0i5xw3TOSShtFADNVOwB+puXzPsSqPKYNXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv3AErnj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv3AErnj"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35b9d29480aso2121008a91.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774258832; x=1774863632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecGp/dA0Yu9oZZFz93r7/hSVGYyEetqpqN5wTpj3AUI=;
        b=dv3AErnj9tHQ5on9TnKeGJeRVBtIfuJk6Mh8KSq2Wav1vNJAFl/EPoviDyb++jDlp0
         JVLcjEWrxwBb8EhXLUXCv12m2RlR4awUGChvJAqguQWKmB/aksCXrpnmU8u+k5z7VHe9
         c1PpcZ4AWb6f8mqdI3HKvyWd/dgK/rt7wtjAVpMzfMv31cwe/9l9yU9T1w3orudS9/eD
         OaCZYHdGPOhvU0QLnVyLNhPKNZbvOxrWOG7awrGnSrH+0ox5qgcU/DYylhlTMjMpnDNH
         YHp0jGtjw/fN5+siNp386/UmPxhQzPszE+AUF+RycGiL4Vd4hUafrF9icgnA4mLHUJRb
         Eo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258832; x=1774863632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecGp/dA0Yu9oZZFz93r7/hSVGYyEetqpqN5wTpj3AUI=;
        b=NTPuGl4ntomDodb9Xh74XHaYaeIR/W4ITukpCs/VqVqzaRht/vTfpw0xmnoPGhAH8C
         q6EiZNZnQZwG2mH25VYkDM+CzydDwBrq+5QuOHOfh651KN9Nmpj7T1Da+P5NZRE2biN8
         bAZnF4NebLRe9Qd36RseGCSpnwv3h4rY76XUNKJV7Y6Vi9puT7uGCmzhoDzwQD64cl0G
         k6ETXyayGj19vXCFWXKg+vK/3/bNm9sy0yYmOfCsn5IEjEu2CugjJ2kr9C3UiKcwG/Z7
         SsmcOwPktKiYe3RiNI0BMvvR/hudKySsKy4AMt9lvqqLiCj2C884bfI3Zfd8WV/TmgzF
         Tw5g==
X-Forwarded-Encrypted: i=1; AJvYcCULLEFHO6dh55SObTReKSejI2WqxM3bIBp3x2ivQ0+wbQANPHMi0WMgAUgxv0kra4eFGSbXTBUzaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hqDrMpv9bTyC7q/I16ERjefnAMpQfdcDBWDDyH2liHvvw38l
	hSDMZSxP7auONbMBGbiAPzvYcCZaV1ENYk9pB+0VroNYqJSX/pE0yU2Y
X-Gm-Gg: ATEYQzw/heQ1wlyEyMOC9Jj21zInItuU5eJ1yNiQYpSaI1s0tMIbkGkw/4BENqFRoZm
	avimwoWzv7PDC7EvOIgJbSHq3tzYYwf9KMCxwifbpMkyyOW1g+iJ7Ubo1PbrNw5BJJEx8gjH+jR
	T0CGSRV2/s+3CYv947wmOIbzGV/VXu/dd6u8sT9IYNh7uP8b8VAxzNO6A64+rw7ICvalaqXd6SV
	jDfVfBZcAyrvzx9O2WlBHVUDoAo/mW+7f+gDA5JWx2Qg7Vlkao0KJgvhtwGLlm0g+sA9IPeNhSE
	xmElr9OOPwkdtU9rhjx9Y8EoNBKz//JpImYpyVd7pz/aB0Tmbx/hehnoJ1sobgyE2H1spTBUqvH
	OARIsjDnkYlIG1GDNAJ4nZ1Q+h+5fOzC4kB+NHpWKNlDf8srGM62pa21LspLqShg8D9wxJBF6LE
	RvINJ9N2ksH1z0E7ZJXA2FVc75oA==
X-Received: by 2002:a17:903:3890:b0:2b0:6638:b357 with SMTP id d9443c01a7336-2b0826c751dmr118483915ad.11.1774258832443;
        Mon, 23 Mar 2026 02:40:32 -0700 (PDT)
Received: from ubuntu.. ([152.58.131.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08351675esm131984965ad.14.2026.03.23.02.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:40:32 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] thermal: devfreq_cooling: avoid unnecessary kfree of freq_table
Date: Mon, 23 Mar 2026 09:40:18 +0000
Message-ID: <20260323094018.2264-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dfc->freq_table is only allocated in the non-EM path via
devfreq_cooling_gen_tables(). In the EM path, it remains NULL.

Avoid calling kfree() unnecessarily when freq_table was never allocated.

This resolves a Smatch warning:
calling kfree() when 'dfc->freq_table' is always NULL.

Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
 drivers/thermal/devfreq_cooling.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 597e86d16a4e..1c7dffc8d45f 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -472,7 +472,8 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 remove_qos_req:
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
 free_table:
-	kfree(dfc->freq_table);
+	if (!dfc->em_pd)
+		kfree(dfc->freq_table);
 free_dfc:
 	kfree(dfc);
 
-- 
2.43.0

