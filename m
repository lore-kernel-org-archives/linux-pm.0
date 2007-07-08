From: Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] rtc-cmos: use cmos_rtc_board_info to determine
	wake_on callback
Date: Sat, 7 Jul 2007 23:49:53 -0400
Message-ID: <20070708034953.GB19633__29998.485328588$1183866590$gmane$org@dmt>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
	<20070401165601.GA13389@cosmic.amd.com>
	<200704011728.10966.david-b@pacbell.net>
	<20070402165511.GD5024@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070402165511.GD5024@cosmic.amd.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


>From my understand ACPI fills a cmos_rtc_board_info with pointers for
wake_on/wake_off callbacks and registers that at dev->platform_data.

So use that to retrieve the callback pointers.

Am I missing something?

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index e24ea82..5bfab23 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -549,6 +549,7 @@ #ifdef	CONFIG_PM
 static int cmos_suspend(struct device *dev, pm_message_t mesg)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	struct cmos_rtc_board_info *board_info = dev->platform_data;
 	int		do_wake = device_may_wakeup(dev);
 	unsigned char	tmp;
 
@@ -572,8 +573,8 @@ static int cmos_suspend(struct device *d
 
 	if (tmp & RTC_AIE) {
 		cmos->enabled_wake = 1;
-		if (cmos->wake_on)
-			cmos->wake_on(dev);
+		if (board_info->wake_on)
+			board_info->wake_on(dev);
 		else
 			enable_irq_wake(cmos->irq);
 	}
