From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Subject: [PATCH v3] PM / Domains: export symbols to add/remove devices from genpd
Date: Wed, 18 Nov 2015 01:12:00 +0530
Message-ID: <1447789320-2742-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
List-Id: linux-pm@vger.kernel.org

Drivers which can be built as loadable module needs symbols
- pm_genpd_add_device/pm_genpd_remove_device to add/remove devices
to/from genpd. Those drivers create platform devices, which comes
under a powerdomain.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
---
 drivers/base/power/domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f932058..0c62451 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1252,6 +1252,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__pm_genpd_add_device);
 
 /**
  * pm_genpd_remove_device - Remove a device from an I/O PM domain.
@@ -1302,6 +1303,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pm_genpd_remove_device);
 
 /**
  * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
-- 
1.9.1
