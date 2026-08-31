Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC43BAD93
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167531; cv=none; b=tu2+CorjC2pDvx6NUMZsBdAtUuUfZhF75crgnEHE3K7w0QC5u0Tb3/U1zDIQKs3E6wR9X9eXjTy7M5r+TcVVx1kS9oux17TTpDhgC6jwLUA78ogEJASEwZU9Mj+21udXl1iOS9gvOZt2vADT1GmV9LUFw5QWgEs7hNi8PAhDVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167531; c=relaxed/simple;
	bh=5OhO7H5wy/8gR1JroAGflKbDlfbgFnL6qS3SY0hElg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dx4ODb6q9DRfwiURO4qM/D6vAXb/28jM4dpao5fJGJr6V/74s9kFwuJkHsR38JuodGA3SEZmTc66aDTiLxFCeT9tyudaXjvX0g7TjFM/3ycRgreOg3Orl5PMYI8brFRI7ufMovub+6TxdhMUcbPNzMWYr6VSXiITxzE6FLYXLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d903e972efso5065415ad.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 02:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788167529; x=1788772329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2MVWbIG+FPtZ3MOvl/1hLGDkOqyRLPEPkcfNhS/eoCo=;
        b=YbK+JrSJy3KauQdp9+XKAkCxZS8g1sNpPs342DlXNobl2llPmwe0f7X1fn3ad8v9UK
         rLVYVV/gVTDyqGtG7k+ZbM4hGytV2Ld8iHYoWj+IW96loyNOkV+4mB1ql4cJmHhPz0ZP
         UyYmjRWveCo3hRJX7zEMys8MzBQnTbX4AWgwOyOKf0vXpL9/OJxjnSFbwP35cfsBcS7O
         BTuWA1gHhCUpPTe0oJjA6NFG8SUbBXYipZa57Uch4syvVVXxWuEHiN+ZyFhB/rTX1/I6
         6mktxQNKvA2/PNkd+t4aJYF4ISDQiaIDG3kN9rtWI+xeYBtol8I90JzBPAjAQD+MQQUS
         76Bg==
X-Forwarded-Encrypted: i=1; AKwUvByPKmHpN5crnluMKRNkMSjlE2wik8a792Ye9OpNFcrtOkitW2anf8UjdvefbPJTN4lqicpQDiFJ1A==@vger.kernel.org
X-Gm-Message-State: AFuF++luH/asTJXGInUunH2knXbFbww4rkPe/vxjEs8jzxXF/gQk+WCk
	/MFoX+cN04dOjVOYa1S+eMija9YFkgLTk+yjEc29DmjbEySNVU8zI0oo
X-Gm-Gg: AYBFou0pptZnZvPlRldSP09D8CSswQkcYdS6iavPoEsKRtSxW6OYbTepLpbilvvp50E
	g0u/E98YJlJgVMP2bJVkKS4gdAAK68pU+v4h9JK2MhfgI9b0sblRJ/TuxnIw0B8bj2TG4+KCDdx
	82yUcFen+ehdW2HnYgi80ozbxOjuYUM9H94m99tVbcbyh1fWO8I7ZQD2bdDUpfKDIPfkIudha7R
	tdX52Mtop/5dyLmsLCTpIY8FsXSbd+lmp7/DthfWN0oxKp/+Fgp/xpT+QH66gtk9uWMgAzp0eks
	83juM4TQDnSpzGekvZPgsSOvbdEwt1RzfzzMCnheBlvKb+4zTv/BGoiVg+zF8jabxkRmUtbBlbw
	OlZe4eSm8IMsKmpcWBN5xon/dgyoonjXBZa724mwtbRZx6YT2JLFrrk/iXhBW1QHmSbGH8WOrge
	jDxWFQcijDrVem+haN7N3e9FNhFNJDEj6eavVUEsllESE0QAwvZLFGc8uQtdA3nGm3GHuqosOcC
	mwBxzoWoQ==
X-Received: by 2002:a17:90b:3c8f:b0:398:dc16:3c29 with SMTP id 98e67ed59e1d1-398dc16407dmr10064170a91.7.1788167529083;
        Mon, 31 Aug 2026 02:12:09 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75952ea3dsm31587995ad.24.2026.08.31.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:12:08 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: patrice.chotard@foss.st.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] cpufreq: sti: avoid NULL dereference in dev_err()
Date: Mon, 31 Aug 2026 17:11:59 +0800
Message-ID: <20260831091159.3906287-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ddata.cpu is NULL-checked, then immediately passed to dev_err().
Replace with pr_err() to avoid dereferencing NULL.

Fixes: ab0ea257fc58 ("cpufreq: st: Provide runtime initialised driver for ST's platforms")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/sti-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index b15b3142b5fe..144ac0f1d85d 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -263,7 +263,7 @@ static int __init sti_cpufreq_init(void)
 
 	ddata.cpu = get_cpu_device(0);
 	if (!ddata.cpu) {
-		dev_err(ddata.cpu, "Failed to get device for CPU0\n");
+		pr_err("Failed to get device for CPU0\n");
 		goto skip_voltage_scaling;
 	}
 
@@ -281,7 +281,7 @@ static int __init sti_cpufreq_init(void)
 		goto register_cpufreq_dt;
 
 skip_voltage_scaling:
-	dev_err(ddata.cpu, "Not doing voltage scaling\n");
+	pr_err("Not doing voltage scaling\n");
 
 register_cpufreq_dt:
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-- 
2.43.0

