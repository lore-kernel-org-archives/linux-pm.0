From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] PM / Domains: Allow overriding the ->xlate() callback
Date: Tue, 14 Mar 2017 20:15:14 +0100
Message-ID: <20170314191516.13083-2-thierry.reding@gmail.com>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170314191516.13083-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Allow generic power domain providers to override the ->xlate() callback
in case the default genpd_xlate_onecell() translation callback is not
good enough.

One potential use-case for this is to allow generic power domains to be
specified by an ID rather than an index.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
