Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927237;
	b=YieTRs8cj4leffbbCh/19Ifk9g9ewdsQ2Fbn57pmb7rj4TU0G+FP9ERv6QyU2vYFHmMI
	 W4gEqUb3r/eaz+04JNZuUU9FwUyHchFlGkHs9rEwUfkIkj4l3dIChRkLxEdc7vhhhPscV
	 LAAUkvhl0CTKKgqacl8yPFtCSP2DaEFz4QI/5/yyrfhxBpCEf41Veafs/oqKqNb6cII46
	 yS/Xkt7/YQNbgb9INboUm/YvpdHlKufzuXa13kTKo2S50SkyW1MB2CPwWsV91RsOMqjDe
	 AuClBssdbEBOdRFb04G9gxw6cVZ3zscBzpQwQhLW0PG+0ygGU65bn8RIzXl0KJwuCjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IcxkjBHup5sZEhtgWmpJfXaRSSMGBc6DzJDbIf6ZHew=;
	b=OiLU4YNqTesfrNqEN+yi6b0pAo8I0xRjsi6AwF1lCLkrRZcHuFOPhGQsxIJez0c0Z/Pm
	 x0XjG22CHJnGKistn8kGmBvsDusz7KY1aJQsOa/tnmh3rd/f+261E4W+JS1Eb+cGYIcp/
	 hpCDdcSs+Q/SUZ2gFOOkmg+GlIvhOXnTeDe0WBfdMNnzu0drXEvqFsMrTwZKfdrP2tBMy
	 eyfwBNEVbZ/FLA8CfRw9mORJP3MXLeP6xNmjYJwb2+F6x4Je5GtZPpwv7Gs5yrNSJllG+
	 WFMikhAkHsQOuGfa3ixbKbNBKgr0nwb++JvGnpiCfpfN+NiBS1v9a+KuX54GQdAQJxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dBr/0Bb+";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F4606A332
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 14:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79F4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dBr/0Bb+
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso883725a91.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794927236; x=1795532036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IcxkjBHup5sZEhtgWmpJfXaRSSMGBc6DzJDbIf6ZHew=;
        b=dBr/0Bb+hdm5ZUT3xp4UZz2XLLt/WRlAAT5R1y2ZnVq7W4/jwNXoayAVMZ2SCj4iBW
         b4V2Q5LCCw10lHqDFL+hd25tjoM79SokWeW48mSt5kk5Dh8FJPjESuaVXOzc0EX38LM9
         jo7/7Hh0lxoYOGIr7nfHu8RY9/sDG6CxojsYr+cn8r+qpW94GETsCOPURwPllE6TanA8
         ii4dTsS5fL/q0NKMr3OYIt2CulS316B+6cY5mX/cEz6PjotIBYhiNrW1uNhVhe8Iqgdu
         /dAsn6EOZY72xwHJD2dffY1fon+W7qRRscBsi0wa/XwyZ9u/K/PucgBsD04GwtrwDVMC
         Yvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927236; x=1795532036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IcxkjBHup5sZEhtgWmpJfXaRSSMGBc6DzJDbIf6ZHew=;
        b=B3QP1Kxp/iceLIj37MNe0QPXogbNQ+sqm6DrBJtppDqLY2bQTXFfJZUngtyDuoXhS3
         Aqcdg14W3kUgS/PAJVIGMpt6dqkwQVdpU3USBX4TOkXo43WOttWaIQZcX+hA9ifIaoKU
         AMvXPh3FDQrB7M7MHk0R9tJ1k+RkoSFRfZGcsbIUAktQMfB7xAl9zO7sr4QjUzt43BF0
         A1yqT/pcf3gKmesQyQq4bSIraNC6Hiqd8k1kywt26u+4vk2/8rbJYHdS8uEio8tEF0BR
         aLPjY7sAlZLNDVoCk7+CBXqNeVqD/evux3VMW+KxaJFK4APb3TTtfVlEQPfqkErcIIE0
         qrYA==
X-Forwarded-Encrypted: i=1; AL+hErHDu9Li84LCAo5i8aji3TQB8JltXi15caGRlkXwLaMDZxX8YIJ/ohhhvXOYA4rKSwTasNPvtY15xg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8I1otDVYj+4OehL1fBeAgLxqUG7gotylbOW2cv5btXKz0KMS1Q
	8b6vDBoHyPZe0njaESWh8DfCnRJSQLeMR4BwsDDs1SrdbJgb7votaoph
