Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62239937C;
	Fri, 17 Jul 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281360; cv=none; b=ZvoZKh3oTKcbhzXPPAlHX9si6q1iKNysE+RX/kf0kKpkNCRc9/PQwUXQwPmra1d7wC4NosU8HkES2kbj6xJpLgmxoz6PH56fpdyyXFQxKebf2UmjsFZtxvgjgDOR1rzM0mPyzJeLp+ATwJPXqtDqhKMUmTLtDky+KUJ3CEm6gaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281360; c=relaxed/simple;
	bh=LATwzIv2NadJsqcYyL4N51kwnPnXXpLKyhGHaX5+vQI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qv3+EXD3XijXqQEQo74uLcdFH4Uh25mkzkDVt4ecb36POxsFX6ig5Cd0V5XD8OTRiyC6aHlXFCStSkxagtiJ8hMfz89WMq3QzBpaaygsNxcmsxAy+Oz0cbylRj6+hHpVldqyuDaQzhB8R3IfHt90Y6YBGLW2C44bdBahvgRn9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBffKPD4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ym5wg2a5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBffKPD4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ym5wg2a5"
Date: Fri, 17 Jul 2026 09:42:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784281355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjQZbQDl34BX3Jchzo6Vuicu7ZVMGR4kLm08swdrKRI=;
	b=qBffKPD4qMo3gP4LEA/UNxanjJMQkh2zJLJ9ga5896CugDSJR3pcRv37VTM4WL3sTB03VF
	3yCVLKGK3F9pe/spS5R9BDmPKKHEPPqnMpMonN/XYEgUHaEt6HB7XSccHf8uWPJtYnZ565
	aVzYKwkS1HaOnnzEg7N4nsXjyJfENeP42BJTTLjHcpgSuWmQxVc8N8RxWqhDpM2at8cvw3
	EqIFC4spxsREXtCpjkBsFoPKQFSgVUuepG+GxU+Db4S57hrN6O/ANfxZXOLja6vahFPAcE
	Ol3u7jk+KpSHCbgfTleAyuUGvY+Ya0eGRCqdsIDJ3+GJ5oChFNikRg/O48R20g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784281355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjQZbQDl34BX3Jchzo6Vuicu7ZVMGR4kLm08swdrKRI=;
	b=ym5wg2a5UsKmpWY28m2hJW1PFTuXNEuub+PLqDohZs0iqFvkE8du47UVwsJWhNT92SaiOd
	f4kkqLBBmcDVR7Bg==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] cpufreq: Stop using 32-bit MSR interfaces
Cc: Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260703112445.1763078-1-jgross@suse.com>
References: <20260703112445.1763078-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178428135385.1844600.122695507470455180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     e8caa0abfbf0283874582e8160cef5fca845ffb8
Gitweb:        https://git.kernel.org/tip/e8caa0abfbf0283874582e8160cef5fca84=
5ffb8
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 03 Jul 2026 13:24:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 Jul 2026 11:31:25 +02:00

cpufreq: Stop using 32-bit MSR interfaces

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
removed. Use the related 64-bit variants instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Link: https://patch.msgid.link/20260703112445.1763078-1-jgross@suse.com
---
 drivers/cpufreq/acpi-cpufreq.c       | 22 ++++----
 drivers/cpufreq/e_powersaver.c       | 49 ++++++++---------
 drivers/cpufreq/longhaul.c           | 15 ++---
 drivers/cpufreq/longrun.c            | 77 +++++++++++++--------------
 drivers/cpufreq/powernow-k6.c        | 12 ++--
 drivers/cpufreq/powernow-k8.c        | 67 +++++++++++------------
 drivers/cpufreq/speedstep-centrino.c | 16 +++---
 drivers/cpufreq/speedstep-lib.c      | 63 +++++++++++-----------
 8 files changed, 164 insertions(+), 157 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9..10ea603 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -246,32 +246,32 @@ static unsigned extract_freq(struct cpufreq_policy *pol=
icy, u32 val)
=20
 static u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
 {
-	u32 val, dummy __always_unused;
+	u64 val;
=20
-	rdmsr(MSR_IA32_PERF_CTL, val, dummy);
-	return val;
+	rdmsrq(MSR_IA32_PERF_CTL, val);
+	return (u32)val;
 }
=20
 static void cpu_freq_write_intel(struct acpi_pct_register *not_used, u32 val)
 {
-	u32 lo, hi;
+	u64 msrval;
=20
-	rdmsr(MSR_IA32_PERF_CTL, lo, hi);
-	lo =3D (lo & ~INTEL_MSR_RANGE) | (val & INTEL_MSR_RANGE);
-	wrmsr(MSR_IA32_PERF_CTL, lo, hi);
+	rdmsrq(MSR_IA32_PERF_CTL, msrval);
+	msrval =3D (msrval & ~(u64)INTEL_MSR_RANGE) | (val & INTEL_MSR_RANGE);
+	wrmsrq(MSR_IA32_PERF_CTL, msrval);
 }
