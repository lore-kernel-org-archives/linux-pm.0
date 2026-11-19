Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055354;
	b=JlHHGZgdDwnah+Hz7Af6/TLOp+id2oEBKUS/KLYtC7cW+KnUveCuhi2uUEN7Sh9FwK15
	 jmrvSlKRkusz8rtqWtKVHg2WuNgt7cXgAhcpPdEMaBDhCxc4Zvb2rIIjIW32WaqiTy9Sq
	 sp+8MYZ2v0rGpkQt8Pgu4bbwK/DpxlOMsclX0OQ3pG2kxWwtOQld7S+crl6ySRxUjBy4T
	 cq6F1PJroUJ0weopa4q5jNuYksLX93MUout6f8pPfe6bqlui//6NRwNsikLer/ANTVA4L
	 0jYYjv8yAXTkWY5HztAPRfP6UXKQj6yMjgujc4EhJP1WpzZrz4A8Wqo0IcxTAcMj0Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Jf4u6WrHRBEz+rPw92oXhHCCYEyYYwuCte9W9COqiwg=;
	b=w45IM7Ou07vxCYTSbdk6HOu/NG7/h8QBd7kIW34crKprpx3EqbKLGTtlU00VTEYGE4Ug
	 EoiLLki/7hHWGsQsUJ1NuUWnJLaYFAwgkd4Y4x1QlfGLxDUdUrWoRQJZsAm++cNSFGZng
	 RN3aqJX4KwFTf9fZ06VbQyuw5v52Vu5fu4qqz9pGdZ4hkrGVczhpdN6lvVmlNAXdXg2QV
	 rBFQcr4j6l5nBGJLM3utkxYiLsTjfMTqGi6hQ6X1kSnHkrECE30rRWQTFmgo23XBGw24M
	 d0u6DG9Rk/qE+6xN34sPMTJ2tmNNL8dnRFu+1O1fcoKFWbJ/uEYmWd8u7Hp4/VqAI+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDvcu9l4;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BA60A2604
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 02:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 533BA60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDvcu9l4
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a3c08d6928so2442251c88.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 18:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795055351; x=1795660151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jf4u6WrHRBEz+rPw92oXhHCCYEyYYwuCte9W9COqiwg=;
        b=IDvcu9l4Ql+lH7/tSPgv9W9HfcOc/IlSoDXSzqw2Ogvz67xObeBNwdANsGavByYeqR
         KLInUZZRA8fvMR5BH+qjegeycnrJnF2idXQf80J85vtVzSf5bv2kUVT0DUS82R6a0W1X
         mIIrlHVvcAOW0086g2Eg2jWaIyh1AY7je2ufJb19IJEkwnGHJ4WoAAZBAqxqO+Q09otm
         FAkm8yJCLPD0sbiGlKOfWcH4JeNqTM3/kP/BdSeg1kAurOcHfPvbfg8vid66HxuGrTUP
         CHFLXd6SuScxyvZTeO17Pu/hf3SVvU+6dOs2cuXvZ9EaBdfIgYPoVlRUYSwEtlhWnOoC
         pwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795055351; x=1795660151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jf4u6WrHRBEz+rPw92oXhHCCYEyYYwuCte9W9COqiwg=;
        b=kUOzQAuU4GzW9btOJUL9oEqecgpW3kMitpd8HQgdv8QUQ8GsqrnAeO6XEU65Pz97qL
         xp7m3jD9zcIZZVHj2GvCr1bto6YwdpvNmmawS/Bmcdx866iVF0ZzgfOMY641ix/1fjgn
         XmjocHL0zIldSJX8lSlBI5vuO/SLoVKXZ+fUn9iqebxsqjYe82wCnhfrdiG0ncanNZRg
         tv22QT/0M4c46pc6epGFgJSD3YnZAqvQcytP8lRn7MTqCLFYRdEbbLy+gBFKr7yrJGgm
         J6pqxTUzrKIo4A0KgEf35BikUSP3VT8e8oggaRtuTfxMKZZNeuRQ8oPReUCL1eqRxWpD
         TvyA==
X-Forwarded-Encrypted: i=1; AL+hErFpURnqdrEpINI8pS5Y4FwXfe/1oP2wse6yiDHqEFUvIu1MhC6K5hwuNPtGxF28sStfmJzOxjaTvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OmAeeVgjmrrUicoJWR46s9gXMsd/WsLBv3OOSEqYdhpq2U2TD
	0/B5NHMktmCusLv/Wah270cqa4rG4o+UFjDr6EE5OR+P8i/SoMryMCg7
