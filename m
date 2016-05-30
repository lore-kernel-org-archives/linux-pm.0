From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH] intel_idle: correct/improve BXT support
Date: Mon, 30 May 2016 06:26:24 -0600
Message-ID: <574C4D9002000078000EFAAC@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:39965 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbcE3M02 convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pm@vger.kernel.org:2:1>);
	Mon, 30 May 2016 08:26:28 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org

Commit 5dcef69486 ("intel_idle: add BXT support") added an 8-element
lookup array with just a 2-bit value used for lookups. As per the SDM
that bit field is really 3 bits wide. Since the top two array entries
are zero, deal with the resulting invalid (zero) values by moving the
zero-MSR-value check into irtl_2_usec() and having that function's
caller check the function result instead.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/idle/intel_idle.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

--- 4.7-rc1/drivers/idle/intel_idle.c
+++ 4.7-rc1-intel-idle-BXT-time-unit/drivers/idle/intel_idle.c
@@ -1154,7 +1154,10 @@ static unsigned long long irtl_2_usec(un
 {
 	unsigned long long ns;
 
-	ns = irtl_ns_units[(irtl >> 10) & 0x3];
+	if (!irtl)
+		return 0;
+
+	ns = irtl_ns_units[(irtl >> 10) & 0x7];
 
 	return div64_u64((irtl & 0x3FF) * ns, 1000);
 }
@@ -1167,43 +1170,39 @@ static unsigned long long irtl_2_usec(un
 static void bxt_idle_state_table_update(void)
 {
 	unsigned long long msr;
+	unsigned int usec;
 
 	rdmsrl(MSR_PKGC6_IRTL, msr);
-	if (msr) {
-		unsigned int usec = irtl_2_usec(msr);
-
+	usec = irtl_2_usec(msr);
+	if (usec) {
 		bxt_cstates[2].exit_latency = usec;
 		bxt_cstates[2].target_residency = usec;
 	}
 
 	rdmsrl(MSR_PKGC7_IRTL, msr);
-	if (msr) {
-		unsigned int usec = irtl_2_usec(msr);
-
+	usec = irtl_2_usec(msr);
+	if (usec) {
 		bxt_cstates[3].exit_latency = usec;
 		bxt_cstates[3].target_residency = usec;
 	}
 
 	rdmsrl(MSR_PKGC8_IRTL, msr);
-	if (msr) {
-		unsigned int usec = irtl_2_usec(msr);
-
+	usec = irtl_2_usec(msr);
+	if (usec) {
 		bxt_cstates[4].exit_latency = usec;
 		bxt_cstates[4].target_residency = usec;
 	}
 
 	rdmsrl(MSR_PKGC9_IRTL, msr);
-	if (msr) {
-		unsigned int usec = irtl_2_usec(msr);
-
+	usec = irtl_2_usec(msr);
+	if (usec) {
 		bxt_cstates[5].exit_latency = usec;
 		bxt_cstates[5].target_residency = usec;
 	}
 
 	rdmsrl(MSR_PKGC10_IRTL, msr);
-	if (msr) {
-		unsigned int usec = irtl_2_usec(msr);
-
+	usec = irtl_2_usec(msr);
+	if (usec) {
 		bxt_cstates[6].exit_latency = usec;
 		bxt_cstates[6].target_residency = usec;
 	}



