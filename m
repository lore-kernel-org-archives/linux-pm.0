From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] intel_pstate: Clean up intel_pstate_get()
Date: Sat, 07 May 2016 02:24:48 +0200
Message-ID: <6744251.0XRRsX0MUN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60866 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758971AbcEGAVe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 20:21:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

intel_pstate_get() contains a local variable that's initialized but
never used and it can be written in fewer lines of code, so clean
it up.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1390,14 +1390,9 @@ static int intel_pstate_init_cpu(unsigne
 
 static unsigned int intel_pstate_get(unsigned int cpu_num)
 {
-	struct sample *sample;
-	struct cpudata *cpu;
+	struct cpudata *cpu = all_cpu_data[cpu_num];
 
-	cpu = all_cpu_data[cpu_num];
-	if (!cpu)
-		return 0;
-	sample = &cpu->sample;
-	return get_avg_frequency(cpu);
+	return cpu ? get_avg_frequency(cpu) : 0;
 }
 
 static void intel_pstate_set_update_util_hook(unsigned int cpu_num)

