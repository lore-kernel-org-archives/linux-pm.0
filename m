Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893765;
	b=3C1sy9irTtKgAusY/B4R9X73rZLYOfd/efk1MxapYstsB46UThF2ofgPgLXszW+j/AoW
	 rrOzJP5g5Z+2dILy8JLb9Pnzv/mipgvt5qHfmF2+fRfIWNdnSrjamkJgviwl2E2u1kABX
	 b1rXjmatno5MK0r5efoJPQ3d07twihsQhHhF1az16mj/lGO/oFt8qcIl6UyzQQxTV02J7
	 2J4jWc8qTkjwjC4P9SZo52u4KBXxLq5T1s9rsWrkGDnQO8Y9rZ4EJk43FsvCpMY2tNzU8
	 DdxlZJ38IaqGSJEQhlchmRRYwg28dtN+I6zLZSCVHnk/1ejnbO9emkChh6jWBo3XN4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893765;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=nziS5TbtFGx4rdOxVPJ034Qg1SHmwYCA5vWFG7kEirU=;
	b=20BHXOfI5pxK2iYRBC1R8C7MEDV2kLrSR9AmoQw6Sj4YIxMK1XrRRK0WZ74WRzDj1M8B
	 hH7Wju9tO2t1phK9cplAwlrKeebWi7OX/QSon/HzwncL0I32q8L0W3lzZSjsK0uk6m1WZ
	 MP74aQDeNRrHdIRjvGIKMAUyfozD0Nl48NADc3ZLs8c22qLr7DTU2Nh4r3ZMBaXzSJppa
	 aYgVJkWqdh1KEtbXim60RGup+gQSLtHDLRO+vnkt+98xDPp1Ipe+j2keUntrggXUn+gZK
	 WY0FXA7FPtuZ/RQDfqtYsawkEht/ViuZpo7Dleos50rLCbEqTJFDrEBGYhPQwifCGXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EHkbJaxa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mm6eHSB9;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3B608363F
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C3B608363F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EHkbJaxa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mm6eHSB9
Date: Thu, 05 Nov 2026 15:49:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nziS5TbtFGx4rdOxVPJ034Qg1SHmwYCA5vWFG7kEirU=;
	b=EHkbJaxafSKL0JQuua32yvHW2NyygWgUTu1jpffkKL/ZKq3qNFTa07dbSzOFUZ80uOfhWx
	quMrfUIzY+EP7isKGulHYIpJetBnEr6gOLreO4GpwDC8gcwMJx74Kbs/sMEuSPPNFMjcjz
	sJq/br3bDxeXxrr7aI/a8ug2e3V00MwmeMKB/BazSm4Ra8QMa83YgS5qXqBTeHEGWTL6h2
	iNISPszY1UQEdishfK8UgFeD00hmqrG6S8zlugfwloJ1WcHPOnpdSpGKwoW1oWB3elij7N
	K69mB2RM5yCqx4OcFzAS7S8t8L1h80J57poM9YV0xo9LxtzqFEOPMe+ESgdjEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nziS5TbtFGx4rdOxVPJ034Qg1SHmwYCA5vWFG7kEirU=;
	b=mm6eHSB9PtNEUJwZkPixCY1XeHvijMtD+dx36Y9WYMaBFKcYvwBAsMQ/0NlJ4ujTrmrWXX
	4pGRQjA7Q6d7VcBw==
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
Message-ID: <179389376185.1009794.10578357051183454451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     2237a6871722f9cafedf6820527a88430df26be2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//2237a6871722f9cafedf6820527a88430df26be2
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:26=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00

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
