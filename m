From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: supply: pcf50633-charger: remove redundant variable charging_start
Date: Tue, 31 Oct 2017 13:48:23 +0000
Message-ID: <20171031134823.24997-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable charging_start is being set but is never read, it is therefore
redundant and can be removed. Cleans up sparse warning:

drivers/power/supply/pcf50633-charger.c:61:3: warning: Value stored to
'charging_start' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/pcf50633-charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
index 1ad7ccce6075..1aba14046a83 100644
--- a/drivers/power/supply/pcf50633-charger.c
+++ b/drivers/power/supply/pcf50633-charger.c
@@ -43,7 +43,6 @@ int pcf50633_mbc_usb_curlim_set(struct pcf50633 *pcf, int ma)
 	struct pcf50633_mbc *mbc = platform_get_drvdata(pcf->mbc_pdev);
 	int ret = 0;
 	u8 bits;
-	int charging_start = 1;
 	u8 mbcs2, chgmod;
 	unsigned int mbcc5;
 
@@ -58,7 +57,6 @@ int pcf50633_mbc_usb_curlim_set(struct pcf50633 *pcf, int ma)
 		ma = 100;
 	} else {
 		bits = PCF50633_MBCC7_USB_SUSPEND;
-		charging_start = 0;
 		ma = 0;
 	}
 
-- 
2.14.1
