From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] cpuidle: dt: Add missing 'of_node_put()'
Date: Mon, 12 Jun 2017 17:55:09 +0200
Message-ID: <1497282910-19085-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170612155441.GE2261@mai>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612155441.GE2261@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

'of_node_put()' should be called on pointer returned by
'of_parse_phandle()' when done. In this function this is done in all path
except this 'continue', so add it.

Fixes: 97735da074fd ("drivers: cpuidle: Add status property to ARM idle states")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index ffca4fc..ae8eb03 100644
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
2.7.4
