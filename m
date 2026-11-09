Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211761;
	b=rKb39Ay7WsvF3qLaNgcdK/k2icVxrmlLXOO1pD0NyeUgowVXJgnA3C43rI1iisFiTsQG
	 rjb6DpuDzQWjOYwvgrBJWaiXH93OiJD0lJ5jf1SxmJVwRnUv4cQ+/UI6cP6zmpeEos+f+
	 HR6j2I48pP/mQjFxU+h0NofS9j7URmUOqgpIDTTdT7emL56mod//iF0a7iPwfuXLpUAtd
	 MhHnEw6wBqFm1Qr2m73Cut5kOarb2gFN1ij3DP1wGY9PNunGOJC8GYDoo+lrOJxfLrcXk
	 6/nuS8SNtnxQ7ACbZfuBJEzKQxFv0VqV2kbA6FxVRrblf9SDNsKUurdxEkuwvTB30YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211761;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=WxG9mDVd4SEsuPUu5Ydwb61jq88ALRNRG1pqf8petYs=;
	b=CdwHK/i4EmgtWlqINmOrWOn1JrJmFmtYYbmapynFOR9k1vY4PKiiJ3X991gLdY3jditD
	 /KTtF3ut8xwBH1BB++uolkRU7IBBlcAx+WdAU9k/me1ZWF36NN4OoO0j/tVAWq6JiIFGJ
	 f8MPbbq2VXDE3SF4FrPKMX/FVgfPCmaoZ3uXNguKSkWjaljM6HIRVNmYoP9Ef9ONmOkDG
	 TktnqK1PzC9ooTn5QeJ4P9WpVikYY0njWlQeHuBnBcnVDm6mnYE9bnn/FvmxHJhncLTPQ
	 Ie1NJFrHEniMg0TBFAyk00VYDNZNJXYfwFkdgCXXW1ZFTXNBBnzbVDUzyoM01OTy5wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C19D606D805;
	Mon,  9 Nov 2026 08:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C19D606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8CxQNGrf_Fqrr8dAA--.21003S3;
	Mon, 09 Nov 2026 16:09:15 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxmM2lf_FqdCQzAA--.37921S3;
	Mon, 09 Nov 2026 16:09:11 +0800 (CST)
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
Subject: [PATCH v9 4/7] thermal/drivers/loongson2: Simplify thermal sensor registration
Date: Mon,  9 Nov 2026 16:09:00 +0800
Message-ID: <d071c7e447a9fdccf7dc9cd7f94344e2191ccce2.1794211535.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1794211535.git.zhoubinbin@loongson.cn>
References: <cover.1794211535.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxmM2lf_FqdCQzAA--.37921S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEGCGrxOf4EUAAAsF
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyfXFWkAr4rAryDWr17Arc_yoW8uw18pr
	W3CasxGrZrGrsru34DZr4UXFWjka43tFW7ZF4xuwn5urZ8J34agryFqF4rXryxAFyrZF12
	vr1qyr4UCFWDX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVuyxDUUUU

The Loongson-2K SoCs expose a single on-chip thermal sensor, so the
loop over LOONGSON2_MAX_SENSOR_SEL_NUM only ever registers one thermal
zone. The additional iterations never succeed and the surrounding
error handling ends up relying on the value of tzd after the loop,
which is fragile and hard to follow.

Register sensor index 0 directly and fail the probe if that single
registration fails.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 2d24d310c0a7..18f6ae70288e 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -17,8 +17,6 @@
 
 #include "thermal_hwmon.h"
 
-#define LOONGSON2_MAX_SENSOR_SEL_NUM	3
-
 #define LOONGSON2_THSENS_CTRL_HI_REG	0x0
 #define LOONGSON2_THSENS_CTRL_LOW_REG	0x8
 #define LOONGSON2_THSENS_STATUS_REG	0x10
@@ -190,7 +188,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
 	struct thermal_zone_device *tzd;
-	int ret, irq, i;
+	int ret, irq;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -221,17 +219,9 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
 	loongson2_thermal_set(data, 0, 0, false);
 
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

