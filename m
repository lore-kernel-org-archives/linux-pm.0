From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 6/6] acpi/cppc: Add support for CPPC Enable register
Date: Fri, 22 Mar 2019 20:26:13 +0000
Message-ID: <7e20fe2349bff1dc14c477c5bb456b8b1cde2994.1553285718.git.Janakarajan.Natarajan@amd.com>
References: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "Ghannam, Yazen" <Yazen.Ghannam@amd.com>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
List-Id: linux-pm@vger.kernel.org

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

To enable CPPC on a processor, the OS should write a value "1" to the
CPPC Enable register. Add support for this register.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 96 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  1 +
 2 files changed, 97 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f8827ba7015d..8c6804976bb8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -224,6 +224,43 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj=
,
 }
 define_one_cppc_ro(feedback_ctrs);
=20
+/* Used to move ENABLE register value between userspace and platform */
+static bool cppc_cpu_enable;
+
+static ssize_t show_enable(struct kobject *kobj,
+			   struct attribute *attr,
+			   char *buf)
+{
+	struct cpc_desc *cpc_ptr =3D to_cpc_desc(kobj);
+	int ret;
+
+	ret =3D cppc_get_enable(cpc_ptr->cpu_id);
+	if (ret)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", cppc_cpu_enable);
+}
+
+static ssize_t store_enable(struct kobject *kobj,
+			    struct attribute *attr,
+			    const char *c, ssize_t count)
+{
+	struct cpc_desc *cpc_ptr =3D to_cpc_desc(kobj);
+	int ret;
+
+	ret =3D kstrtobool(c, &cppc_cpu_enable);
+	if (ret)
+		return ret;
+
+	ret =3D cppc_set_reg(cpc_ptr->cpu_id, NULL, ENABLE);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+define_one_cppc_rw(enable);
+
 static struct kobj_type cppc_ktype =3D {
 	.sysfs_ops =3D &kobj_sysfs_ops,
 };
@@ -794,6 +831,9 @@ int set_cppc_attrs(struct cpc_desc *cpc, int entries)
 		case DESIRED_PERF:
 			cppc_attrs[attr_i++] =3D &desired_perf.attr;
 			break;
+		case ENABLE:
+			cppc_attrs[attr_i++] =3D &enable.attr;
+			break;
 		}
 	}
=20
@@ -1383,6 +1423,9 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *per=
f_ctrls,
 	}
=20
 	switch (reg_idx) {
+	case ENABLE:
+		value =3D cppc_cpu_enable;
+		break;
 	case DESIRED_PERF:
 		value =3D perf_ctrls->desired_perf;
 		break;
@@ -1572,6 +1615,59 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *p=
erf_ctrls)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf);
=20
+/**
+ * cppc_get_enable - Read a CPUs enable register.
+ * @cpu: CPU from which to read control values.
+ *
+ * Return: 0 for success.
+ */
+int cppc_get_enable(int cpu)
+{
+	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
+	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *enable_reg;
+	struct cppc_pcc_data *pcc_ss_data =3D NULL;
+	int ret =3D 0, regs_in_pcc =3D 0;
+	u64 enable;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU: %d\n", cpu);
+		return -ENODEV;
+	}
+
+	enable_reg =3D &cpc_desc->cpc_regs[ENABLE];
+
+	if (!CPC_SUPPORTED(enable_reg)) {
+		pr_warn("CPC ENABLE register not supported.\n");
+		return -ENOTSUPP;
+	}
+
+	if (CPC_IN_PCC(enable_reg)) {
+		pcc_ss_data =3D pcc_data[pcc_ss_id];
+		down_write(&pcc_ss_data->pcc_lock);
+		regs_in_pcc =3D 1;
+		/* Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			ret =3D -EIO;
+			goto out_err;
+		}
+	}
+
+	if (cpc_read(cpu, enable_reg, &enable)) {
+		ret =3D -EFAULT;
+		goto out_err;
+	}
+
+	cppc_cpu_enable =3D enable;
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_enable);
+
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
  *
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 6f651235933c..fcdedff8e6bd 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -139,6 +139,7 @@ struct cppc_cpudata {
 	cpumask_var_t shared_cpu_map;
 };
=20
+extern int cppc_get_enable(int cpu);
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
 extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
--=20
2.17.1
