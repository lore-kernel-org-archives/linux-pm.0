Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607967;
	b=JFSzwSsiOPFPeCoxk9+wx6pGBMUfLPbINr8xtxbE09TdP1AEVEiiDFBLwPiG8c3YPfhd
	 ZI6E2qh1misaw/r26i0YRaVmepb5K+cBYmM14n8ExRyiSYJGF6L5nETwf6W4YuxuHMQmb
	 /PaLS19msRICcX7MQc/Gz7/+wP8cXQaK4mGXkUYvIVuxhIBbLOF3QsCFmk9/r8edA+rrv
	 9yX2Zd9aF2RuUjEtQ360jr3mNSUdIPtKHszEJcQIALoe2AAsgPWNfzpgP9eE6WxLbqmWV
	 So00jBqyHV8+CCQ40wFtjeLVHf1FzqslcYMr5oSJ6JLuqhknaUggcznQ1uMuAfTrtBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607967;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=aDeKYnbNfrYtOI7GvDjcRNtZbUR6gqyQF4vphPq3DWY=;
	b=lXV3SQ3GDxLV0oMVf5JhKbOOpseUZI8jT0FOe8m+ACG3rDraoB/OJ5OynDyVihuTGcZg
	 2MvFlTBh41oJPMnwanwgk7nnlrNuCIsMeiosihPM67f5L/cu3/mLtrHFc/6WAcKSyNtO1
	 LDnV0ZpYl/nStyARr/zNoj9wsnOb7BlCVVkO5UAlhEot1t+Bqr8P8LszanByQ2yEvtMdU
	 ztTPniQVqFqNDaaQtu+IxlvVIflgNDbKBrHOX0o/ARDVa78/pf2ED6JdMTh19eUyJTZfH
	 mRAgAKRKfIZ3eiqttzYfzoQFz517z6NzDBcnjHoIf8dwcfARPFSP9GAcILKsGr9gUeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=g7ub3T7B;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=aWvHhnhm;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A606606A330
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A606606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=g7ub3T7B;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=aWvHhnhm
Date: Wed, 25 Nov 2026 11:59:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDeKYnbNfrYtOI7GvDjcRNtZbUR6gqyQF4vphPq3DWY=;
	b=g7ub3T7BBch2JjhoGSXN7ZJrKcnX/fLcO6cYB2OjMcvKeMZFIeq8JS89NZNrGSnxAgkofq
	avYQg1VeUkYcWxpa2d0JaZvpCX14/Lrlpavjc9mBtm1vtUnIEWW87guI7xg17YhrhjqHhF
	tqiySd52BXQxu/DFAD0+Q0ycS2qe26G+QUdzdKYMdseNYZH4Yw+ZVv8Ohzx/lM4RlLXO9U
	K2ehlv79b0zZYh+fGyiSgamOlQCwXy3YhyWKCYHtkoTkAeZi/sZw6hPyH2l9PtDke8tcPb
	0K00MeZKUJarE6eZmS5WETojDkV1o0HJmFJxIQgITFgP4UssgmLh3nlDNrR7Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDeKYnbNfrYtOI7GvDjcRNtZbUR6gqyQF4vphPq3DWY=;
	b=aWvHhnhmQOmH1Exk5icErN6a5pOLwt2XGoQBkeN7Ks5hVyA4IEMWD5OnyNSz8vW+nkWQfc
	iaSgIAVsDw9fGCBA==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Disable IRQ across system suspend/resume
Cc: Sashiko <sashiko-bot@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-4-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-4-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560796397.92412.9843937836472139044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     7b0469dfa22e78b85a77d040ca787110fbcabfa9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//7b0469dfa22e78b85a77d040ca787110fbcabfa9
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:21=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/samsung: acpm-tmu: Disable IRQ across system suspend/resume

The PM core masks device IRQs in dpm_suspend_noirq() and unmasks them in
dpm_resume_noirq(), leaving the TMU interrupt enabled after
acpm_tmu_suspend() and before acpm_tmu_resume() while runtime PM is
disabled and PCLK is gated:

1. If acpm_tmu_thread_fn() runs in that window,
   pm_runtime_resume_and_get() fails with -EACCES and returns IRQ_NONE
   without clearing the level-high hardware interrupt, triggering an
   unhandled IRQF_ONESHOT interrupt storm when the line is unmasked.
2. If acpm_tmu_thread_fn() is already running when acpm_tmu_suspend()
   executes, pm_runtime_force_suspend() ignores usage_count and gates
   PCLK underneath MMIO INTPEND reads.

Call disable_irq() at the start of acpm_tmu_suspend() to mask and
synchronize the interrupt before tearing down sensors and runtime PM,
and re-enable it with enable_irq() on acpm_tmu_suspend() rollback and
before returning from acpm_tmu_resume().

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://sashiko.dev/#/patchset/20260603-acpm-tmu-v8-0-0f1810a356e6@lina=
ro.org?part=3D2
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-4-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index f490551..55ee972 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -541,6 +541,8 @@ static int acpm_tmu_suspend(struct device *dev)
 	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
 	int ret, restore_ret;
=20
+	disable_irq(priv->irq);
+
 	ret =3D acpm_tmu_control(priv, false);
 	if (ret)
 		goto err_restore_sensors;
@@ -568,6 +570,8 @@ err_restore_sensors:
 		dev_err(dev, "Failed to re-enable TMU after suspend failure: %d\n",
 			restore_ret);
=20
+	enable_irq(priv->irq);
+
 	return ret;
 }
=20
@@ -580,14 +584,19 @@ static int acpm_tmu_resume(struct device *dev)
=20
 	ret =3D pm_runtime_force_resume(dev);
 	if (ret)
-		return ret;
+		goto out_enable_irq;
=20
 	/* APB clock not required for this specific msg */
 	ret =3D ops->resume(handle, priv->mbox_chan_id);
 	if (ret)
-		return ret;
+		goto out_enable_irq;
+
+	ret =3D acpm_tmu_control(priv, true);
=20
-	return acpm_tmu_control(priv, true);
+out_enable_irq:
+	enable_irq(priv->irq);
+
+	return ret;
 }
=20
 static int acpm_tmu_runtime_suspend(struct device *dev)
