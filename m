From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH V5 4/6] drivers: firmwware: psci: Support hierachical idle
 states
Date: Fri,  3 Mar 2017 13:48:15 -0800
Message-ID: <1488577697-127445-5-git-send-email-lina.iyer@linaro.org>
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

Read in the idle state properties for a CPU's idle state from its PM
domain, if such a domain exists or use the existing CPU node property.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/firmware/psci.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 18ae62d..190d3a7 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -292,15 +292,24 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 {
 	int i, ret, count = 0;
 	u32 *psci_states;
-	struct device_node *state_node;
-
-	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
-		count++;
-		of_node_put(state_node);
+	struct device_node *state_node, *dn;
+	struct of_phandle_args args;
+	bool cpu_has_domain = false;
+	const char *property;
+
+	/* Is there a domain provider for this CPU? */
+	ret = of_parse_phandle_with_args(cpu_node, "power-domains",
+					"#power-domain-cells", 0, &args);
+	if (!ret) {
+		dn = args.np;
+		ret = of_count_phandle_with_args(dn, "domain-idle-states",
+								NULL);
+		cpu_has_domain = (ret > 0);
 	}
 
+	count = (cpu_has_domain) ? ret :
+		of_count_phandle_with_args(cpu_node, "cpu-idle-states", NULL);
+
 	if (!count)
 		return -ENODEV;
 
@@ -308,10 +317,17 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	if (!psci_states)
 		return -ENOMEM;
 
+	if (cpu_has_domain) {
+		property = "domain-idle-states";
+	} else {
+		property = "cpu-idle-states";
+		dn = cpu_node;
+	}
+
 	for (i = 0; i < count; i++) {
 		u32 state;
 
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_parse_phandle(dn, property, i);
 
 		ret = of_property_read_u32(state_node,
 					   "arm,psci-suspend-param",
-- 
2.7.4
