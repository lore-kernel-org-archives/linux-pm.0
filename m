From: Peng Fan <peng.fan@nxp.com>
Subject: [RFC] platform: detach from PM domains on shutdown
Date: Tue, 15 May 2018 17:01:10 +0800
Message-ID: <20180515090110.26820-1-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: ulf.hansson@linaro.org, fabio.estevam@nxp.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
List-Id: linux-pm@vger.kernel.org

When reboot Linux, the PM domains attached to a device
are not shutdown. To SoCs which relys on reset the whole SoC,
there is no need to shutdown PM domains, but to Linux running
in a virtual machine with devices pass-through, we could not
reset the whole SoC. Currently we need Linux to shutdown its
PM domains when reboot.

commit 2d30bb0b3889 ("platform: Do not detach from PM domains on shutdown"),
removes what this patch tries to add, because of a warning.
commit e79aee49bcf9 ("PM: Avoid false-positive warnings in dev_pm_domain_set()")
already fixes the false alarm warning. So let's detach the power domain
to shutdown PM domains after driver shutdown.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

I do not find a better place to shutdown power domain when reboot Linux,
so add back the line that commit 2d30bb0b3889 removes, because it is
a false alarm warning as commit e79aee49bcf9 describes.

 drivers/base/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8075ddc70a17..a5929f24dc3c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -616,6 +616,7 @@ static void platform_drv_shutdown(struct device *_dev)
 
 	if (drv->shutdown)
 		drv->shutdown(dev);
+	dev_pm_domain_detach(_dev, true);
 }
 
 /**
-- 
2.14.1
