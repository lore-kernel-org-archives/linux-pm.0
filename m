From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/5] thermal: hisilicon: fix IRQ imbalance enabling
Date: Fri, 26 Feb 2016 11:43:45 +0800
Message-ID: <1456458227-12950-4-git-send-email-leo.yan@linaro.org>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

When register sensors into thermal zone during initialization phase, it
reports error for IRQ imbalance enabling:

[    2.040713] WARNING: at kernel/irq/manage.c:513
[    2.040719] Modules linked in:
[    2.040721]
[    2.040729] CPU: 1 PID: 804 Comm: irq/33-hisi_the Not tainted 4.5.0-rc4+ #505
[    2.040732] Hardware name: HiKey Development Board (DT)
[    2.040736] task: ffffffc03ae82580 ti: ffffffc0379c8000 task.ti: ffffffc0379c8000
[    2.040745] PC is at __enable_irq+0x74/0x84
[    2.040749] LR is at __enable_irq+0x74/0x84

This warning is for IRQ imbalance enabling, which is caused by
enable_irq() twice. During sensor's initialization it tries to enable
IRQ, the driver will call thermal_zone_of_sensor_register() to bind
sensors and read sensor's temperature. But at this moment the flag
"data->irq_enabled" has been not initialized as correct state, so it
finally introduces the function enabled_irq() to be called twice. In
essentially this is caused by the flag "data->irq_enabled" is
inconsistent with real hardware IRQ enabling state.

So this patch is to fix this issue, firstly init "irq_enabled" flag
before binding sensors to thermal zone. Also change to use the function
irq_get_irqchip_state() to read back real interrupt line state.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 7a3e5d8..982ffd1 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -343,6 +343,10 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	hisi_thermal_enable_bind_irq_sensor(data);
+	irq_get_irqchip_state(data->irq, IRQCHIP_STATE_MASKED,
+			      &data->irq_enabled);
+
 	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
 		ret = hisi_thermal_register_sensor(pdev, data,
 						   &data->sensors[i], i);
@@ -353,9 +357,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			hisi_thermal_toggle_sensor(&data->sensors[i], true);
 	}
 
-	hisi_thermal_enable_bind_irq_sensor(data);
-	data->irq_enabled = true;
-
 	return 0;
 }
 
-- 
1.9.1
