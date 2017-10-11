From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2] PM / OPP: add missing of_node_put() for of_get_cpu_node()
Date: Wed, 11 Oct 2017 11:11:01 +0100
Message-ID: <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdJKKLN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Oct 2017 06:11:13 -0400
In-Reply-To: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Commit 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
moved away from using cpu_dev->of_node because of some limitations.
However commit 7467c9d95989 ("of: return of_get_cpu_node from
of_cpu_device_node_get if CPUs are not registered") added support to
falls back to of_get_cpu_node if called if CPUs are not registered yet.

It adds the missing of_node_put for the CPU device nodes. This patch also
moves back to use of_cpu_device_node_get in dev_pm_opp_of_get_sharing_cpus
to avoid scanning the device tree again.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Fixes: 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/opp/of.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

v1->v2:
	- Moved of_node_put after using cpu_np
	- Renamed the $subject as fixing refcount is key part of the part
	  and correctly relates to "Fixes" tag
	- Also added include change which was accidentally missed

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 0b718886479b..6a486ad81259 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -16,7 +16,7 @@
 #include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/device.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/export.h>

@@ -603,7 +603,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		if (cpu == cpu_dev->id)
 			continue;

-		cpu_np = of_get_cpu_node(cpu, NULL);
+		cpu_np = of_cpu_device_node_get(cpu);
 		if (!cpu_np) {
 			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
 				__func__, cpu);
@@ -614,10 +614,12 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		/* Get OPP descriptor node */
 		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
 		if (!tmp_np) {
+			of_node_put(cpu_np);
 			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
 			ret = -ENOENT;
 			goto put_cpu_node;
 		}
+		of_node_put(cpu_np);

 		/* CPUs are sharing opp node */
 		if (np == tmp_np)
--
2.7.4
