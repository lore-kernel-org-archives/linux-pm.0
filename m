Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607964;
	b=Gv7Ilib52SjL0PBk/RKPJI/G/y7YAIBbLGkcGeMqYuS7+6PEGuaI4Bj/v+LC+iuK0LZ/
	 9RwxPhiqDo8QLOcnweubYAiL5ZKd0r7+nq1t7zHi9DVAJhT9kjZhFO2A/IXbitFnFjxFq
	 fey8iHEluM2kGZUHWO16hs/DLVeD5/C5yVS9T+R2Q/hrkpJN39PjRhRJCScMsd9LyWBKx
	 exihzsDQvIDpXfL0Wo+22ob58ICdNTy/P22kSWDtTzYmwb+SxPE5Olf8UlSB64NLxNiQO
	 MUBLcW2onVY0zsiaSA+auPHraEGwkkq0YzuNNXMcrfJDgaXv8HQkrwGuOuowaZg6h0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607964;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=QtyEIPt2zVCmqSFaAF2cYCC8I6jIQwzI+nKLEac56Bo=;
	b=chkV26KC4mOE7MEBZeZRNrx3IQqC4B6WxW9n8AwyOXII2dN3ZduN+8+nBBSaMCrRY+LD
	 N9xdk+qNK/VOZh5UpDyjIDQE+cSdmh1Dv1XN8TQvQPtzspcD4pPOM/icg+ZbZbl58UPU6
	 ylPcSiXrb0S+bWL429Yk99GAyw8EdP5M5/wp9Ew3q58/Oa/L9SbcV6ypikqkrOo/NYw4l
	 si20ajh5+jt5RJDJqlukQSJzpbUm4iq8s7X2R/fbhKwzUcqPX2yNaYB1GMYKYQkb47RJL
	 bP+KPBAZBYiYM61qTyFqnZq6JYe1I6rFKJOS09TpibpcVc9VdncBSLjQYXBlXT4WKdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eUqOOy8g;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=v9xCjEIF;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921D606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E921D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eUqOOy8g;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=v9xCjEIF
Date: Wed, 25 Nov 2026 11:59:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtyEIPt2zVCmqSFaAF2cYCC8I6jIQwzI+nKLEac56Bo=;
	b=eUqOOy8g01+0r90Daw3g8Iyry1X/5q+/StG6BlZZNBwd7C8izXJCARbCNuASrzqXI5v3sq
	e/anMiqPzfjpq2+S7PD3v9zBFHsCiyh4RuIBEJ/bc/Iym9ld2tXhvbUjP/QIK/N2UdHn/R
	e0C20BUTcdC0v4TsMZ9xfKHUtM/APKzNdRplsz+LUmA8W81tpkVlPhcSZSi5C3kz+xs2En
	rTSMNUwCSxnvop/O0Y3NiB8fgIq2QDdw8RDpT3v2rpLNPusD5mWT/Q/6xoxR+oK5omEN30
	hzK8AmUl6f+6/df88jcx49EtGQU+IZYTS0v0lFlcqFcxC4iJWRZRs13KHqmhfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtyEIPt2zVCmqSFaAF2cYCC8I6jIQwzI+nKLEac56Bo=;
	b=v9xCjEIFsieFjY6E0R6szPFFD8CXaI1MYU7zW3wMwLvDb/eL5nirBRypXb9b4VPtH9IfR9
	2QJd1KgZ4fHMtnBw==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu: Rely
 on devres for probe error and remove teardown
Cc: Sashiko <sashiko-bot@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-6-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-6-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560796062.92412.9151643163747756948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     9b38ccc3c95390be60190aa7920ae1b44735f52d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//9b38ccc3c95390be60190aa7920ae1b44735f52d
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:23=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/samsung: acpm-tmu: Rely on devres for probe error and remove =
teardown

Disabling sensors manually on acpm_tmu_probe() failure or in
acpm_tmu_remove() happens before devres unregisters the thermal zones,
leaving live zones backed by disabled hardware.

With .change_mode() implemented, devres tears down the IRQ, thermal
zones, and runtime PM in reverse registration order:
devm_thermal_of_zone_release() disables each sensor via
thermal_zone_device_disable(), and devm_pm_runtime_enable() disables
autosuspend and runtime PM.

