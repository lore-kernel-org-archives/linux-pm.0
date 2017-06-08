From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 25/25] PM: Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:11 +0300
Message-ID: <20170608134811.60786-26-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 1cda505d6a85..5e32a4f28a49 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -118,9 +118,7 @@ static unsigned int read_magic_time(void)
 	unsigned int val;
 
 	mc146818_get_time(&time);
-	pr_info("RTC time: %2d:%02d:%02d, date: %02d/%02d/%02d\n",
-		time.tm_hour, time.tm_min, time.tm_sec,
-		time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
+	pr_info("RTC time: %ptt, date: %ptd\n", &time, &time);
 	val = time.tm_year;				/* 100 years */
 	if (val > 100)
 		val -= 100;
-- 
2.11.0
