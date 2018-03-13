From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] power: reset: make function sc27xx_poweroff_shutdown static
Date: Tue, 13 Mar 2018 10:54:06 +0000
Message-ID: <20180313105406.28841-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function sc27xx_poweroff_shutdown is local to the source and does
not need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/power/reset/sc27xx-poweroff.c:28:6: warning: symbol
'sc27xx_poweroff_shutdown' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/reset/sc27xx-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 65c477eee559..29fb08b8faa0 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -25,7 +25,7 @@ static struct regmap *regmap;
  * taking cpus down to avoid racing regmap or spi mutex lock when poweroff
  * system through PMIC.
  */
-void sc27xx_poweroff_shutdown(void)
+static void sc27xx_poweroff_shutdown(void)
 {
 #ifdef CONFIG_PM_SLEEP_SMP
 	int cpu = smp_processor_id();
-- 
2.15.1
