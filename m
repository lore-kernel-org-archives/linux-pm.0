From: Quentin Perret <quentin.perret@arm.com>
Subject: [RFC PATCH v3 04/10] PM / EM: Expose the Energy Model in sysfs
Date: Mon, 21 May 2018 15:24:59 +0100
Message-ID: <20180521142505.6522-5-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

This exposes the Energy Model (read-only) of all frequency domains in
sysfs for convenience. To do so, a parent kobject is added to the CPU
subsystem under the umbrella of which a kobject for each frequency
domain is attached.

The resulting hierarchy is as follows for a platform with two frequency
domains for example:

   /sys/devices/system/cpu/energy_model
   ├── fd0
   │   ├── capacity
   │   ├── cpus
   │   ├── frequency
   │   └── power
   └── fd4
       ├── capacity
       ├── cpus
       ├── frequency
       └── power

In this implementation, the kobject abstraction is only used as a
convenient way of exposing data to sysfs. However, it could also be
used in the future to allocate and release frequency domains in a more
dynamic way using reference counting.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h |  1 +
 kernel/power/energy_model.c  | 94 ++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index edde888852ba..ed79903a9721 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -24,6 +24,7 @@ struct em_cs_table {
 struct em_freq_domain {
 	struct em_cs_table *cs_table;
 	cpumask_t cpus;
+	struct kobject kobj;
 };
 
 struct em_data_callback {
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index a2eece7007a8..6ad53f1cf7e6 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -29,6 +29,86 @@ static DEFINE_RWLOCK(em_data_lock);
  */
 static DEFINE_MUTEX(em_fd_mutex);
 
+static struct kobject *em_kobject;
+
+/* Getters for the attributes of em_freq_domain objects */
+struct em_fd_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct em_freq_domain *fd, char *buf);
+	ssize_t (*store)(struct em_freq_domain *fd, const char *buf, size_t s);
+};
+
+#define EM_ATTR_LEN 13
+#define show_table_attr(_attr) \
+static ssize_t show_##_attr(struct em_freq_domain *fd, char *buf) \
+{ \
+	ssize_t cnt = 0; \
+	int i; \
+	struct em_cs_table *table; \
+	rcu_read_lock(); \
+	table = rcu_dereference(fd->cs_table);\
+	for (i = 0; i < table->nr_cap_states; i++) { \
+		if (cnt >= (ssize_t) (PAGE_SIZE / sizeof(char) \
+				      - (EM_ATTR_LEN + 2))) \
+			goto out; \
+		cnt += scnprintf(&buf[cnt], EM_ATTR_LEN + 1, "%lu ", \
+				 table->state[i]._attr); \
+	} \
+out: \
+	rcu_read_unlock(); \
+	cnt += sprintf(&buf[cnt], "\n"); \
+	return cnt; \
+}
+
+show_table_attr(power);
+show_table_attr(frequency);
+show_table_attr(capacity);
+
+static ssize_t show_cpus(struct em_freq_domain *fd, char *buf)
+{
+	return sprintf(buf, "%*pbl\n", cpumask_pr_args(&fd->cpus));
+}
+
+#define fd_attr(_name) em_fd_##_name##_attr
+#define define_fd_attr(_name) static struct em_fd_attr fd_attr(_name) = \
+		__ATTR(_name, 0444, show_##_name, NULL)
+
+define_fd_attr(power);
+define_fd_attr(frequency);
+define_fd_attr(capacity);
+define_fd_attr(cpus);
+
+static struct attribute *em_fd_default_attrs[] = {
+	&fd_attr(power).attr,
+	&fd_attr(frequency).attr,
+	&fd_attr(capacity).attr,
+	&fd_attr(cpus).attr,
+	NULL
+};
+
+#define to_fd(k) container_of(k, struct em_freq_domain, kobj)
+#define to_fd_attr(a) container_of(a, struct em_fd_attr, attr)
+
+static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct em_freq_domain *fd = to_fd(kobj);
+	struct em_fd_attr *fd_attr = to_fd_attr(attr);
+	ssize_t ret;
+
+	ret = fd_attr->show(fd, buf);
+
+	return ret;
+}
+
+static const struct sysfs_ops em_fd_sysfs_ops = {
+	.show	= show,
+};
+
+static struct kobj_type ktype_em_fd = {
+	.sysfs_ops	= &em_fd_sysfs_ops,
+	.default_attrs	= em_fd_default_attrs,
+};
+
 static struct em_cs_table *alloc_cs_table(int nr_states)
 {
 	struct em_cs_table *cs_table;
@@ -114,6 +194,11 @@ static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
 	}
 	fd_update_cs_table(fd->cs_table, cpu);
 
+	ret = kobject_init_and_add(&fd->kobj, &ktype_em_fd, em_kobject, "fd%u",
+									cpu);
+	if (ret)
+		pr_warn("%*pbl: failed kobject init\n", cpumask_pr_args(span));
+
 	return fd;
 
 free_cs_table:
@@ -221,6 +306,15 @@ int em_register_freq_domain(cpumask_t *span, unsigned int nr_states,
 
 	mutex_lock(&em_fd_mutex);
 
+	if (!em_kobject) {
+		em_kobject = kobject_create_and_add("energy_model",
+						&cpu_subsys.dev_root->kobj);
+		if (!em_kobject) {
+			ret = -ENODEV;
+			goto unlock;
+		}
+	}
+
 	/* Make sure we don't register again an existing domain. */
 	for_each_cpu(cpu, span) {
 		if (per_cpu(em_data, cpu)) {
-- 
2.17.0
