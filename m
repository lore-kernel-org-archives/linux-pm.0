Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E754C371046;
	Mon,  3 Aug 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751383; cv=none; b=rrWgJ7Yr43tfIvof8rAyzgBJazmKik1dC00UUkbRfq+G7Y+pNcUqGYNIk81RVAzCNJSqyO3/JK24ygVLkcKcWfxiUBoXf4zdR0gcPpahcQhQW6on/opB4p31wgqmvwzI2/OfRQAjsRXyrmjOTvKkolXZtKL6rUdV7P05i7QPQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751383; c=relaxed/simple;
	bh=TdGjTLd7CFgZjqZPky+2Tqgc86QPVB5Ryw4ljGn3VoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BweZ1LKJ1TKiQ8rFT4bI+eyjOnoyryekaM707oy5j0Z0BOeIweHLIkR+QwpS8CFOH/lJiV6ylQpbmtlitmtYuVdaPU9v9EBUxmavNKer/bz2V0ST/dz+IutJg7iLsJFmujclyCt1Wa5TGYLbiG7RD5ncvhfV39v7GaQ0QxozUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eoQ/C9M1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eoQ/C9M1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4431C1476;
	Mon,  3 Aug 2026 03:02:56 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4713C3F66F;
	Mon,  3 Aug 2026 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785751380; bh=TdGjTLd7CFgZjqZPky+2Tqgc86QPVB5Ryw4ljGn3VoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoQ/C9M1L8XXd6M+eOO/C6DEZ3B8IXNTQkYFkzK6uLFxN3b5+Uktb3Iaj613nE0uD
	 9iTaT2L7g9GajIEl13Fj0nJIBhSC9F2z88DCsAq/D5wnI/sCaIeh5phDbfmp6wQbV7
	 si+t1tTFOBgfr+9FC7bC8Ki8jSKrn05O8JF2fSW0=
From: Christian Loehle <christian.loehle@arm.com>
To: christian.loehle@arm.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v3 1/3] ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
Date: Mon,  3 Aug 2026 11:02:49 +0100
Message-Id: <18ee922e97441b99b9ab346fe559d837d05eb5e7.1785749175.git.christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1785749175.git.christian.loehle@arm.com>
References: <20260729100245.2628302-1-christian.loehle@arm.com> <cover.1785749175.git.christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
calls cppc_get_desired_perf() because some platforms repurpose Desired
Performance to report actual delivered performance.

The fallback was added for platforms on which Desired Performance reflects
delivered performance. ACPI 6.6 defines the register as write-only, so
invoking that workaround on an ACPI 6.6 or later platform would require an
invalid register read.

Make cppc_get_desired_perf() return -EOPNOTSUPP in that case. When checking
the FADT minor revision, mask off its upper errata-generation bits and
compare only the specification minor version.

The FADT revision may not accurately describe the semantics implemented by
_CPC. If a nominally pre-6.6 platform implements Desired Performance as
write-only, a read may return zero and make cppc_cpufreq_get_rate() report
0 kHz. Treat a zero read as unusable and fall back to the cached OSPM
request, just as for a failed read.

Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")
Cc: stable@vger.kernel.org
Suggested-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c       | 15 ++++++++++++++-
 drivers/cpufreq/cppc_cpufreq.c |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 53d09ca98f06..6e5381f8de38 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1316,15 +1316,28 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 	return cpc_write(cpu, reg, val);
 }
 
+static bool cppc_desired_perf_readable(void)
+{
+	u8 minor_revision = acpi_gbl_FADT.minor_revision & 0x0f;
+
+	return acpi_gbl_FADT.header.revision < 6 ||
+	       (acpi_gbl_FADT.header.revision == 6 && minor_revision < 6);
+}
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
  * @desired_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -EOPNOTSUPP for ACPI 6.6 or later, and a negative
+ * errno otherwise.
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
+	/* ACPI 6.6 no longer specifies Desired Performance as readable. */
+	if (!cppc_desired_perf_readable())
+		return -EOPNOTSUPP;
+
 	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6fe0e972952a..80893844353c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -836,7 +836,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	 * value first as some platforms may update the actual delivered perf
 	 * there; if failed, resort to the cached desired perf.
 	 */
-	if (cppc_get_desired_perf(cpu, &delivered_perf))
+	if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_perf)
 		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
-- 
2.34.1

