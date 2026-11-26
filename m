Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656994;
	b=vKlR6wYz9wG9pVS374gQRQQY6ZGp0y2SjW3mX82506KgGwGM5bbRQxULgK03yNJ6S42G
	 S4zYeQP8d1MDZFZsfdPnkhDXblcJ1KCZl6bKNBTYHXIm9BsBnRU48GK9BeRapF9wpJTI+
	 t+htqAl/BhqXqw8nJM0p5SkdsTohCihMgS18KGgWQbaLtu6Hor6tKBjSSQij8lL3dYLr9
	 ofKKwx9H7SmldVoivjKGq0atV98FLs4sLpTH9n0uiqWNDVMfaXAzXwHL9PJOE3IVXzfTb
	 2jj1S+gTZ6wbH1CJvXQgfEt2AilfIrH+dFzHD9kBGBpykOgLf1+5rSu8mQwcp52Najg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SP15XaZUbGtlp60P327+ssWhkCWUemMIccsR99IzlyI=;
	b=ezyFih8SBcwG9X0p/avxbWwA/yojQObMHtYFvKbXgxaMIYtb9SHhg3op2nW/+NTUo8wc
	 2+iptvuMMviG98Iwi1laAy8dxR9xyiPYe9Ba1dcNnEmQiiF8jJ1jZh+0srF7XN2rZjJOJ
	 guTgbd1sMtA5eOykL6GZ+DxV7snmx5krdjU4VeHwB9vbW5AvFzCWiXkiOAUqMr7OZU5YY
	 x7W3kt5eu9JbhQC2V8tDtOxpd4mdcHtT0d7PsLGZKlnEcFYaeLlV/U0+vyk1t6XDeNcC5
	 4p7TSKAaGIfhn9xqUO4qVX3DEK87IB67rRaL2cyU4gElDZvN7deh9e9Wv43m6zkhYaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkOtKQEs;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A71606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 01:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A71606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkOtKQEs
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b600fae14dso2327316b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 17:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795656992; x=1796261792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SP15XaZUbGtlp60P327+ssWhkCWUemMIccsR99IzlyI=;
        b=IkOtKQEsw1P6Qem2Ym5jSb3VAZZX8TmwwUNgxT9DOWowClgIO3DlHf2mSKx2B1wjbP
         0AuxWFLGf2lq1RyFgUQmH0XHDv5gGI6zu00dAbb1L3ezjWpjf/dHnE3u6ZDt6C3W2TXm
         wCtQo4bG4EUmvmT+u7tNN8sQpQAUygbvQN71LN3myFzJpYq9OOmdyDDHqWv1MW2fSCXa
         KG4PzYEqRyb/zxyv6KU3eJyGm4QF82Yn4VGnsmLb9lcqpNh59TNXFGjGac6mTkymDYLn
         suV+97W7fCn7Go40/Ef6MQaiyG5Wd0MQjt2aCFYx7uWUaJLuEqukfQZd9cq0TmzDfUCo
         nksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795656992; x=1796261792;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SP15XaZUbGtlp60P327+ssWhkCWUemMIccsR99IzlyI=;
        b=gA7gIrP6Ijqz5rgy5v1KqCeXYLXBoF7+SZjqBa6yRifJ2GNxuzylCUyrvGa71/MbGo
         3H+jdzlGeYCSfxzOaB/keNwt9l9idQILTlc8I7/KOjTQmJ9pFjdzrrJzUgJf4kbrUkND
         aIZJzrB28g1zh67915hQFYHq7kq/KZcwa1+P2m18DiAluEdxfKbEzicNVMzKYZJ3g4st
         urBhNjhlhmkWMIoYD4kbjRT2D/tTLCu0iAQghd0/DM9ydZRsQdhjESd1hwEGrAWeMNyf
         6k2JPnrjoQKtvVibJ4drTIKA/Q65RwhS7/z1QvaP047/L/PEHcYLt/MZhHrbwwA7MA1o
         pFVg==
X-Forwarded-Encrypted: i=1; AL+hErGCTc6mz+AAmXOTLo8WV/G2CNkghDjzRXfWxLB4iyPvKm+Dc5qm5/4sxVniYqMnPymAARUm3klNng==@vger.kernel.org
X-Gm-Message-State: APuU4Z/K5GCRwGQ9VwwmEme5wjluQ8SSZg4MN2X+IKJLrLYwGbr5C13C
	zm4SBlM5672pRnvAOiR9jmWcPkhAIoDb1r8+/AyRTApI9IkpwqGap562
