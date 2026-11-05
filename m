Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893775;
	b=fmfM7HEuwZxtLpwLGdx2b1Qe6rTou7ztsa1gteUh7hwzscpxQs8pIisAex5/2ZshTPZV
	 pYSd7vHhc2Mz5mxocYax4q4jQxeohLJXeUM+VwmcDFh8GW1st5qUz+z5F34FWoZnIpQFh
	 XkYnf8eJYyVewdwjOvmN4PkfDU+/oHMFqyZ4x7PKYR4naiPcJdqZ2QOlXwFjflEGAnMur
	 lKKTknuE3FmSM2GhiABr/YsRH83tkHd6ywyoTI+hgHhretCpqo9N8B9vrKSN6Zn70Lwmk
	 kQhLK6aXx+VOGmNLBE3tlGE4ykKjj4K9nMZeVNRMltaHJVHoYgpCp3L0lDjC93Ezj3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893775;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=wssfE0m/5I4MHQVHue9+3hJh0i2J3fHdDjldop6XDXM=;
	b=OoiXg8IKsTGAmXDuP9lDao2doipbA4/t2WALQGl1FkhtX8jvMD5YrHdAYbmD7k8dgQyp
	 X4nA/dAy78Nh0oBK7lUdUDDlfR7L7cTDEqfLGciaH+6mBGEh2VU1zmlReqv40VcaERGwy
	 4n8sns55/xiSEA0y/jk9NnT42MjlJeF0PYRB/NRFmu83fPMdlUhsg6/7OOiwWRUYjHaIb
	 ywGm2UnM7rCRBxyBxxFG6mp41aV0hox4yw2l4oEuiYOmGk8kggD0MLcWDVrohBFOeAZhH
	 6TOZYCUYDmMzwxz9e+DuG7Jt+WUCAndLuXaaODujkAvxaezYe+5HY4TGZWmKB000dTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Na4cds+S;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0uC4Prjn;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48983606D813
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48983606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Na4cds+S;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0uC4Prjn
Date: Thu, 05 Nov 2026 15:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893773;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wssfE0m/5I4MHQVHue9+3hJh0i2J3fHdDjldop6XDXM=;
	b=Na4cds+SU6kGrjsw9aOvJz1OsZyfEfvJc6HvUZycsHRVptOHBTyUWkT8vb7fLWL0zvJiVE
	iTb1dT32aOZtzMabefeUrfMwNHPMwIRQOIPLmmRsBZhxtD+yABjSWc0IyQkaQpuymkii7u
	agsW8nc9G4pz40lir9t0qqqFTUAnMyqlWHe+cozyTbh/V0O20IcBpfvK6IMs6szX0QXwlC
	4xbsKdgVIwsQ7RWgsCGmUZlQsSohC10WTJMAVqnTFzRnpVOdnSc2xQlPvmRglUBpIZVzO2
	/aAUzMb6Q//R8mHCQHnmTmpRrMBEqcO0O4OVfoBVQTucxsWfVmysoAaj0d0lHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893773;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wssfE0m/5I4MHQVHue9+3hJh0i2J3fHdDjldop6XDXM=;
	b=0uC4Prjni3L47S/qfP5TFKJFEiZTewsaEosdlU2Sqd+WvpjsDp7i2cw6QFho3R2V7G/iGq
	BeEOBWsDJgRghIAQ==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu: Fix
 acpm_tmu_resume() error handling
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-3-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-3-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389377179.1009794.10978855281315863995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     2cc5bc4c8be4c83211ddeb0fe38d46d7f239b85f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//2cc5bc4c8be4c83211ddeb0fe38d46d7f239b85f
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:20=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:50 +01:00

thermal/drivers/samsung: acpm-tmu: Fix acpm_tmu_resume() error handling

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

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-3-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 48 +++++++----------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index f980208..f490551 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -172,7 +172,7 @@ static void acpm_tmu_control_rollback(struct acpm_tmu_pri=
v *priv, int start_idx)
 	}
 }
=20
-static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on, bool rollba=
ck)
+static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on)
 {
 	struct device *dev =3D priv->dev;
 	int i, ret, err =3D 0;
@@ -191,16 +191,8 @@ static int acpm_tmu_control(struct acpm_tmu_priv *priv, =
bool on, bool rollback)
 		mutex_lock(&sensor->lock);
 		ret =3D acpm_tmu_op_tz_control(sensor, on);
 		mutex_unlock(&sensor->lock);
-		if (ret) {
-			if (!err)
-				err =3D ret;
-
-			/* On enable, stop on first error if rollback is requested */
-			if (on && rollback) {
-				acpm_tmu_control_rollback(priv, i - 1);
-				break;
-			}
-		}
+		if (ret && !err)
+			err =3D ret;
 	}
=20
 	pm_runtime_put_sync(dev);
@@ -539,7 +531,7 @@ static void acpm_tmu_remove(struct platform_device *pdev)
 	 * immediately, preventing clock leaks when the driver is removed.
 	 */
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	acpm_tmu_control(priv, false, false);
+	acpm_tmu_control(priv, false);
 }
=20
 static int acpm_tmu_suspend(struct device *dev)
@@ -549,7 +541,7 @@ static int acpm_tmu_suspend(struct device *dev)
 	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
 	int ret, restore_ret;
=20
-	ret =3D acpm_tmu_control(priv, false, false);
+	ret =3D acpm_tmu_control(priv, false);
 	if (ret)
 		goto err_restore_sensors;
=20
@@ -571,7 +563,7 @@ err_resume_acpm:
 			restore_ret);
=20
 err_restore_sensors:
-	restore_ret =3D acpm_tmu_control(priv, true, false);
+	restore_ret =3D acpm_tmu_control(priv, true);
 	if (restore_ret)
 		dev_err(dev, "Failed to re-enable TMU after suspend failure: %d\n",
 			restore_ret);
@@ -584,34 +576,18 @@ static int acpm_tmu_resume(struct device *dev)
 	struct acpm_tmu_priv *priv =3D dev_get_drvdata(dev);
 	struct acpm_handle *handle =3D priv->handle;
 	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
-	int ret, restore_ret;
-
-	/* APB clock not required for this specific msg */
-	ret =3D ops->resume(handle, priv->mbox_chan_id);
-	if (ret)
-		return ret;
+	int ret;
=20
 	ret =3D pm_runtime_force_resume(dev);
 	if (ret)
-		goto err_suspend_acpm;
+		return ret;
=20
-	ret =3D acpm_tmu_control(priv, true, true);
+	/* APB clock not required for this specific msg */
+	ret =3D ops->resume(handle, priv->mbox_chan_id);
 	if (ret)
-		goto err_suspend_pm;
-
-	return 0;
+		return ret;
=20
-err_suspend_pm:
-	restore_ret =3D pm_runtime_force_suspend(dev);
-	if (restore_ret)
-		dev_err(dev, "Failed to force suspend during resume rollback: %d\n",
-			restore_ret);
-err_suspend_acpm:
-	restore_ret =3D ops->suspend(handle, priv->mbox_chan_id);
-	if (restore_ret)
-		dev_err(dev, "Failed to suspend ACPM during resume rollback: %d\n",
-			restore_ret);
-	return ret;
+	return acpm_tmu_control(priv, true);
 }
=20
 static int acpm_tmu_runtime_suspend(struct device *dev)
