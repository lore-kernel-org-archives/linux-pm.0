Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486948;
	b=f1YDq4q4F3K6N8uUVUUpUdU59b5ZcaodU01J5J55HGiGf9qrG587MnTy/bLPuMx9NfaY
	 gyqkq6yD1GqU9LUjM5QaUJQFrfybNpwwHolS0Dzw58/KLvQG3V17YN1lQORd8cBujru4/
	 mqWuNouDM8FpX1ufH+FlVEVauTKrcQIpzpfsaxIMSUfgHHMhigDxUho57xMBxz8SJFaTS
	 OEahDQxsJdNoAc0VfXoD9qPmx4P3CeSeajsFgwSI4MCRb7sExUJnl2JG4GzjO8+3YgLf6
	 7N3YzWN2yLs1g7edyEfFeaZyYpdj603gfuHUJ4E79QNA+Rw3V12Iq+V9BZO5BDlc3YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fChudSS+GMscnTNQH5lusxdbEKIsc2g9AYrb14IcD68=;
	b=vnSP78/3cSy5pY2UA3Bmd+JXOilLQ+F/uzECco+sHnopcWizZnnzgeabh3spqaoYBzrN
	 ny3BgTNj1cyzY4gUU7fJa4fQ34XkGeCCk2gWa2ysFd0jJZY8zDr9uk1Lec2mktkW8W87k
	 gfDKGTwl0G1GdWBkCECwaB2UA086cOP0Acz1/ztaj7Zlq59PzUo0DMCrvhzJModr1zwq1
	 cIC+CvR+bPEhosnJgACIP704NAxNXehIDU64KqYzpZuLt+sQajSIT/kjkELTD4B46R1Iy
	 iA+YWz0iK08EJf2SXmpMhBiZdvNSfpx5a/4F9yHzHjjbExLwmhPTtCP9wW2fFWs/9rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2qOhPiA;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9963606A31E
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 02:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9963606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2qOhPiA
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1784519a12.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 18:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795486947; x=1796091747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fChudSS+GMscnTNQH5lusxdbEKIsc2g9AYrb14IcD68=;
        b=s2qOhPiAJaFEQ7mFpB0amw4oRwesRpeagCjJpzjoW6ozdz2ajRiH3kXJD5weg47+3j
         OLelbcYnmzUIPOPAZb6fogmWtIRSDwQDsHVkEZdukSS5wwZSF6/zmgd9NNHURspk8ahB
         bmL7HBa7dFP3/GmAm6baRVHXVX+M05VcTrCJSM/3Zd2YeVNzLbTC6GTVYlddLO5gLnYT
         NSOo2AfFo1n170PoT6/txYrM8SaPi6oB6O2K0w0yljgGeA7FIUG1KskHfLF7bl9ewgBe
         3h3ATIPL7zzkI8LeNIHg/65GlXyeLH7VuIhS6NeIAydIxzGxgMKyVv6M0MoeYffzTV3L
         oDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486947; x=1796091747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fChudSS+GMscnTNQH5lusxdbEKIsc2g9AYrb14IcD68=;
        b=zCVjWlPQOp3QunmV6Dl3D0SAP+d1nlepxOLevJ7ovElg8o0V7R/3PZff0vvigDZ0Dy
         N481SyI/dogAs/uVzEpEpboLJ40rJJlYTAzA7/ihUhQMQZaeS+fSD2wjB7jIElUdDrXK
         5HKg6XsumfaxOYN6+8Og5kisFvV5frBg4wSsbnfmAEl0ZxsYLB7ofHUhcW3B9JcPLDqr
         cgvhe5fW0xhkkClQCrBsO8N/b3syrNfo8lFR5Hd4nJe+fFGT/oGaS7IxDrXWrL+DhJsB
         YSTI4yk3HGor3+q82ia1cvHwAItg+kGwITmyl35LBc1zbm/INeZ6+z1H6uO5hoBsp3AZ
         R0DA==
