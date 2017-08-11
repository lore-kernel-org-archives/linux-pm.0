From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: supply: lp8788: Make several arrays static const * const
Date: Fri, 11 Aug 2017 22:52:12 +0100
Message-ID: <20170811215212.9985-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate various read only arrays on the stack but make them
static const, making the object code smaller and saves 148 bytes
overall:

Before:
   text    data     bss     dec     hex filename
  11940    4496      64   16500    4074 lp8788-charger.o

After:
   text    data     bss     dec     hex filename
  11472    4816      64   16352    3fe0 lp8788-charger.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/lp8788-charger.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 677f7c40b25a..0f3432795f3c 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -626,7 +626,7 @@ static ssize_t lp8788_show_charger_status(struct device *dev,
 {
 	struct lp8788_charger *pchg = dev_get_drvdata(dev);
 	enum lp8788_charging_state state;
-	char *desc[LP8788_MAX_CHG_STATE] = {
+	static const char * const desc[LP8788_MAX_CHG_STATE] = {
 		[LP8788_OFF] = "CHARGER OFF",
 		[LP8788_WARM_UP] = "WARM UP",
 		[LP8788_LOW_INPUT] = "LOW INPUT STATE",
@@ -650,8 +650,10 @@ static ssize_t lp8788_show_eoc_time(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lp8788_charger *pchg = dev_get_drvdata(dev);
-	char *stime[] = { "400ms", "5min", "10min", "15min",
-			"20min", "25min", "30min", "No timeout" };
+	static const char * const stime[] = {
+		"400ms", "5min", "10min", "15min",
+		"20min", "25min", "30min", "No timeout"
+	};
 	u8 val;
 
 	lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);
@@ -665,9 +667,13 @@ static ssize_t lp8788_show_eoc_level(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lp8788_charger *pchg = dev_get_drvdata(dev);
-	char *abs_level[] = { "25mA", "49mA", "75mA", "98mA" };
-	char *relative_level[] = { "5%", "10%", "15%", "20%" };
-	char *level;
+	static const char * const abs_level[] = {
+			"25mA", "49mA", "75mA", "98mA"
+	};
+	static const char * const relative_level[] = {
+			"5%", "10%", "15%", "20%"
+	};
+	const char *level;
 	u8 val;
 	u8 mode;
 
-- 
2.11.0
