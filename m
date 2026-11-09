Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199367;
	b=Nmm6JWB0oG7czmp3ltkAvAAcy+PjkxCEFNBhgOkjRtJeibuz2boLEWOtoX0lwE0Nsx3l
	 auiTH7D4qfarG7E85xDPEJ6h2mAcJL/nfX8U8LtMtIZb/QuqlcoU1VA09F/rajXX+i44q
	 q23nkTA3xfSYtVR2idYgTxdKFfYsII1XlSNk36C6Diy4jVdCedIbF1hQQD4XsHFJTgYN6
	 AJb5s4acs6pU5RgnZqK3VD1LcjgLoRXKb2aSmXfgQsd6uagsU3SxewLXgYvwPmEl35Oi7
	 dz7wQi87w8MOFWDf4Nn0Suv4YJmRKKswKOWWQ0lDVdVgcCOAc87DCQwjKWGR+E3BwIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=shxUqKnWZYz/K/hcqwVzW+1VupY1njR3r4UW+YRvWGE=;
	b=RWMub8msxzpzBTkmkEwJHC2C1Bajw2oVD+ZRuMR1hwAuLEbSqVbH9FAIBAPOJwNtqvlD
	 9tauBBYL0gFRuSeV/4uP6sk2a8MxRJBt/92Bh7VRqyPfKeHgwTrZqDfCEYhbixgakpjhV
	 urlpOj/sJ9seu/InzTr4y6dOl25dCSHyo/8YYMK3K5ITfO/+h5vxXTbhQwKgInQEt2c87
	 N0g+XM7rpT1yWRxFepd8gVNvHld1RMOWhD0UCsZB2/Q3b2feEH6Q+A0CJs5XjYCJJZioW
	 sovTISFNt83a3867A4h4636rA2tWb4dwy6rgl5s93BII30ZrRABFxQgj/bcPVbYCktw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aFn5/jAp";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA08606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 04:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBA08606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFn5/jAp
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3712b6d9843so109135eec.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 20:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199366; x=1794804166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shxUqKnWZYz/K/hcqwVzW+1VupY1njR3r4UW+YRvWGE=;
        b=aFn5/jAp5/goiBRVghRUHFdJZk1JQT8b9Cf95Pg++7PNnY69wXy3Q1A9iJcXCs8u6L
         qAGQ+TuTq7SmGvbz18K6y0tH3SGtviISG8F9JB7+Ty713HKQU9468NQlKUkI5m7VPbV0
         ziVWxVwpunNz1y8joLB0gHSgFGoJ7ALKA0vzYn3fFg7X8KglQNDV63kdby5pEUc0kdBF
         y3GiDwYIvUrsZgxICqeAs4xj87CCfCyA0av8vGdo6DGfQeAYdSRq0vgt0pjDDv238C4F
         pO5zgDAsntuYNM82nLMGPWanRHIdn+j5rrBYt4CqWV/NOj/w2u5BLY8XSMhYQNaIvz+Z
         2cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199366; x=1794804166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=shxUqKnWZYz/K/hcqwVzW+1VupY1njR3r4UW+YRvWGE=;
        b=pu4MpejGjlycDWRDIhpdYd9ULd9/u3JNualHPn8o/zhpnZbpEjzWCWdc2BLyrAKreJ
         T8Pq0bSI5zxv2LboCatHNWysGqAArRLWJZ7RvUAYCHyBEoFIjL27cGseLakqKVbSjbFS
         rloSh7LIfO+V54xQg2cZl9iI6Z4+MNCA11E2QHBj0e9JWDinPjRNQ43dMAQFTT/LYYh6
         Uimgfk8P3f+gcFVksKYwjEgZonaaK1nHuOPogUlA3hFB30viPJe/z83FCkEcJtO0JQSx
         NsTd08VCfE2jWQ6KTUl38NTw62CBelmFfbFkesGQwGhSfmEZ9IDA+ah/jm2xAOUL8V7J
         0NvA==
