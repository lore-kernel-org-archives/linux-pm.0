From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 2/2] cpufreq: Remove cpu hotplug callbacks only if they were initialized
Date: Thu, 15 Dec 2016 10:00:58 -0500
Message-ID: <1481814058-4799-3-git-send-email-boris.ostrovsky@oracle.com>
References: <1481814058-4799-1-git-send-email-boris.ostrovsky@oracle.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44927 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756240AbcLOOoa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Dec 2016 09:44:30 -0500
In-Reply-To: <1481814058-4799-1-git-send-email-boris.ostrovsky@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, bigeasy@linutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>

Since cpu hotplug callbacks are requested for CPUHP_AP_ONLINE_DYN state,
successful callback initialization will result in cpuhp_setup_state()
returning a positive value. Therefore acpi_cpufreq_online being zero
indicates that callbacks have not been installed.

This means that acpi_cpufreq_boost_exit() should only remove them if
acpi_cpufreq_online is positive. Trying to call
cpuhp_remove_state_nocalls(0) will cause a BUG().

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/cpufreq/acpi-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 3a98702..3a2ca0f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -930,7 +930,7 @@ static void __init acpi_cpufreq_boost_init(void)
 
 static void acpi_cpufreq_boost_exit(void)
 {
-	if (acpi_cpufreq_online >= 0)
+	if (acpi_cpufreq_online > 0)
 		cpuhp_remove_state_nocalls(acpi_cpufreq_online);
 }
 
-- 
1.7.1

