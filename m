From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 7/7] cpufreq: Perform light-weight init/teardown during
 suspend/resume
Date: Tue, 30 Jul 2013 04:25:25 +0530
Message-ID: <20130729225519.20863.61030.stgit@srivatsabhat.in.ibm.com>
References: <20130729225213.20863.56722.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130729225213.20863.56722.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, viresh.kumar@linaro.org, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com
Cc: stern@rowland.harvard.edu, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that we have the infrastructure to perform a light-weight init/tear-down,
use that in the cpufreq CPU hotplug notifier when invoked from the
suspend/resume path.

This also ensures that the file permissions of the cpufreq sysfs files are
preserved across suspend/resume, something which commit a66b2e (cpufreq:
Preserve sysfs files across suspend/resume) originally intended to do, but
had to be reverted due to other problems.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/cpufreq.c       |   18 +++++++++++-------
 drivers/cpufreq/cpufreq_stats.c |    2 --
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4c5ad4a..170d344 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2028,22 +2028,26 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
 {
 	unsigned int cpu = (unsigned long)hcpu;
 	struct device *dev;
+	bool frozen = false;
 
 	dev = get_cpu_device(cpu);
 	if (dev) {
-		switch (action) {
+
+		if (action & CPU_TASKS_FROZEN)
+			frozen = true;
+
+		switch (action & ~CPU_TASKS_FROZEN) {
 		case CPU_ONLINE:
-		case CPU_ONLINE_FROZEN:
-			cpufreq_add_dev(dev, NULL);
+			__cpufreq_add_dev(dev, NULL, frozen);
 			cpufreq_update_policy(cpu);
 			break;
+
 		case CPU_DOWN_PREPARE:
-		case CPU_DOWN_PREPARE_FROZEN:
-			__cpufreq_remove_dev(dev, NULL, false);
+			__cpufreq_remove_dev(dev, NULL, frozen);
 			break;
+
 		case CPU_DOWN_FAILED:
-		case CPU_DOWN_FAILED_FROZEN:
-			cpufreq_add_dev(dev, NULL);
+			__cpufreq_add_dev(dev, NULL, frozen);
 			break;
 		}
 	}
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index bc73be2..cb38413 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -349,11 +349,9 @@ static int cpufreq_stat_cpu_callback(struct notifier_block *nfb,
 
 	switch (action) {
 	case CPU_DOWN_PREPARE:
-	case CPU_DOWN_PREPARE_FROZEN:
 		cpufreq_stats_free_sysfs(cpu);
 		break;
 	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
 		cpufreq_stats_free_table(cpu);
 		break;
 	}
