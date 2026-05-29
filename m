Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4763CC32B
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049930; cv=none; b=SAifaiNC4oR5SPU25ljupKzvBB8LthbaatgdYrucV8fdXt3y01SkvexyN19Z4WoXIH+UcYy176O5118tO27fgf9HNpyGVXbYqo3WeHnPsoqtc0aioRX72EgTNasvAlxrN6hyvFcsdeRoVoLe6kXLHNubAk3yd+Iwo7xuywD0vqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049930; c=relaxed/simple;
	bh=tAPyKz89EW46XljHqZIwFxQpIg1kIpcVXBA6cGvoHQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHIxfyqxnighUBzLgY32Vm5aIgFsHEbEjtl11vzgZvSl5MwUecUntxpjjA6bQpGdVObNtwvjM0LGytwyqUh99zs/+rVorkNKMW7xTnAWFT5x0HRAvn2VjtPgIWExe5KiLPlwEArTxlvNbPuh9i1g+m57qcX3dtvcnjnXcMfFFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=A+wiudIL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="A+wiudIL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so79001325e9.3
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780049928; x=1780654728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fOkPhHr8hHooigTx+bzWeFuomJclHi91ynirje9k/w=;
        b=A+wiudILsjjc37+3SjysrNLuDm/qBZ1S5lKsYQ60NhK0loXhkurWDP+LH3e3morKTf
         JrIk4iALvy9Xl6yus+oYfns594Nld+2YP9x+jnt3nS4ceyZvSGUt5uPVg6ZcGZBf8JPm
         2DXE1DVn+Em+kQ8QoDYRgfs3PtCNO8bpRi4k3Z4UkzJXr008SJdVZCdp9BbTaXUgql0U
         g4HdEd+wTEeLUNr2+jq75X+y1USsRYYXjCPI6KFV4fKpkllnHrseWYtsGkHPbYIqvwIG
         3WaTmL6jXIMifpKn+r6ERHJvzYnQJ3aQPN//tCG/OaB8xE6cuYG92p0PgoH4G2PnuPX7
         DXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049928; x=1780654728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/fOkPhHr8hHooigTx+bzWeFuomJclHi91ynirje9k/w=;
        b=CzmDuzvpN25dKDdgC7UeEV5l/mAuRPnRhM1suUn4/VSAsvxXGPaOpqQSZC+FPNRqnR
         0EcSLNKG4wv8DiUWXmHcmfXVJ+kYT8ih058UVXQaKkquP6w4hRnEx+Nvya+aek+DivJe
         yq9yWUt6mcjgkd7rF8X3lSlZE1sv+TgE0HRGhKIj4ztxUlXnWfOK5jz6hlinb0lFwWdo
         PpK4lzAw1lNg2kMJNRMzSvk6f8I79CVzb/Q2gNdg2XdT/DPRPxOrdkVbOZ5XmaISRAjL
         ApySvejKbx86AB2R5zHqdJ4g6Au6PhBOF2qQ9F5aYB0FbzbpP8RgxWaInRSXi0pSePC5
         H6bw==
X-Forwarded-Encrypted: i=1; AFNElJ8kd4f1rO6EFpJBGPJpf7ynCX+BujOCr8Z790MXZ9bDMd5uJhkhtrpTzh28idAiyJwuGGmPWed0tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqWIfI2P+0YvTjSP8CvBLnPAS1XakG56Ze4YbcKx9R+KYypBL
	2Ymv//k9BIpAyfYfxNtbf8z9zVhHALjx23BaIKsmxVl0WxFtJWRD923bsVAeYzXSU8w=
X-Gm-Gg: Acq92OH1S6tdQa5wk/ApNi19kh1WVCYQtnDdUZRQyKFpE8h3bzAS1zzNFf/Yr0iO8Sl
	Q4MkTx4H5+LMBfU61CR+aUl3aCrIfa73GzMKPBsAYa3mtl/vLyUkdLsP4HsOHbyIbXe3DuwB4zj
	q04El2rw8XIQHDQEiRjWkgjMcdCDL761ee8kZn/vJvS+PlMAlpgoE29H5ELJL0IqJdrccw0wQDL
	Z+yGd7gHZv+kKbg4kYMIEte9k8yAWZ+kJ7wMsJQKr1fem8v9DHiy4UD/DGg/LUFYSkrevfsw4wK
	4wMjc4dXIfDPajP9eFvc4YCqMHJgnZjHfDpHjfuXKyGOl0AqCeVXLS6kc5/jDLi3U3UFrksoeuO
	7rKuMEJs8yZ7GGh/Muvvf7txSssn7+FJ9F4ANxCYPT1sGTpRP7CCkiln/NNuL+gVEdFn9+Pc69R
	NrVH57keFmxtq3o13+o2sOrOQJmKNvOiYMjAqmWbybK/qGY8WiQju6vfWBGWngsWaDIgCN5p/Qy
	F6M9UnfwDIAIEuPDGe+/30761duUZp/LiV/
X-Received: by 2002:a05:600c:4616:b0:490:8470:31f7 with SMTP id 5b1f17b1804b1-4909c0b0175mr24645975e9.20.1780049927978;
        Fri, 29 May 2026 03:18:47 -0700 (PDT)
Received: from localhost (p200300f65f47db043f932d8b97293bf6.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3f93:2d8b:9729:3bf6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909c12f4d0sm11808515e9.34.2026.05.29.03.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:18:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] power: Unify code style for platform_device_id arrays
Date: Fri, 29 May 2026 12:18:21 +0200
Message-ID:  <d840a6f83e3736510d7d859bf48c9bce04876b0c.1780048925.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=tAPyKz89EW46XljHqZIwFxQpIg1kIpcVXBA6cGvoHQo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGWf4F1X4dPez+n8kGQZ051JhdQWvxXUsztrFu PKEDZJ4hYOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahln+AAKCRCPgPtYfRL+ TusgCACQEv0k1MQmkqXPMM8Lcvz8NSNTwMVUL6oPnuYRTIWLZwViEM81NnqwzX5ei6E4dI/eXrs fMylwmTjuZqxFS5sPhmB4ZnIGsaIDuNU6X3P+gKEh9/7PsduMtpX5JW10FhQIS9rphFeB+Aw55i oyCEQ5L3B6BmQZxQB146e1qEwjAEZeDPxkQdtz7LVkOyPqCsEJbsIzkug8YPZ0tHqQDWjKPXmel jNPE/ZNqh1+6HJK7Xu5vcr7vg8en+94E1vMG1hreBduLUBL0k1OoES0dfpxE8vO50QRbWaVl5kp HbGgv2XSfw1yD1LuvKjkpPHGSz6YTECK3tCskP9HMra4GQdJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Use a single space in the list terminator and remove the trailing comma.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/power/supply/axp288_charger.c    | 2 +-
 drivers/power/supply/axp288_fuel_gauge.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index ea0f5caee8f0..24a8b1ee2fec 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -955,7 +955,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 
 static const struct platform_device_id axp288_charger_id_table[] = {
 	{ .name = "axp288_charger" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, axp288_charger_id_table);
 
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index a3d71fc72064..5af334c0a980 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -799,7 +799,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 
 static const struct platform_device_id axp288_fg_id_table[] = {
 	{ .name = DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, axp288_fg_id_table);
 
-- 
2.47.3

