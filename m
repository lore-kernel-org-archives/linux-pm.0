From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] cpufreq: sa1110: set memory type for h3600
Date: Sat, 12 Jul 2014 11:43:33 +0200
Message-ID: <1405158213-14679-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35249 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbaGLJnq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Jul 2014 05:43:46 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so2120298wgg.7
        for <linux-pm@vger.kernel.org>; Sat, 12 Jul 2014 02:43:43 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

The Compaq iPAQ h3600 also has the K4S281632b-1H memory type.
Verified by prying apart a broken board.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/cpufreq/sa1110-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index 546376719d8f..b5befc211172 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -349,7 +349,7 @@ static int __init sa1110_clk_init(void)
 			name = "K4S641632D";
 		if (machine_is_h3100())
 			name = "KM416S4030CT";
-		if (machine_is_jornada720())
+		if (machine_is_jornada720() || machine_is_h3600())
 			name = "K4S281632B-1H";
 		if (machine_is_nanoengine())
 			name = "MT48LC8M16A2TG-75";
-- 
1.9.3

