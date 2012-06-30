From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/8] acpi_pad: fix power_saving thread deadlock
Date: Sat, 30 Jun 2012 01:07:35 -0400
Message-ID: <5f1601261050251a5ca293378b492a69d590dacb.1341032550.git.len.brown@intel.com>
References: <1341032855-27139-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1341032855-27139-1-git-send-email-lenb@kernel.org>
In-Reply-To: <9f132652d94c96476b0b0a8caf0c10e96ab10fa8.1341032550.git.len.brown@intel.com>
References: <9f132652d94c96476b0b0a8caf0c10e96ab10fa8.1341032550.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Stuart Hayes <Stuart_Hayes@Dell.com>
List-Id: linux-pm@vger.kernel.org

From: Stuart Hayes <Stuart_Hayes@Dell.com>

The acpi_pad driver can get stuck in destroy_power_saving_task()
waiting for kthread_stop() to stop a power_saving thread.  The problem
is that the isolated_cpus_lock mutex is owned when
destroy_power_saving_task() calls kthread_stop(), which waits for a
power_saving thread to end, and the power_saving thread tries to
acquire the isolated_cpus_lock when it calls round_robin_cpu().  This
patch fixes the issue by making round_robin_cpu() use its own mutex.

https://bugzilla.kernel.org/show_bug.cgi?id=42981

Cc: stable@vger.kernel.org
Signed-off-by: Stuart Hayes <Stuart_Hayes@Dell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_pad.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index a43fa1a..1502c502 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -36,6 +36,7 @@
 #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
 static DEFINE_MUTEX(isolated_cpus_lock);
+static DEFINE_MUTEX(round_robin_lock);
 
 static unsigned long power_saving_mwait_eax;
 
@@ -107,7 +108,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return;
 
-	mutex_lock(&isolated_cpus_lock);
+	mutex_lock(&round_robin_lock);
 	cpumask_clear(tmp);
 	for_each_cpu(cpu, pad_busy_cpus)
 		cpumask_or(tmp, tmp, topology_thread_cpumask(cpu));
@@ -116,7 +117,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 	if (cpumask_empty(tmp))
 		cpumask_andnot(tmp, cpu_online_mask, pad_busy_cpus);
 	if (cpumask_empty(tmp)) {
-		mutex_unlock(&isolated_cpus_lock);
+		mutex_unlock(&round_robin_lock);
 		return;
 	}
 	for_each_cpu(cpu, tmp) {
@@ -131,7 +132,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 	tsk_in_cpu[tsk_index] = preferred_cpu;
 	cpumask_set_cpu(preferred_cpu, pad_busy_cpus);
 	cpu_weight[preferred_cpu]++;
-	mutex_unlock(&isolated_cpus_lock);
+	mutex_unlock(&round_robin_lock);
 
 	set_cpus_allowed_ptr(current, cpumask_of(preferred_cpu));
 }
-- 
1.7.11.1.104.ge7b44f1
