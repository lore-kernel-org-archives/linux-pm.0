From: dirk.brandewie@gmail.com
Subject: [PATCH 3/3] intel_pstate: Update documentation of {max,min}_perf_pct sysfs files
Date: Fri, 20 Jun 2014 07:28:00 -0700
Message-ID: <1403274480-10593-4-git-send-email-dirk.j.brandewie@intel.com>
References: <1403274480-10593-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:49238 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbaFTO2P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jun 2014 10:28:15 -0400
In-Reply-To: <1403274480-10593-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, stable@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Update documentation to make the interpretation of the values clearer

References: https://bugzilla.kernel.org/show_bug.cgi?id=64251

Cc: Stable <stable@vger.kernel.org>  [3.13+]
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index e742d21..a69ffe1 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -15,10 +15,13 @@ New sysfs files for controlling P state selection have been added to
 /sys/devices/system/cpu/intel_pstate/
 
       max_perf_pct: limits the maximum P state that will be requested by
-      the driver stated as a percentage of the available performance.
+      the driver stated as a percentage of the available performance. The
+      available (P states) performance may be reduced by the no_turbo
+      setting described below.
 
       min_perf_pct: limits the minimum P state that will be  requested by
-      the driver stated as a percentage of the available performance.
+      the driver stated as a percentage of the max (non-turbo)
+      performance level.
 
       no_turbo: limits the driver to selecting P states below the turbo
       frequency range.
-- 
1.9.0

