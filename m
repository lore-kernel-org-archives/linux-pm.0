From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 02/48] memory: emif: Use API function to determine power-off capability
Date: Thu,  6 Nov 2014 08:42:46 -0800
Message-ID: <1415292213-28652-3-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-pm@vger.kernel.org

Use have_kernel_power_off() to determine if the kernel is able
to power off the system.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5:
- Rebase to v3.18-rc3
v4:
- No change
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
v2:
- poweroff -> power_off

 drivers/memory/emif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 04644e7..317d49f 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1053,10 +1053,10 @@ static irqreturn_t emif_threaded_isr(int irq, void *dev_id)
 		dev_emerg(emif->dev, "SDRAM temperature exceeds operating limit.. Needs shut down!!!\n");
 
 		/* If we have Power OFF ability, use it, else try restarting */
-		if (pm_power_off) {
+		if (have_kernel_power_off()) {
 			kernel_power_off();
 		} else {
-			WARN(1, "FIXME: NO pm_power_off!!! trying restart\n");
+			WARN(1, "FIXME: NO kernel power-off capability!!! trying restart\n");
 			kernel_restart("SDRAM Over-temp Emergency restart");
 		}
 		return IRQ_HANDLED;
-- 
1.9.1
