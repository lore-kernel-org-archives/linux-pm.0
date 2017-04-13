From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/7] tools/power turbostat: fix impossibly large CPU%c1 value
Date: Wed, 12 Apr 2017 20:08:52 -0400
Message-ID: <95149369c1c28b10f7318dfde54018ab107277d0.1492041840.git.len.brown@intel.com>
References: <20170413000853.21648-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34176 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755875AbdDMAJe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 20:09:34 -0400
In-Reply-To: <20170413000853.21648-1-lenb@kernel.org>
In-Reply-To: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
References: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Most CPUs do not have a hardware c1 counter,
and so turbostat derives c1 residency:

c1 = TSC - MPERF - other_core_cstate_counters

As it is not possible to atomically read these coutners,
measurement jitter can case this calcuation to "go negative"
when very close to 0.  Turbostat detect that case and
simply prints c1 = 0.00%

But that check neglected to account for systems where the TSC
crystal clock domain and the MPERF BCLK domain are differ by
a small amount.  That allowed very small negative c1 numbers
to escape this check and be printed as huge positve numbers.

This code begs for a bit of cleanup, but this patch
is the minimal change to fix the issue.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b0591d0da801..0ad966114e58 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1142,7 +1142,7 @@ delta_thread(struct thread_data *new, struct thread_data *old,
 		 * it is possible for mperf's non-halted cycles + idle states
 		 * to exceed TSC's all cycles: show c1 = 0% in that case.
 		 */
-		if ((old->mperf + core_delta->c3 + core_delta->c6 + core_delta->c7) > old->tsc)
+		if ((old->mperf + core_delta->c3 + core_delta->c6 + core_delta->c7) > (old->tsc * tsc_tweak))
 			old->c1 = 0;
 		else {
 			/* normal case, derive c1 */
-- 
2.11.0.161.g6610af872
