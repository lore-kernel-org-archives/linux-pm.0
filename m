From: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 2/3] cpu: expose pm_qos_resume_latency for each cpu
Date: Thu,  5 Jan 2017 23:29:46 +0800
Message-ID: <1483630187-29622-3-git-send-email-alex.shi@linaro.org>
References: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34015 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969440AbdAEPaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2017 10:30:23 -0500
Received: by mail-io0-f181.google.com with SMTP id f103so13219371ioi.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2017 07:30:23 -0800 (PST)
In-Reply-To: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

The cpu-dma PM QoS constraint impacts all the cpus in the system. There
is no way to let the user to choose a PM QoS constraint per cpu.

The following patch exposes to the userspace a per cpu based sysfs file
in order to let the userspace to change the value of the PM QoS latency
constraint.

This change is inoperative in its form and the cpuidle governors have to
take into account the per cpu latency constraint in addition to the
global cpu-dma latency constraint in order to operate properly.

BTW
The pm_qos_resume_latency usage defined in
Documentation/ABI/testing/sysfs-devices-power
The /sys/devices/.../power/pm_qos_resume_latency_us attribute
contains the PM QoS resume latency limit for the given device,
which is the maximum allowed time it can take to resume the
device, after it has been suspended at run time, from a resume
request to the moment the device will be ready to process I/O,
in microseconds.  If it is equal to 0, however, this means that
the PM QoS resume latency may be arbitrary.

Signed-off-by: Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 drivers/base/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c28e1a..29cf3459 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
+#include <linux/pm_qos.h>
 
 #include "base.h"
 
@@ -376,6 +377,9 @@ int register_cpu(struct cpu *cpu, int num)
 
 	per_cpu(cpu_sys_devices, num) = &cpu->dev;
 	register_cpu_under_node(num, cpu_to_node(num));
+#ifdef CONFIG_CPU_IDLE_GOV_MENU
+	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
+#endif
 
 	return 0;
 }
-- 
2.8.1.101.g72d917a

