Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927219;
	b=us3hoQGnfHtDS18qvHQc2G7S+rJdEFtsiTRkRVZNFt2Z93nfRZmEJGPVcbXNwy26srWd
	 t6Ut0pZ2vJR8b5rUUhXainRzriw7TQz8ZwlESsXHRZGSEh2x8Dn2x4LTlUufC1jLj++6I
	 Hd3qpySJrgTPSRst9avheNVz6TiDAIVi4i74WlXVhpb/zF4XcLdKdFcw/+cUtpuoRsJB5
	 3uktN+9956a6Ou0sXSiWArbZsAPp+S9hMTjNyftXqfUE2kAAff/yXJ2iy3X70tjhHyeYx
	 vseqBIKzGMe4m/pYIjxTc1A63NLZ6158IW5dDRsZ+N9mwloGBJiP+eWnz0N/Vptqmrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ji5dmOGNAnAODAW0ROWats0oqO4n06TBqSd0YPOj2Tc=;
	b=dy0GRmjb46ThrktX0ALOcBzLOcCh4jkpLJfTt6rti60KkL8Dr9T4ZByG0dS4krzMjJ/U
	 Fa2JNMT6n3mK0bX2jVy0KXGyaYCz12dQFIqHLW1pCPBykoK0AyCcNdIk6bvnBe7GCxOk7
	 fC5Dubc3i+33UxqweYYYs5Md/3E+KzPoETPQ52PFTgYJesRCM6middDipKQRErT4CuGdX
	 B/JL1mkJ0sGHZMiKf48oWfFW81QqgNNwiYd74BT+55VGGuzTSkyMb/5fUHosPPBCNNMVj
	 qHiudOKq+S8HC04SKs7mj1s0PqP0c10TQO1bFPNK2pfTjKr5bICkVBe6/JD5dS66DJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UOaOdSNE;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823B606A336
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 14:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C823B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UOaOdSNE
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e95bd1c14cso52609315ad.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794927218; x=1795532018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ji5dmOGNAnAODAW0ROWats0oqO4n06TBqSd0YPOj2Tc=;
        b=UOaOdSNEDPzwKswibDqadUr7H5tNKhoihyUcBZqvCA0eThpzAd3uAkozvLkxyi4hNL
         tkQSkRolpThhjcCAckgYfBRcE3FBrANXv6XXUIBGlpmPuNmoSBsrBcceYXw8h41Q6shv
         yBJ3sRQx3maVFHiLv/5yQ9AcMF71+6poyQ3IkbEqy51W10R21yBR7PNcw5EYbMbdmXMk
         dJEx08mhRduNBpcK7wR/o+kXpxztpJOOMfiXriLFEAmWQb4VQ7fyuYp40XhCI1Qyo77p
         96ybB1rSrTddEkAXJ+7fz4q2O05s/QgKSQ80GfldeGFxXIB5SYT1akubImj+Mt8mP+6N
         cv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927218; x=1795532018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ji5dmOGNAnAODAW0ROWats0oqO4n06TBqSd0YPOj2Tc=;
        b=J/IBT7xFV0MqTQHHhTLjELpybc54VOXHccbhUqoYWI/+EDw71xApCle3FfLe/CMiC5
         rRv63QWMOjHySQUAPmJ61UxtlWdtE3/YfgcUiSxTmdZdIwC6Kv6zPhIMZC1pAEeGX67t
         TbjK3j40E/QX48uxzVgp408UzRaqNZl+yyR8flBlm72TAq2bVXj6kPTR6wlVuvKjfhCi
         7TmtNh9EJ7A3hU6dE+l2pwQ+79/8rybfbexpR0R9Clw4v2MfOLKmSzEW3IgnXQDNKzTw
         E8PSnU5CZppw6Wc4KU/as1lTL28X8DwGfEB2LO93h57Y0LUvPbRHBbM1tuX10KT8N5F2
         Rs4w==
X-Forwarded-Encrypted: i=1; AL+hErEkt475nr1Af60U6Op9kaRH6aVedjVvWYyfIC8FFEXyi2Rt0N19tLPpPYM6slW7pJ6t6iljv5KhAw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tq0mgFkHca/rIEck/C6CfLX1XB4gCJGBbEEXdHbCVv8tbRCcg
	sbPA63Knb4OQTHsOxEZT2uKZIMfpr8PLRzbIXIfztC22WLyPEzgNrzXHyv5f66jG3Jo=
