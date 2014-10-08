From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [RFC PATCH v2 3/3] CPPC HACKS
Date: Wed,  8 Oct 2014 16:11:04 -0400
Message-ID: <1412799064-2339-4-git-send-email-ashwin.chaugule@linaro.org>
References: <1412799064-2339-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:60639 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969AbaJHULm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 16:11:42 -0400
Received: by mail-vc0-f178.google.com with SMTP id hq12so7290106vcb.23
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2014 13:11:42 -0700 (PDT)
In-Reply-To: <1412799064-2339-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: dirk.brandewie@gmail.com, rwells@codeaurora.org, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, linda.knippers@hp.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Not for upstreaming.
The IO space specified in the PCCT of the thinkpad
doesn't seem to have anything behind it. So this patch
creates a fake buffer shared between CPPC and PCC.

Also, the write to DESIRED reg to indicate desired CPU
performance level is an MSR on the Thinkpad (PERF_CTL).
This is not specified by the CPC table on this laptop. So
skip the cpc_write64() and directly write to the MSR. This
avoids the deadlock situtaion where IRQs are disabled in the
following path:

mbox_send_message -> send_data -> pcc_send_data

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/cpufreq/acpi_pid.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/acpi_pid.c b/drivers/cpufreq/acpi_pid.c
index a6db149..f67dd8f 100644
--- a/drivers/cpufreq/acpi_pid.c
+++ b/drivers/cpufreq/acpi_pid.c
@@ -763,6 +763,8 @@ static int acpi_cppc_processor_probe(void)
 	unsigned int num_ent, ret = 0, i, cpu, len;
 	acpi_handle handle;
 	acpi_status status;
+	//HACK:
+	u64 *tmp_buff;
 
 	/* Parse the ACPI _CPC table for each cpu. */
 	for_each_possible_cpu(cpu) {
@@ -850,19 +852,32 @@ static int acpi_cppc_processor_probe(void)
 
 		pr_debug("From PCCT: CPPC subspace addr:%llx, len: %d\n", comm_base_addr, len);
 
-		pcc_comm_addr = ioremap(comm_base_addr, len);
-		if (!pcc_comm_addr) {
+		/* HACK:
+		 * The IO space as specified by the PCCT on the Thinkpad
+		 * doesn't seem to have anything behind it. So allocate 
+		 * a temp buff instead and use it between CPPC and PCC.
+		 */
+		tmp_buff = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!tmp_buff) {
+			pr_err("Could not allocate temp PCC comm space\n");
 			ret = -ENOMEM;
-			pr_err("Failed to ioremap PCC comm region mem\n");
 			goto out_free;
 		}
+//		pcc_comm_addr = ioremap(comm_base_addr, len);
+//		if (!pcc_comm_addr) {
+//			ret = -ENOMEM;
+//			pr_err("Failed to ioremap PCC comm region mem\n");
+//			goto out_free;
+//		}
 
 		/*
 		 * Overwrite it here for ease of use later in cpc_read/write calls
 		 * We dont really need the original address again anyway.
 		 */
-		cppc_ss->base_address = (u64)pcc_comm_addr;
-		pr_debug("New PCC comm space addr: %llx\n", (u64)pcc_comm_addr);
+//		cppc_ss->base_address = (u64)pcc_comm_addr;
+		cppc_ss->base_address = (u64)tmp_buff;
+//		pr_debug("New PCC comm space addr: %llx\n", (u64)pcc_comm_addr);
+		pr_debug("New PCC comm space addr: %llx\n", (u64)tmp_buff);
 
 	} else {
 		pr_err("No pcc subspace detected in any CPC structure!\n");
@@ -985,7 +1000,20 @@ static int cppc_set_pstate(struct cpudata *cpudata, int state)
 	}
 
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
-	return cpc_write64(state, desired_reg);
+//	return cpc_write64(state, desired_reg);
+/* HACK: Normally, the cpc_write64() would do the right thing,
+ * by writing to the DESIRED reg as specified by the CPC table.
+ * But, on this X240 laptop, the DESIRED reg is actually an MSR which
+ * is not defined in the CPC. So we could fake it inside the 
+ * pcc_send_data() routine, but that wont work, since the
+ * mbox controller code disables IRQs before calling
+ * pcc_send_data(). This results in a deadlock, when that
+ * routine does a wrmsrl_on_cpu(). Directly call it here
+ * instead. Experimental anyway.
+ */
+	val = state << 8;
+	wrmsrl_on_cpu(cpu, MSR_IA32_PERF_CTL, val);
+	return 0;
 }
 
 static struct cpu_defaults acpi_pid_cppc = {
-- 
1.9.1

