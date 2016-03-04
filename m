From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH 6/8] PM / Domains: Remove a provider by referencing the data pointer
Date: Fri, 4 Mar 2016 11:23:52 +0000
Message-ID: <1457090634-14785-7-git-send-email-jonathanh@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9937 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbcCDLYR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 06:24:17 -0500
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

To remove a PM domain from the system, it is necessary to ensure
that any PM domain providers associated with the PM domain have
been removed. Otherwise it could be possible to obtain a pointer
to a PM domain structure that has been removed.

PM domains now have a reference to the pointer for the PM domain
provider's data variable. Add a function so that a PM domain can
remove a PM domain provider by referencing the data pointer.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 72055fef6256..438885f2455f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1738,6 +1738,30 @@ void of_genpd_del_provider(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 
 /**
+ * of_genpd_del_provider_by_data() - Remove a registered PM domain provider
+ * @data: Pointer to the data associated with the PM domain provider
+ *
+ * Look up a PM domain provider based upon a pointer to it's data and
+ * remove the PM domain provider from the list of providers.
+ */
+void of_genpd_del_provider_by_data(void *data)
+{
+	struct of_genpd_provider *c, *cp;
+
+	mutex_lock(&of_genpd_mutex);
+	list_for_each_entry_safe(cp, c, &of_genpd_providers, link) {
+		if (cp->data == data) {
+			list_del(&cp->link);
+			of_node_put(cp->node);
+			kfree(cp);
+			break;
+		}
+	}
+	mutex_unlock(&of_genpd_mutex);
+}
+EXPORT_SYMBOL_GPL(of_genpd_del_provider_by_data);
+
+/**
  * of_genpd_get_from_provider() - Look-up PM domain
  * @genpdspec: OF phandle args to use for look-up
  *
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bed84413546f..7b7921a65cb0 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -199,6 +199,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
+void of_genpd_del_provider_by_data(void *data);
 struct generic_pm_domain *__of_genpd_xlate_simple(
 					struct of_phandle_args *genpdspec,
 					void *data);
@@ -218,6 +219,7 @@ static inline int __of_genpd_add_provider(struct device_node *np,
 	return 0;
 }
 static inline void of_genpd_del_provider(struct device_node *np) {}
+static inline void of_genpd_del_provider_by_data(void *data) {}
 
 #define __of_genpd_xlate_simple		NULL
 #define __of_genpd_xlate_onecell	NULL
-- 
2.1.4

