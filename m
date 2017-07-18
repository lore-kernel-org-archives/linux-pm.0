From: Rob Herring <robh@kernel.org>
Subject: [PATCH] cpuidle: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:42:55 -0500
Message-ID: <20170718214339.7774-15-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpuidle/dt_idle_states.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index ae8eb0359889..bafd4dbf55d4 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -53,16 +53,16 @@ static int init_state_node(struct cpuidle_state *idle_state,
 		err = of_property_read_u32(state_node, "entry-latency-us",
 					   &entry_latency);
 		if (err) {
-			pr_debug(" * %s missing entry-latency-us property\n",
-				 state_node->full_name);
+			pr_debug(" * %pOF missing entry-latency-us property\n",
+				 state_node);
 			return -EINVAL;
 		}

 		err = of_property_read_u32(state_node, "exit-latency-us",
 					   &exit_latency);
 		if (err) {
-			pr_debug(" * %s missing exit-latency-us property\n",
-				 state_node->full_name);
+			pr_debug(" * %pOF missing exit-latency-us property\n",
+				 state_node);
 			return -EINVAL;
 		}
 		/*
@@ -75,8 +75,8 @@ static int init_state_node(struct cpuidle_state *idle_state,
 	err = of_property_read_u32(state_node, "min-residency-us",
 				   &idle_state->target_residency);
 	if (err) {
-		pr_debug(" * %s missing min-residency-us property\n",
-			     state_node->full_name);
+		pr_debug(" * %pOF missing min-residency-us property\n",
+			     state_node);
 		return -EINVAL;
 	}

@@ -186,8 +186,8 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		}

 		if (!idle_state_valid(state_node, i, cpumask)) {
-			pr_warn("%s idle state not valid, bailing out\n",
-				state_node->full_name);
+			pr_warn("%pOF idle state not valid, bailing out\n",
+				state_node);
 			err = -EINVAL;
 			break;
 		}
@@ -200,8 +200,8 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		idle_state = &drv->states[state_idx++];
 		err = init_state_node(idle_state, matches, state_node);
 		if (err) {
-			pr_err("Parsing idle state node %s failed with err %d\n",
-			       state_node->full_name, err);
+			pr_err("Parsing idle state node %pOF failed with err %d\n",
+			       state_node, err);
 			err = -EINVAL;
 			break;
 		}
--
2.11.0
