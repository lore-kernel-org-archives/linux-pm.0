From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PM / Domains: Fix typo in description of genpd_dev_pm_detach()
Date: Thu, 27 Aug 2015 10:17:00 +0100
Message-ID: <1440667020-8833-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4549 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbbH0JRJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 05:17:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

The function genpd_dev_pm_detach() detaches a device from a PM domain,
however, in the description, the "dev" argument for the function is
described as the device to "attach" instead of "detach". Correct this.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7666a1cbaf95..27888a90ca98 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1889,7 +1889,7 @@ EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
- * @dev: Device to attach.
+ * @dev: Device to detach.
  * @power_off: Currently not used
  *
  * Try to locate a corresponding generic PM domain, which the device was
-- 
2.1.4

