Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244733EB1B;
	Fri,  9 Oct 2026 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514722; cv=none; b=q4tCvlhC4H58JLyvx2V/ie0jCcr5FJINGkgNGv5fWOoFQrTvOXewkfSrm8JPiUvxsmV3RTEm+3Ik4vwLvU4IVYd9xJfOgKb+cVKFRoRsJjgj0SV37Rd/hW0zoBi+c4jc9fGPg8/5CzUfPxnHoYePFCU9s0v8DiVe5EiMVYPGgAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514722; c=relaxed/simple;
	bh=3P5p+7wPNM72aWUfB3E0ZDLNRWRsgtHuHIz9GQ3OA9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBzAoROMCRxCCYQyVu06CvP2ieYoZbd6PUbz/CSycV06Bgfj2dx84Z6CxKqn4hQh6acan3VaVZnyrwQqn+VJCtb6NgZE2GaCD3ccPcm8Jl1ayQnj6AYFq1Tgr3d9xHYBm+LGPiGhippDNNcN1pfk4rpn8Y/wE0QY3Hu+NR7+WMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8Bxb9NeWMhqcfwTAA--.58234S3;
	Fri, 09 Oct 2026 10:58:38 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJDxRs1aWMhquUwqAA--.10860S2;
	Fri, 09 Oct 2026 10:58:35 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v7 4/8] thermal/drivers/loongson2: Simplify thermal sensor registration
Date: Fri,  9 Oct 2026 10:58:24 +0800
Message-ID: <8f877293335699fcd856087bac0b9cdf71138e2b.1791512067.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791512067.git.zhoubinbin@loongson.cn>
References: <cover.1791512067.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxRs1aWMhquUwqAA--.10860S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEPCGrIS3YA3QAAsF
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyfXFWkAr4rWFyfJrWUtrc_yoW8uF1xp3
	y3Ca47GrZrGrsru34DZw4UXrZ0ka43tFW7XF4xWwn5urZ8J34agFyFqFyrXryxCFyrZFyj
	vr1qkr4UCayDX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6hFcUUUUU=

The Loongson-2K SoCs expose a single on-chip thermal sensor, so the
loop over LOONGSON2_MAX_SENSOR_SEL_NUM only ever registers one thermal
zone. The additional iterations never succeed and the surrounding
error handling ends up relying on the value of tzd after the loop,
which is fragile and hard to follow.

Register sensor index 0 directly and fail the probe if that single
registration fails.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 2a31a1f8673e..817b0dab3412 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -16,8 +16,6 @@
 
 #include "thermal_hwmon.h"
 
-#define LOONGSON2_MAX_SENSOR_SEL_NUM	3
-
 #define LOONGSON2_THSENS_CTRL_HI_REG	0x0
 #define LOONGSON2_THSENS_CTRL_LOW_REG	0x8
 #define LOONGSON2_THSENS_STATUS_REG	0x10
@@ -159,7 +157,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
 	struct thermal_zone_device *tzd;
-	int ret, irq, i;
+	int ret, irq;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -190,17 +188,9 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
 	loongson2_thermal_set_trip_temp(data, 0, 0, false);
 
-	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
-		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
-
-		if (!IS_ERR(tzd))
-			break;
-
-		if (PTR_ERR(tzd) != -ENODEV)
-			continue;
-
-		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
-	}
+	tzd = devm_thermal_of_zone_register(dev, 0, data, thermal_ops);
+	if (IS_ERR(tzd))
+		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register sensor");
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
 					IRQF_ONESHOT, "loongson2_thermal", tzd);
-- 
2.52.0

