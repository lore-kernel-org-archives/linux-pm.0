From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH v2 1/2] intel_idle: re-work
 bxt_idle_state_table_update() and its helper
Date: Mon, 27 Jun 2016 00:35:12 -0600
Message-ID: <5770E54002000078000F8D82@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:33066 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcF0GfQ convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pm@vger.kernel.org:2:1>);
	Mon, 27 Jun 2016 02:35:16 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org

Since irtl_ns_units[] has itself zero entries, make sure the caller
recognized those cases along with the MSR read returning zero, as zero
is not a valid value for exit_latency and target_residency.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/idle/intel_idle.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

--- 4.7-rc5-intel-idle-BXT.orig/drivers/idle/intel_idle.c
+++ 4.7-rc5-intel-idle-BXT/drivers/idle/intel_idle.c
@@ -1154,6 +1154,9 @@ static unsigned long long irtl_2_usec(un
 {
 	unsigned long long ns;
 
+	if (!irtl)
+		return 0;
+
 	ns = irtl_ns_units[(irtl >> 10) & 0x3];
 
 	return div64_u64((irtl & 0x3FF) * ns, 1000);
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



