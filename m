Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785693;
	b=SPt4TCQN4kmNpPSHBLt3k98FuYwnBy6zAA1u2tU5zuccP8vMe326JJwmvCUs6qV7uwWb
	 Ob2bk53x9NtLT8TNNUJVJHbeFxkxjcECXx9+a6mNOm8uasHe1/u4AqfRBKtQHpwrZNi2S
	 ZNSayiZOjyPjuSSKtY1S3zYSvEDhVtrXK1WYJMA1U/8wPSh8avbVBQ0eoH/J/IjEXMqAU
	 8g9G1WPJU3o7iO9iyQItAZjRdzLi687vG2N5B+rEQANwVMoxeBYhWXRJocZWI74TouDXn
	 BWRcuNeTXauGOxUrnb6aFfxzlcM2iCcA+RL/OhViwaIhqX7O/J2LD7FMNOqOsKSfBMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:Message-ID:To:Cc;
	bh=csEO5ITGieiYfLlRHach8Sl5I2GDEIKt9+RVcncVde0=;
	b=XXu7CwH5+bwQrd82421WO8aMttYycWxeNAeJlHFgFUMGE0SuOFiDJzj6YqSja/BsPi0I
	 M81DfchiCyutBp/llWRbZ4pdW55f3Pn4xEQiJcxEBvaM/HJj7wMoeOs+0+FzNhejcArC9
	 Vd0fiUDD7tAoooSJhoYRXzR0VbU86rappMBcEsd9pDobhxjDb6Y0NenF5SA/ctzazY5ye
	 9Iizm4LVd9y84Em5/cUCYkQ50NOmwxEDIPe7T8gX/fi1DVcWcXGTJI9eTUxK02aZ4wVEk
	 5LspB2b4W+PNoVdKJ4iiNyqUZRfYtOXosVr01vsW3b0YE91LAfCGoUVQKzttF+dB5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srYIPxVn;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3C606A328
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 09:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1B3C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srYIPxVn
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1148832c88.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785692; x=1794390492; darn=vger.kernel.org;
        h=cc:to:message-id:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=csEO5ITGieiYfLlRHach8Sl5I2GDEIKt9+RVcncVde0=;
        b=srYIPxVn1p35OZGnV591eyvW5rxMAeWP3IoKZavPAoLLTkB36/TTZt9M6JWsHiHN9Y
         Z3v/H38GN4NHtRy5cMC1aDVPFtY69ZbYjGlKwxk6WWq2FBoVC5hxWa6P4mzxYWHK1NqL
         7mHN9tUseuPrBWxoV6lgrBnkjviN/VGEkO0cyEN4uOBBVb7tf1fYXu7FcrkbN8atxvuq
         tbhgzBYvYelmTm9M8cl3q0bWf1p7VeYk1uSOnNeDQDXlyTvAWY6ZMyO47PD53n9doqMh
         KDk2NIMkhZBxlQA9aIn2XF6pnmIZp/zc15jE+8b4PDqXw5TZIBvL/pdL8HJLRinZvV55
         tc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785692; x=1794390492;
        h=cc:to:message-id:subject:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=csEO5ITGieiYfLlRHach8Sl5I2GDEIKt9+RVcncVde0=;
        b=zNMVJ/jar10c8bV6WSxgLa1cM5asMbNja2qnyd6E1G6Oe66GNbGQHP8bnsLMWalFbV
         boWPpZaIMNR+nwM16XEPcVNpmXf/oOvz+R7lOGqbOP1WV08ytKiMT4WNP7hHRVgb7SJQ
         lLsweBnwKNGF3aWonOyZkqiBHQ98WmAhUl/Td95g2dRn3pytTDnTv06A3muVyahoyeSy
         JFxtezRpGCfZZDg/4voqRAvwzLIf0skVTznaQ1msThwJgVVzzlrsU/sDq3vcO7NocCPX
         l4RQstdOpVGFs6WXfW/a49Vc0373f/zgm3pqQjGtHbl8sgjojqQk99CFP6Pa8vw+M4jF
         F1TA==
X-Forwarded-Encrypted: i=1; AKwUvBzjF4xLp+Bqodj3BKezTMkxaZakpPmDsw0IeVSqZ20XHNQNAQKzcVmF4/5hZtRw3ySD4yY6mBuPDA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8UCMZtlNCJQR8ulcgxNItVxMYeLgt5QlBa4+sazgIkG9CF5I6V
	cRpqRExxnvHek4o1TxlnnDLlzJ53VjNVG+fybK+TSGW9Gw9FRC+cKWxs