X-Forwarded-Encrypted: i=1; AL+hErFatF9lLdQ+k/LF4gn1XxvyGWXN5ezpATypl+6Q9fcpJgb+Is+8xON3tugJ2gVaJB5L1JyUJgDXtw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/nY3CpJzQV/pXB0AfeVIsqT7P+iVYGLiogPm7aJIO//Hnt9fOv
	De3t8iVR4nW73Oww96HwOE81awA9RJ2zAFz1mxWYGYCbbWKZTDFB/299
X-Gm-Gg: AYBFou2OocCwTFefylxvg0pXPuwBgU4i+JNo59QCRn14SLU6J8QYAhwmnIl18GhDBlQ
	YvxCedLNvQ7ad76vPPAAGdKwpJCz6uU935nzo+4uKzsoWjS9vHjCFhJtRt3INvdt7h7x82vLTj5
	l3l2ednBns/j7d2Hp+sSEa3WZvhwcErt11uFFrZ+fqnnf9whVOZ1XJwXEEQ/ynCteKL2BOsw4HW
	2lNvBo+TGgo+fOw23ONCdgteXHdzyqV8kiQ+M+YVrogd6qLRbqtTCJecJkmDbUlyPw45xmxag42
	RHAPhcxq3SOTjSBXOniaaguwXy7XDmx138bAOZyNvX0Y+P3q7dRJIgHvmubuNogLeIR3I8x1ico
	vvlH1K44GKPjmU7Z4jNdRQAsIDIuGaH4n3rRxPP5e02Zt6KsstqRS7W4gKguI/evHwopCSm/HX0
	l+xgXG8AWte41O1kPQQyWM/K5/dfdHsWKbuMEHbvp5TGotoIBe8UtG2wPGQmTgFZPuWh62OcGF3
	scFV5eVceoRz7zJUU4xIFixLPXcfPkHn7in4R1untGA8QZdRFeZj2GP0ExDxikDHQzSs8M/vKqx
	I0BL3Y5GcLvhnweGz6n/XEjBW1NSkPB6YmTJjr6yuJcVq8FGETN7l1JNqJnxDtoyK5Eo6A==
X-Received: by 2002:a05:7300:f14a:b0:369:f9b6:f486 with SMTP id 5a478bee46e88-37256aefa73mr5940591eec.41.1794199365785;
        Sun, 08 Nov 2026 20:42:45 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10154026eec.4.2026.11.08.20.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:42:45 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] power: supply: axp20x_usb_power: drain vbus_detect work before unregistering the supply
Date: Mon,  9 Nov 2026 13:42:11 +0900
Message-ID: <20261109044212.1157357-3-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109044212.1157357-1-hj351016@gmail.com>
References: <20261109044212.1157357-1-hj351016@gmail.com>
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

From: Hyunjung Ko <hj351016@gmail.com>

axp20x_usb_power_probe() registers the vbus_detect poll work for devm
cancellation before devm_power_supply_register(). devres unwinds in
reverse, so on unbind the power supply is freed first and the work
cancelled last. The handler calls power_supply_changed(power->supply) and
re-queues itself (and is also queued from the USB power IRQ), so an
instance running in that window dereferences the freed supply.

Register the work cancellation after the power supply, matching the
"request irqs after registering" ordering already used below.

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 7625366104bc..f6a7dcbd5a01 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -979,11 +979,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_delayed_work_autocancel(dev, &power->vbus_detect,
-					   axp_data->axp20x_read_vbus);
-	if (ret)
-		return ret;
-
 	if (power->vbus_mon_bit) {
 		/* Enable vbus valid checking */
 		ret = regmap_field_write(power->vbus_mon_bit, 1);
@@ -1018,6 +1013,11 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(power->supply),
 				     "Failed to register power supply\n");
 
+	ret = devm_delayed_work_autocancel(dev, &power->vbus_detect,
+					   axp_data->axp20x_read_vbus);
+	if (ret)
+		return ret;
+
 	/* Request irqs after registering, as irqs may trigger immediately */
 	for (i = 0; i < axp_data->num_irq_names; i++) {
 		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
-- 
2.43.0

