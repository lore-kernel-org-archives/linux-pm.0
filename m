Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A32DF137
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161438; cv=none; b=hkeFGMOJnzUc5umjUxuPLkaL5SRpv26+2qTnqOii00T8Yb/td3Yzgz8Wzwc1pUmcYkLz5IIOpmRUipQ1UURDej4QbXM5zb78DyctICe7Qr5zKpyVAQMP/pX3jooB+0fmCwioB3pfoXH4+mJyjFgU45krJF2x6IriDniI9Bv8W5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161438; c=relaxed/simple;
	bh=2B1kl82sYmAxF1gcvXNtWp/v9p548DwYxTPqP/ibams=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZforVG6nn2GFkCmrxwRDTU+0KsZLRIhal5xbTuE2a5SyvHOLZHlemYBtuHEYpp+3MRr4mgB7d27c09TD0wfD7QNd818vQ7SQi8/Imgie1SVMHOFEYdFFlI5RnLRxMnJoZbSJ7Q1wp3DRQtTbhN33VERIYVANhrFkHoXq0IUGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ceb5a39c48so11209675ad.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 00:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161434; x=1788766234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cm/3LxFAE23VmmspdwwF2dVngvqHxTwL+4Y3pEVCqwE=;
        b=P9c/X/B89cJtGibxFLBj5ex7/awfEj68WYrUV04IcaI2bVKihedvVq6W8AZzSQKoRq
         TmocCliAAyfmPepamTfiZPron19Qheli4oZsDmx+MWSgaCVq7SrjQW2f9C47dFugS3rM
         RT87cimlkw6efj8W8+euh+IBSuC44cuqvfRixObDiWDS+fLF9ADtGazwrr7QcjKCxyMT
         B+SI+BLz45NhkjAgbqFNs9LIxIeeA3moZyXceJmsXJphIYZP63Xe1PmqOEwC9tiLOnej
         cugaEHovP2a3TCy73vQcL1+lS7u+wS0FJY6d27ltYO9vAdDheqI+ARJY6L0RtkdbxpSJ
         dFXw==
X-Forwarded-Encrypted: i=1; AKwUvBwY7oIfda2B5M1OlHEuj/JfNcvd81aFeWkzxhx9lpysbuDI6jmS9WVSE3nDaCAPWXzRQKAz+f72zA==@vger.kernel.org
X-Gm-Message-State: AFuF++nWqNZFm/Y8kXeIIkHr6+UDpzQMhILAwOiOMc2HMhBDHNj6g4ES
	qDU5NE/nGB8gfJUsdl+e4SI9GjfSeuM4h1ab69OoDVdKJiJN3VKn3wIE
X-Gm-Gg: AR+sD12X4SN9yS+5hDd/qVmEub/XFF8C8GRQdnK+XN3N0lp/O1eqSihGxMh45HCXGrS
	U5+4k2ohLMU6V9WDrLaBGAv1OBw7+QOIc6qOO53kHw3fcaSEZwln4c3BiQ5Dhz/IGYjGmjTZJzo
	/rFduA5QcC27J6qCYIoVVfrErhShZAGDAvYaa55EMNvZP8JrXxIu+HPLuqSmvLkIWlsBKos26Ci
	DDR5ZnWvB15mO3S3s4CDsmlrSzde0lfjxZHt8BB7aq5HAQmNG2XcJapAsR0V8rb67vpHgOoqHqm
	Gfcgv6zNj5UQs6Y2rtkhXLFfZtiu9yVlyrdQrY8AFDOL3uP/tuPk0zVyOVSAPeuxyi+ffJ8lSpx
	M1VkiR+L3//NbCsPcMHyCRF3GPs+WTGV3Qx8nVRG49eX/iRRaGle6XP0FSwdpjwjjmI96AKE9Bn
	a6AiBPJ+lpmkF3rI6a/ZiYX4zO+CtmosYGj6xK/9Czw++3RGzZnE6sXi/5TrHGnROya8ysB9HuO
	R+WChSHHUIZNqoEEydQ8A==
X-Received: by 2002:a17:903:3244:b0:2d8:d4cd:dc90 with SMTP id d9443c01a7336-2d8d4cddf8bmr245815485ad.19.1788161433689;
        Mon, 31 Aug 2026 00:30:33 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988d184sm30107865ad.62.2026.08.31.00.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 00:30:33 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	thierry.reding@kernel.org,
	jonathanh@nvidia.com
Cc: sumitg@nvidia.com,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] cpufreq: tegra194: fix double-pointer error in get_cpu_ndiv
Date: Mon, 31 Aug 2026 15:30:08 +0800
Message-ID: <20260831073009.3772408-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ndiv is already a u64 pointer, passing &ndiv to smp_call_function_single()
results in a u64** being written to instead of the caller's u64 variable,
so the caller always reads back an uninitialized ndiv.  Drop the spurious
'&'.

Fixes: 0839ed1fd7ac ("cpufreq: tegra194: add soc data to support multiple soc")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/tegra194-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index c6375e14d445..1eb96e9f3310 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -367,7 +367,7 @@ static void tegra194_get_cpu_ndiv_sysreg(void *ndiv)
 
 static int tegra194_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
 {
-	return smp_call_function_single(cpu, tegra194_get_cpu_ndiv_sysreg, &ndiv, true);
+	return smp_call_function_single(cpu, tegra194_get_cpu_ndiv_sysreg, ndiv, true);
 }
 
 static void tegra194_set_cpu_ndiv_sysreg(void *data)
-- 
2.43.0

