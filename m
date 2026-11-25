Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575823;
	b=C2P7Es/mKMDjO6zdmqZbmWZiVYLkVy0AQPK0iktx8zO6730BTQaq33Huvi9mfA8i6bH/
	 Tml2qOrZMCxVL52SAkJqD7T3T9ECFhGy/61V+zteMqa+g+f4qf9kUBslFaf+pWpz8s7A3
	 jNmbsbYoZZdC8orgYDPYEtD0cWQWfSwIvUZ5/SvJsJoOAaYi4IWfIpba76SclhgR7Lbp+
	 2n+48ddPv3VB3L9jdrnOzq4tQbm/6iYorQ5EJwS6lViDdsvtU59vKbS2jTUNaLvLVm/Sp
	 uDAomXx+BOe0HXQX6NeC1Dgzr8/vEfYkxxLHc8oN8hjgYlmWZwCPDvI80Q9EBtHe5ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aObshDLUDkI5DYfLUeDOOwlZtaV71Oz7yE0ISv0Zs5o=;
	b=PwF3tMNm9csaDgpScXXnayhRTJNNZ9IMPuAWCb607jSarSZ31IwThQSxFyvW526ii7k5
	 2AQN3gP8HGS1Wit4XL/ggqF/NZsjkU3Ap3mpxMfE8NkTX4G2KpVKIvNHhF2obfgbSYsYy
	 QS3KtETelE9vdx2U9I0hlheYEntabN7rgD5jgK+72kW7wpIyBR5zblfJcAA9TJe9Ph47M
	 8r4CjA4qqZZk+UYbvW7a1yDq+QWSCXKlMXYfyVZJLBvtjXq1JaeoNi9QZilRXKmcvQ5Yo
	 eGJ5I6LDipeEYtwkw3aZEp96NHcOL7Gra7GXqtvASMhBsr21DSPVU6cZ0TzOl8bMtsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LDZ6Q0wf;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A010606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A010606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LDZ6Q0wf
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38431138772so6772309eec.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575823; x=1796180623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aObshDLUDkI5DYfLUeDOOwlZtaV71Oz7yE0ISv0Zs5o=;
        b=LDZ6Q0wfQlvvGbJjWLDPZnYrk492UiL1Dh3GsI9JvPsxEIOLue4hUCgxw31lKe4icI
         2V2yGnT2NqXS28IhxhzYIAKgOiEFqFIDaM6hdh/sWwosMmxYrRUTvzx3dJuMvVCgetbL
         QbOuwtprPJFaKgmo/Zxjzb30HYWhaRgTUPq3i8QACs72ki3DmkCnBkkzw9UQOVHWWSH6
         qlyrXon4M74/xoKWHq2DjSEhwqaKxO40o/erAtrdX8vOIyQYWoUe6CdEXKau+0GjJFx+
         2+3RUTHZ0UGytVOc2wC659oqLXi1V37QR8EvAnOIgYaxhXC9QA+EPvYD4Z2llrgSaYyf
         01Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575823; x=1796180623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aObshDLUDkI5DYfLUeDOOwlZtaV71Oz7yE0ISv0Zs5o=;
        b=osuHg4/l5t2gMc4fyE44oE9ovSwLRWYHEwCL4HsHNfVNSA+3NHu5wuj2USEMXxPRdA
         lNHVN5cOvETtrbbeQ2TPQBLSJKWXSDeO4KpS2M/CaWm1GrEKdorUsSS2JDahjOk7G8Mj
         iR3DPghq/TcipLW5XbueMhkL4/iGdIBSFDtB58IUJz45L74aA15XtjjDp4Qzwi9DJsXX
         Ke5gdL75DYD1gjrxQ3gw3Tq2U8atIGOOU8aC4wl6fnt1wC5+EzCzxLk/13ehaT10jZaw
         B9CYMTTBufNDd8ZUQU32pNunnPsysV5BO89tr0mCoyFEkXlGfQ7sIWf6Ni+3BLDpiYJ/
         cSlg==
X-Forwarded-Encrypted: i=1; AL+hErGjWZGf24frDhjeRN15t7xAm6JYngbm4JTEpPNbC1O/qvs9yLZ96sLobN3OzM9T1kRvejy4EDHwbA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9gSX7MmfhRkSvXXb442VANjfiryiCOsPX/aNeNFl85Ud3lgEhW
	zFIGnJexkgQhXGXurH2RDzRnTLYTppdH6BubBxHh8uLNRfKbTMAGO8fnHmcUAiIVRRJwCQ==
