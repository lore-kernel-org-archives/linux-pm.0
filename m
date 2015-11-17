From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Subject: [PATCH v2] PM / Domains: export __pm_genpd_add_device symbol
Date: Tue, 17 Nov 2015 21:17:29 +0530
Message-ID: <1447775249-26252-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bon0085.outbound.protection.outlook.com ([157.56.111.85]:34706
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750867AbbKQPsH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Nov 2015 10:48:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>

Drivers which can be built as loadable module needs symbol
- pm_genpd_add_device to add devices to genpd.
Those drivers create platform devices, which comes under a powerdomain.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f932058..cfa59e3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1252,6 +1252,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__pm_genpd_add_device);
 
 /**
  * pm_genpd_remove_device - Remove a device from an I/O PM domain.
-- 
1.9.1

