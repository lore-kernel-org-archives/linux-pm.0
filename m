From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 10/12] cpufreq: ap806: add missing of_node_put after
 of_device_is_available
Date: Sat, 23 Feb 2019 14:20:41 +0100
Message-ID: <1550928043-14889-11-git-send-email-Julia.Lawall@lip6.fr>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Add an of_node_put when a tested device node is not available.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
identifier f;
local idexpression e;
expression x;
@@

e = f(...);
... when != of_node_put(e)
    when != x = e
    when != e = x
    when any
if (<+...of_device_is_available(e)...+>) {
  ... when != of_node_put(e)
(
  return e;
|
+ of_node_put(e);
  return ...;
)
}
// </smpl>

Fixes: f525a670533d9 ("cpufreq: ap806: add cpufreq driver for Armada 8K")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/cpufreq/armada-8k-cpufreq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -u -p a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -128,8 +128,10 @@ static int __init armada_8k_cpufreq_init
 	struct cpumask cpus;
 
 	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
-	if (!node || !of_device_is_available(node))
+	if (!node || !of_device_is_available(node)) {
+		of_node_put(node);
 		return -ENODEV;
+	}
 
 	nb_cpus = num_possible_cpus();
 	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);