X-Gm-Gg: AYBFou0aypVYzPnwbjHyKexnVrghjnN3lJmK3tqLxL40NHO5MvPUqVoaAii3N83sN4f
	Hq49pKkFhYewCIJwDWe1T1+8MiROGuN0vCsza7KyAbVk2qtirLI3AoUE2hAF4/d2qP8NJVEVTNQ
	h0HHRbUBF7BXYxP5u2KCoyOxgf9aDPzTnvJ3l4IPmJbF//OcxPWxZ/OQ6tSeiX9uRmK49bGiujX
	mIiRmmQDfH6MCkcEPjwOzRCS5s6BkPmAdmWVoujt3ptCWaPGIs1Kexs4CUN79WHa9bZYOhg7boU
	cQwBJpYlXDtgdwgNy/3JxS9cvCIn1O7X0Vlj4E1NFU9EiD+saQiteGm3lNsaxOc7u7CyRqutQ9Z
	aXjN95NhJNLc16thbQJm7mnTtmb/i5cQuogMddsbZ08bGVg6NfN9L8PLEqOe6J/iuJG3Op+0xyT
	w8qMrbQLEh24Q0Gek9p51nQQq/+qIy/etygbUtCuYK5iDzPxZ2n+bhLmYC5fmpDkx2vxQMmfbJq
	2dCeXWOM6INT8VX3B4z4ycW+ftiFc8Q60mV1ZZ9Hly3iq2ilQ4KUy/RqEDuEbFYNIBZMJUj6KFz
	+5xNdBT5RU/4ycXzdmBkFmlJRWl3Z5QXOs7JkrRLyVkv+l2vQDVjBuNYPzdw5I5X3OAA6bvEcEI
	Hp/D8fLfJ38m95LpBnaGXLZZgWvtRUcoLcSYaZus0
X-Received: by 2002:a05:7022:1708:b0:1b2:4b42:1870 with SMTP id a92af1059eb24-1b543cff066mr3748180c88.31.1795055351102;
        Wed, 18 Nov 2026 18:29:11 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:38a8:0:f6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b549e398e4sm5790186c88.15.2026.11.18.18.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 18:29:10 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: niklas.soderlund@ragnatech.se,
	rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edubezval@gmail.com
Subject: [PATCH v2] thermal/drivers/rcar_thermal: disable the work before masking the interrupt
Date: Thu, 19 Nov 2026 10:29:03 +0800
Message-Id: <20261119022903.1493494-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118072321.1259639-1-shunsheng1218@gmail.com>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
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

The interrupt line is shared, so waiting for the handler once does not keep
it from running again later; unregister it in ->remove() instead of only
calling synchronize_irq().  devm_free_irq() waits for a handler that is
running right now as well, and the slot is marked unused so that the probe
failure path, which also ends here, cannot release it twice.

Every sensor that the removal walks has been through INIT_DELAYED_WORK()
before it is linked into common->head, so no uninitialised work is touched.
The interrupt numbers are recorded in an array whose unused slots stay
negative, instead of being counted separately.

Fixes: 697ee786f15d ("thermal: rcar_thermal: Prevent doing work after unbind")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4, CONFIG_RCAR_THERMAL=y.
No hardware was available, so the removal path was not exercised and no race
injection was run.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.

Changes in v2:
 - Drop the shutdown flag and the separate IRQ count.  Niklas asked for less
   state, so the removal now disables the delayed work before the source is
   masked and unregisters the shared IRQ instead of waiting for it once.
 - Keep the interrupt numbers in an array whose unused slots stay negative.
---
 drivers/thermal/renesas/rcar_thermal.c | 37 ++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index af6d09a75bb6..3310ed4a8bda 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -39,11 +39,15 @@
 /* THSSR */
 #define CTEMP	0x3f
 
+/* .nirqs of every supported chip is at most this */
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
@@ -376,10 +380,34 @@ static void rcar_thermal_remove(struct platform_device *pdev)
 	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 	struct rcar_thermal_priv *priv;
+	int i;
 
-	rcar_thermal_for_each_priv(priv, common) {
+	/*
+	 * Stop the work from being queued again and wait for a running one to
+	 * finish before the interrupt source is masked: rcar_thermal_work()
+	 * re-enables its source when it is done, so it has to be gone before
+	 * the source is disabled for good.
+	 */
+	rcar_thermal_for_each_priv(priv, common)
+		disable_delayed_work_sync(&priv->work);
+
+	rcar_thermal_for_each_priv(priv, common)
 		rcar_thermal_irq_disable(priv);
-		cancel_delayed_work_sync(&priv->work);
+
+	/*
+	 * The handler is shared, so waiting for it once is not enough: another
+	 * user of the line can invoke it again after that, when the zones and
+	 * the sensors it walks are already gone.  Unregister it here; that
+	 * waits for a handler that is running right now as well.
+	 */
+	for (i = 0; i < RCAR_THERMAL_MAX_IRQ; i++) {
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
@@ -413,6 +441,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	spin_lock_init(&common->lock);
 	common->dev = dev;
 
+	for (i = 0; i < RCAR_THERMAL_MAX_IRQ; i++)
+		common->irqs[i] = -ENOENT;
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -449,6 +480,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (ret)
 			goto error_unregister;
 
+		common->irqs[i] = irq;
+
 		/* update ENR bits */
 		if (chip->irq_per_ch)
 			enr_bits |= 1 << i;
-- 
2.34.1

