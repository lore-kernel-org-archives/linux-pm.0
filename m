Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1636AB77
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861173; cv=none; b=dGBfOCOniMwJh6Nhyjx0eMuc7MumOwwUBspXomeqeECPq8P2u92HuBGme1heBl1oawHvwU1mZ8DdH2QwbJRtQRLV4sMxJ6Cgcd2nS4uTFRemrsTe3LHMJq2uYKyPn+N29ELgpogeJUJ0KorTDiAnwY7/+vICbHFpo40RsEhmjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861173; c=relaxed/simple;
	bh=4d/Xb0DIXoO809r/V4S1IPoIqW3F3P2oEtFKsbOMuAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ultxdITDoIoogu6rjlyB+an3aL3ryExG+oGtbBVpJ/+YZ/HDAB6zHWvpiYiD4F4rq0m42yirg5YOrZLIelo2koE/vfiOgPYCPfS4bpRnhZoldKvQZfyEvcHjYmDqKhOUYAXeAlKy5vPc4sl/jt4rGxy+4eOppVbvu6pPtrZPeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfHaqgAG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfHaqgAG"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so256466a91.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773861171; x=1774465971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hByq3PCCv6ND3TKDb90lFTFvo5+Fx3QviKoBxNuUu1E=;
        b=NfHaqgAGxurEgOkMYcJkXXxH0d3Tpw4n4KzlGaTT1vYr5L1j7WLshQJvtvhJow60Go
         n18FA5dtI1AligWHBdk3lIjaMiZDulrtLjtwh9MfTX2s+wBpU+ICCsFjs+i2zJWSlbll
         gc7fnKD1NF1gMSh+AElXP6X9g4z44bnPdGu94UucKQtWkgzcziCka4J4iRvvHuvWA85U
         56eW8Z7KYtdgdu0xUYlLZsoAR9f7QEinwuOUVB9EH4K8Ky5hUR8VxrcfhXAQmDjvgFWS
         x7koAnIYCfbnr1Dx5nz8cN33E2+4mobGhe1p2gNwmBdvnrUccgqFB8git3n1cIH3cQjZ
         2r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861171; x=1774465971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hByq3PCCv6ND3TKDb90lFTFvo5+Fx3QviKoBxNuUu1E=;
        b=SJjqb+Xx/B3NtEdhrJHFIpvgr0rAbdxE15VVedvStw7ZpOFkjAFnB94o79yg9DJUlJ
         ldPXoYreBbhAfcP96UHmRavTGZ5Fy4pAq11xHa5U8T/SA5LD4rnLT0EVLr2H7XB5HR6z
         VUz0g6IVyDsbf4cYbMan5SoOiy3NtthS4fiBv0Sge6hK31YXhXuK1hMbOEFT22yj3bFn
         AJlYx9tBXLaMLO3axqpQTlYe3Mrk5qTW3TOKoibMHXytGNcG5vLv5//slxGJLw4q+rve
         LVOK7USuaYrDQ5dCOP+19iLcynTYLH2WWpaQw39+wvD2jxlyevfZvfZUdUusbcqY2TxR
         kmDQ==
X-Gm-Message-State: AOJu0YzorvD6A4jD9N7ANgAPE+n4dwO1wcr3YqsPBeUWurU32uj2dhLk
	zDaq2Ub/EjezXGTeEdByHdDPj+uQhMSufowqqqL38C2wIp3mDNLGhEcvmmmugg==
X-Gm-Gg: ATEYQzzhHILpymk20YHBP/Mt6ZvCiYtW4S7e6Zj3kzcoL5aPPmWy3P8o9z4kiSGSfFX
	ol2OQ6LosoI2HeXeeAxsea553U+/Dye6rvg3KIeSY8b5eyBBS8iMLfvkRQgSArQZ8fWqu3gdZUw
	ew3H+zLCM43uak4kp8ZhSnJkwuxZne42vG4eIndDyQVxdVwDTKhf7j8DXa+VCFfiXTlQ+wnxFu+
	Yklnk6cFj+VJpFPIYavty9viBKCIY0QT6t24y0rQzMp0K/x5fWzEvDlkTrNUQg3HiDMijtrsYR7
	WE7UTVANx3zHMTrYGP0zGijjGV437LmO0hzKUektmBgg/ArWYDh8jahdcx5Waxtcw5DB8hXQhbX
	fd5GxDi71L2SIaN+mYr8mcIgM3BHftCYdngRXAefe/lkM08Z8RxmRfQgPBxWkmOPR1FLJZynyZx
	KXe3hvTLLRDk0Jc1PmYeZNr2ul2jM54FQkFoIG2N/qc/yBxg8LNXZNzpI=
X-Received: by 2002:a17:90b:2fce:b0:356:282e:7eb7 with SMTP id 98e67ed59e1d1-35bb9e7e328mr3745513a91.12.1773861170724;
        Wed, 18 Mar 2026 12:12:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm387993a91.14.2026.03.18.12.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:12:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cpufreq: tegra194: remove COMPILE_TEST
Date: Wed, 18 Mar 2026 12:12:33 -0700
Message-ID: <20260318191233.5851-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver needs architecture specific headers to build. Problem gets
exposed when TEGRA_BPMP gets COMPILE_TEST added to it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4014bc9dd73a..47c9b031f1b3 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -248,7 +248,7 @@ config ARM_TEGRA186_CPUFREQ
 
 config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
-	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
 	depends on TEGRA_BPMP
 	default ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
 	help
-- 
2.53.0

