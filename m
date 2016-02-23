From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] [RFC] PM / Domains: Join state name and index in debugfs output
Date: Tue, 23 Feb 2016 17:49:18 +0100
Message-ID: <1456246158-19673-2-git-send-email-geert+renesas@glider.be>
References: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:40610 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbcBWQtX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 11:49:23 -0500
In-Reply-To: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>
Cc: linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

For low-power states, the state index is part of the state, hence join
them with a hyphen in the /sys/kernel/debug/pm_genpd/pm_genpd_summary
output. E.g. "off 0" becomes "off-0".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Alternative separators could be ":" or "/".
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 01015d85ab6493fc..9e59543d314c4b0b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1892,7 +1892,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
 	if (genpd->status == GPD_STATE_POWER_OFF)
-		snprintf(state, sizeof(state), "%s %u",
+		snprintf(state, sizeof(state), "%s-%u",
 			 status_lookup[genpd->status], genpd->state_idx);
 	else
 		snprintf(state, sizeof(state), "%s",
-- 
1.9.1

