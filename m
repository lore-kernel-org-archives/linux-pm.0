From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] Documentation: update cputopology.txt
Date: Fri, 24 Apr 2015 16:36:45 +0200
Message-ID: <1429886205-28520-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33605 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbbDXOgV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 10:36:21 -0400
Received: by wiax7 with SMTP id x7so36564137wia.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 07:36:20 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>, Bartosz Golaszewski <bgolaszewski+renesas@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski+renesas@baylibre.com>

The documentation on cpu topology seems to be a bit out-of-date. It
doesn't mention the **_siblings_list attributes and uses old names
for topology_**_cpumask() macros.

Add information on missing attributes plus some minor clarifications.

Signed-off-by: Bartosz Golaszewski <bgolaszewski+renesas@baylibre.com>
---
 Documentation/cputopology.txt | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 0aad6de..27e67d7 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -1,6 +1,6 @@
 
 Export CPU topology info via sysfs. Items (attributes) are similar
-to /proc/cpuinfo.
+to /proc/cpuinfo output of some architectures:
 
 1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
 
@@ -23,20 +23,35 @@ to /proc/cpuinfo.
 4) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
-	core as cpuX
+	core as cpuX.
 
-5) /sys/devices/system/cpu/cpuX/topology/core_siblings:
+5) /sys/devices/system/cpu/cpuX/topology/thread_siblings_list:
+
+	human-readable list of cpuX's hardware threads within the same
+	core as cpuX.
+
+6) /sys/devices/system/cpu/cpuX/topology/core_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	physical_package_id.
 
-6) /sys/devices/system/cpu/cpuX/topology/book_siblings:
+7) /sys/devices/system/cpu/cpuX/topology/core_siblings_list:
+
+	human-readable list of cpuX's hardware threads within the same
+	physical_package_id.
+
+8) /sys/devices/system/cpu/cpuX/topology/book_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	book_id.
 
+9) /sys/devices/system/cpu/cpuX/topology/book_siblings_list:
+
+	human-readable list of cpuX's hardware threads within the same
+	book_id.
+
 To implement it in an architecture-neutral way, a new source file,
-drivers/base/topology.c, is to export the 4 or 6 attributes. The two book
+drivers/base/topology.c, is to export the 6 or 9 attributes. The three book
 related sysfs files will only be created if CONFIG_SCHED_BOOK is selected.
 
 For an architecture to support this feature, it must define some of
@@ -48,16 +63,17 @@ these macros in include/asm-XXX/topology.h:
 #define topology_core_cpumask(cpu)
 #define topology_book_cpumask(cpu)
 
-The type of **_id is int.
-The type of siblings is (const) struct cpumask *.
+The type of **_id macros is int.
+The type of **_cpumask macros is (const) struct cpumask *. The latter
+correspond with appropriate **_siblings sysfs attributes.
 
 To be consistent on all architectures, include/linux/topology.h
 provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 1) physical_package_id: -1
 2) core_id: 0
-3) thread_siblings: just the given CPU
-4) core_siblings: just the given CPU
+3) thread_cpumask: just the given CPU
+4) core_cpumask: just the given CPU
 
 For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
 default definitions for topology_book_id() and topology_book_cpumask().
-- 
2.1.4

