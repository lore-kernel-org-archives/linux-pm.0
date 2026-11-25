Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575819;
	b=Qa/Zk6TiXtGtsrWgYzz0xoj4XZiPs/ukbdX8ax6LNYoB+JgjwDNEyNEbQhhAakMeu3Hx
	 /dK3QFrlfNGWKd2RCzFtBjYXaOQ7vy0EYjWf9+Hc91Y3iu188UtyzPG+jC1qwktXf345j
	 MlVPpCWD8Dn8Un6WLXw6AUlI2DeLa3bmthL2X0zBrDA0yT5lfKJVDGue5cVDrZUapMW0X
	 iYUHTu9UlUWuZk65PTp1z1ZSPQw74ijTC3pjTcC1bZpnJQqjJSAyBdqs5Brt3pukoh7+H
	 0+6fqJV4UA0rp5hYJ9wYlirSHo5oMKWxG+QbGDq3y30dYO12JA16B2VytKiX25uNv8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtRLHOs8cntlnxdkgv4Kw+h5TM5UXfe7SQ7bFbXkzM4=;
	b=MZTQq6IYGzzc6hjGB753PgeXlSVmNAMxwhajLvQbSfO6MQJoNWq9jcol4Gf/Xc75dLAT
	 F1l1uEllu794dPH6tZQTdK1zzXb4TpCPSLaNVUKLWsG8xLmeGUsjWLjID5NZlynzkCsAL
	 PYWw7sKg3Vre0wATfS64a8tnBh/eiji5l1jAJjIimLxYe/P77rq5tlegc5fV1HxnFdK3b
	 3TxSzWp1W54zDgSb+8bjbtJ/TXXIkumkq03mYSBpQIhPzuPiugMKdFv/lV9fEj66E+b4Z
	 QjGJRV33t6rK2x2lj85LG/eveVsIiGbEN0It7Pg1uiMZZ0rNl8XnNk94Cq9+Glts0lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TKOVKSt2;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B1606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B2B1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TKOVKSt2
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so4640018eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575819; x=1796180619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtRLHOs8cntlnxdkgv4Kw+h5TM5UXfe7SQ7bFbXkzM4=;
        b=TKOVKSt2MdXGJInMSKFALiaHDsdHQbhwKK9lg98AHMRSX3/spzwYNAo05kQ/wIrQ/5
         cs3kpotHqq3rqtGsIGOfEiHPMaBf3bEzRyB0GXtKDoUYYnL2O3sLdJQ6F4H3r5nT/mHi
         rsfQ2qnCw69gXaDMFSEeDS8N8kOILefhIGR3mVl6E5L4KF50kDgvjrdOqru/9GXw2y34
         pcvPDJmkRcXh+0FpZZPD71wz1Yd7UHrStUa7HDZ2oqJ3b33cXwJKijwMfR/DS/TkcXCp
         2zx1MzKEWgZirYZVkuWUDa/hdPsjsHtjnozOI9STanaIMcJ+gpVQYIOQjY6r10LE7HVu
         hxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575819; x=1796180619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtRLHOs8cntlnxdkgv4Kw+h5TM5UXfe7SQ7bFbXkzM4=;
        b=183BIP3xACVV22w/Ao26uZk44cRgFZqon741hi2Xb9zu9o7/VzCFs2z5WiyQ2pNIA1
         jftAPSBqH79GLCSJ/zMi9pWo7edgYVyuD21HyyKlFMFW7Xdjvq8J08vW1ptD2yx1GpPE
         5/3/V+Qk0bgP9UeJa3LbLxrr1wmjothGc0ekW4INR8/LQczFUkpxqx4nT+g6urunb4uT
         fEtSbilnwidKbw02zaoJT7CSiPZ3DopajNPCKvLe2Br6QXibnYG4C4SVZrKdB7ItrTxo
         hvEGYRQxDoj8x/+I3t9aG7olIzleV9icfb0lx6VdHdeFa1CXQiacuwdAF8fl4wYELH5T
         mnPg==
