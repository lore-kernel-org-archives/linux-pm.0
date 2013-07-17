From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 06/15] drivers/bus: arm-cci: avoid parsing DT for cpu
 device nodes
Date: Wed, 17 Jul 2013 15:06:15 +0100
Message-ID: <1374069984-20567-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Since the CPU device nodes can be retrieved using arch_of_get_cpu_node,
we can use it to avoid parsing the cpus node searching the cpu nodes and
mapping to logical index.

This patch removes parsing DT for cpu nodes by using of_get_cpu_node.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/bus/arm-cci.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7332889..7dd891c 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -122,17 +122,8 @@ EXPORT_SYMBOL_GPL(cci_ace_get_port);
 
 static void __init cci_ace_init_ports(void)
 {
-	int port, ac, cpu;
-	u64 hwid;
-	const u32 *cell;
-	struct device_node *cpun, *cpus;
-
-	cpus = of_find_node_by_path("/cpus");
-	if (WARN(!cpus, "Missing cpus node, bailing out\n"))
-		return;
-
-	if (WARN_ON(of_property_read_u32(cpus, "#address-cells", &ac)))
-		ac = of_n_addr_cells(cpus);
+	int port, cpu;
+	struct device_node *cpun;
 
 	/*
 	 * Port index look-up speeds up the function disabling ports by CPU,
@@ -141,18 +132,13 @@ static void __init cci_ace_init_ports(void)
 	 * The stashed index array is initialized for all possible CPUs
 	 * at probe time.
 	 */
-	for_each_child_of_node(cpus, cpun) {
-		if (of_node_cmp(cpun->type, "cpu"))
-			continue;
-		cell = of_get_property(cpun, "reg", NULL);
-		if (WARN(!cell, "%s: missing reg property\n", cpun->full_name))
-			continue;
-
-		hwid = of_read_number(cell, ac);
-		cpu = get_logical_index(hwid & MPIDR_HWID_BITMASK);
+	for_each_possible_cpu(cpu) {
+		/* too early to use cpu->of_node */
+		cpun = of_get_cpu_node(cpu);
 
-		if (cpu < 0 || !cpu_possible(cpu))
+		if (WARN(!cpun, "Missing cpu device node\n"))
 			continue;
+
 		port = __cci_ace_get_port(cpun, ACE_PORT);
 		if (port < 0)
 			continue;
-- 
1.8.1.2
