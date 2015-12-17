From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] PM / OPP: Fix parsing of opp-microvolt and opp-microamp
 properties
Date: Thu, 17 Dec 2015 19:04:38 +0100
Message-ID: <1471955.ORlHo2b56O@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44394 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbLQSGD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 13:06:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>, linux-samsung-soc@vger.kernel.org

Commit 01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name>'
bindings") broke support for parsing standard opp-microvolt and
opp-microamp properties.  Fix it by setting 'name' string to
proper value for !prop cases.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Fixes: 01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name> 'bindings")
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- rework the changes as requested by Viresh

This fixes Exynos4x12 cpufreq-dt suppport regression present in
linux-pm/linux-next tree.  Rafael, please apply.  Thank you.

 drivers/base/power/opp/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/base/power/opp/core.c
===================================================================
--- a/drivers/base/power/opp/core.c	2015-12-17 18:57:27.358981831 +0100
+++ b/drivers/base/power/opp/core.c	2015-12-17 18:58:04.550982529 +0100
@@ -814,7 +814,7 @@ static int opp_parse_supplies(struct dev
 
 	if (!prop) {
 		/* Search for "opp-microvolt" */
-		name[13] = '\0';
+		sprintf(name, "opp-microvolt");
 		prop = of_find_property(opp->np, name, NULL);
 
 		/* Missing property isn't a problem, but an invalid entry is */
@@ -855,7 +855,7 @@ static int opp_parse_supplies(struct dev
 
 	if (!prop) {
 		/* Search for "opp-microamp" */
-		name[12] = '\0';
+		sprintf(name, "opp-microamp");
 		prop = of_find_property(opp->np, name, NULL);
 	}
 

