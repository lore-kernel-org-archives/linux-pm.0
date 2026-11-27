Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791279;
	b=JBAZ0yweBcA6DuVwnLDgfT4eGn6ralDdy0NGUDXfTfKW4CJsn8woUgjfPDTIvgDN+Be9
	 1zMF5Q2A+EFuvObnQsvhhcKZ4oIs1zqcYJlOtRgdBoD0DWJ0h4D09IRBiXiSqIVKrS3XC
	 zYTHyZvVCO4pkPK2bUe9JFY1k/cHPZL2DUoql6Pnt9LTtZtpX8q+6vxh1jbtdLsDu8eG3
	 hcIAblxAc89eJ/CBr3AeSK1EAfSIkLy8/4sol4I2i90k1usqgYxfwa4Pf0v6Z4oDAtI9n
	 568INoI7Ahd3CQNvoMTvwG+drky7+b0N46FMjLmNFBv4PyWyV1Tr3CxoYAPKeCrIwng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S7ViY/cTDE6eZiSIsJOL9yqvd7LrFKnJqPqwHsnZ7M0=;
	b=vDGtLKZGfLpAltt+S8AAruTnMJ5YaQt3fBH06rU1LmZydAZJ+iRRQiMZ4qiZoE56dmSg
	 GwGpE/kMJvz1yW9gdSIJpBgyWgRBRwxEYILfHV2tejUBwmtB/0645EfZr7Y/p7ok8IjVM
	 3yyEd+rA1uJAcSvqFLG0fSTuKUUUcKn+ILtZFXuMFzguBdLzz+uVHcWwkyJxihP5UsNzw
	 aGmMe63s24ACivz/ZSyWDNdLZzDRapllTUvEFSkEIG4O/ErSWJnc46te7gCuTAZoBPFds
	 3i4IAQsEJf78ti2Z9JXU3E/mFdzzfa+Q3Tfscn7iu4HM0Tb+87IIateUfe8uA8Ya/gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=esviXNbl;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E30606A331
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8E30606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=esviXNbl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so83248795e9.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795791277; x=1796396077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7ViY/cTDE6eZiSIsJOL9yqvd7LrFKnJqPqwHsnZ7M0=;
        b=esviXNblUsN/O6pLU1HCwyW244AehioypbWII7mHLB/cUm5fASw16qqWiuviQd62fj
         hMnEfOoquDDjAPkKBDweEbkuO79znsgBfGTJcs4yX4bV2fSFtzXsZiga+3bkYkS0xXAj
         /1wK2KwIAW4U4xTlOq8caWJ7xMpHKc7Xlzi0sLz20rDyxsp5fCMrd9s2CUewrhgLo+RZ
         aCESnVo8+Rj3WuKLPUE1HsKRWqKmsnj8YLOQjmAcCD/x0MjLICUlUfHzUI4Lq6ss4ZYt
         wGQ6DCDsTISp/V3hBqMvE64veS+UBal3MgVk/dj4DMUHd5kkMelvN1chjc42yUilw6lX
         2P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791277; x=1796396077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7ViY/cTDE6eZiSIsJOL9yqvd7LrFKnJqPqwHsnZ7M0=;
        b=YPpdD5/BwbpybjiVjADKkXc9ENjTioxM2H+ktUJmFaH+bMwnaV1Gfbj6VSpL0gzWmU
         hlo0rLaCi0MIsdM0dEXLTTcUJdOE1ORNojPfO3d5y+3NUmZEmuzY9h6TYF2cpa5ZEKgX
         4WerzjE1uGM2MsVChjrpvC2CV/f5CrathteJvyLWcKximHnyvBKSovS2nHWPzZIxM8pp
         CfCTaYy5wjnmxKXeLc8lQeIP+rMr1fq2rY1z54K+o5roNnCpMYOzr9RvmgKxnhOabYHM
         QM2Szr2LJ3wQh6kbIFWEufp16lkuUdYTNEkWulCsUKA0ga56ZjbUuqHdxvr23znECL6Y
         sjAA==
X-Forwarded-Encrypted: i=1; AL+hErGSwD4t1K51fS5HYofuAo3e5T/+eIoBYS03cHWkwoIYDxYuhl6bk2vlCmVav4viXlZQ4vGvcMytcA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+b1ZKo4sIs/SrbuFXp12yaGmhy+CXZHpYWb8Adcfa4ykqeZyP6
	Xkrc9lRXCHv3pJkBXFV8WQFH2kMcmCROzQmkSbeQr9Eufxtp/lw8/Hey
