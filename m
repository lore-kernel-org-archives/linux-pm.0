From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] PM: Documentation update for freeze state
Date: Mon, 13 May 2013 10:42:11 +0800
Message-ID: <1368412932-4500-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:20547 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab3EMCmR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 12 May 2013 22:42:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/power/devices.txt   |   15 ++++++++-------
 Documentation/power/interface.txt |    4 ++--
 Documentation/power/states.txt    |   20 +++++++++++++++++---
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index 504dfe4..a66c982 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -268,7 +268,7 @@ situations.
 System Power Management Phases
 ------------------------------
 Suspending or resuming the system is done in several phases.  Different phases
-are used for standby or memory sleep states ("suspend-to-RAM") and the
+are used for freeze, standby, and memory sleep states ("suspend-to-RAM") and the
 hibernation state ("suspend-to-disk").  Each phase involves executing callbacks
 for every device before the next phase begins.  Not all busses or classes
 support all these callbacks and not all drivers use all the callbacks.  The
@@ -309,7 +309,8 @@ execute the corresponding method from dev->driver->pm instead if there is one.
 
 Entering System Suspend
 -----------------------
-When the system goes into the standby or memory sleep state, the phases are:
+When the system goes into the freeze, standby or memory sleep state,
+the phases are:
 
 		prepare, suspend, suspend_late, suspend_noirq.
 
@@ -368,7 +369,7 @@ the devices that were suspended.
 
 Leaving System Suspend
 ----------------------
-When resuming from standby or memory sleep, the phases are:
+When resuming from freeze, standby or memory sleep, the phases are:
 
 		resume_noirq, resume_early, resume, complete.
 
@@ -433,8 +434,8 @@ the system log.
 
 Entering Hibernation
 --------------------
-Hibernating the system is more complicated than putting it into the standby or
-memory sleep state, because it involves creating and saving a system image.
+Hibernating the system is more complicated than putting it into the other
+sleep states, because it involves creating and saving a system image.
 Therefore there are more phases for hibernation, with a different set of
 callbacks.  These phases always run after tasks have been frozen and memory has
 been freed.
@@ -485,8 +486,8 @@ image forms an atomic snapshot of the system state.
 
 At this point the system image is saved, and the devices then need to be
 prepared for the upcoming system shutdown.  This is much like suspending them
-before putting the system into the standby or memory sleep state, and the phases
-are similar.
+before putting the system into the freeze, standby or memory sleep state,
+and the phases are similar.
 
     9.	The prepare phase is discussed above.
 
diff --git a/Documentation/power/interface.txt b/Documentation/power/interface.txt
index c537834..f1f0f59a 100644
--- a/Documentation/power/interface.txt
+++ b/Documentation/power/interface.txt
@@ -7,8 +7,8 @@ running. The interface exists in /sys/power/ directory (assuming sysfs
 is mounted at /sys). 
 
 /sys/power/state controls system power state. Reading from this file
-returns what states are supported, which is hard-coded to 'standby'
-(Power-On Suspend), 'mem' (Suspend-to-RAM), and 'disk'
+returns what states are supported, which is hard-coded to 'freeze',
+'standby' (Power-On Suspend), 'mem' (Suspend-to-RAM), and 'disk'
 (Suspend-to-Disk). 
 
 Writing to this file one of those strings causes the system to
diff --git a/Documentation/power/states.txt b/Documentation/power/states.txt
index 4416b28..42f28b7 100644
--- a/Documentation/power/states.txt
+++ b/Documentation/power/states.txt
@@ -2,12 +2,26 @@
 System Power Management States
 
 
-The kernel supports three power management states generically, though
-each is dependent on platform support code to implement the low-level
-details for each state. This file describes each state, what they are
+The kernel supports four power management states generically, though
+one is generic and the other three are dependent on platform support
+code to implement the low-level details for each state.
+This file describes each state, what they are
 commonly called, what ACPI state they map to, and what string to write
 to /sys/power/state to enter that state
 
+state:		Freeze / Low-Power Idle
+ACPI state:	S0
+String:		"freeze"
+
+This state is a generic, pure software, light-weight, low-power state.
+It allows more energy to be saved relative to idle by freezing user
+space and putting all I/O devices into low-power states (possibly
+lower-power than available at run time), such that the processors can
+spend more time in their idle states.
+This state can be used for platforms without Standby/Suspend-to-RAM
+support, or it can be used in addition to Suspend-to-RAM (memory sleep)
+to provide reduced resume latency.
+
 
 State:		Standby / Power-On Suspend
 ACPI State:	S1
-- 
1.7.9.5