X-Gm-Gg: AZFdTZekQh7dqQkxw6X2qAJpAzhMO6/wc1xXSE8B7+AhddafFzwAqvM2u5WJIGMgf+o
	iqVgKlgTaGPb1bZdIFD570XN0lFk9MW2CTX6spy6HnjL1J3xmULp/8rb8ZcoW2VF8Gu6DXr0Cad
	N8l7KB59E3MAarNK8RsJiY6FWj9qu45Z1XF32cNzxsBr4RqIcQOWGa8Gyj66SV1E3x83w6Tmit0
	/cR5NHWawyv9mV65SAInkSAifCBhYOw1LUiwdtxxGJLLRPVvyptFh6C6JjG5mc2oe5gU9T4NpG7
	MSkI0tVqpnu0s5HU9FL3mBX1nVx8NmZVB7Tde5JKaoySox7AU7kL7pFqDzMmiX4qWUnEQS0ECkX
	J5dFyl+nGRh/OmDciY2YKlBYZGh7mBP3IsqNgeECnXkZsSXpPtledg6QC7U4bI98r1eiyjAc5tR
	EqwbKw8sMWBXvWlvo2MlceGSGPY3MO/eDDMCjq/pH7wAdV25Qd+JEXco5B/EiwDV0nc3FSMi6Mi
	IL3Y2AZvLS31sfKvNV4YS67gNYWpFFjIz1fN669/GLUgxCpEhnlDk099vD/aZ8iE64aT5YG7xyf
	x//wkDc+KoTh4w9m02+FDYJdc7SVplbwD2kV2pl5ZoTG9agc4gnPJ1DL6XSZusmTU35fsOQ/zzt
	FXl1Kl4TpTBqO7UEoqIIAaD8YN+n078CKpfgWesQFJ4M2WME=
X-Received: by 2002:a05:6a00:8015:b0:89e:92e:4211 with SMTP id d2e1a72fcca58-8c87bcbcecdmr16856465b3a.16.1795656992438;
        Wed, 25 Nov 2026 17:36:32 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872951febsm9748633b3a.14.2026.11.25.17.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:36:31 -0800 (PST)
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
Subject: [PATCH v5] thermal: rcar_gen3: check for sensors before reading the fuses
Date: Thu, 26 Nov 2026 09:36:26 +0800
Message-Id: <20261126013626.2168810-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125060429.GK3898744@ragnatech.se>
References: <20261125060429.GK3898744@ragnatech.se>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rcar_gen3_thermal_read_fuses() reads the THSCP register through the
first TSC. If the device has no TSC resources, priv->tscs[0] is NULL,
and the read causes a NULL pointer dereference.

Before hardware calibration support was added, leaving the
!priv->num_tscs check at the end of probe was safe because TSCs were
only accessed inside loops over the discovered sensors.
rcar_gen3_thermal_read_fuses() introduced an unconditional access to
priv->tscs[0] before that check.

Move the existing zero-TSC check right after discovering the sensors,
before reading the calibration fuses.

Fixes: c3131bd5586d ("thermal: rcar_gen3_thermal: Read calibration from hardware")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Changes since v4 (split out from the withdrawn 3-patch series):
  - Split out as a standalone single patch per Niklas Söderlund's feedback
    (<20261125060429.GK3898744@ragnatech.se>,
     <20261125113106.GM3898744@ragnatech.se>).
  - Rewrote the commit message and added the Fixes tag per Niklas's review.
  - No functional code change relative to v4 patch 1/3.

Testing:
  Compile tested only (no Renesas R-Car Gen3 hardware): arm64
  (aarch64-linux-gnu-gcc, CONFIG_ARCH_RENESAS=y, CONFIG_RCAR_GEN3_THERMAL=y,
  W=1, 0 warnings) against 666539eecdf4.

AI assistance:
  AI tools assisted with initial static analysis and commit/patch drafting;
  the author manually reviewed the probe/remove paths, verified commit
  c3131bd5586d, ran the arm64 compile check, and takes full responsibility
  for the patch.

 drivers/thermal/renesas/rcar_gen3_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 9c64cbc2ee670..a96f02d4a8adf 100644
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

