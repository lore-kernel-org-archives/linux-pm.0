From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: docs: Add missing cpuinfo_cur_freq description
Date: Thu, 27 Jul 2017 02:05:56 +0200
Message-ID: <3481245.BTZgO6DXTS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48929 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751078AbdG0AN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 20:13:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a description of the cpuinfo_cur_freq policy attribute in sysfs
to the cpufreq documentation under Documentation/admin-guide/pm/ as
it is missing after commit 2a0e49279850 (cpufreq: User/admin
documentation update and consolidation) that overlooked it.

Fixes: 2a0e49279850 (cpufreq: User/admin documentation update and consolidation)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpufreq.rst |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/Documentation/admin-guide/pm/cpufreq.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpufreq.rst
+++ linux-pm/Documentation/admin-guide/pm/cpufreq.rst
@@ -237,6 +237,14 @@ are the following:
 	This attribute is not present if the scaling driver in use does not
 	support it.
 
+``cpuinfo_cur_freq``
+	Current frequency of the CPUs belonging to this policy as obtained from
+	the hardware (in KHz).
+
+	This is expected to be the frequency the hardware actually runs at.
+	If that frequency cannot be determined, this attribute should not
+	be present.
+
 ``cpuinfo_max_freq``
 	Maximum possible operating frequency the CPUs belonging to this policy
 	can run at (in kHz).
