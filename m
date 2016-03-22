From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] cpufreq: acpi-cpufreq: make Intel/AMD MSR access, io port access static
Date: Tue, 22 Mar 2016 22:34:30 +0800
Message-ID: <1458657270-2440-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20029 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757386AbcCVOiW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 10:38:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

These frequency register read/write operations' implementations for the
given processor (Intel/AMD MSR access or I/O port access) are only used
internally in acpi-cpufreq, so make them static.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 59a7b38..985be6e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -245,7 +245,7 @@ static unsigned extract_freq(u32 val, struct acpi_cpufreq_data *data)
 	}
 }
 
-u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
+static u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
 {
 	u32 val, dummy;
 
@@ -253,7 +253,7 @@ u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
 	return val;
 }
 
-void cpu_freq_write_intel(struct acpi_pct_register *not_used, u32 val)
+static void cpu_freq_write_intel(struct acpi_pct_register *not_used, u32 val)
 {
 	u32 lo, hi;
 
@@ -262,7 +262,7 @@ void cpu_freq_write_intel(struct acpi_pct_register *not_used, u32 val)
 	wrmsr(MSR_IA32_PERF_CTL, lo, hi);
 }
 
-u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
+static u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
 {
 	u32 val, dummy;
 
@@ -270,12 +270,12 @@ u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
 	return val;
 }
 
-void cpu_freq_write_amd(struct acpi_pct_register *not_used, u32 val)
+static void cpu_freq_write_amd(struct acpi_pct_register *not_used, u32 val)
 {
 	wrmsr(MSR_AMD_PERF_CTL, val, 0);
 }
 
-u32 cpu_freq_read_io(struct acpi_pct_register *reg)
+static u32 cpu_freq_read_io(struct acpi_pct_register *reg)
 {
 	u32 val;
 
@@ -283,7 +283,7 @@ u32 cpu_freq_read_io(struct acpi_pct_register *reg)
 	return val;
 }
 
-void cpu_freq_write_io(struct acpi_pct_register *reg, u32 val)
+static void cpu_freq_write_io(struct acpi_pct_register *reg, u32 val)
 {
 	acpi_os_write_port(reg->address, val, reg->bit_width);
 }
-- 
2.8.0.rc3

