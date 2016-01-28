From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/9] drm/edid: convert to use match_string() helper
Date: Thu, 28 Jan 2016 15:14:20 +0200
Message-ID: <1453986865-133572-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28149 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967733AbcA1NPJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jan 2016 08:15:09 -0500
In-Reply-To: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/drm_edid_load.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
index 698b8c3..9a401ae 100644
--- a/drivers/gpu/drm/drm_edid_load.c
+++ b/drivers/gpu/drm/drm_edid_load.c
@@ -170,16 +170,11 @@ static void *edid_load(struct drm_connector *connector, const char *name,
 	int i, valid_extensions = 0;
 	bool print_bad_edid = !connector->bad_edid_counter || (drm_debug & DRM_UT_KMS);
 
-	builtin = 0;
-	for (i = 0; i < GENERIC_EDIDS; i++) {
-		if (strcmp(name, generic_edid_name[i]) == 0) {
-			fwdata = generic_edid[i];
-			fwsize = sizeof(generic_edid[i]);
-			builtin = 1;
-			break;
-		}
-	}
-	if (!builtin) {
+	builtin = match_string(generic_edid_name, GENERIC_EDIDS, name);
+	if (builtin >= 0) {
+		fwdata = generic_edid[builtin];
+		fwsize = sizeof(generic_edid[builtin]);
+	} else {
 		struct platform_device *pdev;
 		int err;
 
@@ -252,7 +247,7 @@ static void *edid_load(struct drm_connector *connector, const char *name,
 	}
 
 	DRM_INFO("Got %s EDID base block and %d extension%s from "
-	    "\"%s\" for connector \"%s\"\n", builtin ? "built-in" :
+	    "\"%s\" for connector \"%s\"\n", (builtin >= 0) ? "built-in" :
 	    "external", valid_extensions, valid_extensions == 1 ? "" : "s",
 	    name, connector_name);
 
-- 
2.7.0.rc3

