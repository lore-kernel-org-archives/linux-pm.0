From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 09/10] PM / Domains: Store the provider in the PM domain structure
Date: Tue, 16 Aug 2016 10:49:35 +0100
Message-ID: <1471340976-5379-10-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11976 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbcHPJug (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 05:50:36 -0400
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

It is possible that a device has more than one provider of PM domains
and to support the removal of a PM domain by provider, it is necessary
to store a reference to the provider in the PM domain structure.
Therefore, store a reference to the firmware node handle in the PM
domain structure and populate it when providers (only device-tree based
providers are currently supported by PM domains) are registered.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 18 ++++++++++++++----
 include/linux/pm_domain.h   |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 72b973539205..0bc145e8e902 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1539,6 +1539,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 		return -EINVAL;
 	}
 
+	genpd->provider = &np->fwnode;
+
 	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
 
 	mutex_unlock(&gpd_list_lock);
@@ -1564,10 +1566,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	mutex_lock(&gpd_list_lock);
 
 	for (i = 0; i < data->num_domains; i++) {
-		if (!pm_genpd_present(data->domains[i])) {
-			mutex_unlock(&gpd_list_lock);
-			return -EINVAL;
-		}
+		if (!pm_genpd_present(data->domains[i]))
+			goto error;
+
+		data->domains[i]->provider = &np->fwnode;
 	}
 
 	ret = genpd_add_provider(np, genpd_xlate_onecell, data);
@@ -1575,6 +1577,14 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	mutex_unlock(&gpd_list_lock);
 
 	return ret;
+
+error:
+	while (i--)
+		data->domains[i]->provider = NULL;
+
+	mutex_unlock(&gpd_list_lock);
+
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index fbdc5c4588ef..4aa285e44eb0 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -51,6 +51,7 @@ struct generic_pm_domain {
 	struct mutex lock;
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
+	struct fwnode_handle *provider;	/* Identity of the domain provider */
 	const char *name;
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
-- 
2.1.4

