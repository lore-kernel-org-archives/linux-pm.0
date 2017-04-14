From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] Doc/PM: Sync with intel_powerclamp code behavior
Date: Fri, 14 Apr 2017 11:19:24 -0700
Message-ID: <1492193964-49735-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64418 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753957AbdDNSSe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:18:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>
Cc: Masanari Iida <standby24x7@gmail.com>, Wang Xiaolong <xiaolong.wang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Commit feb6cd6a0f9f ("thermal/intel_powerclamp: stop sched tick in forced
idle") changed how idle injection accouting, so we need to update
the documentation accordingly.

This patch also expands more details on the behavior of cur_state.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reported-by: Wang, Xiaolong <xiaolong.wang@intel.com>
---
 Documentation/thermal/intel_powerclamp.txt | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/thermal/intel_powerclamp.txt b/Documentation/thermal/intel_powerclamp.txt
index 60073dc..b5df211 100644
--- a/Documentation/thermal/intel_powerclamp.txt
+++ b/Documentation/thermal/intel_powerclamp.txt
@@ -268,6 +268,15 @@ cur_state:0
 max_state:50
 type:intel_powerclamp
 
+cur_state allows user to set the desired idle percentage. Writing 0 to
+cur_state will stop idle injection. Writing a value between 1 and
+max_state will start the idle injection. Reading cur_state returns the
+actual and current idle percentage. This may not be the same value
+set by the user in that current idle percentage depends on workload
+and includes natural idle. When idle injection is disabled, reading
+cur_state returns value -1 instead of 0 which is to avoid confusing
+100% busy state with the disabled state.
+
 Example usage:
 - To inject 25% idle time
 $ sudo sh -c "echo 25 > /sys/class/thermal/cooling_device80/cur_state
@@ -278,11 +287,12 @@ then the powerclamp driver will not start idle injection. Using Top
 will not show idle injection kernel threads.
 
 If the system is busy (spin test below) and has less than 25% natural
-idle time, powerclamp kernel threads will do idle injection, which
-appear running to the scheduler. But the overall system idle is still
-reflected. In this example, 24.1% idle is shown. This helps the
-system admin or user determine the cause of slowdown, when a
-powerclamp driver is in action.
+idle time, powerclamp kernel threads will do idle injection. Forced
+idle time is accounted as normal idle in that common code path is
+taken as the idle task.
+
+In this example, 24.1% idle is shown. This helps the system admin or
+user determine the cause of slowdown, when a powerclamp driver is in action.
 
 
 Tasks: 197 total,   1 running, 196 sleeping,   0 stopped,   0 zombie
-- 
2.7.4
