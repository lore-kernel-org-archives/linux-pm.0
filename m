From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/15] power-supply: Check for failures only when we can fail
Date: Thu,  4 Sep 2014 17:31:34 +0530
Message-ID: <b53eff32f02a045db2d40825ac0f666246f66411.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42803 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMDL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:03:11 -0400
Received: by mail-pa0-f45.google.com with SMTP id bj1so19703959pad.4
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:03:11 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

In power_supply_show_property() routine, we call ->get_property() conditionally
and should check for failure in that case only. There is no point comparing
'ret' for errors when 'ret' is surely zero.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_sysfs.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index 750a202..c23b1b2 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -73,19 +73,20 @@ static ssize_t power_supply_show_property(struct device *dev,
 	const ptrdiff_t off = attr - power_supply_attrs;
 	union power_supply_propval value;
 
-	if (off == POWER_SUPPLY_PROP_TYPE)
+	if (off == POWER_SUPPLY_PROP_TYPE) {
 		value.intval = psy->type;
-	else
+	} else {
 		ret = psy->get_property(psy, off, &value);
 
-	if (ret < 0) {
-		if (ret == -ENODATA)
-			dev_dbg(dev, "driver has no data for `%s' property\n",
-				attr->attr.name);
-		else if (ret != -ENODEV)
-			dev_err(dev, "driver failed to report `%s' property: %zd\n",
-				attr->attr.name, ret);
-		return ret;
+		if (ret < 0) {
+			if (ret == -ENODATA)
+				dev_dbg(dev, "driver has no data for `%s' property\n",
+					attr->attr.name);
+			else if (ret != -ENODEV)
+				dev_err(dev, "driver failed to report `%s' property: %zd\n",
+					attr->attr.name, ret);
+			return ret;
+		}
 	}
 
 	if (off == POWER_SUPPLY_PROP_STATUS)
-- 
2.0.3.693.g996b0fd

