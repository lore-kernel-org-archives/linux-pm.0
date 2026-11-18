Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998987;
	b=aFt8ZLGh1e/YhxvJbg7KtOvDcqu9GhQCeWmXvYiOsSgwl2Hz0JVN6EnfF12SFqlsCL0W
	 WZqd5ZocqJzkJYRtOA4zgaDB+f6sOOjsZDsZPlNENAyxF3R7x8aKY4re91+tPowf6pv6k
	 jGU9BH44eWNfNi0X2IWoXMXiugVpKUxDnPppCmy1v1y66t5EORZRDB93/4H7vrC6Dc3LP
	 HtyQglWWBTRuotnK/1FlN1ec9Ne1hTC04QhAq5llR9ECWh7ovTuHidQKZ0X3ddixQ2O3P
	 4u03dCYn5eoO5eKQIgLFxv7ZI4FpohEAGUE8s7rGbKdZP4U061AyiUwqJC4E5DZlzVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LIcWmceFZYgQietyQnWOcEmUtfnOG0g7rm/baVCxi6w=;
	b=2h8g58SYFppThWCM9MmURX69kwng75BQ2xj0enDixkoHJdezpw2KOIGTsGG2aYJaTSPd
	 YJKV+Xc2/DD0EbfZWvx4zOWsD9pW8/evPtz7m0JGBtSfRR044JduTbsnCgqOUQ/TBq5Rs
	 dY/8i26rbApmGQi8T87dIe7ICwLzVIwPAQk5bG3lSOyJuAkYXxvWLD4hGtRnfBTMrqAlJ
	 ZxbYgV+rHgH+VS4xOsVotnJ2Uzrwpqx3PjgN/PUF98wbPBRkEe0EuLP4T858L7Hajhln6
	 8g3YN6KNtjVz98Ydqa4ntKb5AhrbLOzI2fKDaO6ITYagmSJNBJGXVWRJPhaBaFiCAHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxdHWTwH;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ECC606A33A
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 10:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82ECC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxdHWTwH
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-381f65e4e4bso1386008eec.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 02:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998987; x=1795603787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIcWmceFZYgQietyQnWOcEmUtfnOG0g7rm/baVCxi6w=;
        b=HxdHWTwHorAG2PIpdZLKc3N7ObMPHGYzpHCyX9EECRrJOGiaxqPRBf/D59uI26fi3M
         H7le+B+pvLdnU5bvJjbeYl6czjcErebJQPVTucJBkhLL/8MhXuYY+GCumBRXrEuZNmzj
         eK9zqoo8ciY0gymBrAEMJajGYsx0SHidLXDkEPBn+tu0GHkMypA02nIjmgdpJ9gMpU0/
         wbqh3Fms4eOTjOtK6G9s2nYky9I42q1yjWFwpLgFvEo/MGQr2dQS5sipAdL+S9vcFrbl
         UY4bGPqVpkzkuFY5Ao4Ie9RApz928FndTReiBwIYhk4Myv2oMB5qQ2s4R0IDqWB0yajr
         rDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998987; x=1795603787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIcWmceFZYgQietyQnWOcEmUtfnOG0g7rm/baVCxi6w=;
        b=cZpk0G3ZLTl8oCKpsQUvQ3s7HyQkZ+3/MavrAs4nv/zoe02fx/NBy8K/ds59zwp5rG
         Se1BQv+W3VD/hzC4ZyYb63bxYOIUjPuzZ3FQH63obTFMKTBvqd0pzmrtKK/Ca7/n02Tj
         ObYhVQbcweAVZdDczEmaiYCRTeSp9m+WVrrlcGaLSaz1WTHAWOoMySwTxB/2Yjg3qxxH
         89RWEtSVPw/FejEKFkxoLCjdkikHxJX2528gBJStdBj4xvOyn+AbpsHK/7TTRL6GEHCW
         lZJJl9gGoDCA7pc2yaJWf4MIfTchxqmbCNSZwC5q8ywnrnGeerNJqcOf+zmhfcChtuPm
         vEEw==
