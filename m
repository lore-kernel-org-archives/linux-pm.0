From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [RFC PATCH  1/4] devfreq_cooling: make the structs devfreq_cooling_xxx visible for all
Date: Fri, 26 Aug 2016 14:18:02 +0100
Message-ID: <20160826131805.14820-2-lukasz.luba@arm.com>
References: <20160826131805.14820-1-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbcHZNTY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 09:19:24 -0400
In-Reply-To: <20160826131805.14820-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, lukasz.luba@arm.com, javi.merino@arm.com, orjan.eide@arm.com

Currently the protection #ifdef CONFIG_DEVFREQ_THERMAL cuts the needed
structures devfreq_cooling_ops and devfreq_cooling_device.
The functions which are supposed to provide the empty implementation complain
about unknown structures.
Similar solution is present in include/linux/devfreq.h.

Reviewed-by: Ørjan Eide <orjan.eide@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/devfreq_cooling.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
index 7adf6cc..3049f94 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -20,7 +20,6 @@
 #include <linux/devfreq.h>
 #include <linux/thermal.h>
 
-#ifdef CONFIG_DEVFREQ_THERMAL
 
 /**
  * struct devfreq_cooling_power - Devfreq cooling power ops
@@ -43,6 +42,8 @@ struct devfreq_cooling_power {
 	unsigned long dyn_power_coeff;
 };
 
+#ifdef CONFIG_DEVFREQ_THERMAL
+
 struct thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 				  struct devfreq_cooling_power *dfc_power);
-- 
2.9.2

