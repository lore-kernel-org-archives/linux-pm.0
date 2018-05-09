From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 3/8] firmware: arm_scmi: rename get_transition_latency and
 add_opps_to_device
Date: Wed,  9 May 2018 18:07:09 +0100
Message-ID: <1525885634-22348-4-git-send-email-sudeep.holla@arm.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Most of the scmi code follows the suggestion from Greg KH on a totally
different thread[0] to have the subsystem name first, followed by the
noun and finally the verb with couple of these exceptions.

This patch fixes them so that all the functions names are aligned to
on practice.

[0] https://www.spinics.net/lists/arm-kernel/msg583673.html

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c   |  4 ++--
 drivers/firmware/arm_scmi/perf.c | 10 +++++-----
 include/linux/scmi_protocol.h    | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index b4dbc77459b6..50b1551ba894 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -117,7 +117,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = handle->perf_ops->add_opps_to_device(handle, cpu_dev);
+	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
 	if (ret) {
 		dev_warn(cpu_dev, "failed to add opps to the device\n");
 		return ret;
@@ -164,7 +164,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
-	latency = handle->perf_ops->get_transition_latency(handle, cpu_dev);
+	latency = handle->perf_ops->transition_latency_get(handle, cpu_dev);
 	if (!latency)
 		latency = CPUFREQ_ETERNAL;
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 987c64d19801..611ab08e6174 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -349,8 +349,8 @@ static int scmi_dev_domain_id(struct device *dev)
 	return clkspec.args[0];
 }
 
-static int scmi_dvfs_add_opps_to_device(const struct scmi_handle *handle,
-					struct device *dev)
+static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
+				     struct device *dev)
 {
 	int idx, ret, domain;
 	unsigned long freq;
@@ -383,7 +383,7 @@ static int scmi_dvfs_add_opps_to_device(const struct scmi_handle *handle,
 	return 0;
 }
 
-static int scmi_dvfs_get_transition_latency(const struct scmi_handle *handle,
+static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
 					    struct device *dev)
 {
 	struct perf_dom_info *dom;
@@ -432,8 +432,8 @@ static struct scmi_perf_ops perf_ops = {
 	.level_set = scmi_perf_level_set,
 	.level_get = scmi_perf_level_get,
 	.device_domain_id = scmi_dev_domain_id,
-	.get_transition_latency = scmi_dvfs_get_transition_latency,
-	.add_opps_to_device = scmi_dvfs_add_opps_to_device,
+	.transition_latency_get = scmi_dvfs_transition_latency_get,
+	.device_opps_add = scmi_dvfs_device_opps_add,
 	.freq_set = scmi_dvfs_freq_set,
 	.freq_get = scmi_dvfs_freq_get,
 };
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index a171c1e293e8..f4c9fc0fc755 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -85,8 +85,8 @@ struct scmi_clk_ops {
  * @level_set: sets the performance level of a domain
  * @level_get: gets the performance level of a domain
  * @device_domain_id: gets the scmi domain id for a given device
- * @get_transition_latency: gets the DVFS transition latency for a given device
- * @add_opps_to_device: adds all the OPPs for a given device
+ * @transition_latency_get: gets the DVFS transition latency for a given device
+ * @device_opps_add: adds all the OPPs for a given device
  * @freq_set: sets the frequency for a given device using sustained frequency
  *	to sustained performance level mapping
  * @freq_get: gets the frequency for a given device using sustained frequency
@@ -102,10 +102,10 @@ struct scmi_perf_ops {
 	int (*level_get)(const struct scmi_handle *handle, u32 domain,
 			 u32 *level, bool poll);
 	int (*device_domain_id)(struct device *dev);
-	int (*get_transition_latency)(const struct scmi_handle *handle,
+	int (*transition_latency_get)(const struct scmi_handle *handle,
 				      struct device *dev);
-	int (*add_opps_to_device)(const struct scmi_handle *handle,
-				  struct device *dev);
+	int (*device_opps_add)(const struct scmi_handle *handle,
+			       struct device *dev);
 	int (*freq_set)(const struct scmi_handle *handle, u32 domain,
 			unsigned long rate, bool poll);
 	int (*freq_get)(const struct scmi_handle *handle, u32 domain,
-- 
2.7.4
