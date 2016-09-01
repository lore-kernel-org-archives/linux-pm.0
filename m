From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu
Date: Thu, 1 Sep 2016 11:50:47 +0800
Message-ID: <57C7A597.4050001@linaro.org>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-2-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33494 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754737AbcIADuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 23:50:51 -0400
Received: by mail-pa0-f50.google.com with SMTP id cy9so25170570pac.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Aug 2016 20:50:51 -0700 (PDT)
In-Reply-To: <1472114562-2736-2-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>


Few commits and patch changed according to Greg's comments.

Regards
Alex

====

>From 186c534b0b8b9649fbfce05b0b4f90f764c571a4 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linaro.org>
Date: Tue, 16 Aug 2016 15:29:01 +0800
Subject: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu

Adding /sys/devices/system/cpu/cpux/power/pm_qos_resume_latency_us for
each of cpus. The pm_qos_resume_latency usage defined in
Documentation/ABI/testing/sysfs-devices-power

The cpu-dma PM QoS constraint impacts all the cpus in the system. There
is no way to let the user to choose a PM QoS constraint per cpu.

The following patch exposes to the userspace a per cpu based sysfs file
in order to let the userspace to change the value of the PM QoS latency
constraint.

This change is inoperative in its form and the cpuidle governors have to
take into account the per cpu latency constraint in addition to the
global cpu-dma latency constraint in order to operate properly.

Signed-off-by: Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/base/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c28e1a..2c3b359 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
+#include <linux/pm_qos.h>
 
 #include "base.h"
 
@@ -376,6 +377,7 @@ int register_cpu(struct cpu *cpu, int num)
 
 	per_cpu(cpu_sys_devices, num) = &cpu->dev;
 	register_cpu_under_node(num, cpu_to_node(num));
+	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
 
 	return 0;
 }
-- 
2.8.1.101.g72d917a


 
