From: Todd E Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH] new suspend_resume trace event for console resume
Date: Fri, 19 Sep 2014 14:07:12 -0700
Message-ID: <20140919210711.GA15652@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43286 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757831AbaISVHN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Sep 2014 17:07:13 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

This patch adds another suspend_resume trace event for analyze_suspend
to capture. The resume_console call can take several hundred milliseconds
if the printk buffer is full of debug info. The tool will now inform 
testers of the wasted time and encourage them to disable it in
production builds.

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
----
 kernel/power/suspend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 18c6219..e837dd6 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -361,7 +361,9 @@ int suspend_devices_and_enter(suspend_state_t state)
 	suspend_test_start();
 	dpm_resume_end(PMSG_RESUME);
 	suspend_test_finish("resume devices");
+	trace_suspend_resume(TPS("resume_console"), state, true);
 	resume_console();
+	trace_suspend_resume(TPS("resume_console"), state, false);
 
  Close:
 	platform_suspend_end(state);
