From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 21/21] PM: Switch to use %ptR
Date: Wed, 28 Nov 2018 21:05:37 +0200
Message-ID: <20181128190537.14074-22-andriy.shevchenko@linux.intel.com>
References: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Mark Salyzyn <salyzyn@android.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: linux-pm@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 1cda505d6a85..b11f47a1e819 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -118,9 +118,7 @@ static unsigned int read_magic_time(void)
 	unsigned int val;
 
 	mc146818_get_time(&time);
-	pr_info("RTC time: %2d:%02d:%02d, date: %02d/%02d/%02d\n",
-		time.tm_hour, time.tm_min, time.tm_sec,
-		time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
+	pr_info("RTC time: %ptRt, date: %ptRd\n", &time, &time);
 	val = time.tm_year;				/* 100 years */
 	if (val > 100)
 		val -= 100;
-- 
2.19.2
