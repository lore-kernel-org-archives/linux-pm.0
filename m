From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: reset: add in missing white space in error message text
Date: Mon, 12 Sep 2016 14:05:04 +0100
Message-ID: <20160912130504.1878-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <ssantosh@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A dev_err message spans two lines and the literal string is missing
a white space between words. Add the white space.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/reset/keystone-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index c70f1bf..0938085 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -139,7 +139,7 @@ static int rsctrl_probe(struct platform_device *pdev)
 		}
 
 		if (val >= WDT_MUX_NUMBER) {
-			dev_err(dev, "ti,wdt-list property can contain"
+			dev_err(dev, "ti,wdt-list property can contain "
 				"only numbers < 4\n");
 			return -EINVAL;
 		}
-- 
2.9.3
