From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [RFC PATCH v2 1/3] PCC HACKS: Update PCC comm region with MSR data
Date: Wed,  8 Oct 2014 16:11:02 -0400
Message-ID: <1412799064-2339-2-git-send-email-ashwin.chaugule@linaro.org>
References: <1412799064-2339-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:38928 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbaJHULk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 16:11:40 -0400
Received: by mail-vc0-f173.google.com with SMTP id ij19so7426085vcb.4
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2014 13:11:38 -0700 (PDT)
In-Reply-To: <1412799064-2339-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: dirk.brandewie@gmail.com, rwells@codeaurora.org, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, linda.knippers@hp.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Not for upstreaming. Hacked for experiments on the
the Thinkpad X240. The pcc_send_data() function is
modified to read certain MSRs and update a shared
memory region. This enables the PCC client (CPPC
in this case) to read from the buffer as though
it were getting data from a remote processor.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/pcc.c | 125 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 109 insertions(+), 16 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index a16991e..27d0e61 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -98,22 +98,22 @@ static bool pcc_tx_done(struct mbox_chan *chan)
 	u16 cmd_delay = pcct_ss->min_turnaround_time;
 	unsigned int retries = 0;
 
-	/* Try a few times while waiting for platform to consume */
-	while (!(readw_relaxed(&generic_comm_base->status)
-		    & PCC_CMD_COMPLETE)) {
-
-		if (retries++ < 5)
-			udelay(cmd_delay);
-		else {
-			/*
-			 * If the remote is dead, this will cause the Mbox
-			 * controller to timeout after mbox client.tx_tout
-			 * msecs.
-			 */
-			pr_err("PCC platform did not respond.\n");
-			return false;
-		}
-	}
+//	/* Try a few times while waiting for platform to consume */
+//	while (!(readw_relaxed(&generic_comm_base->status)
+//		    & PCC_CMD_COMPLETE)) {
+//
+//		if (retries++ < 5)
+//			udelay(cmd_delay);
+//		else {
+//			/*
+//			 * If the remote is dead, this will cause the Mbox
+//			 * controller to timeout after mbox client.tx_tout
+//			 * msecs.
+//			 */
+//			pr_err("PCC platform did not respond.\n");
+//			return false;
+//		}
+//	}
 	return true;
 }
 
@@ -127,6 +127,97 @@ static int get_subspace_id(struct mbox_chan *chan)
 	return id;
 }
 
+#define PCC_HACK
+
+#ifdef PCC_HACK
+
+#include <asm/msr.h>
+
+/* These offsets are from the SSDT9.asl table on the Thinkpad X240 */
+
+/* These are offsets per CPU from which its CPC table begins. */
+int cpu_base[] = {0, 0x64, 0xC8, 0x12C, 0x190, 0x1F4, 0x258, 0x2BC};
+
+/* These are offsets of the registers in each CPC table. */
+#define HIGHEST_PERF_OFFSET 0x0
+#define LOWEST_PERF_OFFSET	0xc
+#define DESIRED_PERF_OFFSET 0x14
+
+static int core_get_min(void)
+{
+	u64 val;
+	rdmsrl(MSR_PLATFORM_INFO, val);
+	return (val >> 40) & 0xff;
+}
+
+static int core_get_max(void)
+{
+	u64 val;
+	rdmsrl(MSR_PLATFORM_INFO, val);
+	return (val >> 8) & 0xff;
+}
+
+static int core_get_turbo(void)
+{
+	u64 value;
+	int nont, ret;
+
+	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
+	nont = core_get_max();
+	ret = ((value) & 255);
+	if (ret <= nont)
+		ret = nont;
+	return ret;
+}
+
+static int pcc_send_data(struct mbox_chan *chan, void *data)
+{
+	struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
+	u64 pcc_comm_addr = pcct_ss->base_address;
+	unsigned int cpu;
+	u16 cmd = *(u16 *) data;
+	u64 desired_val;
+
+	/*XXX: Instead of waiting for platform to consume the cmd,
+	 * just do what the platform would've done.
+	 */
+	switch (cmd) {
+		case 0:	//PCC_CMD_READ
+
+			/* XXX: Normally the Platform would need to update all the other CPPC registers as well.
+			 * But for this experiment, since we're not really using all of them, we'll only update
+			 * what we use.
+			 */
+			for_each_possible_cpu(cpu) {
+				*(char*)(pcc_comm_addr + cpu_base[cpu] + HIGHEST_PERF_OFFSET) = core_get_turbo();
+				*(char*)(pcc_comm_addr + cpu_base[cpu] + LOWEST_PERF_OFFSET) = core_get_min();
+			}
+			break;
+		case 1:  //PCC_CMD_WRITE
+
+			/* XXX: All this hackery is very X86 Thinkpad X240 specific.
+			 * Normally, the cpc_write64() would have all the info on
+			 * how, where and what to write.
+			 */
+			for_each_possible_cpu(cpu) {
+				desired_val = *(u64*)(pcc_comm_addr + cpu_base[cpu] + DESIRED_PERF_OFFSET);
+
+				if (desired_val) {
+					wrmsrl_on_cpu(cpu, MSR_IA32_PERF_CTL, desired_val << 8);
+					*(u64*)(pcc_comm_addr + cpu_base[cpu] + DESIRED_PERF_OFFSET) = 0;
+				}
+			}
+			break;
+		default:
+			pr_err("Unknown PCC cmd from the OS\n");
+			return 0;
+	}
+
+	return 0;
+}
+
+#else
+
 /* Channel lock is already held by mbox controller code. */
 static int pcc_send_data(struct mbox_chan *chan, void *data)
 {
@@ -171,6 +262,8 @@ out_err:
 	return ret;
 }
 
+#endif
+
 static struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 	.last_tx_done = pcc_tx_done,
-- 
1.9.1

