From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 1/3] PM / Domains: Allow overriding the ->xlate() callback
Date: Wed, 29 Mar 2017 18:34:50 +0200
Message-ID: <20170329163452.10761-2-thierry.reding@gmail.com>
References: <20170329163452.10761-1-thierry.reding@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34059 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbdC2Qe6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 12:34:58 -0400
In-Reply-To: <20170329163452.10761-1-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Stefan Kristiansson <stefank@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Allow generic power domain providers to override the ->xlate() callback
in case the default genpd_xlate_onecell() translation callback is not
good enough.

One potential use-case for this is to allow generic power domains to be
specified by an ID rather than an index.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/power/domain.c | 8 ++++----
 include/linux/pm_domain.h   | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e697dec9d25b..c102557f6c7e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1570,9 +1570,6 @@ EXPORT_SYMBOL_GPL(pm_genpd_remove);
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 
-typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
-						   void *data);
-
 /*
  * Device Tree based PM domain providers.
  *
@@ -1730,6 +1727,9 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 	mutex_lock(&gpd_list_lock);
 
+	if (!data->xlate)
+		data->xlate = genpd_xlate_onecell;
+
 	for (i = 0; i < data->num_domains; i++) {
 		if (!data->domains[i])
 			continue;
@@ -1740,7 +1740,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		data->domains[i]->has_provider = true;
 	}
 
-	ret = genpd_add_provider(np, genpd_xlate_onecell, data);
+	ret = genpd_add_provider(np, data->xlate, data);
 	if (ret < 0)
 		goto error;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5339ed5bd6f9..5163f371a308 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -204,9 +204,13 @@ static inline void pm_genpd_syscore_poweron(struct device *dev) {}
 /* OF PM domain providers */
 struct of_device_id;
 
+typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
+						   void *data);
+
 struct genpd_onecell_data {
 	struct generic_pm_domain **domains;
 	unsigned int num_domains;
+	genpd_xlate_t xlate;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
-- 
2.12.0