X-Gm-Gg: AZFdTZcgB/jmjwWkigQkdh8Kb2Ws6Pp7AAPhsXJz+ynx+nGZo3NbgkSAwBBa6FPh0w3
	6BXYwcW96RsEZwLd7MOn7vZZKbs0DwaiPbjXcVHr8TpILgwmmsOW0XXj4o6k+k3UlhOTvIS+pHy
	SkU+cNZMzXoNETCa0urO8oXEP2G7yGhohDr0jt4sAc//qJi+UEvJfabG4O2qc5byZHNi1VT6kQ9
	CUN7knCTXalX0EqbNuUHMUjWr0Egp270PoIUQF/SgJK0/EEgiWkGJwVQ+izgMD9AAJJ0OyKVZVD
	G1+6N9CfMrT6cy+UAsGaHWIcTX589wYxegwSDDwDZuKf3emnS5UoAkmI4vYt0eV8E0n6oNt+38u
	iiIp3URtmqpSyIstRahkkCKHCf4VFtVeEubRANye+LVz8ODGBMbCneIXi1KEMTuQQMmE0LFTORu
	xRtFrtaqDB0J+odJ+SuuOTq8fb86UaiTAGbUOe1+v1OMAbS8QOSnUPV2LbDBdG1Yu7ZexOGz/pD
	Z1QLTNb/dgemd09eexHEr3er1mrPAbk83EdzTZhR/FRXO+rIo9HZnYNBvXi5qlIiptbNs9T4VGU
	j9VuxOrdCtym2p95YwB4tUC8nLJcQEliqIlHmv9KU8O57t8cYhuW2sk0fW6QdpOXJ5lPuLLd+bL
	MFqCGGlTRzzP6DnkRVGYt9x7QxDktWZpsJbQwTQlR
X-Received: by 2002:a17:903:1b46:b0:2e9:660a:7944 with SMTP id d9443c01a7336-2ee0df11a51mr140279215ad.58.1794927217892;
        Tue, 17 Nov 2026 06:53:37 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a88a55sm17545035ad.65.2026.11.17.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:53:37 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: db8500: register the zone before requesting the interrupts
Date: Tue, 17 Nov 2026 22:53:31 +0800
Message-Id: <20261117145331.1092458-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Both threaded handlers call thermal_zone_device_update(th->tz, ...), but
the thermal zone is registered last, after both
devm_request_threaded_irq() calls.

That leaves two windows.  During probe an interrupt can be served while
th->tz is still NULL or holds an error pointer.  On removal devres runs
in reverse order, so the zone is unregistered and freed before the two
IRQs are released, and a handler that the hardirq has already woken can
then operate on a freed thermal_zone_device.

Register the zone first and request the interrupts afterwards, so devres
releases the IRQs before the zone.

Stopping the PRCMU measurement from .remove() would not be enough on its
own: db8500_thermal_update_config(), which both handlers call, stops the
sensing and starts it again, so a handler still running when .remove()
returns restarts it.  Register the stop as a devres action placed between
the zone and the interrupts instead.  It then runs after both handlers
have been released and before the zone goes away, and it also covers a
probe failure past that point.

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Prepared against v7.4-rc1-1969-g666539eecdf4.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.

This revision registers the thermal zone before the interrupts and puts
the PRCMU stop into a devres action placed between them, so devres
releases both handlers first, then stops the measurement, then
unregisters the zone.  A stop issued from .remove() alone would be
undone by a handler still running db8500_thermal_update_config(), which
stops the sensing and starts it again.

Testing: compiled for ARCH=arm with u8500_defconfig (gcc 11.4,
arm-linux-gnueabi).  No Ux500 hardware was available, so neither the
normal removal nor the second-IRQ-failure path was exercised.
---
 drivers/thermal/db8500_thermal.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 48981247763f..b8f75838cc4d 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -148,6 +148,11 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
 	return IRQ_HANDLED;
 }
 
+static void db8500_thermal_stop_action(void *data)
+{
+	db8500_prcmu_stop_temp_sense();
+}
+
 static int db8500_thermal_probe(struct platform_device *pdev)
 {
 	struct db8500_thermal_zone *th = NULL;
@@ -160,6 +165,23 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	th->dev = dev;
 
+	/* register of thermal sensor and get info from DT */
+	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
+	if (IS_ERR(th->tz)) {
+		dev_err(dev, "register thermal zone sensor failed\n");
+		return PTR_ERR(th->tz);
+	}
+	dev_info(dev, "thermal zone sensor registered\n");
+
+	/*
+	 * Registered after the zone and before the interrupts, so devres runs
+	 * it after both handlers have been released: a handler cannot restart
+	 * the measurement behind our back.
+	 */
+	ret = devm_add_action_or_reset(dev, db8500_thermal_stop_action, th);
+	if (ret)
+		return ret;
+
 	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
 	if (low_irq < 0)
 		return low_irq;
@@ -180,14 +202,6 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	/* register of thermal sensor and get info from DT */
-	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
-	if (IS_ERR(th->tz)) {
-		dev_err(dev, "register thermal zone sensor failed\n");
-		return PTR_ERR(th->tz);
-	}
-	dev_info(dev, "thermal zone sensor registered\n");
-
 	/* Start measuring at the lowest point */
 	db8500_thermal_update_config(th, 0, PRCMU_DEFAULT_LOW_TEMP,
 				     db8500_thermal_points[0]);
-- 
2.34.1

