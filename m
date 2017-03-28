From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH 1/4] PM / Domains: Prepare for supporting explicit PM domain control
Date: Tue, 28 Mar 2017 15:14:00 +0100
Message-ID: <1490710443-27425-2-git-send-email-jonathanh@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org, rnayak@codeaurora.org
Cc: stanimir.varbanov@linaro.org, sboyd@codeaurora.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The generic PM domain framework only supports consumers that require a
single PM domain. In order to extend the framework so that consumers can
explicitly control more than one PM domain, detect if the consumers
specifies more than one PM domain and if it does then don't
automatically bind the device with any of the PM domains and (leap of
faith!) assume the consumer knows what to do!

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e697dec9d25b..0eb75954c087 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2011,6 +2011,16 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (dev->pm_domain)
 		return -EEXIST;
 
+	/*
+	 * If there are more than one PM domain defined for a device,
+	 * then these need to be manually controlled by the driver
+	 * that device, because the genpd core cannot bind a device
+	 * with more than one PM domain.
+	 */
+	if (of_count_phandle_with_args(dev->of_node, "power-domains",
+				       "#power-domain-cells") > 1)
+		return 0;
+
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 					"#power-domain-cells", 0, &pd_args);
 	if (ret < 0) {
-- 
2.7.4