=20
 static u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
 {
-	u32 val, dummy __always_unused;
+	u64 val;
=20
-	rdmsr(MSR_AMD_PERF_CTL, val, dummy);
-	return val;
+	rdmsrq(MSR_AMD_PERF_CTL, val);
+	return (u32)val;
 }
=20
 static void cpu_freq_write_amd(struct acpi_pct_register *not_used, u32 val)
 {
-	wrmsr(MSR_AMD_PERF_CTL, val, 0);
+	wrmsrq(MSR_AMD_PERF_CTL, val);
 }
=20
 static u32 cpu_freq_read_io(struct acpi_pct_register *reg)
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index eb5a920..54689eb 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -90,7 +90,7 @@ static int eps_acpi_exit(struct cpufreq_policy *policy)
 static unsigned int eps_get(unsigned int cpu)
 {
 	struct eps_cpu_data *centaur;
-	u32 lo, hi;
+	u64 val;
=20
 	if (cpu)
 		return 0;
@@ -99,50 +99,50 @@ static unsigned int eps_get(unsigned int cpu)
 		return 0;
=20
 	/* Return current frequency */
-	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
-	return centaur->fsb * ((lo >> 8) & 0xff);
+	rdmsrq(MSR_IA32_PERF_STATUS, val);
+	return centaur->fsb * ((val >> 8) & 0xff);
 }
=20
 static int eps_set_state(struct eps_cpu_data *centaur,
 			 struct cpufreq_policy *policy,
 			 u32 dest_state)
 {
-	u32 lo, hi;
+	u64 val;
 	int i;
=20
 	/* Wait while CPU is busy */
-	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
+	rdmsrq(MSR_IA32_PERF_STATUS, val);
 	i =3D 0;
-	while (lo & ((1 << 16) | (1 << 17))) {
+	while (val & ((1 << 16) | (1 << 17))) {
 		udelay(16);
-		rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
+		rdmsrq(MSR_IA32_PERF_STATUS, val);
 		i++;
 		if (unlikely(i > 64)) {
 			return -ENODEV;
 		}
 	}
 	/* Set new multiplier and voltage */
-	wrmsr(MSR_IA32_PERF_CTL, dest_state & 0xffff, 0);
+	wrmsrq(MSR_IA32_PERF_CTL, dest_state & 0xffff);
 	/* Wait until transition end */
 	i =3D 0;
 	do {
 		udelay(16);
-		rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
+		rdmsrq(MSR_IA32_PERF_STATUS, val);
 		i++;
 		if (unlikely(i > 64)) {
 			return -ENODEV;
 		}
-	} while (lo & ((1 << 16) | (1 << 17)));
+	} while (val & ((1 << 16) | (1 << 17)));
=20
 #ifdef DEBUG
 	{
 	u8 current_multiplier, current_voltage;
=20
 	/* Print voltage and multiplier */
-	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
-	current_voltage =3D lo & 0xff;
+	rdmsrq(MSR_IA32_PERF_STATUS, val);
+	current_voltage =3D val & 0xff;
 	pr_info("Current voltage =3D %dmV\n", current_voltage * 16 + 700);
-	current_multiplier =3D (lo >> 8) & 0xff;
+	current_multiplier =3D (val >> 8) & 0xff;
 	pr_info("Current multiplier =3D %d\n", current_multiplier);
 	}
 #endif
@@ -171,7 +171,6 @@ static int eps_target(struct cpufreq_policy *policy, unsi=
gned int index)
 static int eps_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int i;
-	u32 lo, hi;
 	u64 val;
 	u8 current_multiplier, current_voltage;
 	u8 max_multiplier, max_voltage;
@@ -195,13 +194,13 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
=20
 	switch (c->x86_model) {
 	case 10:
-		rdmsr(0x1153, lo, hi);
-		brand =3D (((lo >> 2) ^ lo) >> 18) & 3;
+		rdmsrq(0x1153, val);
+		brand =3D (((val >> 2) ^ val) >> 18) & 3;
 		pr_cont("Model A ");
 		break;
 	case 13:
-		rdmsr(0x1154, lo, hi);
-		brand =3D (((lo >> 4) ^ (lo >> 2))) & 0x000000ff;
+		rdmsrq(0x1154, val);
+		brand =3D (((val >> 4) ^ (val >> 2))) & 0x000000ff;
 		pr_cont("Model D ");
 		break;
 	}
@@ -237,20 +236,20 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	}
=20
 	/* Print voltage and multiplier */
-	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
-	current_voltage =3D lo & 0xff;
+	rdmsrq(MSR_IA32_PERF_STATUS, val);
+	current_voltage =3D val & 0xff;
 	pr_info("Current voltage =3D %dmV\n", current_voltage * 16 + 700);
