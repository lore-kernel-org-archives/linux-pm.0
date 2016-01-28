From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/9] device property: convert to use match_string() helper
Date: Thu, 28 Jan 2016 15:14:18 +0200
Message-ID: <1453986865-133572-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3144 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbcA1NOd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jan 2016 08:14:33 -0500
In-Reply-To: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/property.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c359351..f902b55 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -647,7 +647,7 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 	const char *propname, const char *string)
 {
 	const char **values;
-	int nval, ret, i;
+	int nval, ret;
 
 	nval = fwnode_property_read_string_array(fwnode, propname, NULL, 0);
 	if (nval < 0)
@@ -664,13 +664,7 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 	if (ret < 0)
 		goto out;
 
-	ret = -ENODATA;
-	for (i = 0; i < nval; i++) {
-		if (!strcmp(values[i], string)) {
-			ret = i;
-			break;
-		}
-	}
+	ret = match_string(values, nval, string);
 out:
 	kfree(values);
 	return ret;
-- 
2.7.0.rc3

