From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 1/4] PM / Domains: Simplify detaching a device from its
 genpd
Date: Thu, 22 Sep 2016 15:38:29 -0600
Message-ID: <20160922213829.GA1537@linaro.org>
References: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
 <1474465133-14865-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34002 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbcIVVid (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2016 17:38:33 -0400
Received: by mail-pa0-f52.google.com with SMTP id wk8so32959832pab.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2016 14:38:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1474465133-14865-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Jon Hunter <jonathanh@nvidia.com>

On Wed, Sep 21 2016 at 07:39 -0600, Ulf Hansson wrote:
>There's no need to validate the PM domain by using genpd_lookup_dev() when
>removing the device via genpd's genpd_dev_pm_detach() function. That's
>because this function can't be called, unless there is a valid PM domain
>for the device.
>
>To simplify the behaviour, let's move code from pm_genpd_remove_device()
>into a new internal function, genpd_remove_device(), which is called from
>pm_genpd_remove_device() and genpd_dev_pm_detach().
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Lina Iyer <lina.iyer@linaro.org>

>---
> drivers/base/power/domain.c | 33 +++++++++++++++++++--------------
> 1 file changed, 19 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index 83ae3d7..63f0f8b 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -1121,13 +1121,8 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> }
> EXPORT_SYMBOL_GPL(__pm_genpd_add_device);
>
>-/**
>- * pm_genpd_remove_device - Remove a device from an I/O PM domain.
>- * @genpd: PM domain to remove the device from.
>- * @dev: Device to be removed.
>- */
>-int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>-			   struct device *dev)
>+static int genpd_remove_device(struct generic_pm_domain *genpd,
>+			       struct device *dev)
> {
> 	struct generic_pm_domain_data *gpd_data;
> 	struct pm_domain_data *pdd;
>@@ -1135,10 +1130,6 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>
> 	dev_dbg(dev, "%s()\n", __func__);
>
>-	if (!genpd || genpd != genpd_lookup_dev(dev))
>-		return -EINVAL;
>-
>-	/* The above validation also means we have existing domain_data. */
> 	pdd = dev->power.subsys_data->domain_data;
> 	gpd_data = to_gpd_data(pdd);
> 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
>@@ -1170,6 +1161,20 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>
> 	return ret;
> }
>+
>+/**
>+ * pm_genpd_remove_device - Remove a device from an I/O PM domain.
>+ * @genpd: PM domain to remove the device from.
>+ * @dev: Device to be removed.
>+ */
>+int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>+			   struct device *dev)
>+{
>+	if (!genpd || genpd != genpd_lookup_dev(dev))
>+		return -EINVAL;
>+
>+	return genpd_remove_device(genpd, dev);
>+}
> EXPORT_SYMBOL_GPL(pm_genpd_remove_device);
>
> static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>@@ -1797,14 +1802,14 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
> 	unsigned int i;
> 	int ret = 0;
>
>-	pd = genpd_lookup_dev(dev);
>-	if (!pd)
>+	pd = dev_to_genpd(dev);
>+	if (IS_ERR(pd))
> 		return;
>
> 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>
> 	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
>-		ret = pm_genpd_remove_device(pd, dev);
>+		ret = genpd_remove_device(pd, dev);
> 		if (ret != -EAGAIN)
> 			break;
>
>-- 
>1.9.1
>
