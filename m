From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Mon, 10 Aug 2015 12:01:58 +0530
Message-ID: <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34316 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbbHJGck (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 02:32:40 -0400
Received: by pdbfa8 with SMTP id fa8so27809128pdb.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2015 23:32:40 -0700 (PDT)
In-Reply-To: <cover.1439187821.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439187821.git.viresh.kumar@linaro.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

'dev_opp' will always be NULL in _of_init_opp_table_v2() after creating
OPPs for a device. There is no point comparing it against NULL there.

Restructure code a bit to make it more efficient.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 1daaa1a418a2..c9747fb192b1 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1295,20 +1295,19 @@ static int _of_init_opp_table_v2(struct device *dev,
 	if (WARN_ON(!count))
 		goto out;
 
-	if (!ret) {
-		if (!dev_opp) {
-			dev_opp = _find_device_opp(dev);
-			if (WARN_ON(!dev_opp))
-				goto out;
-		}
-
-		dev_opp->np = opp_np;
-		dev_opp->shared_opp = of_property_read_bool(opp_np,
-							    "opp-shared");
-	} else {
+	if (ret) {
 		of_free_opp_table(dev);
+		goto out;
 	}
 
+	dev_opp = _find_device_opp(dev);
+	if (WARN_ON(!dev_opp))
+		goto out;
+
+	dev_opp->np = opp_np;
+	dev_opp->shared_opp = of_property_read_bool(opp_np,
+			"opp-shared");
+
 out:
 	return ret;
 }
-- 
2.4.0

