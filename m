Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030488;
	b=LloNpnxrn1EpHGSwHt9zwqD7eBHZiuUrTw0xBH06tVNIGxekfdBGodvOc8fgHWXvO5o7
	 R5WIpdtweTtfhxnOoMNkT3HyTMFc7ud3a3DRZqC43mZ7HGWb9+sZOWGmNC1Zyu2lhoYo9
	 9Hp8VU1HfWEVIuZunCuDaaEQLhPgfJG9UxEqWsF65BjYNzh54e9EWE/VtqOGo+JAlPrnx
	 gJfUtCPvHjS+ZeTDhF6Acp2Uicl3AfPu543Ml07WPfwgopSy/pKN1u1vuvAa5jYzSKHER
	 iP4gJJbifUpOrUiz8tSpeMx8D7UTKjb+O6SM5nf+WJbe3XtWv/7EWv21j4Ar1cmWznA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ULiAXlDs6uzz6Xg5tVgN5dURBE6+891+t2MegFSZRrM=;
	b=4kmBnv4HeQw7Sqtyb4DIGXbx98wEmkMk+OcyuonHu9OzNGpC2x1hWK3iNbQTE5feO+14
	 Pb04pZCXmHgsj/nIsM8kMHrGvLHIIFzT2mqhcaid5qLisEfMRohJuwI7YIDn1bf2OrbvN
	 3490cR4uoLAQIGRai2EKzJU5wRpNzTxnZnv0XdwBgsrJboH0qMwnq6bULz6jQZ2UF8qhC
	 7gsRIa2WZyEtz1V/KbARWyTvmwbsr827KQtZpq8WjRMGZoWz5Tw53cyO/8c+aM2JKrh08
	 atjh+Uny7hODeTlQ9VNiwC/nPOOPGCR2dfJWOsJzzHBb5jinN9OiHtg8jNj0vlh2gUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rrEj1gjI;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DDB606A338
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35DDB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rrEj1gjI
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c498e2d623bso133830866b.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030486; x=1793635286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULiAXlDs6uzz6Xg5tVgN5dURBE6+891+t2MegFSZRrM=;
        b=rrEj1gjI5wPoLmWezx5JCZYgb2FeB2NczDLKP7ev0LPHlugVgNIFQ5k2OK3kQo3Jfh
         1HYr0ea4P0fQoDFSx55TbTgO+6pxh+gHBJ2FZSJUqCP+94yCz+9Lx/BlVF/UOefcaxvD
         7Ez9QKHsdkYs4/iu5WOc7W8p+UXgSseIkznkfKCUpZTeHILYIN2z3ezYq9HPy8RzhsW2
         aa1nYzFpXqViWe4avmMG+wKj/qR3FdLjxuWuYlz1fzzrpRdbeQ9vhLCuxZExvu8z8G4A
         Gvm1wA80nXQ+j/w5BxQFvFwu0Bx/NjwNMH9bz33KMEKKJCuUozNNzvZr2D0VJZMgf/TA
         biTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030486; x=1793635286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULiAXlDs6uzz6Xg5tVgN5dURBE6+891+t2MegFSZRrM=;
        b=qUR9vWG4MtgeHQBzrkRSfU51jCrwpBGWKZggFpZLa4ngNMSO1iIQ9gq0spZ/LMCSkT
         G1sBrWH4fv9jahlZjNVZzPZ3qqnn07hirB/3jgb1/Q+mBiB7VKybTRk6tc0t4LHbuRW+
         fINuXqIfSorYfsq8W8VZV1KMOoVBAASHFe9JZCD/LnTKJ9cYpM+fHOjt4Fr5PispwoY3
         niULF5Snd5VTeLo1QL6A0bCDJZbnwzFSAXWdrvudcFGDjr4r9sWZH0lO/lhna+E/MRlf
         kjX91bXiJyufCLYP47lXNJ8qC0kD4bRVo1+SFlTA+4iLjhaDhVnEZcwRyI/klvpL2K7K
         rN6w==
