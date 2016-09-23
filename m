From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH] PM / OPP: Don't support OPP if it provides supported-hw but platform does not
Date: Fri, 23 Sep 2016 15:07:47 -0500
Message-ID: <20160923200747.3948-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:36070 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758289AbcIWUHy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Sep 2016 16:07:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Lee Jones <lee.jones@linaro.org>, Dave Gerlach <d-gerlach@ti.com>

The OPP framework allows each OPP to set a opp-supported-hw property
which provides values that are matched against supported_hw values
provided by the platform to limit support for certain OPPs on specific
hardware. Currently, if the platform does not set supported_hw values,
all OPPs are interpreted as supported, even if they have provided their
own opp-supported-hw values.

If an OPP has provided opp-supported-hw, it is indicating that there is
some specific hardware configuration it is supported by. These constraints
should be honored, and if no supported_hw has been provided by the
platform, there is no way to determine if that OPP is actually supported,
so it should be marked as not supported.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/base/power/opp/of.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 1dfd3dd92624..ccccaf9f8968 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -71,8 +71,18 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 	u32 version;
 	int ret;
 
-	if (!opp_table->supported_hw)
-		return true;
+	if (!opp_table->supported_hw) {
+		/*
+		 * In the case that no supported_hw has been set by the
+		 * platform but there is an opp-supported-hw value set for
+		 * an OPP then the OPP should not be enabled as there is
+		 * no way to see if the hardware supports it.
+		 */
+		if (of_find_property(np, "opp-supported-hw", NULL))
+			return false;
+		else
+			return true;
+	}
 
 	while (count--) {
 		ret = of_property_read_u32_index(np, "opp-supported-hw", count,
-- 
2.9.3

