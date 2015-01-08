From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver if MCPM is unavailable
Date: Thu,  8 Jan 2015 06:29:04 +0000
Message-ID: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:57561 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbAHG3i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jan 2015 01:29:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

If big.LITTLE driver is initialized even when MCPM is unavailable,
we get the below warning the first time cpu tries to enter deeper
C-states.

------------[ cut here ]------------
WARNING: CPU: 4 PID: 0 at kernel/arch/arm/common/mcpm_entry.c:130 mcpm_cpu_suspend+0x6d/0x74()
Modules linked in:
CPU: 4 PID: 0 Comm: swapper/4 Not tainted 3.19.0-rc3-00007-gaf5a2cb1ad5c-dirty #11
Hardware name: ARM-Versatile Express
[<c0013fa5>] (unwind_backtrace) from [<c001084d>] (show_stack+0x11/0x14)
[<c001084d>] (show_stack) from [<c04fe7f1>] (dump_stack+0x6d/0x78)
[<c04fe7f1>] (dump_stack) from [<c0020645>] (warn_slowpath_common+0x69/0x90)
[<c0020645>] (warn_slowpath_common) from [<c00206db>] (warn_slowpath_null+0x17/0x1c)
[<c00206db>] (warn_slowpath_null) from [<c001cbdd>] (mcpm_cpu_suspend+0x6d/0x74)
[<c001cbdd>] (mcpm_cpu_suspend) from [<c03c6919>] (bl_powerdown_finisher+0x21/0x24)
[<c03c6919>] (bl_powerdown_finisher) from [<c001218d>] (cpu_suspend_abort+0x1/0x14)
[<c001218d>] (cpu_suspend_abort) from [<00000000>] (  (null))
---[ end trace d098e3fd00000008 ]---

This patch fixes the issue by checking for the availability of MCPM
before initializing the big.LITTLE cpuidle driver

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/cpuidle/cpuidle-big_little.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index e3e225fe6b45..40c34faffe59 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -182,6 +182,10 @@ static int __init bl_idle_init(void)
 	 */
 	if (!of_match_node(compatible_machine_match, root))
 		return -ENODEV;
+
+	if (!mcpm_is_available())
+		return -EUNATCH;
+
 	/*
 	 * For now the differentiation between little and big cores
 	 * is based on the part number. A7 cores are considered little
-- 
1.9.1

