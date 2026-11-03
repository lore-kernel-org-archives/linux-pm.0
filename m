Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690727;
	b=3dFWAo/1gWFRtMIDloG/FASMklyNBekijV7wfHuK/j0TTNSdlUngDO2GXlxp57yl/+t3
	 dze9BA2ZZ4ZbRaqDCHsbON0/qB5npolqoM+R1hmurKWdQxewAE4oJSoTgVd7huSQZwzwR
	 iYGWCYsiw6Vrq3QW+hyELWQ2yMKtCtjRrw9QhS6VsEU06UnVKub+L6xbN6bbNstgE9fA5
	 SKT2MOgGKs0TtycdOkShtao/TC0O4cm2327OAKbt8pzFIlmvwCQV58tTB44LhjxcnEg39
	 RrJ/sduFBQyvBo+1bPzkss8XzlR8T30eaGoNJGKUk8Fu6VvAvB4v2SlsbwNvfDWWq5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690727;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=sbYsjIuAmmj9qc9MD7OVH8PdOpsGjgwLlEDWhDRoGbU=;
	b=bYUF4ANAwTk2ZOvZIK/DQLBIEnA/k4rRdbHRdUmVX/Q7aOsXxPl4yorQjQFnTjZZK0BN
	 hr7irScjBVq5sbAOL5QVCAlFIaCccSzFueROy19Zao6/y16yP2yWBjLK8x1NX7bd7IVT4
	 BebwtdMYDZHeGzppO7yrNQxFkq1ra3dghIFtPCAHGBcw5aTxHxENmfbTW+YdzabkpDdS3
	 5Hv10hzWXFZUZvkwAbvpZSTI+3fXx6xurbyQNNWgc/v9+H1YlM3TazAK68PhvmQRnonMe
	 PgJr1jsZGFuDoCHZiax0n33dKsCkFcGaxT1cPKg7zEvCvwaQNeqhMLW8IXXtJU5sA/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD3606A32D;
	Tue,  3 Nov 2026 07:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38BD3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxYdFkjOlqH94bAA--.15759S3;
	Tue, 03 Nov 2026 15:25:24 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJBx5cxijOlq7xUyAA--.10875S2;
	Tue, 03 Nov 2026 15:25:23 +0800 (CST)
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
Subject: [PATCH v8 4/7] thermal/drivers/loongson2: Simplify thermal sensor registration
Date: Tue,  3 Nov 2026 15:25:13 +0800
Message-ID: <7668eeead32fd1ca85622a4593585237f3807949.1793690276.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793690276.git.zhoubinbin@loongson.cn>
References: <cover.1793690276.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJBx5cxijOlq7xUyAA--.10875S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0D1AAAsy
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyfXFWkAr4rWFyfJrWUtrc_yoW8urWxp3
	y3GasrGrZrGrsru34DZw4UXFWjk3W3tFW7XF4xuwn5urZ8J34agFyYqFyFqryxAFyrZF12
	vr1qkrWUCayDW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIYhFUUUUU

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
index 8be0c6a29efe..19e3f9246cc0 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -17,8 +17,6 @@
 
 #include "thermal_hwmon.h"
 
-#define LOONGSON2_MAX_SENSOR_SEL_NUM	3
-
 #define LOONGSON2_THSENS_CTRL_HI_REG	0x0
 #define LOONGSON2_THSENS_CTRL_LOW_REG	0x8
 #define LOONGSON2_THSENS_STATUS_REG	0x10
@@ -176,7 +174,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
 	struct thermal_zone_device *tzd;
-	int ret, irq, i;
+	int ret, irq;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -207,17 +205,9 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
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

