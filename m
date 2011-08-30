From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 5/5] PM / Domains: Add default power off
	governor function
Date: Wed, 31 Aug 2011 00:22:43 +0200
Message-ID: <201108310022.43850.rjw__1826.1109515608$1314847014$gmane$org@sisk.pl>
References: <201108310017.03103.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108310017.03103.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Add a function deciding whether or not a given PM domain should
be powered off on the basis of that domain's devices' PM QoS
constraints.

---
 drivers/base/power/domain_governor.c |   96 +++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h            |    7 ++
 2 files changed, 103 insertions(+)

Index: linux/include/linux/pm_domain.h
===================================================================
--- linux.orig/include/linux/pm_domain.h
+++ linux/include/linux/pm_domain.h
@@ -49,6 +49,10 @@ struct generic_pm_domain {
 	int (*start_device)(struct device *dev);
 	int (*stop_device)(struct device *dev);
 	bool (*active_wakeup)(struct device *dev);
+	ktime_t power_off_latency;
+	ktime_t power_on_latency;
+	s64 break_even_ns;
+	s64 min_delta_ns;
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
@@ -64,6 +68,9 @@ struct gpd_link {
 };
 
 struct gpd_gov_dev_data {
+	ktime_t start_latency;
+	ktime_t suspend_latency;
+	ktime_t resume_latency;
 	s64 break_even_ns;
 };
 
Index: linux/drivers/base/power/domain_governor.c
===================================================================
--- linux.orig/drivers/base/power/domain_governor.c
+++ linux/drivers/base/power/domain_governor.c
@@ -35,6 +35,102 @@ static bool default_stop_ok(struct devic
 	return constraint_ns > gov_data->break_even_ns;
 }
 
+/* This routine must be executed under the PM domain's lock. */
+static bool default_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct gpd_link *link;
+	struct pm_domain_data *pdd;
+	ktime_t off_time, on_time;
+	s64 delta_ns, min_delta_ns;
+
+	on_time = genpd->power_on_latency;
+	/* Check if slave domains can be off for enough time. */
+	delta_ns = ktime_to_ns(ktime_add(genpd->power_off_latency, on_time));
+	min_delta_ns = 0;
+	/* All slave domains have been powered off at this point. */
+	list_for_each_entry(link, &genpd->master_links, master_node) {
+		if (delta_ns > link->slave->min_delta_ns)
+			return false;
+
+		delta_ns = link->slave->min_delta_ns - delta_ns;
+		if (delta_ns < min_delta_ns)
+			min_delta_ns = delta_ns;
+	}
+
+	genpd->min_delta_ns = min_delta_ns;
+
+	/* Compute the total time needed to power off the domain. */
+	off_time = ktime_set(0, 0);
+	/* All devices have been stopped at this point. */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		struct gpd_gov_dev_data *gov_data;
+
+		if (!pdd->dev->driver)
+			continue;
+
+		gov_data = to_gpd_data(pdd)->gov_data;
+		if (!gov_data)
+			continue;
+
+		off_time = ktime_add(off_time, gov_data->suspend_latency);
+	}
+	off_time = ktime_add(off_time, genpd->power_off_latency);
+
+	/*
+	 * For each device in the domain compute the difference between the
+	 * QoS value and the total time required to bring the device back
+	 * assuming that the domain will be powered off and compute the minimum
+	 * of those.
+	 */
+	min_delta_ns = 0;
+	on_time = ktime_add(on_time, off_time);
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		struct gpd_gov_dev_data *gov_data;
+		struct device *dev = pdd->dev;
+		ktime_t dev_up_time;
+		s32 constraint;
+		s64 constraint_ns;
+
+		if (!dev->driver)
+			continue;
+
+		gov_data = to_gpd_data(pdd)->gov_data;
+		if (gov_data) {
+			dev_up_time = ktime_add(on_time,
+						gov_data->resume_latency);
+			dev_up_time = ktime_add(dev_up_time,
+						gov_data->start_latency);
+		} else {
+			dev_up_time = on_time;
+		}
+
+		constraint = dev_pm_qos_read_value(dev);
+		if (constraint < 0)
+			return false;
+		else if (constraint == 0) /* 0 means "don't care" */
+			continue;
+
+		constraint_ns = constraint;
+		constraint_ns *= NSEC_PER_USEC;
+		delta_ns = constraint_ns - ktime_to_ns(dev_up_time);
+		if (min_delta_ns > delta_ns)
+			min_delta_ns = delta_ns;
+	}
+
+	/* Compare the computed delta with the break even value. */
+	if (min_delta_ns < genpd->break_even_ns)
+		return false;
+
+	/* Store the computed value for the masters to use. */
+	if (genpd->min_delta_ns > min_delta_ns)
+		genpd->min_delta_ns = min_delta_ns;
+
+	/* The domain can be powered off. */
+	return true;
+}
+
 struct dev_power_governor default_qos_governor = {
 	.stop_ok = default_stop_ok,
+	.power_down_ok = default_power_down_ok,
 };
