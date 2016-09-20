From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 2/3] PM / Domains: Add support for devices with multiple domains
Date: Tue, 20 Sep 2016 11:28:06 +0100
Message-ID: <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474367287-10402-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Some devices may require more than one PM domain to operate and this is
not currently by the PM domain framework. Furthermore, the current Linux
'device' structure only allows devices to be associated with a single PM
domain and so cannot easily be associated with more than one. To allow
devices to be associated with more than one PM domain, if multiple
domains are defined for a given device (eg. via device-tree), then:
1. Create a new PM domain for this device. The name of the new PM domain
   created matches the device name for which it was created for.
2. Register the new PM domain as a sub-domain for all PM domains
   required by the device.
3. Attach the device to the new PM domain.

By default the newly created PM domain is assumed to be in the 'off'
state to ensure that any parent PM domains will be turned on if not
already on when the new PM domain is turned on.

When a device associated with more than one PM domain is detached,
wait for any power-off work to complete, then remove the PM domain that
was created for the device by calling pm_genpd_remove() (this also
removes it as a child to any other PM domains) and free the memory
for the PM domain.

For devices using device-tree, devices that require multiple PM domains
are detected by seeing if the 'power-domains' property has more than one
entry defined.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---

Here is an example output from pm_genpd_summary following this change
for the Tegra210 XHCI device:

domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
70090000.usb                    on
    /devices/platform/70090000.usb                      unsupported
xusbc                           on              70090000.usb
xusbb                           off-0
xusba                           on              70090000.usb

I am not sure if this is confusing to have a device and domain with the
same name. So let me know if you have any thoughts!


 drivers/base/power/domain.c | 102 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 382735949591..ee39824c03b3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1826,7 +1826,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
 	unsigned int i;
-	int ret = 0;
+	int count, ret = 0;
 
 	pd = genpd_lookup_dev(dev);
 	if (!pd)
@@ -1851,6 +1851,19 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	/* Check if PM domain can be powered off after removing this device. */
 	genpd_queue_power_off_work(pd);
+
+	count = of_count_phandle_with_args(dev->of_node, "power-domains",
+					   "#power-domain-cells");
+	if (count > 1) {
+		cancel_work_sync(&pd->power_off_work);
+
+		ret = pm_genpd_remove(pd);
+		if (ret < 0)
+			dev_err(dev, "failed to remove PM domain %s: %d\n",
+				pd->name, ret);
+
+		kfree(pd);
+	}
 }
 
 static void genpd_dev_pm_sync(struct device *dev)
@@ -1898,6 +1911,73 @@ static int genpd_dev_pm_attach_device(struct device *dev,
 
 }
 
+static int genpd_dev_pm_attach_one(struct device *dev)
+{
+	struct generic_pm_domain *pd;
+	int ret;
+
+	mutex_lock(&gpd_list_lock);
+	pd = genpd_dev_pm_lookup(dev, 0);
+	if (IS_ERR(pd)) {
+		mutex_unlock(&gpd_list_lock);
+		return PTR_ERR(pd);
+	}
+
+	ret = genpd_dev_pm_attach_device(dev, pd);
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+}
+
+static int genpd_dev_pm_attach_many(struct device *dev, unsigned int count)
+{
+	struct generic_pm_domain *pd, *parent;
+	unsigned int i;
+	int ret;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->name = dev_name(dev);
+
+	ret = pm_genpd_init(pd, NULL, true);
+	if (ret < 0)
+		goto err_free;
+
+	mutex_lock(&gpd_list_lock);
+	for (i = 0; i < count; i++) {
+		parent = genpd_dev_pm_lookup(dev, i);
+		if (IS_ERR(parent)) {
+			ret = PTR_ERR(parent);
+			goto err_remove;
+		}
+
+		ret = genpd_add_subdomain(parent, pd);
+		if (ret < 0)
+			goto err_remove;
+
+	}
+
+	ret = genpd_dev_pm_attach_device(dev, pd);
+	if (ret < 0)
+		goto err_remove;
+
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+
+err_remove:
+	WARN_ON(genpd_remove(pd));
+
+	mutex_unlock(&gpd_list_lock);
+
+err_free:
+	kfree(pd);
+
+	return ret;
+}
+
 /**
  * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
  * @dev: Device to attach.
@@ -1915,8 +1995,7 @@ static int genpd_dev_pm_attach_device(struct device *dev,
  */
 int genpd_dev_pm_attach(struct device *dev)
 {
-	struct generic_pm_domain *pd;
-	int ret;
+	int count;
 
 	if (!dev->of_node)
 		return -ENODEV;
@@ -1924,17 +2003,12 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (dev->pm_domain)
 		return -EEXIST;
 
-	mutex_lock(&gpd_list_lock);
-	pd = genpd_dev_pm_lookup(dev, 0);
-	if (IS_ERR(pd)) {
-		mutex_unlock(&gpd_list_lock);
-		return -EPROBE_DEFER;
-	}
-
-	ret = genpd_dev_pm_attach_device(dev, pd);
-	mutex_lock(&gpd_list_lock);
-
-	return ret;
+	count = of_count_phandle_with_args(dev->of_node, "power-domains",
+					   "#power-domain-cells");
+	if (count > 1)
+		return genpd_dev_pm_attach_many(dev, count);
+	else
+		return genpd_dev_pm_attach_one(dev);
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
-- 
2.1.4
