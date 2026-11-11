Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435692;
	b=mreO5l0JuS5fnnw6bZ2R0glUdV1hTj0SUk+cPBeW/F3e8u1NNpxe3kBV5WLoThwLB2Jf
	 n1o1QjY4DZ+DqOOogjHaGQ7j8/rXn+P3/R91NW0DB2345jOQ5bD/ARs4tYFkFnMeiLB8w
	 WIYyOhavpAtRdZj5iwYpgu6wRk8ZolHOxs8ldYTpnialPIo/wqUzCL+7rD2/dsG1L0eP5
	 5i8pzTLU7WLuOj3JpDOw3haFUkLiCvy/20H8s0lS+55sG/x2dwS/YB98889IQQx3gTt74
	 D5BL5OJ8JR48nXH7LZzStNTY0Kd9yvb3V3SmbjNP3FXX+L2cPjr7hMBJ8GFhTs3E10w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TmtKdF1AWiRH6We9YcRb8zDEzdlOz4E493C6LB5k0/I=;
	b=CXgL7cRAfE2rryeRmmQheu21NfSYf6DjoBD8NFlkVNeKFyc5NiWPyfTnw2jIGId40Ssu
	 bY/TUVEPjPfRkBB18v5ORDQkwNH1EoAreNbkrUT8taoWqQ5WpHuBH1dQddzVikyCdLscD
	 rvR+g1WSbpC5ENjAQTNklnvEHmpQR2ErLLoPSzhZBL60VLM2SD122iBmsnhm/ouA8nU6K
	 5U28QjRC2ncNKhCRlOVc6gaVHL4haZPIBsv9MXkC/WV/zDZ2nvxFFeC/tT+XB751ukKRx
	 Y2ir+xTmzXtUX5+vIKwhDFfWtrsWDYp3ct+s2gTh8g5k+p5UFzqi5LGmRCVukMGmLXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAhkWesh;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86112606A326
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 22:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86112606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAhkWesh
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so2888845e9.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 14:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435690; x=1795040490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmtKdF1AWiRH6We9YcRb8zDEzdlOz4E493C6LB5k0/I=;
        b=GAhkWeshmXeULO0RrMSF/TEbMI1rd1Dbu9ohLHmmwmxzRDiTMT2sMZNOQ0a/2G4tSa
         H43L05tjDvA1Bxxt1FR0x7e35oZYwRvJ1bPbenazsGlsk6ItPwLVNWaA8oLMlpAkjEMS
         N1eitSPCAEted5vZEUqrFL1vZplEM9l6Qz1nDytE6InIAI6DDiR7kdkNiqHS3v5905vR
         Aj2onbDH/JimL5zPsjwpBGJkuAdihvFqTbdkbnw57v9zXPy5MYzjSmc9abLm6CNH+Ri5
         ol5v1SfAiMPfJRhlzhf4IPiRSgTD4nrdqYu0lLd92MoaB+d6cjc14Q7V5WsmiC9hHrTP
         qOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435690; x=1795040490;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TmtKdF1AWiRH6We9YcRb8zDEzdlOz4E493C6LB5k0/I=;
        b=Vt8qXrgraD6PI9M9HDJblQlZGEzonVIlPY6to5MoKX9Yl9N9s3llDfS5ltBVxUeWnf
         0OzOOXpeKH4EO5fRKU8BtupuJWv0TSy0ERiQ+xBkzje1tPvwTxn/hr/J6O+GJLHbDgtY
         AtyGj0mgxMp0SSbwVE4UxQ083KA6RVqC/0Fd/VUt5ddtZRnEK5k6OUPsvNcZO2SSh7HC
         lDdlmZjCBhdWxBx6+cdJft00n3pbgw8Oc090hfmkMQvFgyKEJ+In487zRxbKKBnVWIO2
         LhiAP1Ktq0FCOrL8U0/r0RGbh2XdDlJD4oeswUeXVQuw8cgSsIVYdq6PGPMwGmJSsiSx
         q9WA==