X-Gm-Gg: AZFdTZeOScH0gDEuFlA/Dx1kX1dgT//Qi0IHb72Gb5mZkYVnlk2aoEaOL72YdZSq5+s
	Erga9R8f5CqAY1mg4mv55tyrv+E4N7R2TmU7BjzQxxTljHKzTbQhfIl5wRvrQVKWiJaSD9GYrrn
	WlGD00ouVxLYbcWfDC6kNJH6PTggkk+2rLnDNckGkSgS31YBNWQ9xA+gILd4W0ArTjSmtsznwql
	NRAuLv8JTVla65CEJ54dyjMgcnJpX41EAz+DbZgfYCbn5WgrsIDVzfH7AvADrM0nsN42meKGE5Z
	tjHftcDlFZHtdIuMNA/CvhIkUcuccj5jQzBFgZ6ZJoHp/6wItRCVOxdmP7R4E0gg2pCfpQJ8DBx
	7aaziraPsq7PfgF3LU21V7myk1ooVtNl3N9mOT1IgXH1/k8eK8YCmiI+zHT6UXu/TsTnCAFNuAo
	v0osZlaqkSxaqzTrqHmyQLYzvO3hcZzzSDoABlmLmAgJ4i29UyCr7Y7kQ/5sUk/bkDpLtjLQAiP
	1DCXyUAS00/1mWAM/9ywpw9NVj0v+2/aHSAEaqlJpkyAzMARMl+b9oAWhiGegH/3FaomCprlzma
	RRQ5fYP6AxIk/Tb8So7H32+nl3sEJgqjojj74QKlfnKr4sABXiEMvDOVV2HysvJFWzalwoYwUpg
	hRS29MsHDoT7EtZyzcbVfpLB+qi2m3QTNAgsmSp6Q
X-Received: by 2002:a17:90b:4c0f:b0:3b0:a757:e372 with SMTP id 98e67ed59e1d1-3b1b0b63d19mr13435372a91.47.1794927235946;
        Tue, 17 Nov 2026 06:53:55 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm11910657a91.1.2026.11.17.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:53:55 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: rcar_gen3: quiesce the interrupt source before releasing it
Date: Tue, 17 Nov 2026 22:53:48 +0800
Message-Id: <20261117145348.1092528-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
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

rcar_gen3_thermal_remove() only drops the runtime PM reference.  The two
threaded interrupts are left to devres, which releases them after the
TSC objects and the thermal zones have already been freed, and the
device keeps raising interrupts because nothing clears REG_GEN3_IRQEN.

rcar_gen3_thermal_irq() walks priv->tscs[i], reads REG_GEN3_IRQSTR
through tsc->base and calls thermal_zone_device_update(tsc->zone), so a
handler that the hardirq has already woken can run after those objects
are gone.

Disable the interrupt source for every TSC first, then release the
interrupt handlers, and only then drop the runtime PM reference.
REG_GEN3_IRQEN is only ever written by rcar_gen3_thermal_init(); a
concurrent set_trips() writes REG_GEN3_IRQMSK alone, so it cannot undo
the disable.

Remember the interrupt numbers that were successfully requested, so that
the partial-probe path, which also ends in .remove(), only releases what
was actually registered.

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Prepared against v7.4-rc1-1969-g666539eecdf4.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.

This revision also clears REG_GEN3_IRQEN for every TSC before the
handlers are released.  rcar_gen3_thermal_init() is the only writer of
IRQEN; set_trips() writes IRQMSK only, so a concurrent trip update
cannot re-enable the interrupt source.

Testing: compile tested only (arm64, gcc 11.4).  No R-Car hardware was
available.  The partial-probe path that also ends in .remove() was not
exercised.
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 9c64cbc2ee67..35bb49915a75 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -110,6 +110,8 @@ struct rcar_gen3_thermal_priv {
 	int ptat[3];
 	int tj_t;
 	const struct rcar_thermal_info *info;
+	int irqs[2];
+	unsigned int num_irqs;
 };
 
 static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
@@ -468,7 +470,28 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
 
 static void rcar_gen3_thermal_remove(struct platform_device *pdev)
 {
+	struct rcar_gen3_thermal_priv *priv = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	unsigned int i;
+
+	/*
+	 * Disable the interrupt source while the device is still runtime
+	 * resumed.  REG_GEN3_IRQEN is only ever written by
+	 * rcar_gen3_thermal_init(); a concurrent set_trips() writes
+	 * REG_GEN3_IRQMSK alone, so it cannot re-enable the source here.
+	 */
+	for (i = 0; i < priv->num_tscs; i++) {
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN, 0);
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
+	}
+
+	/*
+	 * Release the interrupts before the TSCs and zones are freed:
+	 * free_irq() waits for an executing threaded handler, and the handler
+	 * dereferences both priv->tscs[i] and priv->tscs[i]->zone.
+	 */
+	for (i = 0; i < priv->num_irqs; i++)
+		devm_free_irq(dev, priv->irqs[i], priv);
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
@@ -504,6 +527,8 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
 						IRQF_ONESHOT, irqname, priv);
 		if (ret)
 			return ret;
+
+		priv->irqs[priv->num_irqs++] = irq;
 	}
 
 	return 0;
-- 
2.34.1

