From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v3 PATCH 3/3] powernv-cpufreq: Treat pstates as opaque 8-bit values
Date: Wed, 13 Dec 2017 12:27:41 +0530
Message-ID: <1513148261-21097-4-git-send-email-ego@linux.vnet.ibm.com>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, viresh.kumar@linaro.org, rjw@rjwysocki.net, huntbag@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On POWER8 and POWER9, the PMSR and the PMCR registers define pstates
to be 8-bit wide values. The device-tree exports pstates as 32-bit
wide values of which the lower byte is the actual pstate.

The current implementation in the kernel treats pstates as integer
type, since it used to use the sign of the pstate for performing some
boundary-checks. This is no longer required after the patch
"powernv-cpufreq: Fix pstate_to_idx() to handle non-continguous
pstates".

So, in this patch, we modify the powernv-cpufreq driver to uniformly
treat pstates as opaque 8-bit values obtained from the device-tree or
the PMCR. This simplifies the extract_pstate() helper function since
we no longer no longer require to worry about the sign-extentions.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 47 ++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 8e3dbca..8a4e2ce 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -110,12 +110,11 @@ struct global_pstate_info {
  *	    hashtable
  */
 struct pstate_idx_revmap_data {
-	int pstate_id;
+	u8 pstate_id;
 	unsigned int cpufreq_table_idx;
 	struct hlist_node hentry;
 };
 
-u32 pstate_sign_prefix;
 static bool rebooting, throttled, occ_reset;
 
 static const char * const throttle_reason[] = {
@@ -170,14 +169,9 @@ enum throttle_reason_type {
 	bool wof_enabled;
 } powernv_pstate_info;
 
-static inline int extract_pstate(u64 pmsr_val, unsigned int shift)
+static inline u8 extract_pstate(u64 pmsr_val, unsigned int shift)
 {
-	int ret = ((pmsr_val >> shift) & 0xFF);
-
-	if (!ret)
-		return ret;
-
-	return (pstate_sign_prefix | ret);
+	return ((pmsr_val >> shift) & 0xFF);
 }
 
 #define extract_local_pstate(x) extract_pstate(x, LPSTATE_SHIFT)
@@ -194,7 +188,7 @@ static inline int extract_pstate(u64 pmsr_val, unsigned int shift)
  *		   If @i is out of bound, this will return the pstate
  *		   corresponding to the nominal frequency.
  */
-static inline int idx_to_pstate(unsigned int i)
+static inline u8 idx_to_pstate(unsigned int i)
 {
 	if (unlikely(i >= powernv_pstate_info.nr_pstates)) {
 		pr_warn_once("idx_to_pstate: index %u is out of bound\n", i);
@@ -213,7 +207,7 @@ static inline int idx_to_pstate(unsigned int i)
  *		   this will return the index of the nominal
  *		   frequency.
  */
-static unsigned int pstate_to_idx(int pstate)
+static unsigned int pstate_to_idx(u8 pstate)
 {
 	unsigned int key = pstate % POWERNV_MAX_PSTATES;
 	struct pstate_idx_revmap_data *revmap_data;
@@ -223,7 +217,7 @@ static unsigned int pstate_to_idx(int pstate)
 			return revmap_data->cpufreq_table_idx;
 	}
 
-	pr_warn_once("pstate_to_idx: pstate %d not found\n", pstate);
+	pr_warn_once("pstate_to_idx: pstate 0x%x not found\n", pstate);
 	return powernv_pstate_info.nominal;
 }
 
@@ -291,7 +285,7 @@ static int init_powernv_pstates(void)
 		powernv_pstate_info.wof_enabled = true;
 
 next:
-	pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
+	pr_info("cpufreq pstate min 0x%x nominal 0x%x max 0x%x\n", pstate_min,
 		pstate_nominal, pstate_max);
 	pr_info("Workload Optimized Frequency is %s in the platform\n",
 		(powernv_pstate_info.wof_enabled) ? "enabled" : "disabled");
@@ -323,8 +317,6 @@ static int init_powernv_pstates(void)
 	powernv_pstate_info.nr_pstates = nr_pstates;
 	pr_debug("NR PStates %d\n", nr_pstates);
 
-	pstate_sign_prefix = pstate_min & ~0xFF;
-
 	for (i = 0; i < nr_pstates; i++) {
 		u32 id = be32_to_cpu(pstate_ids[i]);
 		u32 freq = be32_to_cpu(pstate_freqs[i]);
@@ -333,14 +325,14 @@ static int init_powernv_pstates(void)
 
 		pr_debug("PState id %d freq %d MHz\n", id, freq);
 		powernv_freqs[i].frequency = freq * 1000; /* kHz */
-		powernv_freqs[i].driver_data = id;
+		powernv_freqs[i].driver_data = id & 0xFF;
 
 		revmap_data = (struct pstate_idx_revmap_data *)
 			      kmalloc(sizeof(*revmap_data), GFP_KERNEL);
 
-		revmap_data->pstate_id = id;
+		revmap_data->pstate_id = id & 0xFF;
 		revmap_data->cpufreq_table_idx = i;
-		key = id % POWERNV_MAX_PSTATES;
+		key = (revmap_data->pstate_id) % POWERNV_MAX_PSTATES;
 		hash_add(pstate_revmap, &revmap_data->hentry, key);
 
 		if (id == pstate_max)
@@ -364,14 +356,13 @@ static int init_powernv_pstates(void)
 }
 
 /* Returns the CPU frequency corresponding to the pstate_id. */
-static unsigned int pstate_id_to_freq(int pstate_id)
+static unsigned int pstate_id_to_freq(u8 pstate_id)
 {
 	int i;
 
 	i = pstate_to_idx(pstate_id);
 	if (i >= powernv_pstate_info.nr_pstates || i < 0) {
-		pr_warn("PState id %d outside of PState table, "
-			"reporting nominal id %d instead\n",
+		pr_warn("PState id 0x%x outside of PState table, reporting nominal id 0x%x instead\n",
 			pstate_id, idx_to_pstate(powernv_pstate_info.nominal));
 		i = powernv_pstate_info.nominal;
 	}
@@ -477,8 +468,8 @@ static inline void set_pmspr(unsigned long sprn, unsigned long val)
  */
 struct powernv_smp_call_data {
 	unsigned int freq;
-	int pstate_id;
-	int gpstate_id;
+	u8 pstate_id;
+	u8 gpstate_id;
 };
 
 /*
@@ -501,9 +492,9 @@ static void powernv_read_cpu_freq(void *arg)
 	freq_data->pstate_id = extract_local_pstate(pmspr_val);
 	freq_data->freq = pstate_id_to_freq(freq_data->pstate_id);
 
-	pr_debug("cpu %d pmsr %016lX pstate_id %d frequency %d kHz\n",
-		raw_smp_processor_id(), pmspr_val, freq_data->pstate_id,
-		freq_data->freq);
+	pr_debug("cpu %d pmsr %016lX pstate_id 0x%x frequency %d kHz\n",
+		 raw_smp_processor_id(), pmspr_val, freq_data->pstate_id,
+		 freq_data->freq);
 }
 
 /*
@@ -565,7 +556,7 @@ static void powernv_cpufreq_throttle_check(void *data)
 	struct chip *chip;
 	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
-	int pmsr_pmax;
+	u8 pmsr_pmax;
 	unsigned int pmsr_pmax_idx;
 
 	pmsr = get_pmspr(SPRN_PMSR);
@@ -579,7 +570,7 @@ static void powernv_cpufreq_throttle_check(void *data)
 			goto next;
 		chip->throttled = true;
 		if (pmsr_pmax_idx > powernv_pstate_info.nominal) {
-			pr_warn_once("CPU %d on Chip %u has Pmax(%d) reduced below nominal frequency(%d)\n",
+			pr_warn_once("CPU %d on Chip %u has Pmax(0x%x) reduced below that of nominal frequency(0x%x)\n",
 				     cpu, chip->id, pmsr_pmax,
 				     idx_to_pstate(powernv_pstate_info.nominal));
 			chip->throttle_sub_turbo++;
-- 
1.9.4
