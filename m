Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893773;
	b=t0TPcLRx+naQSoYTewv7PIXur8/t4HlERsAJncokQlTO69GbBQfYDPCoC95st4tO46Z+
	 82AaXUmQe+BzDDgPNGtkZtZUsOQ4sBSN5ccQkqUHlPUQ4GvSPuJio8BC7m63lMnvYtIlu
	 IqYjAzK1RGSRsvzxabvmUk6Cl+r8OzWyjVGxLIO6fIzDSOhEjTGR7OjlvM541oC4zI2Ra
	 YH5GG08VYRizbdtcR11nji2AqSJHUTqAWlI8sryDGyE3hbk1cBoSnrxRtww2IUhcFgLmL
	 LzDOdE/Mbeor4XxNXYWIDppMxXwDjIwO0pbMdvgCzYOy6CWkQi6x5G3oA8OqZ2ByEgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893773;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=B0xlsfBzzq53G9u6bldGuV7s36xo3a13EiwJE8NDYa8=;
	b=AtUg7RPkdxP7lMUQ+D2ugyUq6Gx3UJ3Lgh740m6+NAg+wdkbaGRj/L/UWHrSajHRDLKr
	 GFIbDRgmyLsrJ7YkPNf0FwIH5T5CJvtehV3WhkyODeFCMS685ThOgoWDnT2thDxo229wC
	 ZeQhp7vmFsZsPKnx0tHPuVxYH1lLFEIVpW/L01fhy42mY0TDT2E15Oqavc50KZZwdSaoU
	 SCFTXkxk97PZHuGjc/6xoRWLTsXYaAaDHA1hObWDkCppZD5AsHvqkJyBZnvGSWIJVnQWi
	 TB3hxG3gOs1J8zXYR7Rfm+fneMndmQS0msbdx+eQ+QoC/WcJ3y/hBJmYi4fbcfjYT9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HolMXL+9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="M/lfr2lc";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6960A5BE0
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54C6960A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HolMXL+9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=M/lfr2lc
Date: Thu, 05 Nov 2026 15:49:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893771;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0xlsfBzzq53G9u6bldGuV7s36xo3a13EiwJE8NDYa8=;
	b=HolMXL+9ZnroDQy7R994kFGXEmuU2GgzolxuTBuZiiEQtXs7RGgmz6pDCTLZBu6e3PPksk
	k3pzFPf1cj1c95RMvSSo6QyvcI/5SZFkt8yqMfwHlCd4gGgrBy9ml7r6JsVHCMEDmAIfme
	xI8lX3dQP5e+pMwnnu2PPXFLpduL4ufrm8SDlcxfEVmP5oPYZXBm9aqmjDwmpkgCtTv4gV
	u5R+/+1idz/9L5TAMHT46gr9QBwqlh+3j43M7Gw0VvsZvrLkaL8tW3NGcXJMLMFk3Ofvuu
	Nzein5qXcyK0+F1Zahefh5v6OqQdBt/nedtFaa3eIoGKiJkwG5JsAWFoAWC1rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0xlsfBzzq53G9u6bldGuV7s36xo3a13EiwJE8NDYa8=;
	b=M/lfr2lcSu8WXEIS78+CEj7AgTFAhohQXUXD9f9hg/B+txDZSMmNochda6GXnr2MmdyXdg
	9yG3gAoXG9lA8nBA==
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
Message-ID: <179389377003.1009794.1793884789522136780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     e0e2dbdc45f208c1d14cf891175378e93dde5098
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//e0e2dbdc45f208c1d14cf891175378e93dde5098
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:21=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:50 +01:00

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
