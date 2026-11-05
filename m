Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893770;
	b=Fv+1d4JCsBm9LGfyHn069hB5N2VDKl4gclwL+3uJqd7ahRt4GND6ifJtdlCU1vPxX8YN
	 DfhNK47iE+eQZFypyMKnx9qXng/Vhbx8yhJLqiO5yxswKgbVwebhMra8Su/Jfw6mnC5Ff
	 jV93uxjWUAXoTooKKRHFay6esKH2O6pLps5x6nC+byhrTokjJ6mG7gTsr7qQlYvzzW7AU
	 bs83qQKB9moN+jqTpqay8/+gIgutQLC7hSE3ZJM3npRDsRDSq1CyNso5zTQW17Pjf95Rc
	 F/HYladJ7t/K2b00xbEhfMpkORlSZGkZ7VkvkhDxLryLMDXnipq+0xfZ+XP6alNBcPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893770;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=KBIWDwn0DY4hXd/ZQ26hdkPzxSwgJKY0rvjF4QEYw9s=;
	b=nazhMt6Uau5E+c2P3gNDiljFDr3sE0PufmJEgiSqRHBmn80XD1WPThYvAKRVjV1OC9iD
	 jZjnAxV1SwebTsv9tcQ8/q0g0HIUOSpeuMDVCkSuphAriKLoiQsNtMsyECXSPzy/FuZHi
	 5Ep0Np7SWzA3e3cmYvPq6OrqNINDQtgZGzywgX0iR4zvwisvY5gKqRwW6da3K+eoe2w50
	 jLe1bE/vLmuNAY64jZX0qzEhIbtNJCTVlWmUMKpTkgV55Fd/boZ4FywudYr9O2M8UeQB2
	 DDsIOuHDJqapGjK+b1UB/3Rko/C2yqR2SCx/WSMukaZxfh6XXno5dWbgPBJviBnkTEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ehqzckyg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=j37lCymf;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C160A3819
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C56C160A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ehqzckyg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=j37lCymf
Date: Thu, 05 Nov 2026 15:49:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893768;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBIWDwn0DY4hXd/ZQ26hdkPzxSwgJKY0rvjF4QEYw9s=;
	b=ehqzckygFXow5rAVdBSC8HRLfQ74ONdUn/O6aku3LCjpxlq96PPZb62lCanduPzmxJi3Qr
	9XxsHjXdlLKCHZqmmaqYFN5gY1Sksu1NFcfKPK3BI9F3bu/XEITXRQR3P/aQq+ilKUzBFA
	1DQdVzCpv2mfu7eofunnv9JjnwOOvz3tI923hbNfR2WNGpV+oD2D3FpP1PjCFIv/nyRfmH
	rintZMhtf0xS5O35ANr7WhXiKnyKIMKpJuUakvRjrKdM8QCJ4+36MzZGUjfk7y/g5vsapO
	cxwdjTLAaKkF0p9hq5FHV2pgMHsxnQK8dVJQ4BcGOF1fJ5ZHAPoNM7dQ7ugJEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893768;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBIWDwn0DY4hXd/ZQ26hdkPzxSwgJKY0rvjF4QEYw9s=;
	b=j37lCymfp1vVHL+d+fZWixF5OHGSRtn9LPk154p0nDgG/3m/7IkBS+cNHG544EbmRWwMD+
	o6tF6itBgrbTNEBA==
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
Message-ID: <179389376667.1009794.7287841820978986080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     3980362b31bf935b778dea1a8d90590ecef82e8d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//3980362b31bf935b778dea1a8d90590ecef82e8d
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:23=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:50 +01:00

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
