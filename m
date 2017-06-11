From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] cpuidle: dt: Add missing 'of_node_put()'
Date: Sun, 11 Jun 2017 14:28:54 +0200
Message-ID: <20170611122854.4182-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:37339 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdFKM3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jun 2017 08:29:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'of_node_put()' should be called on pointer returned by
'of_parse_phandle()' when done. In this function this is done in all path
except this 'continue', so add it.

Fixes: 97735da074fd ("drivers: cpuidle: Add status property to ARM idle states")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/cpuidle/dt_idle_states.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index ffca4fc0061d..ae8eb0359889 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -180,8 +180,10 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
 
-		if (!of_device_is_available(state_node))
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
 			continue;
+		}
 
 		if (!idle_state_valid(state_node, i, cpumask)) {
 			pr_warn("%s idle state not valid, bailing out\n",
-- 
2.11.0
