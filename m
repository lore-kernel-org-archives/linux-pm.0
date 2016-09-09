From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 08/10] PM / Domains: Add support for removing PM domains
Date: Fri, 9 Sep 2016 16:17:33 +0100
Message-ID: <63871fe6-cda6-2a95-9c09-e4b3ebfa3419@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-9-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A@mail.gmail.com>
 <c8498eca-6934-1cab-31d9-3d8ce4c74897@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c8498eca-6934-1cab-31d9-3d8ce4c74897-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 09/09/16 14:54, Jon Hunter wrote:
> On 08/09/16 12:49, Ulf Hansson wrote:
>> On 16 August 2016 at 11:49, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> The genpd framework allows users to add PM domains via the pm_genpd_init()
>>> function, however, there is no corresponding function to remove a PM
>>> domain. For most devices this may be fine as the PM domains are never
>>> removed, however, for devices that wish to populate the PM domains from
>>> within a driver, having the ability to remove a PM domain if the probing
>>> of the device fails or the driver is unloaded is necessary.
>>>
>>> Add the function pm_genpd_remove() to remove a PM domain by referencing
>>> it's generic_pm_domain structure.
>>>
>>> PM domains can only be removed if they are not a parent domain to
>>> another PM domain and have no devices associated with them.
>>
>> I think we should also check if the there's is a provider registered
>> for the genpd, as it should also prevent the genpd from being removed.
>> Right?
> 
> Yes I would agree. I had thought that after patch #4 of this series that
> only the provider itself would be able to call this. However, we should
> probably still verify that the provider has correctly remove itself.

So now I have the following. I am still not 100% happy. I cannot clear
the ->provider when calling of_genpd_del_provider() and so I cannot use
this to verify if the provider is present and so I need to check the
list of providers and it gets a bit messy. I have been wracking my
brains to find a better alternative (including a single function to
remove the provider and domains at once but there are issues with that
as well).

I think that long term it may make sense to reference the providers
exclusively by the fwnode_handle and make the list of provider non-DT
specific. I could do it now, but it would increase the series.

Cheers
Jon

---
 drivers/base/power/domain.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  5 +++
 2 files changed, 94 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 82f87038f108..57c64fc1a164 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -39,6 +39,8 @@
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
+static bool genpd_provider_present(struct device_node *np);
+
 /*
  * Get the generic PM domain for a particular struct device.
  * This validates the struct device pointer, the PM domain pointer,
@@ -1356,6 +1358,68 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
+static int genpd_remove(struct generic_pm_domain *genpd)
+{
+	struct gpd_link *l, *link;
+
+	if (IS_ERR_OR_NULL(genpd))
+		return -EINVAL;
+
+	mutex_lock(&genpd->lock);
+
+	if (is_of_node(genpd->provider)) {
+		if (genpd_provider_present(to_of_node(genpd->provider))) {
+			mutex_unlock(&genpd->lock);
+			pr_err("Provider present, unable to remove %s\n",
+			       genpd->name);
+			return -EBUSY;
+		}
+	}
+
+	if (!list_empty(&genpd->master_links) || genpd->device_count) {
+		mutex_unlock(&genpd->lock);
+		pr_err("%s: unable to remove %s\n", __func__, genpd->name);
+		return -EBUSY;
+	}
+
+	list_for_each_entry_safe(link, l, &genpd->slave_links, slave_node) {
+		list_del(&link->master_node);
+		list_del(&link->slave_node);
+		kfree(link);
+	}
+
+	list_del(&genpd->gpd_list_node);
+	mutex_unlock(&genpd->lock);
+	cancel_work_sync(&genpd->power_off_work);
+	pr_debug("%s: removed %s\n", __func__, genpd->name);
+
+	return 0;
+}
+
+/**
+ * pm_genpd_remove - Remove a generic I/O PM domain
+ * @genpd: Pointer to PM domain that is to be removed.
+ *
+ * To remove the PM domain, this function:
+ *  - Removes the PM domain as a subdomain to any parent domains,
+ *    if it was added.
+ *  - Removes the PM domain from the list of registered PM domains.
+ *
+ * The PM domain will only be removed, if it is not a parent to any
+ * other PM domain and has no devices associated with it.
+ */
+int pm_genpd_remove(struct generic_pm_domain *genpd)
+{
+	int ret;
+
+	mutex_lock(&gpd_list_lock);
+	ret = genpd_remove(genpd);
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_remove);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 
 typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
@@ -1563,6 +1627,26 @@ void of_genpd_del_provider(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 
 /**
+ * genpd_provider_present() - Verify if a PM domain provider is present
+ * @np: Device node pointer associated with the PM domain provider
+ */
+static bool genpd_provider_present(struct device_node *np)
+{
+	struct of_genpd_provider *cp;
+
+	mutex_lock(&of_genpd_mutex);
+	list_for_each_entry(cp, &of_genpd_providers, link) {
+		if (cp->node == np) {
+			mutex_unlock(&of_genpd_mutex);
+			return true;
+		}
+	}
+	mutex_unlock(&of_genpd_mutex);
+
+	return false;
+}
+
+/**
  * genpd_get_from_provider() - Look-up PM domain
  * @genpdspec: OF phandle args to use for look-up
  *
@@ -1798,6 +1882,11 @@ out:
 	return ret ? -EPROBE_DEFER : 0;
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
+#else
+static bool genpd_provider_present(struct device_node *np)
+{
+	return false;
+}
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e71764ac7248..4aa285e44eb0 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -129,6 +129,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern int pm_genpd_init(struct generic_pm_domain *genpd,
 			 struct dev_power_governor *gov, bool is_off);
+extern int pm_genpd_remove(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -164,6 +165,10 @@ static inline int pm_genpd_init(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
+static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-- 
2.1.4 

-- 
nvpublic
