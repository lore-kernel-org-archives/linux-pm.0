From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/8] opp: don't match for existing OPPs when list is empty
Date: Tue, 25 Nov 2014 16:04:17 +0530
Message-ID: <e4f750979598b20b02730f08720f2020e8a0dd0b.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33523 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbaKYKfT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 05:35:19 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so334326pde.10
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 02:35:18 -0800 (PST)
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, stefan.wahren@i2se.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

OPP list is guaranteed to be empty when 'dev_opp' is created. And so we don't
need to run the comparison loop with existing OPPs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 76ae6fd..a333e2ef 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -417,6 +417,12 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	/* Hold our list modification lock here */
 	mutex_lock(&dev_opp_list_lock);
 
+	/* populate the opp table */
+	new_opp->dev_opp = dev_opp;
+	new_opp->rate = freq;
+	new_opp->u_volt = u_volt;
+	new_opp->available = true;
+
 	/* Check for existing list for 'dev' */
 	dev_opp = find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
@@ -441,14 +447,10 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 
 		/* Secure the device list modification */
 		list_add_rcu(&dev_opp->node, &dev_opp_list);
+		head = &dev_opp->opp_list;
+		goto list_add;
 	}
 
-	/* populate the opp table */
-	new_opp->dev_opp = dev_opp;
-	new_opp->rate = freq;
-	new_opp->u_volt = u_volt;
-	new_opp->available = true;
-
 	/*
 	 * Insert new OPP in order of increasing frequency
 	 * and discard if already present
@@ -474,6 +476,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 		return ret;
 	}
 
+list_add:
 	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
 
-- 
2.0.3.693.g996b0fd

