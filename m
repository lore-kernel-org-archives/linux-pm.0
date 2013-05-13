From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] PM: documentation update: remove inaccurate suspend/hibernate transition lantency statement
Date: Mon, 13 May 2013 10:42:12 +0800
Message-ID: <1368412932-4500-2-git-send-email-rui.zhang@intel.com>
References: <1368412932-4500-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:20547 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753628Ab3EMCmS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 12 May 2013 22:42:18 -0400
In-Reply-To: <1368412932-4500-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

The lantency of the transition from suspend and hibernate is
platform-dependent.
Thus we should not refer the lantency in the documentation.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/power/states.txt |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/power/states.txt b/Documentation/power/states.txt
index 42f28b7..442d43d 100644
--- a/Documentation/power/states.txt
+++ b/Documentation/power/states.txt
@@ -36,9 +36,6 @@ We try to put devices in a low-power state equivalent to D1, which
 also offers low power savings, but low resume latency. Not all devices
 support D1, and those that don't are left on. 
 
-A transition from Standby to the On state should take about 1-2
-seconds. 
-
 
 State:		Suspend-to-RAM
 ACPI State:	S3
@@ -56,9 +53,6 @@ transition back to the On state.
 For at least ACPI, STR requires some minimal boot-strapping code to
 resume the system from STR. This may be true on other platforms. 
 
-A transition from Suspend-to-RAM to the On state should take about
-3-5 seconds. 
-
 
 State:		Suspend-to-disk
 ACPI State:	S4
@@ -88,7 +82,3 @@ low-power state (like ACPI S4), or it may simply power down. Powering
 down offers greater savings, and allows this mechanism to work on any
 system. However, entering a real low-power state allows the user to
 trigger wake up events (e.g. pressing a key or opening a laptop lid).
-
-A transition from Suspend-to-Disk to the On state should take about 30
-seconds, though it's typically a bit more with the current
-implementation. 
-- 
1.7.9.5

