From: James Morse <james.morse@arm.com>
Subject: [PATCH v3 5/7] PM / Hibernate: Allow arch code to influence CPU hotplug during hibernate
Date: Tue, 28 Jun 2016 15:51:48 +0100
Message-ID: <1467125510-18758-6-git-send-email-james.morse@arm.com>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48059 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbcF1OzQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jun 2016 10:55:16 -0400
In-Reply-To: <1467125510-18758-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Chen Yu C <yu.c.chen@intel.com>, linux-pm@vger.kernel.org

Architecture code may need to do extra work when secondary CPUs are
disabled during hibernate and resume. This may include pushing sleeping
CPUs into a deeper power-saving state, or influencing which CPU resume
occurs on.

Define a macro arch_hibernation_disable_cpus(), which defaults to calling
disable_nonboot_cpus() if undefined. Architectures that need to do extra
work around these calls can use this to influence disable_nonboot_cpus()
behaviour. The macro should be defined in asm/suspend.h, and
ARCH_HIBERNATION_CPUHP should be added to Kconfig.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
---
Changes since v2:
 * Added CONFIG_ARCH_HIBERNATION_CPUHP include guard allowing
 * Switch to macro approach.

 kernel/power/hibernate.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index fca9254280ee..338745e78f7e 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -31,8 +31,16 @@
 #include <linux/ktime.h>
 #include <trace/events/power.h>
 
+#ifdef CONFIG_ARCH_HIBERNATION_CPUHP
+/* Arch definition of the arch_hibernation_disable_cpus() macro? */
+#include <asm/suspend.h>
+#endif
+
 #include "power.h"
 
+#ifndef arch_hibernation_disable_cpus
+#define arch_hibernation_disable_cpus(x) disable_nonboot_cpus()
+#endif
 
 static int nocompress;
 static int noresume;
@@ -279,7 +287,7 @@ static int create_image(int platform_mode)
 	if (error || hibernation_test(TEST_PLATFORM))
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = arch_hibernation_disable_cpus(true);
 	if (error || hibernation_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -433,7 +441,7 @@ static int resume_target_kernel(bool platform_mode)
 	if (error)
 		goto Cleanup;
 
-	error = disable_nonboot_cpus();
+	error = arch_hibernation_disable_cpus(false);
 	if (error)
 		goto Enable_cpus;
 
@@ -551,7 +559,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = arch_hibernation_disable_cpus(true);
 	if (error)
 		goto Enable_cpus;
 
-- 
2.8.0.rc3

