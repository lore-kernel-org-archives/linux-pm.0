From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] PM / OPP: Fix incorrect comments
Date: Tue, 16 Feb 2016 14:17:52 +0530
Message-ID: <a2e646290fdc966d8126176bae51bc648a4eddf8.1455612454.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35317 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441AbcBPIsN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 03:48:13 -0500
Received: by mail-pf0-f180.google.com with SMTP id c10so103613607pfc.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2016 00:48:13 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org

Some comments were just copy/pasted from other sections and don't match
to the routines they were added for. Fix them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 5fb2f061129e..bdae09c1d8eb 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1254,7 +1254,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
 
 /**
  * dev_pm_opp_put_supported_hw() - Releases resources blocked for supported hw
- * @dev: Device for which supported-hw has to be set.
+ * @dev: Device for which supported-hw has to be put.
  *
  * This is required only for the V2 bindings, and is called for a matching
  * dev_pm_opp_set_supported_hw(). Until this is called, the device_opp structure
@@ -1303,7 +1303,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
 
 /**
  * dev_pm_opp_set_prop_name() - Set prop-extn name
- * @dev: Device for which the regulator has to be set.
+ * @dev: Device for which the prop-name has to be set.
  * @name: name to postfix to properties.
  *
  * This is required only for the V2 bindings, and it enables a platform to
@@ -1362,7 +1362,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
 
 /**
  * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
- * @dev: Device for which the regulator has to be set.
+ * @dev: Device for which the prop-name has to be put.
  *
  * This is required only for the V2 bindings, and is called for a matching
  * dev_pm_opp_set_prop_name(). Until this is called, the device_opp structure
-- 
2.7.1.410.g6faf27b

