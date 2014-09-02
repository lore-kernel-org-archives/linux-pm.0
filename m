From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] Documentation/kernel-parameters: Update test_suspend option
Date: Tue,  2 Sep 2014 11:54:41 -0700
Message-ID: <1409684081-9659-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1409684081-9659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59716 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbaIBSyd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Sep 2014 14:54:33 -0400
In-Reply-To: <1409684081-9659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Updated documentation to add freeze mode and repeat capability.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/kernel-parameters.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5ae8608..67a499b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3303,11 +3303,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	tdfx=		[HW,DRM]
 
-	test_suspend=	[SUSPEND]
+	test_suspend=	[SUSPEND][,N]
 			Specify "mem" (for Suspend-to-RAM) or "standby" (for
-			standby suspend) as the system sleep state to briefly
-			enter during system startup.  The system is woken from
-			this state using a wakeup-capable RTC alarm.
+			standby suspend) or "freeze" (for suspend type freeze)
+			as the system sleep state during system startup with
+			the optional capability to repeat N number of times.
+			The system is woken from this state using a
+			wakeup-capable RTC alarm.
 
 	thash_entries=	[KNL,NET]
 			Set number of hash buckets for TCP connection
-- 
1.9.1

