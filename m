From: Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH] powercap/intel_rapl: Fix trailing semicolon
Date: Wed, 17 Jan 2018 10:30:34 +0000
Message-ID: <20180117103034.21907-1-luisbg@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60852 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeAQKav (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 05:30:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Luis de Bethencourt <luisbg@kernel.org>

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 drivers/powercap/intel_rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 0188cff98cdd..35636e1d8a3d 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1211,7 +1211,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	struct rapl_domain *rd;
 	char dev_name[17]; /* max domain name = 7 + 1 + 8 for int + 1 for null*/
 	struct powercap_zone *power_zone = NULL;
-	int nr_pl, ret;;
+	int nr_pl, ret;
 
 	/* Update the domain data of the new package */
 	rapl_update_domain_data(rp);
-- 
2.15.1
