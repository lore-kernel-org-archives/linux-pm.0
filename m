Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAF4418F0
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134971; cv=none; b=dbDTOsz2xl6VafiAhQEfrzJZGSlLzM8+IFRp7k1tKtCra/EeuclXJIh09FKAPBfb8d+kr8ibKvps3KuUe6SYV3nIU3ZUGQbKNXpXPln3c/I02BDwoPcpt4LPwnPlY4ufMCHkgBWIFKmeqm0kbQcNOhJbB+qq/ZDzs5Gq4rYVa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134971; c=relaxed/simple;
	bh=oCIm21h1xlZz1ac67TCK0k/M2uaB2EsOtQDVrIRc4YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FrSfBv0yupFzXRHn2ZuDn4IXzpT1gsG95V+6cwMZ51unz3iDYXRYqd2Ia629mYrd/r7XOLcAMMVBGJogWCzy3JqqR9n3trgUXGL/f20zQXJr+GjUxI41+JhfL9Qfo/WKIdBR/L24ZHCSEu4932od5SSXUt376xt9DMzk491vqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=4aDBMVWL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="4aDBMVWL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so19252355e9.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134968; x=1773739768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgvXV9daisj99tiFpRQvp/oWE6rCsyVXhi3xoGqS9rM=;
        b=4aDBMVWLbE4pkVbP5+UGmJ9FE50fL8wakMNGfE6mpmyuoOi4WMP5pr2dYnFqQOPKJK
         KDplrtDP8gyKQxIwevtxfoywsBwTizsvokti+nFhV4uV36kIWBXvEi82LDSfB55QLpVu
         2LRyEj2Z4Xcv6HHBvjzVNdTarbNYL3OakGTA6Q8TFR0TuDTGs7OVx862oz3mu8xNxPvx
         Ax4MS55GZiySBu8kMjD5osLr7ig/62KRXp9mqjh6kBxbx48MkyQTyeEuiK08oroMIyuA
         PiMPZ5zsk1MGRm+fDjyeUaO7qRIrXhSO+XsSjTfIcd/0BbhYccaQG4oW9AtFkR3RdATV
         FiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134968; x=1773739768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GgvXV9daisj99tiFpRQvp/oWE6rCsyVXhi3xoGqS9rM=;
        b=Q6KpiJcNIYLaJ45gEeCxlUYYjTcCih021JAfb1Qg9xydMWTUmZolJaq5DR8IUwkfoh
         CtdA32kr5XJ6T6PKzp/sZ4OIeRJAitTzbd6scWFF/uHV3+Vd0z7iVbU1nKex8tWsS69Y
         9wKVb6oZpCu2Hts0g1jFYXmGxtY1hOZMspcFnbVWIWTuLEyo2vfnlEjau+H6l4rFfWX4
         P54PL18PdPI0dgaf9yFoGejM6R4PNKKxf0FdEQoMnma4YkMmE8EFCxS/LyNvcg77JMr7
         gJuKtD8i1nXJ9vlEvc0BDjT21DRfpyvM613PwzHYh9cjbmvQ8KJYGsfuAY11T+yXtcUN
         JV0A==
X-Forwarded-Encrypted: i=1; AJvYcCW/DqJ9Ll24Opfbzo+MlFpUGCLHz/OJq4SkckkJ2XP2iILS+tWl3Bz9CCl9aStiO/RtInTZCR7KHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpQ634ZHriTLOTTGmiF2HU9C5Zgzo62IrOb5zZGRzosQ1VKbG
	lrOyJWtRj4vi3O6M3IYr7sRNGWFcKYcY3b3dnSzdFx1z7t5hz+wgnqdxo8e0CcJkhBs=
