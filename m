From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 4/5] cpupower: rework the "cpupower frequency-info" command
Date: Tue,  1 Dec 2015 17:14:16 +0100
Message-ID: <1448986457-12844-5-git-send-email-trenn@suse.com>
References: <1448986457-12844-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49859 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755704AbbLAQOW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Dec 2015 11:14:22 -0500
In-Reply-To: <1448986457-12844-1-git-send-email-trenn@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Jacob Tanenbaum <jtanenba@redhat.com>, Thomas Renninger <trenn@suse.com>

From: Jacob Tanenbaum <jtanenba@redhat.com>

this patch makes two changes to the way that "cpupower
frequancy-info" operates

1. make it so that querying individual values always returns a
   message to the user

currently cpupower frequency info doesn't return anything to the user when
querying an individual value cannot be returned

[root@amd-dinar-09 cpupower]# cpupower -c 4 frequency-info -d
analyzing CPU 4:
[root@amd-dinar-09 cpupower]#

I added messages so that each query prints a message to the terminal

[root@amd-dinar-09 cpupower]# ./cpupower -c 4 frequency-info -d
analyzing CPU 4:
  no or unknown cpufreq driver is active on this CPU
[root@amd-dinar-09 cpupower]#

(this is just one example)

2. change debug_output_one() to use the functions already provided
   by cpufreq-info.c to query individual values of interest.

Signed-off-by: Jacob Tanenbaum <jtanenba@redhat.com>
Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 235 +++++++++++-------------------
 1 file changed, 88 insertions(+), 147 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 522b357..c13bc8c 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -245,149 +245,21 @@ static int get_boost_mode(unsigned int cpu)
 	return 0;
 }
 
-static void debug_output_one(unsigned int cpu)
-{
-	char *driver;
-	struct cpufreq_affected_cpus *cpus;
-	struct cpufreq_available_frequencies *freqs;
-	unsigned long min, max, freq_kernel, freq_hardware;
-	unsigned long total_trans, latency;
-	unsigned long long total_time;
-	struct cpufreq_policy *policy;
-	struct cpufreq_available_governors *governors;
-	struct cpufreq_stats *stats;
-
-	if (cpufreq_cpu_exists(cpu))
-		return;
-
-	freq_kernel = cpufreq_get_freq_kernel(cpu);
-	freq_hardware = cpufreq_get_freq_hardware(cpu);
-
-	driver = cpufreq_get_driver(cpu);
-	if (!driver) {
-		printf(_("  no or unknown cpufreq driver is active on this CPU\n"));
-	} else {
-		printf(_("  driver: %s\n"), driver);
-		cpufreq_put_driver(driver);
-	}
-
-	cpus = cpufreq_get_related_cpus(cpu);
-	if (cpus) {
-		printf(_("  CPUs which run at the same hardware frequency: "));
-		while (cpus->next) {
-			printf("%d ", cpus->cpu);
-			cpus = cpus->next;
-		}
-		printf("%d\n", cpus->cpu);
-		cpufreq_put_related_cpus(cpus);
-	}
-
-	cpus = cpufreq_get_affected_cpus(cpu);
-	if (cpus) {
-		printf(_("  CPUs which need to have their frequency coordinated by software: "));
-		while (cpus->next) {
-			printf("%d ", cpus->cpu);
-			cpus = cpus->next;
-		}
-		printf("%d\n", cpus->cpu);
-		cpufreq_put_affected_cpus(cpus);
-	}
-
-	latency = cpufreq_get_transition_latency(cpu);
-	if (latency) {
-		printf(_("  maximum transition latency: "));
-		print_duration(latency);
-		printf(".\n");
-	}
-
-	if (!(cpufreq_get_hardware_limits(cpu, &min, &max))) {
-		printf(_("  hardware limits: "));
-		print_speed(min);
-		printf(" - ");
-		print_speed(max);
-		printf("\n");
-	}
-
-	freqs = cpufreq_get_available_frequencies(cpu);
-	if (freqs) {
-		printf(_("  available frequency steps: "));
-		while (freqs->next) {
-			print_speed(freqs->frequency);
-			printf(", ");
-			freqs = freqs->next;
-		}
-		print_speed(freqs->frequency);
-		printf("\n");
-		cpufreq_put_available_frequencies(freqs);
-	}
-
-	governors = cpufreq_get_available_governors(cpu);
-	if (governors) {
-		printf(_("  available cpufreq governors: "));
-		while (governors->next) {
-			printf("%s, ", governors->governor);
-			governors = governors->next;
-		}
-		printf("%s\n", governors->governor);
-		cpufreq_put_available_governors(governors);
-	}
-
-	policy = cpufreq_get_policy(cpu);
-	if (policy) {
-		printf(_("  current policy: frequency should be within "));
-		print_speed(policy->min);
-		printf(_(" and "));
-		print_speed(policy->max);
-
-		printf(".\n                  ");
-		printf(_("The governor \"%s\" may"
-		       " decide which speed to use\n                  within this range.\n"),
-		       policy->governor);
-		cpufreq_put_policy(policy);
-	}
-
-	if (freq_kernel || freq_hardware) {
-		printf(_("  current CPU frequency is "));
-		if (freq_hardware) {
-			print_speed(freq_hardware);
-			printf(_(" (asserted by call to hardware)"));
-		} else
-			print_speed(freq_kernel);
-		printf(".\n");
-	}
-	stats = cpufreq_get_stats(cpu, &total_time);
-	if (stats) {
-		printf(_("  cpufreq stats: "));
-		while (stats) {
-			print_speed(stats->frequency);
-			printf(":%.2f%%", (100.0 * stats->time_in_state) / total_time);
-			stats = stats->next;
-			if (stats)
-				printf(", ");
-		}
-		cpufreq_put_stats(stats);
-		total_trans = cpufreq_get_transitions(cpu);
-		if (total_trans)
-			printf("  (%lu)\n", total_trans);
-		else
-			printf("\n");
-	}
-	get_boost_mode(cpu);
-
-}
-
 /* --freq / -f */
 
 static int get_freq_kernel(unsigned int cpu, unsigned int human)
 {
 	unsigned long freq = cpufreq_get_freq_kernel(cpu);
-	if (!freq)
+	printf(_("  current CPU frequency: "));
+	if (!freq) {
+		printf(_(" Unable to call to kernel\n"));
 		return -EINVAL;
+	}
 	if (human) {
 		print_speed(freq);
-		printf("\n");
 	} else
-		printf("%lu\n", freq);
+		printf("%lu", freq);
+	printf(_(" (asserted by call to kernel)\n"));
 	return 0;
 }
 
