Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829A388E58;
	Thu, 16 Jul 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185472; cv=none; b=ZYkLAIcrX2RabETOx0pDi4MOOHvsQO0bHngFw4nuMk7Hur/fQbkq6cl7AgDddH7YKg0sMRHBUcQbN/rLlgJM/MLg6rCxDQIsvLRAAehHxl5qXU4nBzgsi6OAyS+AbRB/M79PpAvGxOzEPP3/LDHKbbv8ZtOuhoYfgbQqqZFh9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185472; c=relaxed/simple;
	bh=otAMbqmauztUEEt8tijWrwidHh7IcUZnrAphqegrvwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aWO60kyDnvh5Nu67aU5SRISgoAIyj3rWNJ2kkEXewBWUTdgGmMLYFUuE0SrUhjxILlrnRMYnuCYHtyinEDubXgqz/OuQ7qi+jAromu5umbmmrdx0bYCNoTcgRr26rKWMsq1MEKRU2Rer5NQHZSWEJukcL9reLTT4QZQx//7caso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 93267c4e80e411f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0ae7e942-b482-4ff1-a06c-e927528614e2,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:917364be80770ce4303355b53af277ab,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 93267c4e80e411f1aa26b74ffac11d73-20260716
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1791035787; Thu, 16 Jul 2026 15:04:23 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: shuwei.wu@mailbox.org,
	troy.mitchell@linux.spacemit.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dlan@kernel.org,
	daniel.lezcano@kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2] thermal: spacemit: k1: add shutdown action and reorder registration order
Date: Thu, 16 Jul 2026 15:04:19 +0800
Message-Id: <1967d2bcc8fede6fbd25fc8eee07f2873fb41472.1784184867.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a devm action to clean hardware interrupts, sampling, and control
registers on driver unbind, mirroring what k1_tsensor_init() sets up.

Reorder the registration order within probe(): register the thermal
zones first, then request the IRQ, and register the shutdown action
last.  On removal, the hardware interrupt is disabled first, then the
IRQ is released, and finally the thermal zones are released.  This
avoids the IRQ thread accessing an already unregistered thermal zone
during devres cleanup.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changlog in v2:
1.Disable all regs mirroring what k1_tsensor_init() sets up
2.reorder registration order
3.rename devm_k1_tsensor_shutdown to k1_tsensor_shutdown_action
4.modify git commit log 
---
 drivers/thermal/spacemit/k1_tsensor.c | 73 ++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
index 79222d233129..ab12e2ec8ae4 100644
--- a/drivers/thermal/spacemit/k1_tsensor.c
+++ b/drivers/thermal/spacemit/k1_tsensor.c
@@ -199,6 +199,39 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void k1_tsensor_shutdown(struct k1_tsensor *ts)
+{
+	u32 val;
+
+	/* Disable all interrupts */
+	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
+
+	/* Disable all sensors */
+	val = readl(ts->base + K1_TSENSOR_EN_REG);
+	val &= ~K1_TSENSOR_EN_ALL;
+	writel(val, ts->base + K1_TSENSOR_EN_REG);
+
+	/* Clear the sampling configuration set by k1_tsensor_init() */
+	val = readl(ts->base + K1_TSENSOR_TIME_REG);
+	val &= ~(K1_TSENSOR_TIME_FILTER_PERIOD |
+		 K1_TSENSOR_TIME_ADC_CNT_RST |
+		 K1_TSENSOR_TIME_WAIT_REF_CNT);
+	writel(val, ts->base + K1_TSENSOR_TIME_REG);
+
+	/* Clear the control bits configured by k1_tsensor_init() */
+	val = readl(ts->base + K1_TSENSOR_PCTRL_REG);
+	val &= ~(K1_TSENSOR_PCTRL_RAW_SEL |
+		 K1_TSENSOR_PCTRL_TEMP_MODE |
+		 K1_TSENSOR_PCTRL_HW_AUTO_MODE |
+		 K1_TSENSOR_PCTRL_ENABLE);
+	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
+}
+
+static void k1_tsensor_shutdown_action(void *data)
+{
+	k1_tsensor_shutdown(data);
+}
+
 static int k1_tsensor_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -229,34 +262,48 @@ static int k1_tsensor_probe(struct platform_device *pdev)
 
 	k1_tsensor_init(ts);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_threaded_irq(dev, irq, NULL,
-					k1_tsensor_irq_thread,
-					IRQF_ONESHOT, "k1_tsensor", ts);
-	if (ret < 0)
-		return ret;
-
 	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
 		ts->ch[i].id = i;
 		ts->ch[i].ts = ts;
 		ts->ch[i].tzd = devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_tsensor_ops);
-		if (IS_ERR(ts->ch[i].tzd))
-			return PTR_ERR(ts->ch[i].tzd);
+		if (IS_ERR(ts->ch[i].tzd)) {
+			ret = PTR_ERR(ts->ch[i].tzd);
+			goto err_shutdown;
+		}
 
 		/* Attach sysfs hwmon attributes for userspace monitoring */
 		ret = devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
 		if (ret)
 			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
+	}
 
-		k1_tsensor_enable_irq(ts->ch + i);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto err_shutdown;
 	}
 
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					k1_tsensor_irq_thread,
+					IRQF_ONESHOT, "k1_tsensor", ts);
+	if (ret < 0)
+		goto err_shutdown;
+
+	ret = devm_add_action_or_reset(dev, k1_tsensor_shutdown_action, ts);
+	if (ret)
+		return ret;
+
+	/* Enable interrupts only after all zones and the handler are ready */
+	for (i = 0; i < MAX_SENSOR_NUMBER; ++i)
+		k1_tsensor_enable_irq(ts->ch + i);
+
 	platform_set_drvdata(pdev, ts);
 
 	return 0;
+
+err_shutdown:
+	k1_tsensor_shutdown(ts);
+	return ret;
 }
 
 static const struct of_device_id k1_tsensor_dt_ids[] = {
-- 
2.25.1