X-Gm-Gg: AZFdTZdlNQqblow3/lPPzeJZOlbxJ97KcOIbPx+fpQ1b7VUEjLYrW3qsjFUnKmnIqDR
	H2Xb05G3noBnhO6Pi4DpKztr3yAhyMjBT1W6ueL+AizGjEksLxYKjNOqzXGufptp1KjkZpqw3U0
	FcvRB8feyPBsnOrfAfkrLnlKM8dK5fCc+k6LYSwKGVcrwFt5MXs4R73rTaueT7DzkhGiLrBNehd
	Pz3XXPKvN4kmyj8bQQPiKRBrHQUKhzcxLFwJnV3HMV/aH769ULHqUFy41eoMqe7XJ3ZtRnws9Lh
	eISeCJKVgunG0m4HXkZnoZKOjBAt8RWioMlyQBn7ni130bL12GJhNuXtc5PSBHa2Wao879hDPuS
	XXs+Cbe06LyFsctEoGdXOTga+k+7mNzuyzyiuHB+Hc2sJ53Ktu4VhRwTeC78TShsQOdN5qUcSPQ
	BnIkvrIneIN//Bco+21DdXM6B61h4FMDAJmZg5MYfKpT6V8ufJZhfoiBcTr8AVyUCtMECHq/uLK
	w2V2854w3X4ehOTlhCenmqz9hpz0kIPKwl0aX0NEn9QDbcDBMaE+Rj30TvAjUZraHa8hpefxAz5
	sbpOs6cwigwcZvkhg0joVxIa7Tse11pw9xyYlEnLhmy2gt/4RUrYDtr+ZoN6CYZKg19JPApTHCL
	yqYg=
X-Received: by 2002:a05:600c:820e:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4bb887c9936mr494120945e9.1.1795791276914;
        Fri, 27 Nov 2026 06:54:36 -0800 (PST)
Received: from emanueleg-nb (host-87-4-46-207.retail.telecomitalia.it. [87.4.46.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm633589105e9.1.2026.11.27.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:54:36 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Rob Herring <robh@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] power: reset: tdx-ec-poweroff: Allow building on Qualcomm platforms
Date: Fri, 27 Nov 2026 15:54:24 +0100
Message-ID: <20261127145429.2060162-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127145429.2060162-1-ghidoliemanuele@gmail.com>
References: <20261127145429.2060162-1-ghidoliemanuele@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The Aquila IQ8 EC exposes the same functionality as the SMARC EC.
Allow the driver to be selected on Qualcomm platforms and update the
Kconfig help and the module description to cover non-SMARC modules.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/power/reset/Kconfig           | 9 ++++-----
 drivers/power/reset/tdx-ec-poweroff.c | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bce996bbef28..ecb249cf5359 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -246,15 +246,14 @@ config POWER_RESET_TH1520_AON
 
 config POWER_RESET_TORADEX_EC
 	tristate "Toradex Embedded Controller power-off and reset driver"
-	depends on ARCH_MXC || COMPILE_TEST
+	depends on ARCH_MXC || ARCH_QCOM || COMPILE_TEST
 	depends on I2C
 	select REGMAP_I2C
 	help
-	  This driver supports power-off and reset for SMARC Toradex SoMs,
-	  for example the SMARC iMX8MP and SMARC iMX95, using Toradex
-	  Embedded Controller (EC).
+	  This driver supports power-off and reset for Toradex SoMs using
+	  the Toradex Embedded Controller (EC).
 
-	  Say Y here if you have a Toradex SMARC SoM.
+	  Say Y here if you have a Toradex SoM with an Embedded Controller.
 
 	  If unsure, say N.
 
diff --git a/drivers/power/reset/tdx-ec-poweroff.c b/drivers/power/reset/tdx-ec-poweroff.c
index b4f1c87f5651..5629739fd74a 100644
--- a/drivers/power/reset/tdx-ec-poweroff.c
+++ b/drivers/power/reset/tdx-ec-poweroff.c
@@ -164,5 +164,5 @@ static struct i2c_driver tdx_ec_driver = {
 module_i2c_driver(tdx_ec_driver);
 
 MODULE_AUTHOR("Emanuele Ghidoli <emanuele.ghidoli@toradex.com>");
-MODULE_DESCRIPTION("Toradex SMARC Embedded Controller driver");
+MODULE_DESCRIPTION("Toradex Embedded Controller power-off and reset driver");
 MODULE_LICENSE("GPL");
-- 
2.53.0

