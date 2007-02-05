From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 10/10] powermac: fix G5-cpufreq for cpu on/offline
Date: Mon, 05 Feb 2007 19:30:37 +0100
Message-ID: <20070205185838.837935000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=powermac-fix-cpufreq.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org, cpufreq list <cpufreq@lists.linux.org.uk>, Torrance <torrance123@gmail.com>, Jacob Shin <jacob.shin@amd.com>
List-Id: linux-pm@vger.kernel.org

The original code here is wrong, it applies "previous" knowledge.
The way the cpufreq core is designed is that the policy for the
secondary CPU that comes online says that it must in fact not
use this policy but use the same as the other CPUs that are
listed, which in fact is CPU#0.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: cpufreq list <cpufreq@lists.linux.org.uk>
Cc: Jacob Shin <jacob.shin@amd.com>

---
Not tested yet but from what Jacob said this should work.

--- mb-wireless.orig/arch/powerpc/platforms/powermac/cpufreq_64.c	2007-02-0=
5 18:41:35.414524763 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/cpufreq_64.c	2007-02-05 19:=
08:53.994524763 +0100
@@ -357,13 +357,13 @@ static unsigned int g5_cpufreq_get_speed
 =

 static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	if (policy->cpu !=3D 0)
-		return -ENODEV;
-
 	policy->governor =3D CPUFREQ_DEFAULT_GOVERNOR;
 	policy->cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
 	policy->cur =3D g5_cpu_freqs[g5_query_freq()].frequency;
-	policy->cpus =3D cpu_possible_map;
+	/* secondary CPUs are tied to the primary one by the
+	 * cpufreq core if in the secondary policy we tell it that
+	 * it actually must be one policy together with all others. */
+	policy->cpus =3D cpu_online_map;
 	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
 =

 	return cpufreq_frequency_table_cpuinfo(policy,

--
