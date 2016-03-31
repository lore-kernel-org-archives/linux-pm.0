From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] PM / Domains: Retrieve PM QoS device latencies from DT
Date: Thu, 31 Mar 2016 15:50:26 +0200
Message-ID: <1459432226-22562-2-git-send-email-ulf.hansson@linaro.org>
References: <1459432226-22562-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36489 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbcCaNuf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 09:50:35 -0400
Received: by mail-lf0-f42.google.com with SMTP id e133so60070503lfe.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 06:50:34 -0700 (PDT)
In-Reply-To: <1459432226-22562-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org

For the DT based device attach process, let's parse the device node for
PM QoS latency properties and provide the result as the timing data when
adding a device to its PM domain.

In DT based platforms, this change allows a device to have initial correct
latency values. In the ideal scenario it should mean that the calibration
of these values shouldn't be needed by the genpd governor, but let's leave
that as a future change to consider.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 56705b5..f3302a9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1790,6 +1790,7 @@ int genpd_dev_pm_attach(struct device *dev)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
+	struct gpd_timing_data td;
 	unsigned int i;
 	int ret;
 
@@ -1824,10 +1825,16 @@ int genpd_dev_pm_attach(struct device *dev)
 		return -EPROBE_DEFER;
 	}
 
+	memset(&td, 0, sizeof(td));
+	of_property_read_u64(dev->of_node, "suspend-latency",
+			&td.suspend_latency_ns);
+	of_property_read_u64(dev->of_node, "resume-latency",
+			&td.resume_latency_ns);
+
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
 	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
-		ret = pm_genpd_add_device(pd, dev);
+		ret = __pm_genpd_add_device(pd, dev, &td);
 		if (ret != -EAGAIN)
 			break;
 
-- 
1.9.1

