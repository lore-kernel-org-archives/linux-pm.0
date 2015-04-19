From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable
Date: Sat, 18 Apr 2015 20:53:15 -0400
Message-ID: <87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33266 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbDSAxa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:53:30 -0400
In-Reply-To: <1429404795-23260-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Default behavior unchanged.

cpu_up() has a hard-coded mdelay(10).  Change that to a variable,
with default CONFIG_X86_INIT_MDELAY
and a boot-time override, "cpu_init_mdelay=N"

This patch adds mechanism without changing default policy.
Default policy will be changed in a subsequent patch.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |  7 +++++++
 arch/x86/Kconfig                    | 15 +++++++++++++++
 arch/x86/kernel/smpboot.c           | 16 +++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index bfcb1a6..ec98968 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -737,6 +737,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
+	cpu_init_mdelay=N
+			[X86] Delay for N millisec between assert and de-assert
+			of APIC INIT to start processor.  In most configurations,
+			this occurs once for every CPU upon boot, and online,
+			such as resume from suspend and resume from hibernate.
+			Default: 10
+
 	cpcihp_generic=	[HW,PCI] Generic port I/O CompactPCI driver
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b7d31ca..d2a91da 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,6 +884,21 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
+config X86_INIT_MDELAY
+	int "Milliseconds to wait to de-assert INIT upon CPU startup" if SMP
+	range 0 10
+	default "10"
+	---help---
+	  This allows you to specify how long the BSP will delay
+	  between asserting INIT and de-asserting INIT when starting another CPU.
+	  This delay is paid on each cpu-online operation, including boot-time,
+	  resume from suspend, and resume from hibernate.  The the value of
+	  10 millisec was specified by Multi-Processor Spec 1.4 in 1997.
+	  But modern hardware does not require any delay.
+
+	  The kernel boot-time parameter "cpu_init_mdelay="
+	  will over-ride this build-time default.
+
 source "kernel/Kconfig.preempt"
 
 config UP_LATE_INIT
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index febc6aa..973621f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -555,6 +555,20 @@ wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
 	return (send_status | accept_status);
 }
 
+unsigned int x86_init_mdelay = CONFIG_X86_INIT_MDELAY;
+static int __init cpu_init_mdelay(char *str)
+{
+	unsigned int tmp;
+
+	get_option(&str, &tmp);
+	pr_info("x86_init_mdelay set to %d, was %d", tmp, x86_init_mdelay);
+	x86_init_mdelay = tmp;
+	return 0;
+}
+
+early_param("cpu_init_mdelay", cpu_init_mdelay);
+
+
 static int
 wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 {
@@ -586,7 +600,7 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 	pr_debug("Waiting for send to finish...\n");
 	send_status = safe_apic_wait_icr_idle();
 
-	mdelay(10);
+	mdelay(x86_init_mdelay);
 
 	pr_debug("Deasserting INIT\n");
 
-- 
2.4.0.rc1