@@ -397,13 +269,16 @@ static int get_freq_kernel(unsigned int cpu, unsigned int human)
 static int get_freq_hardware(unsigned int cpu, unsigned int human)
 {
 	unsigned long freq = cpufreq_get_freq_hardware(cpu);
-	if (!freq)
+	printf(_("  current CPU frequency: "));
+	if (!freq) {
+		printf("Unable to call hardware\n");
 		return -EINVAL;
+	}
 	if (human) {
 		print_speed(freq);
-		printf("\n");
 	} else
-		printf("%lu\n", freq);
+		printf("%lu", freq);
+	printf(_(" (asserted by call to hardware)\n"));
 	return 0;
 }
 
@@ -412,9 +287,17 @@ static int get_freq_hardware(unsigned int cpu, unsigned int human)
 static int get_hardware_limits(unsigned int cpu)
 {
 	unsigned long min, max;
-	if (cpufreq_get_hardware_limits(cpu, &min, &max))
+
+	printf(_("  hardware limits: "));
+	if (cpufreq_get_hardware_limits(cpu, &min, &max)) {
+		printf(_("Not Available\n"));
 		return -EINVAL;
-	printf("%lu %lu\n", min, max);
+	}
+
+	print_speed(min);
+	printf(" - ");
+	print_speed(max);
+	printf("\n");
 	return 0;
 }
 
@@ -423,9 +306,11 @@ static int get_hardware_limits(unsigned int cpu)
 static int get_driver(unsigned int cpu)
 {
 	char *driver = cpufreq_get_driver(cpu);
-	if (!driver)
+	if (!driver) {
+		printf(_("  no or unknown cpufreq driver is active on this CPU\n"));
 		return -EINVAL;
-	printf("%s\n", driver);
+	}
+	printf("  driver: %s\n", driver);
 	cpufreq_put_driver(driver);
 	return 0;
 }
