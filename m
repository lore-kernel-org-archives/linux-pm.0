Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3631E83B
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292553; cv=none; b=kuSXeJUnouKS/jscfb3FhIS/KQW7haES3OmAK36pY7ACEW4AegY8rSVSwBMu7z8Oo2VqjOmsVihABp7zVJ1e3djQe46GkaRbRPoldObso2gl/0lQ8T8p/EET5t0kd0A5N2D9QDCfWtNb4xI8JzUmX2tQS23vt4vs0cvXXxP69Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292553; c=relaxed/simple;
	bh=xObQCOiN0w+zUIIotJQUzrX+GI6lzkrYiMyhdIqPchs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGufSlM3BqLAi9fg/prhjyBC+xITDsYrgdoBRgYGm80qxzsnHxCMSNqqLrjRzgRAG/QnWhIVKE3W+Dff9xyUyEb51qSp38YrP3MnL1MgmRce+zPez+RDR7UAfpVe14KSPr9vEfd9ShycBzOXfB2y2dDeDumg05+K9oNlIdOTFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/ry8pf9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/ry8pf9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so56146025e9.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292549; x=1779897349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV5z0VH3S60eKaBNh37Ayp3vpCM7R2YdmjwXSt3Qs84=;
        b=j/ry8pf9D2wyaWwdx5UUKrTNiuH/vuTTnRGIYiSAhv+cfgsZoCfkvDFVixh+bMNwtG
         2iAvEtPLgWoedHXJ/h1YMlWWtLGGjrctel3HjRX++4V82F3qprmKxER5W5Xtl5E1P+Kl
         cPKGW7QG6hIJqaZdN6WtrgPKUn4FYdprfPObH/flFxsP8ltM6ta444+OKZMjj7m8bDJk
         IwIJD23EdjDdpiZlSOxRQrZJkhkRU85FFNMnin92imZprpXbs11QWhDsODe+7wI05LRY
         R7je0B0t6X+WnBEVsHw9gGIYlBH3sMbBB5gWeuBMpJCZJy648SeVYn/+GGiK2mXn5Obv
         SXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292549; x=1779897349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GV5z0VH3S60eKaBNh37Ayp3vpCM7R2YdmjwXSt3Qs84=;
        b=D2lHchozbxGHBp96OCuOE6GF0xEqbc9OUN2jMkXoykvOV1WQ2avUlc7M41tjxmmukY
         MwniVYHKRh/RLW5uagUNHCIX21gtq9aBDxejifSl/BonGlU9b6fzO7PSFbawbhxo85M3
         I1Umw/Wm+PjDZDUD8/YpAnO/KlwkM6zfoe9/SKUmtFBRhTkq7+rn3+TdwHu7jz/dnFcu
         oU47bj8I3x9Ct0lQRhz+7b6b/pt9Om6XM6ki6YWDzSAzkY8k1bYL8B7f9fSbiiwlGZVm
         X/UrgQ3rZFVPSRNyjK2IOzJsSNQOhiroL1QeB1xhXZCUqocyWjGTUnhUpcKfbNcIZAvy
         jOEg==
X-Forwarded-Encrypted: i=1; AFNElJ+O4QmLxbyHNVnhk5u0M3ZDvikw73y6oRjjyJri0T2hFycx/0q1bbpCO+qVWh3Sf2bwgUMuTOv+nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwefvXfCeMYc0PN/cuBViCO/Vc7fHI92+HHMjl9I/MN6ml0v0F4
	n5G7izEwl8UsAZpBC6/9TV+3trV0kombUezh/XJKuZNmpgmsT5JBw+Wv
X-Gm-Gg: Acq92OHH70qHwKCWzA7FDHv9TUPGZRnOwcKQhErm2ngzJ7aox/1BGZqjLZBPiO8Pm/h
	hcIKYAaCkmqYEKIKgp4X32fY9rfjykHLU6FccfQKBM9ru7IfyUUWtASusY4duuuNqySgdA5G7ob
	63syNC352cqr/mhkoAx6b2ogxQWmKnBzLZrr5oMbRGVTRdwK4Iymb1STwB0BTO4A/2OBGc1vLzy
	N2UaTpQzUTgP1Vy/UhhAQoIX0xXlj57zPMkV5ZujnP/qwSNz7d/me4Clef+kJB2LLDEfeghVTXW
	rwjA7NF61X6yKRwMfuWhONpexpa/ICWRG1Igk0lpmMokiuYwACyv9bCrgMhblB6KaxQuWeiRU7A
	uoYv8MEKWQRMuXC7VdaYidZ73FPZdGI6JDTsFF9ITadza20IHm/fjfTvUwdMHK2MOPeVLHDNXmb
	bwNn/l6LVLbOxBP4PJcPvffcNcqb+l2aRY9DfDQ5XYfiRwPrigJ0GC+WHWV7SajWE=
X-Received: by 2002:a05:600c:3b21:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48fe6514dd6mr361015365e9.24.1779292549009;
        Wed, 20 May 2026 08:55:49 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-22-5-99.retail.telecomitalia.it. [79.22.5.99])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fed253f93sm132123215e9.16.2026.05.20.08.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:55:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 1/7] thermal/drivers: airoha: fix copy paste error on clamp_t low temp
Date: Wed, 20 May 2026 17:55:14 +0200
Message-ID: <20260520155525.22239-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520155525.22239-1-ansuelsmth@gmail.com>
References: <20260520155525.22239-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In airoha_thermal_set_trips, there is a copy paste error on clamping the
value for the low trip temp point. Fix it to the correct value and actually
clamp for the low variable.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88e5..439aa011b75c 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -273,7 +273,7 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
 
 	if (low != -INT_MAX) {
 		/* Validate low and clamp it to a supported value */
-		low = clamp_t(int, high, RAW_TO_TEMP(priv, 0),
+		low = clamp_t(int, low, RAW_TO_TEMP(priv, 0),
 			      RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
 
 		/* We offset the low temp of 1°C to trigger correct event */
-- 
2.53.0

