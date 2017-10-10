From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] PM / OPP: use of_cpu_device_node_get() instead of of_get_cpu_node()
Date: Tue, 10 Oct 2017 11:48:39 +0100
Message-ID: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42454 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755709AbdJJKsz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Oct 2017 06:48:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Commit 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
moved away from using cpu_dev->of_node because of some limitations.
However commit 7467c9d95989 ("of: return of_get_cpu_node from
of_cpu_device_node_get if CPUs are not registered") added support to
falls back to of_get_cpu_node if called if CPUs are not registered yet.

This patch moves back to use of_cpu_device_node_get in
dev_pm_opp_of_get_sharing_cpus to avoid scanning the device tree again.
It also adds the missing of_node_put for the CPU device nodes.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Fixes: 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/power/opp/of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 0b718886479b..3505193043fe 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -603,13 +603,14 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		if (cpu == cpu_dev->id)
 			continue;

-		cpu_np = of_get_cpu_node(cpu, NULL);
+		cpu_np = of_cpu_device_node_get(cpu);
 		if (!cpu_np) {
 			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
 				__func__, cpu);
 			ret = -ENOENT;
 			goto put_cpu_node;
 		}
+		of_node_put(cpu_np);

 		/* Get OPP descriptor node */
 		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
--
2.7.4