X-Forwarded-Encrypted: i=1; AL+hErHWjdedMuw/km1BDCoQLEbpzMOUgTHAkXc3RIN6m1R6CQlfDIOkj1i5ylmiNJklZk5WNZOoG68RJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9yMhEub9mtQSiWBNpld9V5F6DMg7xRfP1GicyrtFIR8XElUJRS
	wmdgVrTpHs3HPesXCsvRR7+YEhMrIFB1aZBV8gfs8Z2aXPPlu6KC+C59
X-Gm-Gg: AZFdTZdxfwqhZgMhnlNILqOLIO7fYcL4LpaHGhwVSrVAlfsUDCG0NmJ4I3YJvkXjKoP
	5gUuxhwgjCszKwFY45rVCwbzG8sEZG1dn/N7JAbCBPG84iIWpdCSraGWP+3XKgl7/LGBwqiX6cC
	kLZ5jq6oEoL/f0RE2PtyFF0VaKQxq/UdpzMDUka86AAcVA6btUfDR12lzVFPASIANKumJ1dSct4
	jD+z4mZXlTt9W17Q3fjPHPf+JJt70vn3sPskTMlTxutrFxTcDA7OF7EtiQ9kz9mMfJxB+ljyD+3
	IjdQIDpjICvOAqB4e/D98p7j4DgsulgWKs+J7rRnDCDqGrEXHZ4L6ahrHPDmHUahdXiN+HSyhNr
	maXjREkzsOEBU8n0DM7wAuSnolfo/9a8aI7v4oeDgqvZkRyFxo11okG0xpHnHc1Zq3tLeAmrrlX
	aShPfie8rUPZbr5q6ApUTdp2bcrvt/DUGyjXINmOl5qtMvfXWJZdfz3Uq7BpYzoib07dxYD7ASD
	0BAfYJADa6v9GBF0f12bagq61FJlfbIjsGUl9JGrAD2itx9svJcjctLi2aYyWSJaoWDhjeqqfb8
	nFMJL7cxs8UmbFpjJZ5tHH2+AtbVLM9BcG8S9IIvta2d51FlJ578p8xFbADSHyhrDcc7xzEuI7H
	6S0PNlBTvugFk66KJrqRgYMMpGinpUhcjVFXoxwxpTWZqZhs=
X-Received: by 2002:a17:90b:390b:b0:3ad:eb38:9778 with SMTP id 98e67ed59e1d1-3b41c93e5dfmr11355114a91.48.1795486946762;
        Mon, 23 Nov 2026 18:22:26 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7d36bcsm8210837a91.3.2026.11.23.18.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:22:26 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] thermal/drivers/rcar_thermal: disable the work before masking the interrupt
Date: Tue, 24 Nov 2026 10:22:19 +0800
Message-Id: <20261124022219.1834499-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119022903.1493494-1-shunsheng1218@gmail.com>
References: <20261119022903.1493494-1-shunsheng1218@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcar_thermal_remove() masks the interrupt sources and then cancels the
delayed work of each sensor.  rcar_thermal_irq() drops common->lock before
it walks the sensors and queues priv->work for those whose status changed,
so a handler that read the status before the mask was written can still
queue the work after cancel_delayed_work_sync() has returned.  The work
then runs after ->remove() has finished and devres has freed common, priv
and the thermal zone.

Waiting for the handler alone is not enough either: rcar_thermal_work()
re-enables its interrupt source once it has updated the temperature, so a
work that is still running when the removal starts undoes the mask that
->remove() has just written.

Disable the work before the source is masked.  That makes the
queue_delayed_work() calls in rcar_thermal_irq() no-ops and guarantees
that the re-enable in rcar_thermal_work() has already happened, so the
mask that follows cannot be undone.

For the handler itself, synchronize_irq() is not enough on a shared line:
it waits for the invocation that is running, but the line stays registered
and another user of it can take the interrupt again afterwards, which calls
our handler once more - with the sensors and the zone already unregistered.
devm_free_irq() removes the handler from the shared descriptor first and
waits for the invocation that is in progress second, so after it returns
neither a running nor a new invocation can touch the driver state.

Every sensor that the removal walks has been through INIT_DELAYED_WORK()
before it is linked into common->head, so no uninitialised work is touched.

