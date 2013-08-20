From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v4 06/19] driver/core: cpu: initialize of_node in cpu's device
 struture
Date: Tue, 20 Aug 2013 10:30:08 +0100
Message-ID: <1376991021-12160-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
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

CPUs are also registered as devices but the of_node in these cpu
devices are not initialized. Currently different drivers requiring
to access cpu device node are parsing the nodes themselves and
initialising the of_node in cpu device.

The of_node in all the cpu devices needs to be initialized properly
and at one place. The best place to update this is CPU subsystem
driver when registering the cpu devices.

The OF/DT core library now provides of_get_cpu_node to retrieve a cpu
device node for a given logical index by abstracting the architecture
specific details.

This patch uses of_get_cpu_node to assign of_node when registering the
cpu devices.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/base/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c358bc..4cf0717 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
 
 #include "base.h"
 
@@ -289,6 +290,7 @@ int register_cpu(struct cpu *cpu, int num)
 	cpu->dev.release = cpu_device_release;
 	cpu->dev.offline_disabled = !cpu->hotpluggable;
 	cpu->dev.offline = !cpu_online(num);
+	cpu->dev.of_node = of_get_cpu_node(num, NULL);
 #ifdef CONFIG_ARCH_HAS_CPU_AUTOPROBE
 	cpu->dev.bus->uevent = arch_cpu_uevent;
 #endif
-- 
1.8.1.2
