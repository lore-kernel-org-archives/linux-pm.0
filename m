From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Date: Thu, 3 Jan 2019 12:35:14 +0530
Message-ID: <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Valentin Schneider <valentin.schneider@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>
Cc: nm@ti.com, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Douglas Raillard <Douglas.Raillard@arm.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 20-12-18, 15:27, Valentin Schneider wrote:
> Hi,
> 
> While running some hotplug torture test [1] on my Juno r0 I came across
> the follow splat:
> 
> [  716.561862] ------------[ cut here ]------------
> [  716.566451] refcount_t: underflow; use-after-free.
> [  716.571240] WARNING: CPU: 2 PID: 18 at lib/refcount.c:280 refcount_dec_not_one+0x9c/0xc0
> [  716.579246] Modules linked in:
> [  716.582269] CPU: 2 PID: 18 Comm: cpuhp/2 Not tainted 4.20.0-rc7 #39
> [  716.588469] Hardware name: ARM Juno development board (r0) (DT)
> [  716.594326] pstate: 40000005 (nZcv daif -PAN -UAO)
> [  716.599065] pc : refcount_dec_not_one+0x9c/0xc0
> [  716.603546] lr : refcount_dec_not_one+0x9c/0xc0
> [  716.608024] sp : ffff00000a063c70
> [  716.611299] x29: ffff00000a063c70 x28: 0000000000000000 
> [  716.616555] x27: 0000000000000000 x26: 0000000000000002 
> [  716.621810] x25: ffff000009169000 x24: ffff000008f8e1b0 
> [  716.627065] x23: ffff000008ce0920 x22: 00000000ffffffff 
> [  716.632319] x21: ffff000009169000 x20: ffff8009762a2664 
> [  716.637574] x19: ffff000009294a90 x18: 0000000000000400 
> [  716.642828] x17: 0000000000000000 x16: 0000000000000000 
> [  716.648082] x15: 0000000000000000 x14: 0000000000000400 
> [  716.653336] x13: 000000000000023f x12: 0000000000043705 
> [  716.658590] x11: 0000000000000108 x10: 0000000000000960 
> [  716.663844] x9 : ffff00000a063970 x8 : ffff800976943ec0 
> [  716.669098] x7 : 0000000000000000 x6 : ffff80097ff720b8 
> [  716.674353] x5 : ffff80097ff720b8 x4 : 0000000000000000 
> [  716.679607] x3 : ffff80097ff78e68 x2 : ffff80097ff720b8 
> [  716.684861] x1 : 6374e2a7925c1100 x0 : 0000000000000000 
> [  716.690115] Call trace:
> [  716.692532]  refcount_dec_not_one+0x9c/0xc0
> [  716.696669]  refcount_dec_and_mutex_lock+0x18/0x70
> [  716.701409]  _put_opp_list_kref+0x28/0x50
> [  716.705373]  _dev_pm_opp_find_and_remove_table+0x24/0x88
> [  716.710628]  _dev_pm_opp_cpumask_remove_table+0x50/0xa0
> [  716.715796]  dev_pm_opp_cpumask_remove_table+0x10/0x18
> [  716.720879]  scpi_cpufreq_exit+0x40/0x50
> [  716.724758]  cpufreq_offline+0x108/0x1e0
> [  716.728637]  cpuhp_cpufreq_offline+0xc/0x18

This probably happened due to some of recent OPP core changes and I missed
updating this platform (I updated mvebu though). The problem is completely
different from what you logs show :)

Please try the below patch.

@Sudeep: Please help review it as well.

-- 
viresh

-------------------------8<-------------------------

>From f3913738618031e9d71ebf64461cee22909e6e20 Mon Sep 17 00:00:00 2001
Message-Id: <f3913738618031e9d71ebf64461cee22909e6e20.1546498940.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 3 Jan 2019 12:28:26 +0530
Subject: [PATCH] cpufreq: scpi: Fix freeing of OPPs

Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
_dev_pm_opp_remove_table()"), dynamically created OPP aren't
automatically removed anymore by dev_pm_opp_cpumask_remove_table().

The OPPs for scpi cpufreq driver aren't getting freed currently, fix
that by adding a new callback scpi_ops->remove_device_opps() which will
remove those OPPs.

Cc: 4.20 <stable@vger.kernel.org> # v4.20
Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scpi-cpufreq.c |  4 ++--
 drivers/firmware/arm_scpi.c    | 15 +++++++++++++++
 include/linux/scpi_protocol.h  |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 87a98ec77773..1bfd168de0b2 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -177,7 +177,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	dev_pm_opp_cpumask_remove_table(policy->cpus);
+	scpi_ops->remove_device_opps(cpu_dev);
 
 	return ret;
 }
@@ -190,7 +190,7 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
-	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+	scpi_ops->remove_device_opps(priv->cpu_dev);
 
 	return 0;
 }
diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index c7d06a36b23a..963f2ffbd820 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -716,6 +716,20 @@ static int scpi_dvfs_add_opps_to_device(struct device *dev)
 	return 0;
 }
 
+static void scpi_dvfs_remove_device_opps(struct device *dev)
+{
+	int idx;
+	struct scpi_opp *opp;
+	struct scpi_dvfs_info *info = scpi_dvfs_info(dev);
+
+	/* We already added OPPs successfully, this data can't be invalid */
+	if (WARN_ON(IS_ERR(info) || !info->opps))
+		return;
+
+	for (opp = info->opps, idx = 0; idx < info->count; idx++, opp++)
+		dev_pm_opp_remove(dev, opp->freq);
+}
+
 static int scpi_sensor_get_capability(u16 *sensors)
 {
 	__le16 cap;
@@ -799,6 +813,7 @@ static struct scpi_ops scpi_ops = {
 	.device_domain_id = scpi_dev_domain_id,
 	.get_transition_latency = scpi_dvfs_get_transition_latency,
 	.add_opps_to_device = scpi_dvfs_add_opps_to_device,
+	.remove_device_opps = scpi_dvfs_remove_device_opps,
 	.sensor_get_capability = scpi_sensor_get_capability,
 	.sensor_get_info = scpi_sensor_get_info,
 	.sensor_get_value = scpi_sensor_get_value,
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index 327d65663dbf..d020d517ecaa 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -70,6 +70,7 @@ struct scpi_ops {
 	int (*device_domain_id)(struct device *);
 	int (*get_transition_latency)(struct device *);
 	int (*add_opps_to_device)(struct device *);
+	void (*remove_device_opps)(struct device *);
 	int (*sensor_get_capability)(u16 *sensors);
 	int (*sensor_get_info)(u16 sensor_id, struct scpi_sensor_info *);
 	int (*sensor_get_value)(u16, u64 *);