X-Forwarded-Encrypted: i=1; AL+hErGsrUxLseDwmTBOjVBpH+cS1ECNQPYcTJhArn/oa+9juz4lLokNtRdZVjqSQcWFxSMVbBzaNFq8Tw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kLCpxmrRvZykeCF3ZbYf+ZPrvWiP+I1d8Vo4yLrVldPDJGTrD
	9CcdXpDBKCq6x7Sc8YHWI9Y42H3fdsKDCz+b5lIeK9YDIAHbphjhyAej
X-Gm-Gg: AZFdTZd+9CuBGuZuLoPgNq9uiVcPD4P03FJJiCnPlYkaoiyH5MsuRo2mNipA/5EZEEl
	DlfRQg1xjF2cT+A7QcSy17s6Hy3N0el99O6nep7b+HPraZXySU8uYtE3Yp6IXb+wDsDEqx8ax17
	IXeh6joywznrxLnKAlAQ/RGZDdE7is3DaP4CgnkE1ccReJjWtu2jT26ftuYrFZX6pASZ+G1tToH
	t8fiagskxIIJngI0sc6HQlFJy+teFB28cRgN7NITstrYzfG8PGa4rg1cxqWZ49Xm0uwaXJfL8+G
	x//u+iP3Mdg2nhTCwyvqa8EiGN/j6NezGcT0VxlUtWH1jdP94og37dzOJQyS+8t/yEyctP/97vb
	4fDQIIlVMitu1LcEy3TH2FqFIL6rKTUKXs2r5oxKxfQtgVc1QR044i6ck9Ccgy2h0OPh64Qwqni
	2lItLxcfQ/1iSvrpAgxhywzmlWmoKlMt5zDJcv2OQNTUDnPuuclxddkea4LcQ3hHD0cTiLhr1tZ
	0PJWyggaHlnYsIdL4ScruVAeYSF5DQZQa2tBw7YqI6bL7QznZRybkJw2A/W7ZILD5vX97xCm/tR
	10r2BBqsrDJuJyJ7S3QE9IG4EK4KE0FTaG10ZjDjIMW+D1onDawW9yVJbU7hIp1bsnsNAFhZ383
	IJGXboJO2sMnIKeEVakAbMHpXk1H2HyYg9KoGYGdZhSKE4nv1BT+X5w9UnW18bswooFQd
X-Received: by 2002:a05:693c:8951:10b0:386:b4a1:d92a with SMTP id 5a478bee46e88-386b4a1daa3mr7194731eec.1.1795575818364;
        Tue, 24 Nov 2026 19:03:38 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm52243475eec.14.2026.11.24.19.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:03:37 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] thermal: rcar_gen3: check for sensors before reading the fuses
Date: Wed, 25 Nov 2026 11:03:25 +0800
Message-Id: <20261125030327.953450-2-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125030327.953450-1-shunsheng1218@gmail.com>
References: <20261124095110.131258-1-shunsheng1218@gmail.com>
 <20261125030327.953450-1-shunsheng1218@gmail.com>
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

rcar_gen3_thermal_read_fuses() dereferences tscs[0], but the check that
rejects a device without sensor resources comes after the thermal zones
have been registered.  Move the check up, so that a device exposing no
memory resource is rejected before the fuse reader touches tscs[0].

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
CONFIG_ARCH_RENESAS and CONFIG_RCAR_GEN3_THERMAL.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 9c64cbc2ee67..a96f02d4a8ad 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -557,6 +557,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	}
 
 	priv->num_tscs = i;
+	if (!priv->num_tscs) {
+		ret = -ENODEV;
+		goto error_unregister;
+	}
 
 	if (!rcar_gen3_thermal_read_fuses(priv))
 		dev_info(dev, "No calibration values fused, fallback to driver values\n");
@@ -588,11 +592,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		dev_info(dev, "Sensor %u: Loaded\n", i);
 	}
 
-	if (!priv->num_tscs) {
-		ret = -ENODEV;
-		goto error_unregister;
-	}
-
 	return 0;
 
 error_unregister:
-- 
2.34.1

