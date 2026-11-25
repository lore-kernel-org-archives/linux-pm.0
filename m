Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607959;
	b=xdS3WG8nYoFxvohsYDGUurxoodAofTKbJqM+C0VmPA+Mfeu+z7V4Zk9RCYt12UTOs8wP
	 MmwZ0wDAIfOQU1nQmEJTAz3WwvMGzP/q4HAQ4dgXu3eFMw1b7hwv3CPwC13NntfVlGRb7
	 IjQ/eMV3/D79AtbL4yWkzoif3npLcGuZXdvrPq1r85efDBbyuG99QJmjoq+/Dkf5pV0A9
	 +mERY6ocCPEVq/04g7glxEfbZ0OKScK33GsYQuNDpmb9nwTMaObdPo0Epngx63eOi4MnF
	 ljB8vE+CBdR7mHt/Sgb1Hs9k47CRMvGYMqKc44l+04+vHE1ZH5KmMJfPUOghvIYZaEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607959;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=OEeR/fj+dxDrs1eftvyvqjq2oRJtzSbOfVZxAYiOEX0=;
	b=pYYycN41eeDZIZeNFeIO8sSU7wodo/mWUHXrD6A3ScxUTwcGvzMnoQUBDV4LHlOlL93I
	 IxPJVgQQKB4h7NwrIQRjCQQMIi81NpGqAtmd9+4/IQUxmVVLouqrR8O7lAyaeTN6RHquy
	 SR5ZpD1hgaXWQZe0joHFYDKglmxbPODSPV/diG44PMU1b6O+5ifHcCDqW337D9xZ9dLsu
	 OJ8e+Ns5/rgF7s307RPSz6BEyu39+k4AkKqjAwcT3dbaLPkyET40Q8N8zm5ibIdWkVVJU
	 IEprEyXwJKj3gp8cTAj9uKjm27mQ+Y6VEXMsHvMfcndGxo2xbBjI5Af8ulYJO1ZrEvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4tzRb18l;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=a7vaXh6a;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB3606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7CB3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4tzRb18l;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=a7vaXh6a
Date: Wed, 25 Nov 2026 11:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEeR/fj+dxDrs1eftvyvqjq2oRJtzSbOfVZxAYiOEX0=;
	b=4tzRb18l1/MM8ITCgO6tfjbXjtlP1cHXc2XNwF7sfN8uQ5OCT9F/6Ye9myYwPm7aYvImlM
	Zgtxh56Jb5s8u0UJQcK9uCwwwzs8eneFu+4vEDf5bVf8ivEg+joDIhQNOjICuMvJ8pXD7f
	VG7g1jAp2nTOTRKzWJS1mfGtzzVl72pBYOvClDhZtG+9JMeUTdKr5j9/qjAQVxNWjJf1Zf
	jhgH0egRsIj5tVEdY4rfF3z4LMI1Wpc1n8nbbGimPcmQA4Er7bbipaIHVFaDt6TTaJKzf8
	mzoJPCMCW2Xx79rBMxXdiOS4A2E1UaYyx3c0yp5FdnPMT8IpGHn6JSXA+1frvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEeR/fj+dxDrs1eftvyvqjq2oRJtzSbOfVZxAYiOEX0=;
	b=a7vaXh6aPCtNwGnyWMHaX98GRAowhgj2GdOJ4dbhkso8qh24WxT84mmEfUOiqaKy8Mi3WR
	g252Og9GhDKVPAAQ==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu: Fix
 IRQ locking and error handling
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-9-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-9-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560795551.92412.928055726197102323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     2285ef574c11d88312e4c08710d90065394c33b8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//2285ef574c11d88312e4c08710d90065394c33b8
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:26=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/samsung: acpm-tmu: Fix IRQ locking and error handling