X-Gm-Gg: AYBFou0dYs+Sp4T35t7cdTUtfzaNXNwKP4+y0lfKMLTl3SrzL3YLugUFtoWD1IkDlhv
	a+kaymjSZWRLBH/OX+Yo5Gsoa7Pi/TkHJt8VUHPWxCkpiJNgYcOZj4FX/WTGUTlQGJQgwAlneky
	RnD5ItfnYMgsP1lyn4m6gfHzj6inWdn3J1+7NTiu2tamcXscmQENrV0KFPTKaj1bGkHm9kDgmKG
	LB6GP7XJudTkJTlKnHqC5S9MrxSWSX/fsxyHqudfq4lIGeOLCfPgbou6EdbkMHGUbJE9+q3An4d
	PkG6t0v3BbjSvfnfUFK2NSDjquaye2H8LSTneAr8fz3x5DGk6zZN5XUHhdYVtiHYHdLz+d2RWhz
	weDA26SYV+59Jcm0UxPW/o1eIOkl9bgYuZIVXoT65LEgpOrjdVMH4MQparPbSRmExFTqS6S5fu8
	jk2ib3HI/JIGvCJimSgNnIcbs0658RmiDuuzWq0v0WgqoR3a8vhx4tOU0usFBjHqJI+R+W6Qe0L
	4aLgkGJVh4sJ2fD5bAB26EIkodI5lE5ZQRmrobRM1rh6YyNul+Mn1QedWzZLsEtx3a9LdLVHzOD
	yMUXUYPTsy0UeKYWpTNFqVnnSeX1N9Xgy5OrABeDt3sh3pDlNztmYshPK15q1r4sjGs1
X-Received: by 2002:a05:7300:a98f:b0:360:8596:657d with SMTP id 5a478bee46e88-36a42401568mr33706705eec.32.1793785691546;
        Wed, 04 Nov 2026 01:48:11 -0800 (PST)
Received: from [127.0.1.1] ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm3323400eec.5.2026.11.04.01.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:48:11 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
Date: Wed, 04 Nov 2026 17:47:54 +0800
Subject: [PATCH] power: supply: bq24190: stop IRQ and work before supply
 removal
Message-ID: <179378567491.72692.9015711605062239156@gmail.com>
To: sre@kernel.org
Cc: johannes.goede@oss.qualcomm.com, krzysztof.kozlowski@oss.qualcomm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

bq24190_remove() unregisters its power supplies while a managed IRQ
handler and input_current_limit_work may still access them. The
managed IRQ is only released after remove() returns, so stopping the
supplies first leaves a window for a callback to use freed memory.

Release and synchronize the IRQ before unregistering the supplies,
and cancel the delayed current-limit work. Cancel the work once more
after unregistering to drain any instance requeued by an in-flight
power-supply callback.

A KASAN test with a simulated I2C device and the in-tree charger
driver reproduced the race during removal. The same test completed
without the use-after-free after the change.

Fixes: 4f73a52df7d28278 ("power: supply: bq24190: Avoid rescheduling after cancelling work")
Assisted-by: ZCode:GLM-4
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
 drivers/power/supply/bq24190_charger.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 7a5867dd74c23..fd0ea5385f0dd 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -2265,9 +2265,24 @@ static void bq24190_remove(struct i2c_client *client)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
 
 	bq24190_register_reset(bdi);
+
+	/*
+	 * The IRQ handler and the input current limit work both access the
+	 * power supplies. Stop them before the supplies are unregistered
+	 * and freed below: the devm cleanup only runs after .remove() has
+	 * returned. The second cancel catches work re-queued by an
+	 * external_power_changed() callback which was still running while
+	 * the supplies were unregistered (the work has a 300 ms delay).
+	 */
+	devm_free_irq(bdi->dev, client->irq, bdi);
+	cancel_delayed_work_sync(&bdi->input_current_limit_work);
+
 	if (bdi->battery)
 		power_supply_unregister(bdi->battery);
 	power_supply_unregister(bdi->charger);
+
+	cancel_delayed_work_sync(&bdi->input_current_limit_work);
+
 	if (error >= 0)
 		pm_runtime_put_sync(bdi->dev);
 	pm_runtime_dont_use_autosuspend(bdi->dev);
-- 
2.34.1

