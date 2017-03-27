From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 09/16] cpufreq: intel_pstate: Modify check in intel_pstate_update_status()
Date: Tue, 28 Mar 2017 00:14:08 +0200
Message-ID: <3621003.tsN5tfAxs4@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65505 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752108AbdC0WkD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 18:40:03 -0400
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the checks in intel_pstate_update_status() implicitly relies
on the information that there are only two struct cpufreq_driver
objects available, but it is better to do it directly against the
value it really is about (to make the code easier to follow if
nothing else).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2345,7 +2345,7 @@ static int intel_pstate_update_status(co
 
 	if (size == 7 && !strncmp(buf, "passive", size)) {
 		if (intel_pstate_driver) {
-			if (intel_pstate_driver != &intel_pstate)
+			if (intel_pstate_driver == &intel_cpufreq)
 				return 0;
 
 			ret = intel_pstate_unregister_driver();