X-Forwarded-Encrypted: i=1; AKwUvBzoaBwO5GJM5kWemhMgG8lnkXRHML8pRWjqcCYomd3g7IGZHmcQ3bGhc+g/nme8DCsatmYCgxiwsw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKaI6fu52jihtc/MhtVLmq4D0lV+AbJuJdWHjzvffi2VKJJRP6j
	S4iXG8GukEHh9gAbhLN07pFVMeoUBiR5serTHIiY6HRKv7+W9ApPJBr8QY0lLiqrRPg=
X-Gm-Gg: AYBFou1lLR943/VsgxqcyyTZOo3NoYigGc9AKUGihl5l3wyjvdjv0IhetQwvNq/2QNj
	Q4YlmjgLME17c/hXdvh2RGxQnaRQaOz1gXZ5CJIYgUq1KMmCUmJEEf9cJbLrbDVwqJVMelEhFpQ
	wqUY2tUSso9VLyYjcv51R68OE1KyysMfHDe79NzGG/P2Zn6zyU5N4Z+ouJYF9Kqhah2qNb/7YN9
	WMomyWp514oX6vOS9xSll8AS1kj8o+8/W4AsTmW8UJjCYbLujS9ApmeUE2ud4WfVlsSQF5AWUwx
	y6cJn5PA4RXRVfMTQEWEx3z04qUIDujRMkpRDamphsu4+8ujKhl6jTXD0TPgKTHy/uClpdqe156
	l5rpkofNyjmmBIBu+yS7yQXNNhq4x+smv/Al5x3tJUIFHap5TH6A+mJTVXjh6ZDCHPlLlJAJemU
	lKUrk4LaMlkAPPFvICjWMLU7F9C4RENxAX9a9wjySVHpdrd1lTRlk2NXx9tFDqdOVn0AIeMid74
	Z1q0VvE/gBVvc3dSRHDjX5R9VuG10q/GNoC3Hu3WuwvkmAEa2m2jNXg/LYYiCnNFDBFTT9GUhZn
	aWPpB1h5nM2JT9VaA572zzz4HEQK+miDPNO3dEIU7HOUwYXYjWaX4Mdu3q1jh64IWwBZBc/Rahy
	N/UDKXUeJ5A==
X-Received: by 2002:a17:907:3e06:b0:c46:8b9a:39ae with SMTP id a640c23a62f3a-c46bde4eb8bmr821391266b.28.1793030486440;
        Mon, 26 Oct 2026 09:01:26 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:25 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:20 +0000
Subject: [PATCH 03/15] thermal/drivers/samsung: acpm-tmu: Fix
 acpm_tmu_resume() error handling
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-acpm-tmu-fixes-v1-3-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Juan Yescas <jyescas@google.com>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=5298;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=qCVVqc6x/0s6bvl7rY2mwBkC7vhwwi3YsCjDNoVX0oI=;
 b=OXFKufosU6U5StLfJ2EhbNkIwQkfSSKgKLDfOeJRGJ4ZNoF2KUu4DMwUDH5vRQ4Mq598C/Kqq
 CY0W11kdtKqCDlgRvj8x/U86cthK9v74EmXyy00w+8tt0Y7/tsqWzeK
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Unlike .suspend(), system resume cannot be aborted: device_resume()
clears dev->power.is_suspended before invoking .resume(), and on error
merely logs the failure and continues into normal system operation
without re-enabling runtime PM on the driver's behalf.

acpm_tmu_resume() treats errors by rolling back into a suspended state,
causing three problems:
1. acpm_tmu_suspend() disables runtime PM via pm_runtime_force_suspend().
   If ops->resume() fails before pm_runtime_force_resume() runs, or if
   acpm_tmu_control() fails and the rollback path calls
   pm_runtime_force_suspend(), dev->power.disable_depth remains at 1
   with the device runtime-suspended. Every subsequent
   pm_runtime_resume_and_get() then fails with -EACCES, breaking thermal
   zone operations and causing future system suspends to abort in
   acpm_tmu_suspend().
2. Calling ops->suspend() on error leaves the ACPM TMU firmware in the
   suspended state while Linux considers the device awake, so subsequent
   thermal zone operations run against suspended firmware and the next
   acpm_tmu_suspend() issues an unbalanced ops->suspend() call.