Fixes: 697ee786f15d ("thermal: rcar_thermal: Prevent doing work after unbind")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested: arm64, aarch64-linux-gnu-gcc 11.4, CONFIG_RCAR_THERMAL=y.

The ordering was exercised by a controlled test on a KASAN kernel built from
this tree (x86_64, QEMU/KVM; 17 checks, all passing).  The test uses the real
delayed work, workqueue, wait and signal machinery and a simulated interrupt
line shared by two handlers (irq_sim):

 - a work queued after cancel_delayed_work_sync() has returned is accepted
   and runs; the same queue attempt after disable_delayed_work_sync() is
   rejected and the work never runs;
 - a work that is running when the mask is written re-enables its source
   afterwards, so the mask is undone; disabling the work first and masking
   afterwards leaves the mask in place;
 - after synchronize_irq() returns, another user of the shared line raises
   it again, our handler is invoked and queues the work, which then runs;
   after devm_free_irq() the handler is not invoked again, while the other
   user still receives the line.

The test re-implements this removal ordering rather than compiling the
driver, which would need a real platform device, MMIO and a thermal zone, so
rcar_thermal's own removal path was not executed.  No rcar hardware was
available and no race injection beyond those constructed interleavings was
run.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.

Changes in v3:
 - Reword the RCAR_THERMAL_MAX_IRQ comment without referring to .nirqs.
 - Declare the loop index in the for statement and make it unsigned.
 - Reduce both comments in rcar_thermal_remove() to one line each.
 - Explain in the commit message why a shared line needs devm_free_irq()
   and not synchronize_irq(), and point at the test that exercises it.

Changes in v2:
 - Drop the shutdown flag and the separate IRQ count.  Niklas asked for less
   state, so the removal now disables the delayed work before the source is
   masked and unregisters the shared IRQ instead of waiting for it once.
 - Keep the interrupt numbers in an array whose unused slots stay negative.
---
 drivers/thermal/renesas/rcar_thermal.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index af6d09a75bb6..374c953471e0 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -39,11 +39,15 @@
 /* THSSR */
 #define CTEMP	0x3f
 
+/* Maximum number of interrupts supported by any of the chips */
+#define RCAR_THERMAL_MAX_IRQ	2
+
 struct rcar_thermal_common {
 	void __iomem *base;
 	struct device *dev;
 	struct list_head head;
 	spinlock_t lock;
+	int irqs[RCAR_THERMAL_MAX_IRQ];
 };
 
 struct rcar_thermal_chip {
@@ -377,9 +381,22 @@ static void rcar_thermal_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rcar_thermal_priv *priv;
 
-	rcar_thermal_for_each_priv(priv, common) {
+	/* Drain the work before masking the source it can re-enable. */
+	rcar_thermal_for_each_priv(priv, common)
+		disable_delayed_work_sync(&priv->work);
+
+	rcar_thermal_for_each_priv(priv, common)
 		rcar_thermal_irq_disable(priv);
-		cancel_delayed_work_sync(&priv->work);
+
+	/* Unregister shared IRQ handlers before releasing the zones. */
+	for (unsigned int i = 0; i < RCAR_THERMAL_MAX_IRQ; i++) {
+		if (common->irqs[i] < 0)
+			continue;
+		devm_free_irq(dev, common->irqs[i], common);
+		common->irqs[i] = -ENOENT;
+	}
+
+	rcar_thermal_for_each_priv(priv, common) {
 		if (priv->chip->use_of_thermal)
 			thermal_remove_hwmon_sysfs(priv->zone);
 		else
@@ -413,6 +430,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	spin_lock_init(&common->lock);
 	common->dev = dev;
 
+	for (i = 0; i < RCAR_THERMAL_MAX_IRQ; i++)
+		common->irqs[i] = -ENOENT;
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -449,6 +469,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (ret)
 			goto error_unregister;
 
+		common->irqs[i] = irq;
+
 		/* update ENR bits */
 		if (chip->irq_per_ch)
 			enr_bits |= 1 << i;
-- 
2.34.1