acpm_tmu_has_pending_irq() acquires and releases sensor->lock around the
INTPEND read, and acpm_tmu_thread_fn() re-acquires it to call
ops->clear_tz_irq(), leaving a window where concurrent .set_trips() or
.change_mode() calls can modify sensor state in between. Moreover, if
ops->clear_tz_irq() fails, acpm_tmu_thread_fn() still sets handled =3D true
and updates the thermal zone while INTPEND remains asserted; conversely,
returning IRQ_NONE on a level-high IRQF_ONESHOT line re-triggers the
interrupt up to 100,000 times before the spurious IRQ detector disables
it, so unthrottled dev_err() calls flood the kernel log.

Replace acpm_tmu_has_pending_irq() with acpm_tmu_clear_pending_irq() so
both the INTPEND check and ops->clear_tz_irq() run under a single
guard(mutex)(&sensor->lock), only mark the IRQ handled and update the
thermal zone when an interrupt was pending and cleared, and rate-limit
the error messages on both IRQ_NONE failure paths in the threaded IRQ
handler.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-9-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 42 +++++++++++++----------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index 65be888..42b338d 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -330,11 +330,12 @@ static const struct thermal_zone_device_ops acpm_tmu_se=
nsor_ops =3D {
 	.set_trips =3D acpm_tmu_set_trips,
 };
=20
-static int acpm_tmu_has_pending_irq(struct acpm_tmu_sensor *sensor,
-				    bool *pending_irq)
+static bool acpm_tmu_clear_pending_irq(struct acpm_tmu_sensor *sensor)
 {
 	struct acpm_tmu_priv *priv =3D sensor->priv;
+	const struct acpm_tmu_ops *ops =3D &priv->handle->ops->tmu;
 	unsigned long mask =3D sensor->group->mask;
+	bool pending_irq =3D false;
 	int i, ret;
 	u32 val;
=20
@@ -343,53 +344,50 @@ static int acpm_tmu_has_pending_irq(struct acpm_tmu_sen=
sor *sensor,
 	for_each_set_bit(i, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
 		ret =3D regmap_field_read(priv->regmap_fields[i], &val);
 		if (ret)
-			return ret;
+			return false;
=20
 		if (val) {
-			*pending_irq =3D true;
+			pending_irq =3D true;
 			break;
 		}
 	}
=20
-	return 0;
+	if (!pending_irq)
+		return false;
+
+	ret =3D ops->clear_tz_irq(priv->handle, priv->mbox_chan_id,
+				sensor->group->id);
+	if (ret) {
+		dev_err_ratelimited(priv->dev,
+				    "Sensor %u: failed to clear IRQ (%d)\n",
+				    sensor->group->id, ret);
+		return false;
+	}
+
+	return true;
 }
=20
 static irqreturn_t acpm_tmu_thread_fn(int irq, void *id)
 {
 	struct acpm_tmu_priv *priv =3D id;
-	struct acpm_handle *handle =3D priv->handle;
-	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
 	struct device *dev =3D priv->dev;
 	bool handled =3D false;
 	int i, ret;
=20
 	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret) {
-		dev_err(dev, "Failed to resume: %d\n", ret);
+		dev_err_ratelimited(dev, "Failed to resume: %d\n", ret);
 		return IRQ_NONE;
 	}
=20
 	for (i =3D 0; i < priv->num_sensors; i++) {
 		struct acpm_tmu_sensor *sensor =3D &priv->sensors[i];
-		bool pending_irq =3D false;
-
-		if (!sensor->tzd)
-			continue;
=20
-		ret =3D acpm_tmu_has_pending_irq(sensor, &pending_irq);
-		if (ret || !pending_irq)
+		if (!sensor->tzd || !acpm_tmu_clear_pending_irq(sensor))
 			continue;
=20
 		handled =3D true;
=20
-		scoped_guard(mutex, &sensor->lock) {
-			ret =3D ops->clear_tz_irq(handle, priv->mbox_chan_id,
-						sensor->group->id);
-			if (ret)
-				dev_err(priv->dev, "Sensor %d: failed to clear IRQ (%d)\n",
-					i, ret);
-		}
-
 		thermal_zone_device_update(sensor->tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 	}
