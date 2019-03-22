From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 3/6] acpi/cppc: Rework cppc_set_perf() to use cppc_regs index
Date: Fri, 22 Mar 2019 20:26:08 +0000
Message-ID: <13617b46c2ed526ffa614c39d50cd32d58fc3c3b.1553285718.git.Janakarajan.Natarajan@amd.com>
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

The cppc_set_perf() currently only works for DESIRED_PERF. To make it
generic, pass in the index of the register being accessed.

Also, rename cppc_set_perf() to cppc_set_reg(). This is in preparation
for it to be used for more than just the DESIRED_PERF register.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c       | 36 ++++++++++++++++++++++------------
 drivers/cpufreq/cppc_cpufreq.c |  6 +++---
 include/acpi/cppc_acpi.h       |  2 +-
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9daeb0b034d5..e81c19316628 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -60,7 +60,7 @@ struct cppc_pcc_data {
 	/*
 	 * Lock to provide controlled access to the PCC channel.
 	 *
-	 * For performance critical usecases(currently cppc_set_perf)
+	 * For performance-critical usecases(currently cppc_set_reg)
 	 *	We need to take read_lock and check if channel belongs to OSPM
 	 * before reading or writing to PCC subspace
 	 *	We need to take write_lock before transferring the channel
@@ -1303,26 +1303,38 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs)
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
=20
 /**
- * cppc_set_perf - Set a CPUs performance controls.
- * @cpu: CPU for which to set performance controls.
+ * cppc_set_reg - Set the CPUs control register.
+ * @cpu: CPU for which to set the register.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ * @reg_idx: Index of the register being accessed
  *
  * Return: 0 for success, -ERRNO otherwise.
  */
-int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls,
+		 enum cppc_regs reg_idx)
 {
 	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *desired_reg;
 	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data =3D NULL;
+	struct cpc_register_resource *reg;
 	int ret =3D 0;
+	u32 value;
=20
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
=20
-	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
+	switch (reg_idx) {
+	case DESIRED_PERF:
+		value =3D perf_ctrls->desired_perf;
+		break;
+	default:
+		pr_debug("CPC register index #%d not writeable\n", reg_idx);
+		return -EINVAL;
+	}
+
+	reg =3D &cpc_desc->cpc_regs[reg_idx];
=20
 	/*
 	 * This is Phase-I where we want to write to CPC registers
@@ -1331,7 +1343,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	 * Since read_lock can be acquired by multiple CPUs simultaneously we
 	 * achieve that goal here
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1358,14 +1370,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *=
perf_ctrls)
 	 * Skip writing MIN/MAX until Linux knows how to come up with
 	 * useful values.
 	 */
-	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+	cpc_write(cpu, reg, value);
=20
-	if (CPC_IN_PCC(desired_reg))
+	if (CPC_IN_PCC(reg))
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
 	 *
-	 * Short Summary: Basically if we think of a group of cppc_set_perf
+	 * Short Summary: Basically if we think of a group of cppc_set_reg
 	 * requests that happened in short overlapping interval. The last CPU to
 	 * come out of Phase-I will enter Phase-II and ring the doorbell.
 	 *
@@ -1408,7 +1420,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	 * case during a CMD_READ and if there are pending writes it delivers
 	 * the write command before servicing the read command
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(reg)) {
 		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
 			/* Update only if there are pending write commands */
 			if (pcc_ss_data->pending_pcc_write_cmd)
@@ -1424,7 +1436,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_set_perf);
+EXPORT_SYMBOL_GPL(cppc_set_reg);
=20
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.=
c
index 2ae978d27e61..420bd44f6958 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -211,7 +211,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_polic=
y *policy,
 	freqs.new =3D target_freq;
=20
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret =3D cppc_set_perf(cpu->cpu, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu->cpu, &cpu->perf_ctrls, DESIRED_PERF);
 	cpufreq_freq_transition_end(policy, &freqs, ret !=3D 0);
=20
 	if (ret)
@@ -235,7 +235,7 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy=
 *policy)
=20
 	cpu->perf_ctrls.desired_perf =3D cpu->perf_caps.lowest_perf;
=20
-	ret =3D cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu_num, &cpu->perf_ctrls, DESIRED_PERF);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 				cpu->perf_caps.lowest_perf, cpu_num, ret);
@@ -348,7 +348,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy =
*policy)
 					cpu->perf_caps.highest_perf);
 	cpu->perf_ctrls.desired_perf =3D cpu->perf_caps.highest_perf;
=20
-	ret =3D cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu_num, &cpu->perf_ctrls, DESIRED_PERF);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 				cpu->perf_caps.highest_perf, cpu_num, ret);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index ba6fd7202775..ba3b3fb64572 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -139,7 +139,7 @@ struct cppc_cpudata {
=20
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
-extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cppc_cpudata **);
 extern unsigned int cppc_get_transition_latency(int cpu);
--=20
2.17.1
