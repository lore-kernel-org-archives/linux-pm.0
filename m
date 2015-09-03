From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PM / Domains: Ensure subdomain is not in use before removing
Date: Thu, 3 Sep 2015 09:10:37 +0100
Message-ID: <1441267837-28389-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5826 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbICIKn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 04:10:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: geert@linux-m68k.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

The function pm_genpd_remove_subdomain() removes a subdomain from a
generic PM domain, however, it does not check if the subdomain has any
slave domains or device attached before doing so. Therefore, add a test
to verify that the subdomain does not have any slave domains associated
or any device attached before removing.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/base/power/domain.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 27888a90ca98..071b39dc15a0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1469,6 +1469,13 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 
 	mutex_lock(&genpd->lock);
 
+	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
+		pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
+			subdomain->name);
+		ret = -EBUSY;
+		goto out;
+	}
+
 	list_for_each_entry(link, &genpd->master_links, master_node) {
 		if (link->slave != subdomain)
 			continue;
@@ -1487,6 +1494,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		break;
 	}
 
+out:
 	mutex_unlock(&genpd->lock);
 
 	return ret;
-- 
2.1.4

