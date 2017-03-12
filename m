From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 09/14] cpufreq: intel_pstate: Modify check in intel_pstate_update_status()
Date: Sun, 12 Mar 2017 18:20:48 +0100
Message-ID: <9441548.ISbjm4vJsD@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51413 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934649AbdCLRcj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:39 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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
@@ -2439,7 +2439,7 @@ static int intel_pstate_update_status(co
 
 	if (size == 7 && !strncmp(buf, "passive", size)) {
 		if (intel_pstate_driver) {
-			if (intel_pstate_driver != &intel_pstate)
+			if (intel_pstate_driver == &intel_cpufreq)
 				return 0;
 
 			ret = intel_pstate_unregister_driver();
