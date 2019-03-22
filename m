From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Date: Fri, 22 Mar 2019 20:26:11 +0000
Message-ID: <d16e973c3fa4343134f6d246cc424f29ff5d7dc9.1553285718.git.Janakarajan.Natarajan@amd.com>
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

Newer AMD processors support a subset of the optional CPPC registers.
Create show, store and helper routines for supported CPPC registers.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 119 ++++++++++++++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h |   3 +
 2 files changed, 114 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7cb23b369fc7..f8827ba7015d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -196,6 +196,17 @@ show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, =
nominal_freq);
=20
 show_cppc_data_ro(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data_ro(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, desired_perf);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, max_perf);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, min_perf);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, energy_perf);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, auto_sel_enable);
+
+store_cppc_data_rw(cppc_perf_ctrls, desired_perf, DESIRED_PERF);
+store_cppc_data_rw(cppc_perf_ctrls, max_perf, MAX_PERF);
+store_cppc_data_rw(cppc_perf_ctrls, min_perf, MIN_PERF);
+store_cppc_data_rw(cppc_perf_ctrls, energy_perf, ENERGY_PERF);
+store_cppc_data_rw(cppc_perf_ctrls, auto_sel_enable, AUTO_SEL_ENABLE);
=20
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct attribute *attr, char *buf)
@@ -768,6 +779,21 @@ int set_cppc_attrs(struct cpc_desc *cpc, int entries)
 		case CTR_WRAP_TIME:
 			cppc_attrs[attr_i++] =3D &wraparound_time.attr;
 			break;
+		case MAX_PERF:
+			cppc_attrs[attr_i++] =3D &max_perf.attr;
+			break;
+		case MIN_PERF:
+			cppc_attrs[attr_i++] =3D &min_perf.attr;
+			break;
+		case ENERGY_PERF:
+			cppc_attrs[attr_i++] =3D &energy_perf.attr;
+			break;
+		case AUTO_SEL_ENABLE:
+			cppc_attrs[attr_i++] =3D &auto_sel_enable.attr;
+			break;
+		case DESIRED_PERF:
+			cppc_attrs[attr_i++] =3D &desired_perf.attr;
+			break;
 		}
 	}
=20
@@ -1348,7 +1374,7 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *per=
f_ctrls,
 	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data =3D NULL;
 	struct cpc_register_resource *reg;
-	int ret =3D 0;
+	int ret =3D 0, regs_in_pcc =3D 0;
 	u32 value;
=20
 	if (!cpc_desc) {
@@ -1360,6 +1386,18 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls,
 	case DESIRED_PERF:
 		value =3D perf_ctrls->desired_perf;
 		break;
+	case MAX_PERF:
+		value =3D perf_ctrls->max_perf;
+		break;
+	case MIN_PERF:
+		value =3D perf_ctrls->min_perf;
+		break;
+	case ENERGY_PERF:
+		value =3D perf_ctrls->energy_perf;
+		break;
+	case AUTO_SEL_ENABLE:
+		value =3D perf_ctrls->auto_sel_enable;
+		break;
 	default:
 		pr_debug("CPC register index #%d not writeable\n", reg_idx);
 		return -EINVAL;
@@ -1375,6 +1413,7 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *per=
f_ctrls,
 	 * achieve that goal here
 	 */
 	if (CPC_IN_PCC(reg)) {
+		regs_in_pcc =3D 1;
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1397,13 +1436,10 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *p=
erf_ctrls,
 		cpc_desc->write_cmd_status =3D 0;
 	}
=20
-	/*
-	 * Skip writing MIN/MAX until Linux knows how to come up with
-	 * useful values.
-	 */
-	cpc_write(cpu, reg, value);
+	if (CPC_SUPPORTED(reg))
+		cpc_write(cpu, reg, value);
=20
-	if (CPC_IN_PCC(reg))
+	if (regs_in_pcc)
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
@@ -1451,7 +1487,7 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *per=
f_ctrls,
 	 * case during a CMD_READ and if there are pending writes it delivers
 	 * the write command before servicing the read command
 	 */
-	if (CPC_IN_PCC(reg)) {
+	if (regs_in_pcc) {
 		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
 			/* Update only if there are pending write commands */
 			if (pcc_ss_data->pending_pcc_write_cmd)
@@ -1469,6 +1505,73 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls,
 }
 EXPORT_SYMBOL_GPL(cppc_set_reg);
=20
+int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg, *max_reg, *min_reg;
+	struct cpc_register_resource *energy_reg, *auto_sel_enable_reg;
+	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
+	u64 desired, max, min, energy, auto_sel_enable;
+	struct cppc_pcc_data *pcc_ss_data =3D NULL;
+	int ret =3D 0, regs_in_pcc =3D 0;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU: %d\n", cpu);
+		return -ENODEV;
+	}
+
+	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
+	max_reg =3D &cpc_desc->cpc_regs[MAX_PERF];
+	min_reg =3D &cpc_desc->cpc_regs[MIN_PERF];
+	energy_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
+	auto_sel_enable_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(max_reg) ||
+	    CPC_IN_PCC(min_reg) || CPC_IN_PCC(energy_reg) ||
+	    CPC_IN_PCC(auto_sel_enable_reg)) {
+		pcc_ss_data =3D pcc_data[pcc_ss_id];
+		down_write(&pcc_ss_data->pcc_lock);
+		regs_in_pcc =3D 1;
+
+		/*Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			ret =3D -EIO;
+			goto out_err;
+		}
+	}
+
+	/* desired_perf is the only mandatory value in perf_ctrls */
+	if (cpc_read(cpu, desired_reg, &desired))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(max_reg) && cpc_read(cpu, max_reg, &max))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(min_reg) && cpc_read(cpu, min_reg, &min))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(energy_reg) && cpc_read(cpu, energy_reg, &energy))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(auto_sel_enable_reg) &&
+	    cpc_read(cpu, auto_sel_enable_reg, &auto_sel_enable))
+		ret =3D -EFAULT;
+
+	if (!ret) {
+		perf_ctrls->desired_perf =3D desired;
+		perf_ctrls->max_perf =3D max;
+		perf_ctrls->min_perf =3D min;
+		perf_ctrls->energy_perf =3D energy;
+		perf_ctrls->auto_sel_enable =3D auto_sel_enable;
+	}
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf);
+
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
  *
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index ba3b3fb64572..6f651235933c 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -117,6 +117,8 @@ struct cppc_perf_ctrls {
 	u32 max_perf;
 	u32 min_perf;
 	u32 desired_perf;
+	u32 auto_sel_enable;
+	u32 energy_perf;
 };
=20
 struct cppc_perf_fb_ctrs {
@@ -140,6 +142,7 @@ struct cppc_cpudata {
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
 extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
+extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cppc_cpudata **);
 extern unsigned int cppc_get_transition_latency(int cpu);
--=20
2.17.1
