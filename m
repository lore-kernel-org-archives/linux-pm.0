From: Quentin Armitage <quentin@armitage.org.uk>
Subject: [PATCH] cpufreq: kirkwood: Reinstate cpufreq driver for
 ARCH_KIRKWOOD
Date: Thu, 10 Jul 2014 11:15:55 +0100
Message-ID: <1404987355.23201.65.camel@samson1.armitage.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from rslrsmtp2.opaltelecom.net ([62.24.128.202]:11041 "EHLO
	iprslrsmtp2msp.cpwnetworks.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750966AbaGJK1d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jul 2014 06:27:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Commit ff1f0018cf66080d8e6f59791e552615648a033a ("drivers: Enable
building of Kirkwood drivers for mach-mvebu") added Kirkwood into
mach-mvebu, adding MACH_KIRKWOOD to ARCH_KIRKWOOD in the KConfig files.

The change for ARM_KIRKWOOD_CPUFREQ replaced ARCH_KIRKWOOD with
MACH_KIRKWOOD, whereas all the other changes were ARCH_KIRKWOOD ||
MACH_KIRKWOOD.

As a consequence of this change, the cpufreq driver is no longer enabled
for ARCH_KIRKWOOD. This patch reinstates ARM_KIRKWOOD_CPUFREQ for
ARCH_KIRKWOOD.

Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
---
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index ebac671..24778f0 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -118,7 +118,7 @@ config ARM_INTEGRATOR
          If in doubt, say Y.

 config ARM_KIRKWOOD_CPUFREQ
-       def_bool MACH_KIRKWOOD
+       def_bool ARCH_KIRKWOOD || MACH_KIRKWOOD
        help
          This adds the CPUFreq driver for Marvell Kirkwood
          SoCs.
 