X-Forwarded-Encrypted: i=1; AL+hErE/HD4in8oPW8jl5ywBGNITu+Dr/vaJBmm/eFEwTsrXdUVZDS1rriZDcWT8eCJ0mmDmXdQ3Ddh1rw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9YakFDZM/oCTdlqi5+9XCln8llvFRJVc8PqQRHXC8PSKLTozvG
	5cANy9cMyWadPRUUmvyWnYcKsb+LuTZlRaqIFJ7uWOtyZtD7XA0EYYyP
X-Gm-Gg: AYBFou0tMDV9RQsuNS7T3a6yXHRH1pG9N6KWHL5onzLkEz398YmlDNDvGIFCw136RED
	ZX62Vk6la9y3TXqtgISnYihnRDeeQ5CRe6D5Yfjvre7eCB77ppS0DPS8Au+4ogfEUb5L6e4dz22
	lMm+ryNyTTzTSLBLz2HIaAV3XhLvoRVUPOIK2UpAo2opIazWo7mPL79kUrrgFIgf9zIID+eog8R
	uMa63T30pAnpooFWCRWVJxFjqGYZ+Rp9cQfiP3fDgB+ddfqYkUiuqOSbadlqtXBjAijN7vBH147
	/+XZedD4ZkQ0fLOTKwsECsvPzMghxVmek6NY5kG2UbfRAYQbVlpIVCpsybh80w+1vZrRoY3Kemq
	tihXk5yZpDqiF9yX0VSWSjFGnfemYXYd0vMKcl1LvpKTM1MQO8yX39cbNxuPrYktMC/a6PkVGai
	jHyaYTvQcJ320qEecRKS1t/g1ofWF56lAlTriAXz99zdHJrgiFlDWifA1bd9SwCvVcxONbRhnHJ
	b6t4ElkofWwZRdTNT6gTIxGvYWDf1vzjUHIcQxIwyJm2YqyS8ZnOMLviqrRqRSpYGSzX9w95fvP
	fAcy0wXOGaiOL+mKmac+BtAYUE3/iLNUegzraTw74dVYr3fZ
X-Received: by 2002:a05:600c:c0cf:b0:4ba:4928:8aec with SMTP id 5b1f17b1804b1-4bb4e283f7dmr11079755e9.9.1794435689714;
        Wed, 11 Nov 2026 14:21:29 -0800 (PST)
Received: from localhost ([5.83.201.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08e35e44sm78893405e9.1.2026.11.11.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:21:27 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: Kconfig: Fix two spelling mistakes
Date: Wed, 11 Nov 2026 22:21:24 +0000
Message-ID: <20261111222124.1035303-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of spelling mistakes in the Kconfig text, fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 16d0a38b41b7..1ab617326791 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -246,7 +246,7 @@ config BATTERY_S2MU005
 	select REGMAP_I2C
 	help
 	  Say Y to enable support for the Samsung S2MU005 PMIC integrated
-	  fuel gauge, which works indepenently of the PMIC battery charger
+	  fuel gauge, which works independently of the PMIC battery charger
 	  counterpart, and reports battery metrics.
 
 	  This driver, if built as a module, will be called s2mu005-fuel-gauge.
@@ -463,7 +463,7 @@ config BATTERY_MAX17042
 	  MAX17042 is fuel-gauge systems for lithium-ion (Li+) batteries
 	  in handheld and portable equipment. The MAX17042 is configured
 	  to operate with a single lithium cell. MAX8997 and MAX8966 are
-	  multi-function devices that include fuel gauages that are compatible
+	  multi-function devices that include fuel gauges that are compatible
 	  with MAX17042.
 	  Supported devices: max8966, max8997, max17042, max17047, max17050,
 	  max17055, max77693, max77849.
-- 
2.55.0

