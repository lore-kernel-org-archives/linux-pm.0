From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / domains: Align column headers and data in pm_genpd_summary output
Date: Tue, 11 Aug 2015 14:50:49 +0200
Message-ID: <1439297449-29344-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:43281 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964918AbbHKMuw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 08:50:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maciej Matraszek <m.matraszek@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

"domain": header is indented by 4, data by 0 spaces => 0 spaces
"/device": header is indented by 11, data by 4 spaces => 4 spaces
"slaves": header is indented by 47, data by 49 spaces => 48 spaces

Ruler:
    1234567890123456789012345678901234567890123456789012345678901234567890

Before:

	domain                      status         slaves
	       /device                                      runtime status
    ----------------------------------------------------------------------
    a3sp                            on               a2us
	/devices/platform/e60b0000.i2c                      suspended

After:

    domain                          status          slaves
	/device                                             runtime status
    ----------------------------------------------------------------------
    a3sp                            on              a2us
	/devices/platform/e60b0000.i2c                      suspended

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/domain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c9bc913a938c31e0..a0a99d55022f5387 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2082,7 +2082,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
-	seq_printf(s, "%-30s  %-15s  ", genpd->name, status_lookup[genpd->status]);
+	seq_printf(s, "%-30s  %-15s ", genpd->name, status_lookup[genpd->status]);
 
 	/*
 	 * Modifications on the list require holding locks on both
@@ -2117,8 +2117,8 @@ static int pm_genpd_summary_show(struct seq_file *s, void *data)
 	struct generic_pm_domain *genpd;
 	int ret = 0;
 
-	seq_puts(s, "    domain                      status         slaves\n");
-	seq_puts(s, "           /device                                      runtime status\n");
+	seq_puts(s, "domain                          status          slaves\n");
+	seq_puts(s, "    /device                                             runtime status\n");
 	seq_puts(s, "----------------------------------------------------------------------\n");
 
 	ret = mutex_lock_interruptible(&gpd_list_lock);
-- 
1.9.1