X-Gm-Gg: ATEYQzyhQEC8oZgUBgmrfGRa2XE7zfNw3svaH0/G/BZj0KtP38aF/ZmDODWRGa3TyIH
	8y3jfj5euFZ92DJEsr9cDVyyjui1Djk9AGPaUonDuvq+0y1VwYk7GtOg+2/+qNlNJ1qJTi6se8g
	6adc12BeZb14AHBopXL/5bYd2c/D4hKMEAjct9wV0ywS3awQImc3T9iBJ4Ax8jIM7J2cqOse+qH
	Xb0ReSpHDjvVnEM5maR68lx4VbFKV7aLyz1Q5E6a1a6o/Jc3WqT/2BHTQMcZ9Q02u0qjKuroP25
	L9Y9b7Ys11wqmHctyfVBQIJEZfGPRK3RdhRFLfVfv4A+29T28mgq7MPncekR74siZnXSaP/6JyE
	TwOYTm9bzD0Jv1GOp/N5Kuucy31IrvlgCcn3ZWJCecqAr3+7EMDHwz7Gg1LoSQ/rNkFZP0Ga/z2
	UDzW6DOLjvbGmwHJRQ0J+ReprSz1IqRGX0cdH+hlRLtkYen1VP4P1PsYCKGb5TcmIIhtPmOQGHc
	snJ2A==
X-Received: by 2002:a05:600c:64ce:b0:485:3ca4:4ef4 with SMTP id 5b1f17b1804b1-4853ca451d9mr88483685e9.9.1773134968403;
        Tue, 10 Mar 2026 02:29:28 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:28 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:32 +0400
Subject: [PATCH v3 08/11] power: supply: bq257xx: Add fields for 'charging'
 and 'overvoltage' states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-8-02f8e232d63b@flipper.net>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
In-Reply-To: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2521; i=alchark@flipper.net;
 h=from:subject:message-id; bh=oCIm21h1xlZz1ac67TCK0k/M2uaB2EsOtQDVrIRc4YI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5IYEyN/Ppbnv2n867x654N3/7lIGG5Pv6jL12tTM
 ns6w+XujoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKZ65zmG/85bw2RdPbV1q9Ssav3f2+T2yLOldxUuUJXi8s+u93qTxfDP5K3E6d7
 7JWpNO6bfbhZi2hj7LzL6cLZEifCcD2Y7rmznAQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The driver currently reports the 'charging' and 'overvoltage' states based
on a logical expression in the get_charger_property() wrapper function.
This doesn't scale well to other chip variants, which may have a different
number and type of hardware reported conditions which fall into these
broad power supply states.

Move the logic for determining 'charging' and 'overvoltage' states into
chip-specific accessors, which can be overridden by each variant as
needed.

This helps keep the get_charger_property() wrapper function chip-agnostic
while allowing for new chip variants to be added bringing their own logic.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index deb60a9bd222..951abd035fc5 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -64,8 +64,10 @@ struct bq257xx_chg {
 	struct bq257xx_device *bq;
 	struct power_supply *charger;
 	bool online;
+	bool charging;
 	bool fast_charge;
 	bool pre_charge;
+	bool overvoltage;
 	bool ov_fault;
 	bool batoc_fault;
 	bool oc_fault;
@@ -99,8 +101,10 @@ static int bq25703_get_state(struct bq257xx_chg *pdata)
 	pdata->online = reg & BQ25703_STS_AC_STAT;
 	pdata->fast_charge = reg & BQ25703_STS_IN_FCHRG;
 	pdata->pre_charge = reg & BQ25703_STS_IN_PCHRG;
+	pdata->charging = pdata->fast_charge || pdata->pre_charge;
 	pdata->ov_fault = reg & BQ25703_STS_FAULT_ACOV;
 	pdata->batoc_fault = reg & BQ25703_STS_FAULT_BATOC;
+	pdata->overvoltage = pdata->ov_fault || pdata->batoc_fault;
 	pdata->oc_fault = reg & BQ25703_STS_FAULT_ACOC;
 
 	return 0;
@@ -471,14 +475,14 @@ static int bq257xx_get_charger_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		if (!pdata->online)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else if (pdata->fast_charge || pdata->pre_charge)
+		else if (pdata->charging)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (pdata->ov_fault || pdata->batoc_fault)
+		if (pdata->overvoltage)
 			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		else if (pdata->oc_fault)
 			val->intval = POWER_SUPPLY_HEALTH_OVERCURRENT;

-- 
2.52.0

