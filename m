From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/2] PM / Domains: Fix removal of a subdomain
Date: Fri, 4 Mar 2016 10:55:14 +0000
Message-ID: <1457088915-17284-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19231 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbcCDKzW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 05:55:22 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Commit 30e7a65b3fdb ("PM / Domains: Ensure subdomain is not in use
before removing") added a test to ensure that a subdomain is not a
master to another subdomain or if any devices are using the subdomain
before removing. This change incorrectly used the "slave_links" list to
determine if the subdomain is a master to another subdomain, where it
should have been using the "master_links" list instead. The
"slave_links" list will never be empty for a subdomain and so a
subdomain can never be removed. Fix this by testing if the
"master_links" list is empty instead.

Fixes: 30e7a65b3fdb ("PM / Domains: Ensure subdomain is not in use before removing")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---

This first was originally included in the series to add PM domain support [0].
I am separating this for now, as it can be merged independently.

[0] http://marc.info/?l=linux-pm&m=145650174525180&w=2

 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e8ca290dbf9d..ea9f2aa3fc33 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1382,7 +1382,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	mutex_lock(&subdomain->lock);
 	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
 
-	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
+	if (!list_empty(&subdomain->master_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
 			subdomain->name);
 		ret = -EBUSY;
-- 
2.1.4