-	current_multiplier =3D (lo >> 8) & 0xff;
+	current_multiplier =3D (val >> 8) & 0xff;
 	pr_info("Current multiplier =3D %d\n", current_multiplier);
=20
 	/* Print limits */
-	max_voltage =3D hi & 0xff;
+	max_voltage =3D (val >> 32) & 0xff;
 	pr_info("Highest voltage =3D %dmV\n", max_voltage * 16 + 700);
-	max_multiplier =3D (hi >> 8) & 0xff;
+	max_multiplier =3D (val >> 40) & 0xff;
 	pr_info("Highest multiplier =3D %d\n", max_multiplier);
-	min_voltage =3D (hi >> 16) & 0xff;
+	min_voltage =3D (val >> 48) & 0xff;
 	pr_info("Lowest voltage =3D %dmV\n", min_voltage * 16 + 700);
-	min_multiplier =3D (hi >> 24) & 0xff;
+	min_multiplier =3D (val >> 56) & 0xff;
 	pr_info("Lowest multiplier =3D %d\n", min_multiplier);
=20
 	/* Sanity checks */
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index a18d1d1..4c25992 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -118,13 +118,14 @@ static unsigned int calc_speed(int mult)
=20
 static int longhaul_get_cpu_mult(void)
 {
-	unsigned long invalue =3D 0, lo, hi;
+	unsigned long invalue =3D 0;
+	u64 val;
=20
-	rdmsr(MSR_IA32_EBL_CR_POWERON, lo, hi);
-	invalue =3D (lo & (1<<22|1<<23|1<<24|1<<25))>>22;
+	rdmsrq(MSR_IA32_EBL_CR_POWERON, val);
+	invalue =3D (val & (1<<22|1<<23|1<<24|1<<25))>>22;
 	if (longhaul_version =3D=3D TYPE_LONGHAUL_V2 ||
 	    longhaul_version =3D=3D TYPE_POWERSAVER) {
-		if (lo & (1<<27))
+		if (val & (1<<27))
 			invalue +=3D 16;
 	}
 	return eblcr[invalue];
@@ -761,7 +762,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *polic=
y)
 	struct cpuinfo_x86 *c =3D &cpu_data(0);
 	char *cpuname =3D NULL;
 	int ret;
-	u32 lo, hi;
+	u64 val;
=20
 	/* Check what we have on this motherboard */
 	switch (c->x86_model) {
@@ -835,8 +836,8 @@ static int longhaul_cpu_init(struct cpufreq_policy *polic=
y)
 	}
 	/* Check Longhaul ver. 2 */
 	if (longhaul_version =3D=3D TYPE_LONGHAUL_V2) {
-		rdmsr(MSR_VIA_LONGHAUL, lo, hi);
-		if (lo =3D=3D 0 && hi =3D=3D 0)
+		rdmsrq(MSR_VIA_LONGHAUL, val);
+		if (val =3D=3D 0)
 			/* Looks like MSR isn't present */
 			longhaul_version =3D TYPE_LONGHAUL_V1;
 	}
diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index f3aaca0..82a7bb6 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -35,27 +35,27 @@ static unsigned int longrun_low_freq, longrun_high_freq;
  */
 static void longrun_get_policy(struct cpufreq_policy *policy)
 {
-	u32 msr_lo, msr_hi;
+	struct msr msr;
=20
-	rdmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
-	pr_debug("longrun flags are %x - %x\n", msr_lo, msr_hi);
-	if (msr_lo & 0x01)
+	rdmsrq(MSR_TMTA_LONGRUN_FLAGS, msr.q);
+	pr_debug("longrun flags are %x - %x\n", msr.l, msr.h);
+	if (msr.l & 0x01)
 		policy->policy =3D CPUFREQ_POLICY_PERFORMANCE;
 	else
 		policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
=20
-	rdmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
-	pr_debug("longrun ctrl is %x - %x\n", msr_lo, msr_hi);
-	msr_lo &=3D 0x0000007F;
-	msr_hi &=3D 0x0000007F;
+	rdmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
+	pr_debug("longrun ctrl is %x - %x\n", msr.l, msr.h);
+	msr.l &=3D 0x0000007F;
+	msr.h &=3D 0x0000007F;
=20
 	if (longrun_high_freq <=3D longrun_low_freq) {
 		/* Assume degenerate Longrun table */
 		policy->min =3D policy->max =3D longrun_high_freq;
 	} else {
-		policy->min =3D longrun_low_freq + msr_lo *
+		policy->min =3D longrun_low_freq + msr.l *
 			((longrun_high_freq - longrun_low_freq) / 100);
-		policy->max =3D longrun_low_freq + msr_hi *
+		policy->max =3D longrun_low_freq + msr.h *
 			((longrun_high_freq - longrun_low_freq) / 100);
 	}
 	policy->cpu =3D 0;
@@ -71,7 +71,7 @@ static void longrun_get_policy(struct cpufreq_policy *polic=
y)
  */
 static int longrun_set_policy(struct cpufreq_policy *policy)
 {
-	u32 msr_lo, msr_hi;
+	struct msr msr;
 	u32 pctg_lo, pctg_hi;
=20
 	if (!policy)
@@ -93,24 +93,24 @@ static int longrun_set_policy(struct cpufreq_policy *poli=
cy)
 		pctg_lo =3D pctg_hi;
=20
 	/* performance or economy mode */
-	rdmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
-	msr_lo &=3D 0xFFFFFFFE;
+	rdmsrq(MSR_TMTA_LONGRUN_FLAGS, msr.q);
+	msr.l &=3D 0xFFFFFFFE;
 	switch (policy->policy) {
 	case CPUFREQ_POLICY_PERFORMANCE:
-		msr_lo |=3D 0x00000001;
+		msr.l |=3D 0x00000001;
 		break;
 	case CPUFREQ_POLICY_POWERSAVE:
 		break;
 	}
-	wrmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
+	wrmsrq(MSR_TMTA_LONGRUN_FLAGS, msr.q);
=20
 	/* lower and upper boundary */
-	rdmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
-	msr_lo &=3D 0xFFFFFF80;
-	msr_hi &=3D 0xFFFFFF80;
-	msr_lo |=3D pctg_lo;
-	msr_hi |=3D pctg_hi;
-	wrmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
+	rdmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
+	msr.l &=3D 0xFFFFFF80;
+	msr.h &=3D 0xFFFFFF80;
+	msr.l |=3D pctg_lo;
+	msr.h |=3D pctg_hi;
+	wrmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
=20
 	return 0;
 }
@@ -160,8 +160,7 @@ static unsigned int longrun_get(unsigned int cpu)
 static int longrun_determine_freqs(unsigned int *low_freq,
 						      unsigned int *high_freq)
 {
-	u32 msr_lo, msr_hi;
-	u32 save_lo, save_hi;
+	struct msr msr, save;
 	u32 eax, ebx, ecx, edx;
 	u32 try_hi;
 	struct cpuinfo_x86 *c =3D &cpu_data(0);
@@ -178,15 +177,17 @@ static int longrun_determine_freqs(unsigned int *low_fr=
eq,
 		 * For maximum frequency, read out level zero.
 		 */
 		/* minimum */
-		rdmsr(MSR_TMTA_LRTI_READOUT, msr_lo, msr_hi);
-		wrmsr(MSR_TMTA_LRTI_READOUT, msr_hi, msr_hi);
-		rdmsr(MSR_TMTA_LRTI_VOLT_MHZ, msr_lo, msr_hi);
-		*low_freq =3D msr_lo * 1000; /* to kHz */
+		rdmsrq(MSR_TMTA_LRTI_READOUT, msr.q);
+		msr.l =3D msr.h;
+		wrmsrq(MSR_TMTA_LRTI_READOUT, msr.q);
+		rdmsrq(MSR_TMTA_LRTI_VOLT_MHZ, msr.q);
+		*low_freq =3D msr.l * 1000; /* to kHz */
=20
 		/* maximum */
-		wrmsr(MSR_TMTA_LRTI_READOUT, 0, msr_hi);
-		rdmsr(MSR_TMTA_LRTI_VOLT_MHZ, msr_lo, msr_hi);
-		*high_freq =3D msr_lo * 1000; /* to kHz */
+		msr.l =3D 0;
+		wrmsrq(MSR_TMTA_LRTI_READOUT, msr.q);
+		rdmsrq(MSR_TMTA_LRTI_VOLT_MHZ, msr.q);
+		*high_freq =3D msr.l * 1000; /* to kHz */
=20
 		pr_debug("longrun table interface told %u - %u kHz\n",
 				*low_freq, *high_freq);
@@ -202,9 +203,9 @@ static int longrun_determine_freqs(unsigned int *low_freq,
 	pr_debug("high frequency is %u kHz\n", *high_freq);
=20
 	/* get current borders */
-	rdmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
-	save_lo =3D msr_lo & 0x0000007F;
-	save_hi =3D msr_hi & 0x0000007F;
+	rdmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
+	save.l =3D msr.l & 0x0000007F;
+	save.h =3D msr.h & 0x0000007F;
=20
 	/* if current perf_pctg is larger than 90%, we need to decrease the
 	 * upper limit to make the calculation more accurate.
@@ -214,16 +215,16 @@ static int longrun_determine_freqs(unsigned int *low_fr=
eq,
 	 * on some barrier values */
 	for (try_hi =3D 80; try_hi > 0 && ecx > 90; try_hi -=3D 10) {
 		/* set to 0 to try_hi perf_pctg */
-		msr_lo &=3D 0xFFFFFF80;
-		msr_hi &=3D 0xFFFFFF80;
-		msr_hi |=3D try_hi;
-		wrmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
+		msr.l &=3D 0xFFFFFF80;
+		msr.h &=3D 0xFFFFFF80;
+		msr.h |=3D try_hi;
+		wrmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
=20
 		/* read out current core MHz and current perf_pctg */
 		cpuid(0x80860007, &eax, &ebx, &ecx, &edx);
=20
 		/* restore values */
-		wrmsr(MSR_TMTA_LONGRUN_CTRL, save_lo, save_hi);
+		wrmsrq(MSR_TMTA_LONGRUN_CTRL, save.q);
 	}
 	pr_debug("percentage is %u %%, freq is %u MHz\n", ecx, eax);
=20
diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index 99d2244..2044e8a 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -83,15 +83,15 @@ static const struct {
 static int powernow_k6_get_cpu_multiplier(void)
 {
 	unsigned long invalue =3D 0;
-	u32 msrval;
+	u64 msrval;
=20
 	local_irq_disable();
=20
 	msrval =3D POWERNOW_IOPORT + 0x1;
-	wrmsr(MSR_K6_EPMR, msrval, 0); /* enable the PowerNow port */
+	wrmsrq(MSR_K6_EPMR, msrval); /* enable the PowerNow port */
 	invalue =3D inl(POWERNOW_IOPORT + 0x8);
 	msrval =3D POWERNOW_IOPORT + 0x0;
-	wrmsr(MSR_K6_EPMR, msrval, 0); /* disable it again */
+	wrmsrq(MSR_K6_EPMR, msrval); /* disable it again */
=20
 	local_irq_enable();
=20
@@ -101,8 +101,8 @@ static int powernow_k6_get_cpu_multiplier(void)
 static void powernow_k6_set_cpu_multiplier(unsigned int best_i)
 {
 	unsigned long outvalue, invalue;
-	unsigned long msrval;
 	unsigned long cr0;
+	u64 msrval;
=20
 	/* we now need to transform best_i to the BVC format, see AMD#23446 */
=20
@@ -118,13 +118,13 @@ static void powernow_k6_set_cpu_multiplier(unsigned int=
 best_i)
 	outvalue =3D (1<<12) | (1<<10) | (1<<9) | (index_to_register[best_i]<<5);
=20
 	msrval =3D POWERNOW_IOPORT + 0x1;
-	wrmsr(MSR_K6_EPMR, msrval, 0); /* enable the PowerNow port */
+	wrmsrq(MSR_K6_EPMR, msrval); /* enable the PowerNow port */
 	invalue =3D inl(POWERNOW_IOPORT + 0x8);
 	invalue =3D invalue & 0x1f;
 	outvalue =3D outvalue | invalue;
 	outl(outvalue, (POWERNOW_IOPORT + 0x8));
 	msrval =3D POWERNOW_IOPORT + 0x0;
-	wrmsr(MSR_K6_EPMR, msrval, 0); /* disable it again */
+	wrmsrq(MSR_K6_EPMR, msrval); /* disable it again */
=20
 	write_cr0(cr0);
 	local_irq_enable();
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 2b791f1..fe1f499 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -87,10 +87,10 @@ static u32 convert_fid_to_vco_fid(u32 fid)
  */
 static int pending_bit_stuck(void)
 {
-	u32 lo, hi __always_unused;
+	u64 msr;
=20
-	rdmsr(MSR_FIDVID_STATUS, lo, hi);
-	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
+	rdmsrq(MSR_FIDVID_STATUS, msr);
+	return msr & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
 }
=20
 /*
@@ -99,7 +99,7 @@ static int pending_bit_stuck(void)
  */
 static int query_current_values_with_pending_wait(struct powernow_k8_data *d=
ata)
 {
-	u32 lo, hi;
+	struct msr msr;
 	u32 i =3D 0;
=20
 	do {
@@ -107,11 +107,11 @@ static int query_current_values_with_pending_wait(struc=
t powernow_k8_data *data)
 			pr_debug("detected change pending stuck\n");
 			return 1;
 		}
-		rdmsr(MSR_FIDVID_STATUS, lo, hi);
-	} while (lo & MSR_S_LO_CHANGE_PENDING);
+		rdmsrq(MSR_FIDVID_STATUS, msr.q);
+	} while (msr.l & MSR_S_LO_CHANGE_PENDING);
=20
-	data->currvid =3D hi & MSR_S_HI_CURRENT_VID;
-	data->currfid =3D lo & MSR_S_LO_CURRENT_FID;
+	data->currvid =3D msr.h & MSR_S_HI_CURRENT_VID;
+	data->currfid =3D msr.l & MSR_S_LO_CURRENT_FID;
=20
 	return 0;
 }
@@ -131,22 +131,22 @@ static void count_off_vst(struct powernow_k8_data *data)
 /* need to init the control msr to a safe value (for each cpu) */
 static void fidvid_msr_init(void)
 {
-	u32 lo, hi;
+	struct msr msr;
 	u8 fid, vid;
=20
-	rdmsr(MSR_FIDVID_STATUS, lo, hi);
-	vid =3D hi & MSR_S_HI_CURRENT_VID;
-	fid =3D lo & MSR_S_LO_CURRENT_FID;
-	lo =3D fid | (vid << MSR_C_LO_VID_SHIFT);
-	hi =3D MSR_C_HI_STP_GNT_BENIGN;
-	pr_debug("cpu%d, init lo 0x%x, hi 0x%x\n", smp_processor_id(), lo, hi);
-	wrmsr(MSR_FIDVID_CTL, lo, hi);
+	rdmsrq(MSR_FIDVID_STATUS, msr.q);
+	vid =3D msr.h & MSR_S_HI_CURRENT_VID;
+	fid =3D msr.l & MSR_S_LO_CURRENT_FID;
+	msr.l =3D fid | (vid << MSR_C_LO_VID_SHIFT);
+	msr.h =3D MSR_C_HI_STP_GNT_BENIGN;
+	pr_debug("cpu%d, init lo 0x%x, hi 0x%x\n", smp_processor_id(), msr.l, msr.h=
);
+	wrmsrq(MSR_FIDVID_CTL, msr.q);
 }
=20
 /* write the new fid value along with the other control fields to the msr */
 static int write_new_fid(struct powernow_k8_data *data, u32 fid)
 {
-	u32 lo;
+	struct msr msr;
 	u32 savevid =3D data->currvid;
 	u32 i =3D 0;
=20
@@ -155,15 +155,15 @@ static int write_new_fid(struct powernow_k8_data *data,=
 u32 fid)
 		return 1;
 	}
=20
-	lo =3D fid;
-	lo |=3D (data->currvid << MSR_C_LO_VID_SHIFT);
-	lo |=3D MSR_C_LO_INIT_FID_VID;
+	msr.l =3D fid;
+	msr.l |=3D (data->currvid << MSR_C_LO_VID_SHIFT);
+	msr.l |=3D MSR_C_LO_INIT_FID_VID;
+	msr.h =3D data->plllock * PLL_LOCK_CONVERSION;
=20
-	pr_debug("writing fid 0x%x, lo 0x%x, hi 0x%x\n",
-		fid, lo, data->plllock * PLL_LOCK_CONVERSION);
+	pr_debug("writing fid 0x%x, lo 0x%x, hi 0x%x\n", fid, msr.l, msr.h);
=20
 	do {
-		wrmsr(MSR_FIDVID_CTL, lo, data->plllock * PLL_LOCK_CONVERSION);
+		wrmsrq(MSR_FIDVID_CTL, msr.q);
 		if (i++ > 100) {
 			pr_err("Hardware error - pending bit very stuck - no further pstate chang=
es possible\n");
 			return 1;
@@ -190,7 +190,7 @@ static int write_new_fid(struct powernow_k8_data *data, u=
32 fid)
 /* Write a new vid to the hardware */
 static int write_new_vid(struct powernow_k8_data *data, u32 vid)
 {
-	u32 lo;
+	struct msr msr;
 	u32 savefid =3D data->currfid;
 	int i =3D 0;
=20
@@ -199,15 +199,15 @@ static int write_new_vid(struct powernow_k8_data *data,=
 u32 vid)
 		return 1;
 	}
=20
-	lo =3D data->currfid;
-	lo |=3D (vid << MSR_C_LO_VID_SHIFT);
-	lo |=3D MSR_C_LO_INIT_FID_VID;
+	msr.l =3D data->currfid;
+	msr.l |=3D (vid << MSR_C_LO_VID_SHIFT);
+	msr.l |=3D MSR_C_LO_INIT_FID_VID;
+	msr.h =3D STOP_GRANT_5NS;
=20
-	pr_debug("writing vid 0x%x, lo 0x%x, hi 0x%x\n",
-		vid, lo, STOP_GRANT_5NS);
+	pr_debug("writing vid 0x%x, lo 0x%x, hi 0x%x\n", vid, msr.l, msr.h);
=20
 	do {
-		wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
+		wrmsrq(MSR_FIDVID_CTL, msr.q);
 		if (i++ > 100) {
 			pr_err("internal error - pending bit very stuck - no further pstate chang=
es possible\n");
 			return 1;
@@ -281,9 +281,10 @@ static int transition_fid_vid(struct powernow_k8_data *d=
ata,
 static int core_voltage_pre_transition(struct powernow_k8_data *data,
 		u32 reqvid, u32 reqfid)
 {
+	struct msr msr;
 	u32 rvosteps =3D data->rvo;
 	u32 savefid =3D data->currfid;
-	u32 maxvid, lo __always_unused, rvomult =3D 1;
+	u32 maxvid, rvomult =3D 1;
=20
 	pr_debug("ph1 (cpu%d): start, currfid 0x%x, currvid 0x%x, reqvid 0x%x, rvo =
0x%x\n",
 		smp_processor_id(),
@@ -292,8 +293,8 @@ static int core_voltage_pre_transition(struct powernow_k8=
_data *data,
 	if ((savefid < LO_FID_TABLE_TOP) && (reqfid < LO_FID_TABLE_TOP))
 		rvomult =3D 2;
 	rvosteps *=3D rvomult;
-	rdmsr(MSR_FIDVID_STATUS, lo, maxvid);
-	maxvid =3D 0x1f & (maxvid >> 16);
+	rdmsrq(MSR_FIDVID_STATUS, msr.q);
+	maxvid =3D 0x1f & (msr.h >> 16);
 	pr_debug("ph1 maxvid=3D0x%x\n", maxvid);
 	if (reqvid < maxvid) /* lower numbers are higher voltages */
 		reqvid =3D maxvid;
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep=
-centrino.c
index 9237ed8..de50fb3 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -345,7 +345,7 @@ static unsigned int get_cur_freq(unsigned int cpu)
 static int centrino_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpuinfo_x86 *cpu =3D &cpu_data(policy->cpu);
-	unsigned l, h;
+	u64 q;
 	int i;
=20
 	/* Only Intel makes Enhanced Speedstep-capable CPUs */
@@ -378,16 +378,16 @@ static int centrino_cpu_init(struct cpufreq_policy *pol=
icy)
=20
 	/* Check to see if Enhanced SpeedStep is enabled, and try to
 	   enable it if not. */
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	rdmsrq(MSR_IA32_MISC_ENABLE, q);
=20
-	if (!(l & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
-		l |=3D MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
-		pr_debug("trying to enable Enhanced SpeedStep (%x)\n", l);
-		wrmsr(MSR_IA32_MISC_ENABLE, l, h);
+	if (!(q & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
+		q |=3D MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
+		pr_debug("trying to enable Enhanced SpeedStep (%x)\n", (u32)q);
+		wrmsrq(MSR_IA32_MISC_ENABLE, q);
=20
 		/* check to see if it stuck */
-		rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-		if (!(l & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
+		rdmsrq(MSR_IA32_MISC_ENABLE, q);
+		if (!(q & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
 			pr_info("couldn't enable Enhanced SpeedStep\n");
 			return -ENODEV;
 		}
diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 973716c..2afc3f1 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -69,13 +69,14 @@ static unsigned int pentium3_get_frequency(enum speedstep=
_processor processor)
 		{   0, 0xff}
 	};
=20
+	struct msr msr;
 	u32 msr_lo, msr_tmp;
 	int i =3D 0, j =3D 0;
=20
 	/* read MSR 0x2a - we only need the low 32 bits */
-	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_tmp);
-	pr_debug("P3 - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", msr_lo, msr_tmp);
-	msr_tmp =3D msr_lo;
+	rdmsrq(MSR_IA32_EBL_CR_POWERON, msr.q);
+	pr_debug("P3 - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", msr.l, msr.h);
+	msr_tmp =3D msr_lo =3D msr.l;
=20
 	/* decode the FSB */
 	msr_tmp &=3D 0x00c0000;
@@ -108,19 +109,20 @@ static unsigned int pentium3_get_frequency(enum speedst=
ep_processor processor)
=20
 static unsigned int pentiumM_get_frequency(void)
 {
-	u32 msr_lo, msr_tmp;
+	struct msr msr;
+	u32 msr_tmp;
=20
-	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_tmp);
-	pr_debug("PM - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", msr_lo, msr_tmp);
+	rdmsrq(MSR_IA32_EBL_CR_POWERON, msr.q);
+	pr_debug("PM - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", msr.l, msr.h);
=20
 	/* see table B-2 of 24547212.pdf */
-	if (msr_lo & 0x00040000) {
+	if (msr.l & 0x00040000) {
 		printk(KERN_DEBUG PFX "PM - invalid FSB: 0x%x 0x%x\n",
-				msr_lo, msr_tmp);
+				msr.l, msr.h);
 		return 0;
 	}
=20
-	msr_tmp =3D (msr_lo >> 22) & 0x1f;
+	msr_tmp =3D (msr.l >> 22) & 0x1f;
 	pr_debug("bits 22-26 are 0x%x, speed is %u\n",
 			msr_tmp, (msr_tmp * 100 * 1000));
=20
@@ -129,13 +131,14 @@ static unsigned int pentiumM_get_frequency(void)
=20
 static unsigned int pentium_core_get_frequency(void)
 {
+	struct msr msr;
 	u32 fsb =3D 0;
-	u32 msr_lo, msr_tmp;
+	u32 msr_tmp;
 	int ret;
=20
-	rdmsr(MSR_FSB_FREQ, msr_lo, msr_tmp);
+	rdmsrq(MSR_FSB_FREQ, msr.q);
 	/* see table B-2 of 25366920.pdf */
-	switch (msr_lo & 0x07) {
+	switch (msr.l & 0x07) {
 	case 5:
 		fsb =3D 100000;
 		break;
@@ -158,11 +161,11 @@ static unsigned int pentium_core_get_frequency(void)
 		pr_err("PCORE - MSR_FSB_FREQ undefined value\n");
 	}
=20
-	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_tmp);
+	rdmsrq(MSR_IA32_EBL_CR_POWERON, msr.q);
 	pr_debug("PCORE - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n",
-			msr_lo, msr_tmp);
+			msr.l, msr.h);
=20
-	msr_tmp =3D (msr_lo >> 22) & 0x1f;
+	msr_tmp =3D (msr.l >> 22) & 0x1f;
 	pr_debug("bits 22-26 are 0x%x, speed is %u\n",
 			msr_tmp, (msr_tmp * fsb));
=20
@@ -174,7 +177,8 @@ static unsigned int pentium_core_get_frequency(void)
 static unsigned int pentium4_get_frequency(void)
 {
 	struct cpuinfo_x86 *c =3D &boot_cpu_data;
-	u32 msr_lo, msr_hi, mult;
+	struct msr msr;
+	u32 mult;
 	unsigned int fsb =3D 0;
 	unsigned int ret;
 	u8 fsb_code;
@@ -187,16 +191,16 @@ static unsigned int pentium4_get_frequency(void)
 	if (c->x86_model < 2)
 		return cpu_khz;
=20
-	rdmsr(0x2c, msr_lo, msr_hi);
+	rdmsrq(0x2c, msr.q);
=20
-	pr_debug("P4 - MSR_EBC_FREQUENCY_ID: 0x%x 0x%x\n", msr_lo, msr_hi);
+	pr_debug("P4 - MSR_EBC_FREQUENCY_ID: 0x%x 0x%x\n", msr.l, msr.h);
=20
 	/* decode the FSB: see IA-32 Intel (C) Architecture Software
 	 * Developer's Manual, Volume 3: System Prgramming Guide,
 	 * revision #12 in Table B-1: MSRs in the Pentium 4 and
 	 * Intel Xeon Processors, on page B-4 and B-5.
 	 */
-	fsb_code =3D (msr_lo >> 16) & 0x7;
+	fsb_code =3D (msr.l >> 16) & 0x7;
 	switch (fsb_code) {
 	case 0:
 		fsb =3D 100 * 1000;
@@ -214,7 +218,7 @@ static unsigned int pentium4_get_frequency(void)
 				"Please send an e-mail to <linux@brodo.de>\n");
=20
 	/* Multiplier. */
-	mult =3D msr_lo >> 24;
+	mult =3D msr.l >> 24;
=20
 	pr_debug("P4 - FSB %u kHz; Multiplier %u; Speed %u kHz\n",
 			fsb, mult, (fsb * mult));
@@ -255,7 +259,8 @@ EXPORT_SYMBOL_GPL(speedstep_get_frequency);
 enum speedstep_processor speedstep_detect_processor(void)
 {
 	struct cpuinfo_x86 *c =3D &cpu_data(0);
-	u32 ebx, msr_lo, msr_hi;
+	struct msr msr;
+	u32 ebx;
=20
 	pr_debug("x86: %x, model: %x\n", c->x86, c->x86_model);
=20
@@ -343,11 +348,11 @@ enum speedstep_processor speedstep_detect_processor(voi=
d)
=20
 		/* all mobile PIII Coppermines have FSB 100 MHz
 		 * =3D=3D> sort out a few desktop PIIIs. */
-		rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_hi);
+		rdmsrq(MSR_IA32_EBL_CR_POWERON, msr.q);
 		pr_debug("Coppermine: MSR_IA32_EBL_CR_POWERON is 0x%x, 0x%x\n",
-				msr_lo, msr_hi);
-		msr_lo &=3D 0x00c0000;
-		if (msr_lo !=3D 0x0080000)
+				msr.l, msr.h);
+		msr.l &=3D 0x00c0000;
+		if (msr.l !=3D 0x0080000)
 			return 0;
=20
 		/*
@@ -356,11 +361,11 @@ enum speedstep_processor speedstep_detect_processor(voi=
d)
 		 * it has SpeedStep technology if either
 		 * bit 56 or 57 is set
 		 */
-		rdmsr(MSR_IA32_PLATFORM_ID, msr_lo, msr_hi);
+		rdmsrq(MSR_IA32_PLATFORM_ID, msr.q);
 		pr_debug("Coppermine: MSR_IA32_PLATFORM ID is 0x%x, 0x%x\n",
-				msr_lo, msr_hi);
-		if ((msr_hi & (1<<18)) &&
-		    (relaxed_check ? 1 : (msr_hi & (3<<24)))) {
+				msr.l, msr.h);
+		if ((msr.h & (1<<18)) &&
+		    (relaxed_check ? 1 : (msr.h & (3<<24)))) {
 			if (c->x86_stepping =3D=3D 0x01) {
 				pr_debug("early PIII version\n");
 				return SPEEDSTEP_CPU_PIII_C_EARLY;
