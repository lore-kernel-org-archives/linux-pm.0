From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PM / runtime: Update links_count also if !CONFIG_SRCU
Date: Sat, 10 Feb 2018 19:13:58 +0100
Message-ID: <68feef8bf476ab150e6481b54f1b6f5c401b8e10.1518286105.git.lukas__14334.2953794219$1518287822$gmane$org@wunner.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:53413 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeBJSi6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Feb 2018 13:38:58 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D6EE0300002C4
        for <linux-pm@vger.kernel.org>; Sat, 10 Feb 2018 19:37:39 +0100 (CET)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Commit baa8809f6097 ("PM / runtime: Optimize the use of device links")
added an invocation of pm_runtime_drop_link() to __device_link_del().
However there are two variants of that function, one for CONFIG_SRCU and
another for !CONFIG_SRCU, and the commit only modified the former.

Fixes: baa8809f6097 ("PM / runtime: Optimize the use of device links")
Cc: stable@vger.kernel.org # v4.10+
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b2261f92f2f1..5847364f25d9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -310,6 +310,9 @@ static void __device_link_del(struct device_link *link)
 	dev_info(link->consumer, "Dropping the link to %s\n",
 		 dev_name(link->supplier));
 
+	if (link->flags & DL_FLAG_PM_RUNTIME)
+		pm_runtime_drop_link(link->consumer);
+
 	list_del(&link->s_node);
 	list_del(&link->c_node);
 	device_link_free(link);
-- 
2.15.1