X-Forwarded-Encrypted: i=1; AL+hErGq3Aic9/NO8I1IW/kDXm8nRaJeqUtO1toW0bApRkzVJuS1sexpMHKOf755NvsBK+C5sYwWxi9YSQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CVnvSb9WGUPTmfdqUsmy+0tnPKNon0I0mykci6Jb37YQyQsso
	gUewC50LeLG9zoP7bUfPM7YfizzwF6BtqH48Ag4Bf4Ac+233HALvVoNekV6q5A==
X-Gm-Gg: AZFdTZfMSG7WvTu9Iudlp4L38AvXdYa9h6/xJZCM5iAmNRR+/odF4Ighzs8bvBykbNW
	ic657NjY0zBimXVsisC/paDeAQhTR2U82Oq8VjZBOGKpDa9wZ/ZQigXLhhWDrv4fLEaAk1jCleA
	1s+89j4Ug7ggq+e9x3slpHJ+hDeXrg+ozrR+uccben8BMQrRpHW7UYpsrF7aqDWkV+7WGNvRltV
	hBSJy8NIQpvTrmz1qgRmP/NRlCjLO7Ru3y35ZUevjuxnIaBWYxqAQQd0JBTyq6/YA7eDOkBSEFq
	empRDRlORegpWLh6Jv7sqZdaqmv24ReuOxParIoPuHyF6uyoLjD8UV4TkcXTK0mx7w8C/OXRTac
	+ml0ejT8fca+bjtB+wquHBsPZrx2kXK1IoYNJEfHmCczSi8rvgTMeBkf6GJ2eRjJGSmnyZU0b7C
	fph8XgOgFzJvAIak9HEgMiZG/Y8tShP7eh9larCE+30ETZm42cADmoBiW7d0r3v4eRbltHM5fer
	HQnHSqUEHJkdL+bWjo8c5oIj39l0pbH2LY4u5L9tj6JZZ8UZbJTDvH+oq0Ktbvbd7HsYYgo9paT
	xBJCAaxDfya94ygYTqkzAwk4zZsOy7XY
X-Received: by 2002:a05:7301:fc13:b0:369:f70e:bd40 with SMTP id 5a478bee46e88-38280377e84mr2164257eec.16.1794998986480;
        Wed, 18 Nov 2026 02:49:46 -0800 (PST)
Received: from archl-rock5b ([45.112.0.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm11729913eec.3.2026.11.18.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:49:45 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Alex Elder <elder@riscstar.com>
Subject: [PATCH v2 1/3] i2c: spacemit: Avoid sleeping during bus reset in atomic context
Date: Wed, 18 Nov 2026 16:19:13 +0530
Message-ID: <20261118104935.1716-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
to wait after triggering a bus reset request. However, this function can
be invoked during atomic I2C transfers (such as power-off or restart
handlers running in atomic notifier chains), where sleeping is illegal.

Replace the sleep operation with the driver's internal helper,
spacemit_i2c_delay(), which conditionally uses udelay() when running in
an atomic context, avoiding "scheduling while atomic" bugs.

Fixes: 5dd75dac1b35 ("i2c: spacemit: introduce pio for k1")
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Alex Elder <elder@riscstar.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: https://lore.kernel.org/all/20261110061429.2036-1-linux.amoon@gmail.com/
	collected all te reviewed-by
---
 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index ff32876e24d3..f4b21d7efaaf 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -332,7 +332,7 @@ static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
 		writel(FIELD_PREP(SPACEMIT_RCR_FIELD_RST_CYC, 1),
 		       i2c->base + SPACEMIT_IRCR);
 		writel(SPACEMIT_CR_RSTREQ, i2c->base + SPACEMIT_ICR);
-		usleep_range(20, 30);
+		spacemit_i2c_delay(i2c, 20);
 	}
 
 	/* check sda again here */

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.56.0

