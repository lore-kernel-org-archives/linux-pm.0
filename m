Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430594;
	b=twoIETYv6+56j4wC3rDHVKQsa8MAE8U7iMF+13b8OBl33Nzvkg12mYlBDLnnIXA62Jh4
	 DW9zRSEYxfTReVRhQ2ujjeHIKWl0vOb25pwzrlEnVSvJsJLuupHDIV4m6HwL7qdFtW10b
	 eZnfS7QmN3Aumb9rpBHIHS2VKBZqk/AHwj1qE1PoC33Tsuqy4brnwtPOECFAJ1M+6K1mf
	 U9rDGNOpF57lVAVaqgsOdD5CoRL+nJ0sImzNO6ulxU8CQAmCMiv/0azyCQ7KonOnh5tzL
	 y4JKZy3/GwU6wAO3PT9wY91hKJqyxKlESYOtkf30ZgJNeLASbGy8XF5cBZSCyYMRrZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qGWgS1kK7bTN+UKMspP8Lj57f8piI162PVpn3s78g9w=;
	b=lo2FrRh5ERat50M8Kv93+qS2n01/pveScC7cH2ASuuo23RjFabcGGBiCLgAaCTnDTyym
	 aojq5sX2GP6pDaqnEkwSk32BLvKdPwlHhx5wZs5B8mcw9T/tjgDNhMtPOtrZnGGFGKWTJ
	 r1VjcDlV8q6EFJ8hL4jOWq9+JbOuWeD9W09JmKBCmO42onlFs2doLIjx5dn8MpMjvQhZC
	 udcy25OAhN4l8ZQCXUBs+QSRP3plUvOfbahYAuGhXgNQBiNphMa/nO3WIeIbXCK9KtIKY
	 hS4ezY9OBmtJvo5tzSLbEhOlQpnos3EAgPkt8uFIZyB/b62Tj509KH4Lne/w0tW+U0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lgpvbM66;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC7606A330
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 20:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDC7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lgpvbM66
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4f55a53898cso1683794b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794430593; x=1795035393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGWgS1kK7bTN+UKMspP8Lj57f8piI162PVpn3s78g9w=;
        b=lgpvbM66RwLxyuXocBmWm8xd1PH3Jz+8TAKs9u3ZGynrMyJBL0xj/7Qr9UljPm0bL4
         NHYJNseWat0UCpuuHFHf3dKGeGFGlaJUp1ZwYwGEFsrVY5BqBcREBHFgNyWi0qk0c+oZ
         G6RTL659MjmCZ8Gu8UGuPmSK0U2KeyiwMbmULgxe3J9H579dUDiDuLTAq2mpoYUACAu0
         AOZyeetf1u+tkb3leGFhpAHSrEDBCL1zAZPpUiDxkhd/bzVkFfP1kVjOhbp7qiAMsLnH
         apRuKLCZ3fLzaWYegMcG868u9c8HMpoAon663ZiqNlWDuvcPG/TTzMB3u5ny6gJySrrO
         kQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794430593; x=1795035393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGWgS1kK7bTN+UKMspP8Lj57f8piI162PVpn3s78g9w=;
        b=GJv3wg8tfOGLQeqX8tXZAWFQQ9jbLupW2EKxiduIYSWjW6PSQRPwaaq1rQVjlNf4bm
         lRCeq8AOjpjPd7UXmwlhH1OcGOPtubDWeslceB+pxsM9h1ti9yXvwRxquGpvgsz3oly9
         0HSmohEFEz1wb8LKCUvmGa7TtmKDwon0S/ywr4SGBQuqPytcqXHFJ0VllPbrw9xMvoe+
         7pbw71fKQdfQCW8hnfyQGCUw58UutQUIiPKvE6RzDvWjt9Ckkv0iZio9dnznFkN5hejS
         pG75SyU+Jfk19N9rMIt+3qiJU2lq1yfn4wGaHAmw9DCo/xGcVz2isbZWn8TCXkb0yCe+
         K3cQ==
