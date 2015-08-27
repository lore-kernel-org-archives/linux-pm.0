From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH] PM / Domains: Ensure subdomain is not in use before removing
Date: Thu, 27 Aug 2015 10:21:16 +0100
Message-ID: <1440667276-8986-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2632 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbH0JVW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 05:21:22 -0400
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
---
 drivers/base/power/domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 27888a90ca98..a3ed71d8129a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1469,6 +1469,11 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 
 	mutex_lock(&genpd->lock);
 
+	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	list_for_each_entry(link, &genpd->master_links, master_node) {
 		if (link->slave != subdomain)
 			continue;
@@ -1487,6 +1492,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		break;
 	}
 
+out:
 	mutex_unlock(&genpd->lock);
 
 	return ret;
-- 
2.1.4

