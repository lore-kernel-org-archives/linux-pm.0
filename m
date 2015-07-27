From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6/7] cpufreq: Pass CPU number to cpufreq_policy_alloc()
Date: Mon, 27 Jul 2015 16:07:49 +0200
Message-ID: <1673228.0qyRKCRMJQ@vostro.rjw.lan>
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

Change cpufreq_policy_alloc() to take a CPU number instead of a CPU
device pointer as its argument, as it is the only function called by
cpufreq_add_dev() taking a device pointer argument at this point.

That will allow us to split the CPU online part from cpufreq_add_dev()
more cleanly going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1090,11 +1090,15 @@ static int cpufreq_add_policy_cpu(struct
 	return 0;
 }
 
-static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
+static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
+	struct device *dev = get_cpu_device(cpu);
 	struct cpufreq_policy *policy;
 	int ret;
 
+	if (WARN_ON(!dev))
+		return NULL;
+
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
 		return NULL;
@@ -1122,10 +1126,10 @@ static struct cpufreq_policy *cpufreq_po
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
 
-	policy->cpu = dev->id;
+	policy->cpu = cpu;
 
 	/* Set this once on allocation */
-	policy->kobj_cpu = dev->id;
+	policy->kobj_cpu = cpu;
 
 	return policy;
 
@@ -1233,7 +1237,7 @@ static int cpufreq_add_dev(struct device
 		up_write(&policy->rwsem);
 	} else {
 		recover_policy = false;
-		policy = cpufreq_policy_alloc(dev);
+		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
 			return -ENOMEM;
 	}