3. Rolling back sensors via acpm_tmu_control_rollback() when a single
   sensor fails to re-enable disables sensors that already resumed and
   skips remaining sensors, leaving active CPU clusters without thermal
   monitoring.

Mirror acpm_tmu_suspend() in reverse order by calling
pm_runtime_force_resume() at the start of acpm_tmu_resume(), and drop
the pm_runtime_force_suspend() and ops->suspend() error rollback paths.
Re-enable sensors on a best-effort basis so any sensor that fails
remains marked !sensor->enabled for the thermal core's post-resume
update, and drop the now-unused rollback parameter from
acpm_tmu_control().

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 48 ++++++++++----------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index f9802080acd7..f490551de69a 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -172,7 +172,7 @@ static void acpm_tmu_control_rollback(struct acpm_tmu_priv *priv, int start_idx)
 	}
 }
 
-static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on, bool rollback)
+static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on)
 {
 	struct device *dev = priv->dev;
 	int i, ret, err = 0;
@@ -191,16 +191,8 @@ static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on, bool rollback)
 		mutex_lock(&sensor->lock);
 		ret = acpm_tmu_op_tz_control(sensor, on);
 		mutex_unlock(&sensor->lock);
-		if (ret) {
-			if (!err)
-				err = ret;
-
-			/* On enable, stop on first error if rollback is requested */
-			if (on && rollback) {
-				acpm_tmu_control_rollback(priv, i - 1);
-				break;
-			}
-		}
+		if (ret && !err)
+			err = ret;
 	}
 
 	pm_runtime_put_sync(dev);
@@ -539,7 +531,7 @@ static void acpm_tmu_remove(struct platform_device *pdev)
 	 * immediately, preventing clock leaks when the driver is removed.
 	 */
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	acpm_tmu_control(priv, false, false);
+	acpm_tmu_control(priv, false);
 }
 
 static int acpm_tmu_suspend(struct device *dev)
@@ -549,7 +541,7 @@ static int acpm_tmu_suspend(struct device *dev)
 	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
 	int ret, restore_ret;
 
-	ret = acpm_tmu_control(priv, false, false);
+	ret = acpm_tmu_control(priv, false);
 	if (ret)
 		goto err_restore_sensors;
 
@@ -571,7 +563,7 @@ static int acpm_tmu_suspend(struct device *dev)
 			restore_ret);
 
 err_restore_sensors:
-	restore_ret = acpm_tmu_control(priv, true, false);
+	restore_ret = acpm_tmu_control(priv, true);
 	if (restore_ret)
 		dev_err(dev, "Failed to re-enable TMU after suspend failure: %d\n",
 			restore_ret);
@@ -584,34 +576,18 @@ static int acpm_tmu_resume(struct device *dev)
 	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
 	struct acpm_handle *handle = priv->handle;
 	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
-	int ret, restore_ret;
-
-	/* APB clock not required for this specific msg */
-	ret = ops->resume(handle, priv->mbox_chan_id);
-	if (ret)
-		return ret;
+	int ret;
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
-		goto err_suspend_acpm;
+		return ret;
 
-	ret = acpm_tmu_control(priv, true, true);
+	/* APB clock not required for this specific msg */
+	ret = ops->resume(handle, priv->mbox_chan_id);
 	if (ret)
-		goto err_suspend_pm;
-
-	return 0;
+		return ret;
 
-err_suspend_pm:
-	restore_ret = pm_runtime_force_suspend(dev);
-	if (restore_ret)
-		dev_err(dev, "Failed to force suspend during resume rollback: %d\n",
-			restore_ret);
-err_suspend_acpm:
-	restore_ret = ops->suspend(handle, priv->mbox_chan_id);
-	if (restore_ret)
-		dev_err(dev, "Failed to suspend ACPM during resume rollback: %d\n",
-			restore_ret);
-	return ret;
+	return acpm_tmu_control(priv, true);
 }
 
 static int acpm_tmu_runtime_suspend(struct device *dev)

-- 
2.56.0.257.gf7497c7d27-goog

