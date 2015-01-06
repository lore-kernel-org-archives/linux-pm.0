From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] thermal: rcar: fix ENR register value
Date: Tue, 6 Jan 2015 19:02:07 +0900
Message-ID: <1420538528-5236-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org

Since the write value should always be 0 for bit 31-4 of ENR register
on R-Car H2, this patch fixes the value.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/thermal/rcar_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8803e69..bbdf64e 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -409,7 +409,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			return PTR_ERR(common->base);
 
 		/* enable temperature comparation */
-		rcar_thermal_common_write(common, ENR, 0x00030303);
+		rcar_thermal_common_write(common, ENR, 0x00000003);
 
 		idle = 0; /* polling delay is not needed */
 	}
-- 
1.7.9.5

