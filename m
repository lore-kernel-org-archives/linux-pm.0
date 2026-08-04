Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260E3CC7FF;
	Tue,  4 Aug 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847455; cv=none; b=GEzxQDkGzBIIsOOGAzf9rlOE/2VF3z3p4vdNbqebWIE1a/7vWRr5dx5VyAS6qMGW6SkcHwANxx/ItqFtDGn+3cC8iKKRmR1xVwA2W74ciDyhmKSA6xyQqqZwCnvnv39e2OFyhsp7YP5DIEFgtnalQgRAC4TaFGQpnhKoSPRFvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847455; c=relaxed/simple;
	bh=0gUPrTmhHOp52s9Pu0zyrXD7X152vyvBUl6mpb2YIx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dgi2uKygs9vBONU5jiyMgV4fHKlo+CF+ASTmVqs2ypWkEDQ8BdmwD2aOwH9wNC3JGSsm1Jg/LvaexV5UcNtrtuaUzkta0DnBK60WBjFQWLpfYlm6GH/3cipHvSCnT86kOygtII2hiTHXcTPzupbwjCCIoqgyguFs9/z/p7bjbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8AxqKCc3nFqDkUKAA--.10213S3;
	Tue, 04 Aug 2026 20:44:12 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJAxTOWX3nFqiHAjAA--.53S2;
	Tue, 04 Aug 2026 20:44:10 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lee Jones <lee@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v4 2/5] thermal/drivers/loongson2: Move thermal_ops to chip_data for SoC scalability
Date: Tue,  4 Aug 2026 20:43:55 +0800
Message-ID: <7fe74a58c164da2e7a897598142f28df0e5ef0c4.1785829933.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785829933.git.zhoubinbin@loongson.cn>
References: <cover.1785829933.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOWX3nFqiHAjAA--.53S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEJCGpxbi8nyAAAs3
X-Coremail-Antispam: 1Uk129KBj93XoWxCw13Kr1UCr15Gr1rCFyUurX_yoW5XF4rpa
	yfAw15KFs7Gr4Du3Wqyr18Zr4qyry3ta9xXF4xGw13W398X3sIgFy8JFy0vFWfCFyrAF1U
	ZFyDtFWDAF1DW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

In preparation for supporting additional Loongson SoCs, relocate the
thermal zone device operations pointer (thermal_ops) from the probe
routine to the per-SoC chip_data structure. This eliminates the need
to add conditional branches in probe() when a new SoC is introduced;
instead, the appropriate ops can be statically assigned in the match
data.

No functional change intended.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 5f47fa51fb90..1a8ca2cd06f1 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -39,6 +39,7 @@
 struct loongson2_thermal_chip_data {
 	unsigned int thermal_sensor_sel;
 	unsigned int flags;
+	const struct thermal_zone_device_ops *thermal_ops;
 };
 
 struct loongson2_thermal_data {
@@ -124,7 +125,6 @@ static const struct thermal_zone_device_ops loongson2_2k2000_of_thermal_ops = {
 
 static int loongson2_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_device_ops *thermal_ops;
 	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
 	struct thermal_zone_device *tzd;
@@ -145,10 +145,6 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		data->temp_reg = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(data->temp_reg))
 			return PTR_ERR(data->temp_reg);
-
-		thermal_ops = &loongson2_2k2000_of_thermal_ops;
-	} else {
-		thermal_ops = &loongson2_2k1000_of_thermal_ops;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -160,7 +156,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	loongson2_thermal_set(data, 0, 0, false);
 
 	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
-		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
+		tzd = devm_thermal_of_zone_register(dev, i, data, data->chip_data->thermal_ops);
 		if (!IS_ERR(tzd))
 			break;
 
@@ -186,11 +182,13 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
 	.thermal_sensor_sel = 0,
 	.flags = 0,
+	.thermal_ops = &loongson2_2k1000_of_thermal_ops,
 };
 
 static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k2000_data = {
 	.thermal_sensor_sel = 0,
 	.flags = LS2K2000_THSENS_OUT_FLAG,
+	.thermal_ops = &loongson2_2k2000_of_thermal_ops,
 };
 
 static const struct of_device_id of_loongson2_thermal_match[] = {
-- 
2.52.0

