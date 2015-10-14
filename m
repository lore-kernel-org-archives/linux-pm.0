From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] PM / OPP: Remove confusing error message in of_cpumask_init_opp_table()
Date: Wed, 14 Oct 2015 17:52:23 +0200
Message-ID: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40974 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754135AbbJNPxR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 11:53:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The of_cpumask_init_opp_table() function will print an error message
(with pr_err) if it cannot find the OPP table for a certain CPU in the
Device Tree.

There are users of the cpufreq-dt driver (which is the one calling
of_cpumask_init_opp_table) that do not have the OPP points defined in
the Device Tree. Instead, such users dynamically create the OPP table
at boot time depending on the system configuration. Such a case is
planned in the cpufreq-dt driver, which on purpose ignores the return
value of of_cpumask_init_opp_table() with the following comment: "OPPs
might be populated at runtime, don't check for error here".

For such platforms, the of_cpumask_init_opp_table() prints a spurious
and confusing error message for each CPU:

[    1.749548] of_cpumask_init_opp_table: couldn't find opp table for cpu:0, -19
[    1.756784] of_cpumask_init_opp_table: couldn't find opp table for cpu:1, -19
[    1.764031] of_cpumask_init_opp_table: couldn't find opp table for cpu:2, -19
[    1.771268] of_cpumask_init_opp_table: couldn't find opp table for cpu:3, -19

This is confusing because everything is working fine, cpufreq works
and it knows the OPP table that was registered at boot time (on
Marvell Armada XP):

$ cat /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state
666500 1884
1333000 23333

To avoid this confusion, this patch simply deletes the error message.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/base/power/opp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 7ae7cd9..11206d2 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1489,9 +1489,6 @@ int of_cpumask_init_opp_table(cpumask_var_t cpumask)
 
 		ret = of_init_opp_table(cpu_dev);
 		if (ret) {
-			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
-			       __func__, cpu, ret);
-
 			/* Free all other OPPs */
 			of_cpumask_free_opp_table(cpumask);
 			break;
-- 
2.6.1

