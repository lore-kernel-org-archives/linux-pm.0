From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: thermal / x86: Fix init error code path in package temperature driver
Date: Sat, 20 Jul 2013 22:48:03 +0200
Message-ID: <1652739.TRfBKHdnvc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63849 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754860Ab3GTUiG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Jul 2013 16:38:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The error code path of the x86 package temperature thermal driver's
initialization routine, pkg_temp_thermal_init(), makes an unbalanced
call to get_online_cpus(), which causes subsequent CPU offline
operations, and consequently system suspend, to permanently block
in cpu_hotplug_begin() on systems where get_core_online() returns
an error code.

Remove the extra get_online_cpus() to fix the problem (tested on
Toshiba Portege R500).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/x86_pkg_temp_thermal.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/thermal/x86_pkg_temp_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/x86_pkg_temp_thermal.c
+++ linux-pm/drivers/thermal/x86_pkg_temp_thermal.c
@@ -592,7 +592,6 @@ static int __init pkg_temp_thermal_init(
 	return 0;
 
 err_ret:
-	get_online_cpus();
 	for_each_online_cpu(i)
 		put_core_offline(i);
 	put_online_cpus();

