From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 08/12] powermac: fix G5-cpufreq for cpu on/offline
Date: Wed, 07 Feb 2007 13:45:44 +0100
Message-ID: <20070207124613.702615000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
Content-Disposition: inline; filename=powermac-fix-cpufreq.patch
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: linuxppc-dev@ozlabs.org
Cc: Paul Mackeras <paulus@samba.org>, cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-pm@vger.kernel.org

The original code here is wrong, it applies "previous" knowledge.
The way the cpufreq core is designed is that the policy for the
secondary CPU that comes online says that it must in fact not
use this policy but use the same as the other CPUs that are
listed, which in fact is CPU#0.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Paul Mackeras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: cpufreq@lists.linux.org.uk
Cc: Jacob Shin <jacob.shin@amd.com>

---
Tested on my powermac with suspend-to-disk.
Paul, please apply to powerpc.

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/cpufreq_64.c	2007-02-07 02:54:58.341884289 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/cpufreq_64.c	2007-02-07 02:55:34.023884289 +0100
@@ -357,13 +357,13 @@ static unsigned int g5_cpufreq_get_speed
 
 static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	if (policy->cpu != 0)
-		return -ENODEV;
-
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	policy->cur = g5_cpu_freqs[g5_query_freq()].frequency;
-	policy->cpus = cpu_possible_map;
+	/* secondary CPUs are tied to the primary one by the
+	 * cpufreq core if in the secondary policy we tell it that
+	 * it actually must be one policy together with all others. */
+	policy->cpus = cpu_online_map;
 	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
 
 	return cpufreq_frequency_table_cpuinfo(policy,

--
