From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH V5 1/6] drivers: cpuidle: Read CPU's idle state from PM domain
Date: Fri,  3 Mar 2017 13:48:12 -0800
Message-ID: <1488577697-127445-2-git-send-email-lina.iyer@linaro.org>
References: <1488577697-127445-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488577697-127445-1-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, brendan.jackman@arm.com, sudeep.holla@arm.com, andy.gross@linaro.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Currently CPUs idle states and idle states of its parent are represented
in a flattened model by the cpu-dile-states property of the CPU node.
The CPUs idle states are followed by its cluster idle states. With the
introduction of CPU PM domains, the CPUs and domain idle states may be
represented hierarchically as part of the domain DT definition. This
would mean presenting idle state information in 2 places - CPU nodes for
the CPU and the cluster's with the PM domains.

Also, it makes sense to define domains around each individual CPU since
each of them is a power domain in its own right. The CPU idle states can
now be represented as its domain's idle state, defined by the
domain-idle-states property. This avoids presenting idle states in
multiple places in the DT.

Modify the DT-based cpuidle driver to check for the presence of a CPU's
domain and if present read the domain-idle-states of the PM domain and
if the CPU's domain is absent, revert to reading in the cpu-idle-states
property of the CPU DT node.

Suggested-by: Sudeep Holla <sudeep.holla@qrm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index ffca4fc..4df7d45 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -98,6 +98,39 @@ static int init_state_node(struct cpuidle_state *idle_state,
 }
 
 /*
+ * Get the state node at @idx. State node may be defined as domain's idle state
+ * if the CPU has its own domain or defined as CPU's idle state if it doesn't
+ * have a domain provider.
+ */
+static struct device_node *get_state_node(struct device_node *cpu_node,
+				unsigned int idx)
+{
+	struct device_node *dn;
+	bool cpu_has_domain = false;
+	struct of_phandle_args args;
+	const char *property;
+	int err;
+
+	err = of_parse_phandle_with_args(cpu_node, "power-domains",
+					"#power-domain-cells", 0, &args);
+	if (!err) {
+		dn = args.np;
+		err = of_count_phandle_with_args(dn, "domain-idle-states",
+								NULL);
+		cpu_has_domain = (err > 0);
+	}
+
+	if (cpu_has_domain) {
+		property = "domain-idle-states";
+	} else {
+		property = "cpu-idle-states";
+		dn = cpu_node;
+	}
+
+	return of_parse_phandle(dn, property, idx);
+}
+
+/*
  * Check that the idle state is uniform across all CPUs in the CPUidle driver
  * cpumask
  */
@@ -118,8 +151,7 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
 	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
 	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
 		cpu_node = of_cpu_device_node_get(cpu);
-		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-						   idx);
+		curr_state_node = get_state_node(cpu_node, idx);
 		if (state_node != curr_state_node)
 			valid = false;
 
@@ -176,7 +208,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 	cpu_node = of_cpu_device_node_get(cpumask_first(cpumask));
 
 	for (i = 0; ; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = get_state_node(cpu_node, i);
 		if (!state_node)
 			break;
 
-- 
2.7.4
