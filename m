From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/7] cpufreq: Do not update related_cpus on every policy activation
Date: Mon, 27 Jul 2015 16:06:54 +0200
Message-ID: <3102455.P3lingtaHD@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <3874727.Jpay9zgokc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3874727.Jpay9zgokc@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The related_cpus mask includes CPUs whose cpufreq_cpu_data per-CPU
pointers have been set to the given policy.  Since those pointers
are only set at the policy creation time and unset when the policy
is deleted, the related_cpus should not be updated between those
two operations.

For this reason, avoid updating it whenever the first of the
"related" CPUs goes online.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1251,12 +1251,12 @@ static int cpufreq_add_dev(struct device
 
 	down_write(&policy->rwsem);
 
-	/* related cpus should atleast have policy->cpus */
-	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
-
-	/* Remember which CPUs have been present at the policy creation time. */
-	if (!recover_policy)
+	if (!recover_policy) {
+		/* related_cpus should at least include policy->cpus. */
+		cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
+		/* Remember CPUs present at the policy creation time. */
 		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
+	}
 
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
