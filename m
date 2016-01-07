From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/8] device property: convert to use match_string() helper
Date: Thu,  7 Jan 2016 14:06:02 +0200
Message-ID: <1452168368-75630-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.6.4
