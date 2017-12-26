From: gaurav jindal <gauravjindal1104@gmail.com>
Subject: [PATCH]cpuidle: preventive check in cpuidle_select against crash
Date: Tue, 26 Dec 2017 12:56:26 +0530
Message-ID: <20171226072626.GA4153@gaurav.jindal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46148 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZH0a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 02:26:30 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

When selecting the idle state using cpuidle_select, there is no
check on cpuidle_curr_governor. In cpuidle_switch_governor,
cpuidle_currr_governor can be set to NULL to specify "disabled".

Since cpuidle_select cannot return negative value, it has to return 0
in case of error. Printing logs and returning can help in debugging and
preventing possible kernel crash scenarios.

Signed-off-by: Gaurav Jindal<gauravjindal1104@gmail.com>

---

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 68a1682..bf08e3a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -268,6 +268,19 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
  */
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
+
+	/* Since negative return is not allowed
+	 * we have to return 0 even if the
+	 * framework cannot select the idle state
+	 */
+	if (!cpuidle_curr_governor) {
+		pr_err("idle governor is disabled\n");
+		return 0;
+	}
+	if (!cpuidle_curr_governor->select) {
+		pr_err("idle governor select is NULL\n");
+		return 0;
+	}
 	return cpuidle_curr_governor->select(drv, dev);
 }
