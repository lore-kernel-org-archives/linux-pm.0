From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Thu, 10 Sep 2015 23:36:57 +0200
Message-ID: <1725227.VMGKuhRxma@vostro.rjw.lan>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org> <11470100.cEo24Tpcgr@vostro.rjw.lan> <20150910012222.GN5266@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50570 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751018AbbIJVJF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 17:09:05 -0400
In-Reply-To: <20150910012222.GN5266@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On Thursday, September 10, 2015 06:52:22 AM Viresh Kumar wrote:
> On 10-09-15, 03:41, Rafael J. Wysocki wrote:
> > I see one.  That unfortunately is the acpi-cpufreq driver, but it still is one.
> 
> Hmm..
> 
> > Well, cpufreq_generic_get() does _get_raw(), so I suppose acpi-cpufreq may
> > do that too?
> 
> Yeah, it can.

OK, so let's make that change.

BTW, I wonder how much of the stuff in cpufreq.h can be moved to a local header
under drivers/cpufreq/.  It looks like the majority of it is not used by
anybody else.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: cpufreq: acpi-cpufreq: Use cpufreq_cpu_get_raw() in ->get()

cpufreq_cpu_get() called by get_cur_freq_on_cpu() is overkill,
because the ->get() callback is always invoked in a context in
which all of the conditions checked by cpufreq_cpu_get() are
guaranteed to be satisfied.

Use cpufreq_cpu_get_raw() instead of it and drop the
corresponding cpufreq_cpu_put() from get_cur_freq_on_cpu().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |    3 +--
 drivers/cpufreq/cpufreq.c      |    2 +-
 include/linux/cpufreq.h        |    5 +++++
 3 files changed, 7 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -375,12 +375,11 @@ static unsigned int get_cur_freq_on_cpu(
 
 	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
 
-	policy = cpufreq_cpu_get(cpu);
+	policy = cpufreq_cpu_get_raw(cpu);
 	if (unlikely(!policy))
 		return 0;
 
 	data = policy->driver_data;
-	cpufreq_cpu_put(policy);
 	if (unlikely(!data || !data->freq_table))
 		return 0;
 
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -238,13 +238,13 @@ int cpufreq_generic_init(struct cpufreq_
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_init);
 
-/* Only for cpufreq core internal use */
 struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
 	return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
 }
+EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
 
 unsigned int cpufreq_generic_get(unsigned int cpu)
 {
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -129,9 +129,14 @@ struct cpufreq_policy {
 #define CPUFREQ_SHARED_TYPE_ANY	 (3) /* Freq can be set from any dependent CPU*/
 
 #ifdef CONFIG_CPU_FREQ
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
 void cpufreq_cpu_put(struct cpufreq_policy *policy);
 #else
+static inline struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
+{
+	return NULL;
+}
 static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 {
 	return NULL;