X-Forwarded-Encrypted: i=1; AL+hErFTtyjTIIEyzdKuV5eY00cCmuVne8FY+a2VQK5db5I2egBA1c4j5t23NGKE30/1TLTt2kGRuHe/2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cQvPBQybbhJOHBjjcLr4gAwxknugrW65SexaU0xrAQv3wL4NB
	OL8zxjFBeyFlKIglQwv343nGsvI+Xzjj8RPRJDt0++NN9rSMzV9ADRaW
X-Gm-Gg: AYBFou1NooIUKYRvqCC3r/L18+jyUbKdZxrsB97vGe/3maAvvWByRr9/uSmrKxpzsy1
	THq/PHdakEUVxQBWXTBxr+te1XjD8wI0ipK1sONOF9Ty7obfb4xRqg7Wg3q3MyNgbajPqwnjKI1
	qyfIJMF3C2RMFlXa8TkxBKTP8yyp40oImkmory0iLYXMmE9LvNAAVU7YbFA/RAtm9LGT1WTTzPO
	JR/7PHIlBfxD/CWQkZAYJAjyTqLImY4lm2C7oXxI2bjWjjCLrE7wmaManI7HzswfqtPbEbNLNyG
	2VzYNV5+iWGOrwoCcmlqx/QoB1B/arI+t6fyXRHLAV48JoSHbxZ+ccsEsbnf3VgHs/5lt63CgRu
	Q1g6id247gDWGRGCjy6xl4bqekbg0n82/h5U2qf6vfl6urk3vpvngq/ucEl4hnZPvTCerujkhkV
	lfWi94QwT7ugDXsbcJ4ZCV2CDnX2hBJyCi5hS/zyiwbMWtCQBlD/SXbkcngBb4zEgB1H3PXBbVi
	U20zJ1KCUe7TeQdcZPKuRfbIu82OiK3ThKRwvLKP3bPX3sZDYkJxzTeVa6EvFYMBiZyPaOoC7qW
	A4gdxY+dWczLwqAou571Q/hEPhOR+A==
X-Received: by 2002:a05:6808:6605:b0:564:347c:5aa3 with SMTP id 5614622812f47-56b9344c04bmr3276602b6e.2.1794430593243;
        Wed, 11 Nov 2026 12:56:33 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm6564231b6e.11.2026.11.11.12.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:56:32 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Jacob Cook <jacobmcook1984@gmail.com>
Subject: [PATCH V4 2/7] power: supply: rk817-charger: Fix NVRAM SoC value
Date: Wed, 11 Nov 2026 14:56:22 -0600
Message-ID: <20261111205627.56652-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111205627.56652-1-macroalpha82@gmail.com>
References: <20261111205627.56652-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

The NVRAM value is stored as a value between 0 (0%) and 100000 (100%),
but the bounds checking checks and truncates with a max of 10000,
causing a value of 100% to get read as 10%.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Suggested-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 674622398efa..39c945622c4d 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -728,7 +728,7 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 
 	/*
 	 * Read the nvram for state of charge. Sanity check for values greater
-	 * than 100 (10000) or less than 0, because other things (BSP kernels,
+	 * than 100 (100000) or less than 0, because other things (BSP kernels,
 	 * U-Boot, or even i2cset) can write to this register. If the value is
 	 * off it should get corrected automatically when the voltage drops to
 	 * the min (soc is 0) or when the battery is full (soc is 100).
@@ -738,8 +738,8 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 	if (ret < 0)
 		return ret;
 	charger->soc = get_unaligned_le24(bulk_reg);
-	if (charger->soc > 10000)
-		charger->soc = 10000;
+	if (charger->soc > 100000)
+		charger->soc = 100000;
 	if (charger->soc < 0)
 		charger->soc = 0;
 
-- 
2.53.0

