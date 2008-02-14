From: Yi Yang <yi.y.yang@intel.com>
Subject: [PATCH 2.6.25-rc1] cpufreq: fix cpufreq policy refcount
	imbalance
Date: Fri, 15 Feb 2008 07:44:29 +0800
Message-ID: <1203032669.3897.8.camel__485.226119826798$1203066103$gmane$org@yangyi-dev.bj.intel.com>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	<1201043126.3861.5.camel@yangyi-dev.bj.intel.com>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201043126.3861.5.camel@yangyi-dev.bj.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: akpm@linux-foundation.org, torvalds@linux-foundation.org, gregkh@suse.de
Cc: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, elendil@planet.nl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, yhlu.kernel@gmail.com, mingo@elte.hu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

When one cpu is set to offline, the caller process will hang, according to
the trace data, the problem lies in the refcount error in cpufreq driver,
cpufreq_cpu_callback will wait for completion policy->kobj_unregister
which is nerver completed because a refcount error in function
__cpufreq_remove_dev in file driver/cpufreq/cpufreq.c results in not
calling kobject release method.

In driver/cpufreq/cpufreq.c, the refcount of data->kobj isn't 1 when it
will be unregistered, this problem didn't exist in 2.6.24 and earlier.

The root cause is kobject API switch, kobject_init_and_add and kobject_put
replace older kobject_register and kobject_unregister in 2.6.25-rc1,
compared to 2.6.24, kobject_unregister is deleted in function
__cpufreq_remove_dev but it isn't replaced with kobject_put.

This patch adds kobject_put to balance refcount. I noticed Greg suggests
it will fix a power-off issue to remove kobject_get statement block, but i
think that isn't the best way because those code block has existed very long
and it is helpful because the successive statements are invoking relevant
data.


Signed-off-by: Yi Yang <yi.y.yang@intel.com>
---
 cpufreq.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/cpufreq/cpufreq.c	2008-02-15 04:41:29.000000000 +0800
+++ b/drivers/cpufreq/cpufreq.c	2008-02-15 06:56:56.000000000 +0800
@@ -1057,12 +1057,17 @@ static int __cpufreq_remove_dev (struct 
 
 	unlock_policy_rwsem_write(cpu);
 
+	/* it matches the previous kobject_get */
 	kobject_put(&data->kobj);
 
 	/* we need to make sure that the underlying kobj is actually
 	 * not referenced anymore by anybody before we proceed with
 	 * unloading.
 	 */
+
+	/* unregister data->kobj, it matches kobject_init_and_add */
+	kobject_put(&data->kobj);
+
 	dprintk("waiting for dropping of refcount\n");
 	wait_for_completion(&data->kobj_unregister);
 	dprintk("wait complete\n");