@@ -435,9 +320,19 @@ static int get_driver(unsigned int cpu)
 static int get_policy(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_get_policy(cpu);
-	if (!policy)
+	if (!policy) {
+		printf(_("  Unable to determine current policy\n"));
 		return -EINVAL;
-	printf("%lu %lu %s\n", policy->min, policy->max, policy->governor);
+	}
+	printf(_("  current policy: frequency should be within "));
+	print_speed(policy->min);
+	printf(_(" and "));
+	print_speed(policy->max);
+
+	printf(".\n                  ");
+	printf(_("The governor \"%s\" may decide which speed to use\n"
+	       "                  within this range.\n"),
+	       policy->governor);
 	cpufreq_put_policy(policy);
 	return 0;
 }
@@ -448,8 +343,12 @@ static int get_available_governors(unsigned int cpu)
 {
 	struct cpufreq_available_governors *governors =
 		cpufreq_get_available_governors(cpu);
-	if (!governors)
+
+	printf(_("  available cpufreq governors: "));
+	if (!governors) {
+		printf(_("Not Available\n"));
 		return -EINVAL;
+	}
 
 	while (governors->next) {
 		printf("%s ", governors->governor);
@@ -466,8 +365,12 @@ static int get_available_governors(unsigned int cpu)
 static int get_affected_cpus(unsigned int cpu)
 {
 	struct cpufreq_affected_cpus *cpus = cpufreq_get_affected_cpus(cpu);
-	if (!cpus)
+
+	printf(_("  CPUs which need to have their frequency coordinated by software: "));
+	if (!cpus) {
+		printf(_("Not Available\n"));
 		return -EINVAL;
+	}
 
 	while (cpus->next) {
 		printf("%d ", cpus->cpu);
@@ -483,8 +386,12 @@ static int get_affected_cpus(unsigned int cpu)
 static int get_related_cpus(unsigned int cpu)
 {
 	struct cpufreq_affected_cpus *cpus = cpufreq_get_related_cpus(cpu);
-	if (!cpus)
+
+	printf(_("  CPUs which run at the same hardware frequency: "));
+	if (!cpus) {
+		printf(_("Not Available\n"));
 		return -EINVAL;
+	}
 
 	while (cpus->next) {
 		printf("%d ", cpus->cpu);
@@ -525,8 +432,12 @@ static int get_freq_stats(unsigned int cpu, unsigned int human)
 static int get_latency(unsigned int cpu, unsigned int human)
 {
 	unsigned long latency = cpufreq_get_transition_latency(cpu);
-	if (!latency)
+
+	printf(_("  maximum transition latency: "));
+	if (!latency) {
+		printf(_(" Cannot determine latency.\n"));
 		return -EINVAL;
+	}
 
 	if (human) {
 		print_duration(latency);
@@ -536,6 +447,36 @@ static int get_latency(unsigned int cpu, unsigned int human)
 	return 0;
 }
 
+static void debug_output_one(unsigned int cpu)
+{
+	struct cpufreq_available_frequencies *freqs;
+
+	get_driver(cpu);
+	get_related_cpus(cpu);
+	get_affected_cpus(cpu);
+	get_latency(cpu, 1);
+	get_hardware_limits(cpu);
+
+	freqs = cpufreq_get_available_frequencies(cpu);
+	if (freqs) {
+		printf(_("  available frequency steps:  "));
+		while (freqs->next) {
+			print_speed(freqs->frequency);
+			printf(", ");
+			freqs = freqs->next;
+		}
+		print_speed(freqs->frequency);
+		printf("\n");
+		cpufreq_put_available_frequencies(freqs);
+	}
+
+	get_available_governors(cpu);
+	get_policy(cpu);
+	if (get_freq_hardware(cpu, 1) < 0)
+		get_freq_kernel(cpu, 1);
+	get_boost_mode(cpu);
+}
+
 static struct option info_opts[] = {
 	{"debug",	 no_argument,		 NULL,	 'e'},
 	{"boost",	 no_argument,		 NULL,	 'b'},
-- 
2.1.4