X-Gm-Gg: AZFdTZcKo+WJsciKO4BBWpzJHJrzDoI9MX40TjYr2P5aTwT1MF+AixD5dwLWMDVXi0x
	lB8XumSUZX5ZR9aUaElefvAfs6ZkRP4IC798qr7DSb7TxEKYk/NekOcsqxqLGdV2lSgtEGmaYf0
	BeRHw1uGONrlGPx8ix2OsBJjbWMAXcif0WP54y4sXrAe9+rPxLCZuen4Tu0bWFfQGOHjrXBazTO
	9rfpY4trfn/9pZGzG//xsRTmRmzzf10bLbt6Vss5c8HweM7P4cgktteOHvBkTy5j3mAqTP/ZM4s
	BtfofuQhDhjeu7byxGFQG2dtCs/6F/mkZGjAw+8T85gFG/DHWypXyi5iXtKIhZ/Iv0PoCmAm6ZA
	W3JKDRYFHHKbGnczFNtJ6KLxUzhylCOrLv3vH3NeSxlSjXq7n/63hygsJerxgXFAHv41oY2+0e2
	JXZXyLFyIMquSR7mrZlK5nVJhxXBCMCmeboUjrGAu+IKh/cT82vYoa803Qm4YYIjX0LorTpqj+I
	F3D5C6+0TpXWEDI33TkWVVIM/nbmgydWG31Qbu/UR6lYqqvJiF5UutHAiOVH601iOir9fOwEnwn
	U3CuaJnd8y5do5tF/OX7CttozNpyJSCIBHDER5OYlwhyimt0K563vVCxGR5la2js6MXxMnANl+U
	8n8n//QK3Ha+LipyZViXSCFSSd5gytHe1rRiXeN6pQpWv1vA=
X-Received: by 2002:a05:7300:ec8e:b0:386:a97c:f80d with SMTP id 5a478bee46e88-386ce3a8f03mr1204501eec.27.1795575822378;
        Tue, 24 Nov 2026 19:03:42 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm52243475eec.14.2026.11.24.19.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:03:41 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] thermal: rcar_gen3: release the interrupt handlers from ->remove()
Date: Wed, 25 Nov 2026 11:03:26 +0800
Message-Id: <20261125030327.953450-3-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125030327.953450-1-shunsheng1218@gmail.com>
References: <20261124095110.131258-1-shunsheng1218@gmail.com>
 <20261125030327.953450-1-shunsheng1218@gmail.com>
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

The interrupt handlers are requested before the thermal zones, and
devres releases the managed resources in the reverse order, so the
handlers outlive the zones they report to.  The handler walks every
sensor and calls thermal_zone_device_update() through tsc->zone, which
is not cleared when the zone is unregistered.  Masking the interrupt
sources neither waits for a threaded handler that is already running
nor removes the action.

Release the handlers from ->remove(), which runs before the runtime PM
reference is dropped and before devres unregisters the zones.
free_irq() also waits for a running handler, and after it returns the
handler cannot be invoked again.

Record the interrupt numbers as they are requested, so that a partial
request is undone as well: if the second handler cannot be registered,
the first one is released and the driver falls back to polling, as
before.

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
CONFIG_ARCH_RENESAS and CONFIG_RCAR_GEN3_THERMAL.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 38 ++++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index a96f02d4a8ad..37348f4413b6 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -107,6 +107,8 @@ struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	struct thermal_zone_device_ops ops;
 	unsigned int num_tscs;
+	int irqs[2];
+	unsigned int num_irqs;
 	int ptat[3];
 	int tj_t;
 	const struct rcar_thermal_info *info;
@@ -466,9 +468,25 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
 
+static void rcar_gen3_thermal_free_irqs(struct device *dev,
+					struct rcar_gen3_thermal_priv *priv)
+{
+	while (priv->num_irqs)
+		devm_free_irq(dev, priv->irqs[--priv->num_irqs], priv);
+}
+
 static void rcar_gen3_thermal_remove(struct platform_device *pdev)
 {
+	struct rcar_gen3_thermal_priv *priv = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	unsigned int i;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN, 0);
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
+	}
+
+	rcar_gen3_thermal_free_irqs(dev, priv);
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
@@ -491,22 +509,32 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
 
 	for (i = 0; i < 2; i++) {
 		irq = platform_get_irq_optional(pdev, i);
-		if (irq < 0)
-			return irq;
+		if (irq < 0) {
+			ret = irq;
+			goto release;
+		}
 
 		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
 					 dev_name(dev), i);
-		if (!irqname)
-			return -ENOMEM;
+		if (!irqname) {
+			ret = -ENOMEM;
+			goto release;
+		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						rcar_gen3_thermal_irq,
 						IRQF_ONESHOT, irqname, priv);
 		if (ret)
-			return ret;
+			goto release;
+
+		priv->irqs[priv->num_irqs++] = irq;
 	}
 
 	return 0;
+
+release:
+	rcar_gen3_thermal_free_irqs(dev, priv);
+	return ret;
 }
 
 static int rcar_gen3_thermal_probe(struct platform_device *pdev)
-- 
2.34.1

