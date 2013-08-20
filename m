From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v4 07/19] of/device: add helper to get cpu device node from
 logical cpu index
Date: Tue, 20 Aug 2013 10:30:09 +0100
Message-ID: <1376991021-12160-8-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Multiple drivers need to get the cpu device node from the cpu logical
index and then access the of_node.

This patch adds helper function to fetch the device node directly.

Acked-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 include/linux/of_device.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 9d27475..82ce324 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_OF_DEVICE_H
 #define _LINUX_OF_DEVICE_H
 
+#include <linux/cpu.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h> /* temporary until merge */
 
@@ -43,6 +44,15 @@ static inline void of_device_node_put(struct device *dev)
 	of_node_put(dev->of_node);
 }
 
+static inline struct device_node *of_cpu_device_node_get(int cpu)
+{
+	struct device *cpu_dev;
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return NULL;
+	return of_node_get(cpu_dev->of_node);
+}
+
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -67,6 +77,11 @@ static inline const struct of_device_id *of_match_device(
 {
 	return NULL;
 }
+
+static inline struct device_node *of_cpu_device_node_get(int cpu)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
1.8.1.2
