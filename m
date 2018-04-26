From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/11] PM / Domains: Check for existing PM domain in dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:03 +0200
Message-ID: <1524732790-2234-5-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Instead of checking if an existing PM domain pointer has been assigned in
genpd_dev_pm_attach() and acpi_dev_pm_attach(), move the check to the
common path in dev_pm_domain_attach(), thus potentially avoid one
unnecessary check.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/device_pm.c    | 3 ---
 drivers/base/power/common.c | 3 +++
 drivers/base/power/domain.c | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 3d96e4d..d006300 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1259,9 +1259,6 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	if (!adev)
 		return -ENODEV;
 
-	if (dev->pm_domain)
-		return -EEXIST;
-
 	/*
 	 * Only attach the power domain to the first device if the
 	 * companion is shared by multiple. This is to prevent doing power
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index f6a9ad5..f3cf61f 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -104,6 +104,9 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
 	int ret;
 
+	if (dev->pm_domain)
+		return -EEXIST;
+
 	ret = acpi_dev_pm_attach(dev, power_on);
 	if (ret)
 		ret = genpd_dev_pm_attach(dev);
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d4b96ed..b816adb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2194,9 +2194,6 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (!dev->of_node)
 		return -ENODEV;
 
-	if (dev->pm_domain)
-		return -EEXIST;
-
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 					"#power-domain-cells", 0, &pd_args);
 	if (ret < 0)
-- 
2.7.4