Drop acpm_tmu_remove(), acpm_tmu_control_rollback(), and the manual
teardown in acpm_tmu_probe(), and switch acpm_tmu_control() to
pm_runtime_put_autosuspend() since pm_runtime_put_sync() was only needed
by acpm_tmu_remove().

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://sashiko.dev/#/patchset/20260603-acpm-tmu-v8-0-0f1810a356e6@lina=
ro.org?part=3D2
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-6-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 56 ++---------------------------
 1 file changed, 5 insertions(+), 51 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index 69793fc..4257bec 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -153,26 +153,6 @@ static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor=
 *sensor, bool on)
 	return 0;
 }
=20
-static void acpm_tmu_control_rollback(struct acpm_tmu_priv *priv, int start_=
idx)
-{
-	int i;
-
-	for (i =3D start_idx; i >=3D 0; i--) {
-		struct acpm_tmu_sensor *sensor =3D &priv->sensors[i];
-		int ret;
-
-		if (!sensor->tzd)
-			continue;
-
-		mutex_lock(&sensor->lock);
-		ret =3D acpm_tmu_op_tz_control(sensor, false);
-		mutex_unlock(&sensor->lock);
-		if (ret)
-			dev_err(priv->dev, "Rollback: Failed to disable sensor %d: %d\n",
-				i, ret);
-	}
-}
-
 static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on)
 {
 	struct device *dev =3D priv->dev;
@@ -199,7 +179,7 @@ static int acpm_tmu_control(struct acpm_tmu_priv *priv, b=
ool on)
 			err =3D ret;
 	}
=20
-	pm_runtime_put_sync(dev);
+	pm_runtime_put_autosuspend(dev);
=20
 	return err;
 }
@@ -489,7 +469,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 	ret =3D acpm_handle->ops->tmu.init(acpm_handle, priv->mbox_chan_id);
 	if (ret) {
 		ret =3D dev_err_probe(dev, ret, "Failed to init TMU\n");
-		goto err_pm_put;
+		goto out_pm_put;
 	}
=20
 	for (i =3D 0; i < priv->num_sensors; i++) {
@@ -510,7 +490,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 			}
=20
 			ret =3D dev_err_probe(dev, ret, "Failed to register sensor %d\n", i);
-			goto err_rollback;
+			goto out_pm_put;
 		}
 		sensor->tzd =3D tzd;
=20
@@ -522,39 +502,14 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 	ret =3D devm_request_threaded_irq(dev, priv->irq, NULL,
 					acpm_tmu_thread_fn, IRQF_ONESHOT,
 					dev_name(dev), priv);
-	if (ret) {
+	if (ret)
 		ret =3D dev_err_probe(dev, ret, "Failed to request irq\n");
-		goto err_rollback;
-	}
=20
+out_pm_put:
 	pm_runtime_put_autosuspend(dev);
-
-	return 0;
-
-err_rollback:
-	acpm_tmu_control_rollback(priv, i - 1);
-err_pm_put:
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_put_sync(dev);
 	return ret;
 }
=20
-static void acpm_tmu_remove(struct platform_device *pdev)
-{
-	struct acpm_tmu_priv *priv =3D platform_get_drvdata(pdev);
-
-	/* Stop IRQ first to prevent race with thread_fn */
-	disable_irq(priv->irq);
-
-	/*
-	 * Disable autosuspend to force the subsequent pm_runtime_put_sync()
-	 * inside acpm_tmu_control() to synchronously suspend the device
-	 * immediately, preventing clock leaks when the driver is removed.
-	 */
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	acpm_tmu_control(priv, false);
-}
-
 static int acpm_tmu_suspend(struct device *dev)
 {
 	struct acpm_tmu_priv *priv =3D dev_get_drvdata(dev);
@@ -648,7 +603,6 @@ static struct platform_driver acpm_tmu_driver =3D {
 		.of_match_table =3D acpm_tmu_match,
 	},
 	.probe =3D acpm_tmu_probe,
-	.remove =3D acpm_tmu_remove,
 };
 module_platform_driver(acpm_tmu_driver);
=20
