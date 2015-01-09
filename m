From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/2] PM / OPP: Assert RCU lock in exported functions
Date: Fri, 09 Jan 2015 09:27:57 +0100
Message-ID: <1420792078-14132-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:18971 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbbAII2L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jan 2015 03:28:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Add lockdep asserts for holding the RCU lock when calling
dev_pm_opp_get_freq() and dev_pm_opp_get_voltage() to aid in detecting
RCU misuses.

These are called often after dev_pm_opp_find_freq_ceil/exact() which
already asserts for RCU lock. However one could make an error by
releasing lock too early - just after dev_pm_opp_find_freq_ceil().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/base/power/opp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 106c69359306..842d31e24eee 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -169,6 +169,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	struct dev_pm_opp *tmp_opp;
 	unsigned long v = 0;
 
+	opp_rcu_lockdep_assert();
+
 	tmp_opp = rcu_dereference(opp);
 	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
@@ -199,6 +201,8 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	struct dev_pm_opp *tmp_opp;
 	unsigned long f = 0;
 
+	opp_rcu_lockdep_assert();
+
 	tmp_opp = rcu_dereference(opp);
 	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
 		pr_err("%s: Invalid parameters\n", __func__);
-- 
1.9.1

