From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: supply: cpcap-battery: make array cpcap_battery_irqs static, shrinks object size
Date: Thu, 29 Nov 2018 23:03:42 +0000
Message-ID: <20181129230342.4300-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array cpcap_battery_irqs  on the stack but instead
make it static. Makes the object code smaller by 99 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  13673	   2448	      0	  16121	   3ef9	cpcap-battery.o

After:
   text	   data	    bss	    dec	    hex	filename
  13510	   2512	      0	  16022	   3e96	cpcap-battery.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/cpcap-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 98ba07869c3b..204e22e3e9b4 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -620,7 +620,7 @@ static int cpcap_battery_init_irq(struct platform_device *pdev,
 static int cpcap_battery_init_interrupts(struct platform_device *pdev,
 					 struct cpcap_battery_ddata *ddata)
 {
-	const char * const cpcap_battery_irqs[] = {
+	static const char * const cpcap_battery_irqs[] = {
 		"eol", "lowbph", "lowbpl",
 		"chrgcurr1", "battdetb"
 	};
-- 
2.19.1
