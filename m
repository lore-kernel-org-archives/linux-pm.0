From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] drivers: thermal: processor_thermal: Downgrade error message
Date: Mon, 29 Apr 2019 20:42:13 -0700
Message-ID: <20190430034213.40028-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Downgrade "Unsupported event" message from dev_err to dev_dbg. Otherwise it
floods with this message one some platforms.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 4b206b594825..436c256f111d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -275,7 +275,7 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
 				THERMAL_DEVICE_POWER_CAPABILITY_CHANGED);
 		break;
 	default:
-		dev_err(proc_priv->dev, "Unsupported event [0x%x]\n", event);
+		dev_dbg(proc_priv->dev, "Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
-- 
2.17.2
