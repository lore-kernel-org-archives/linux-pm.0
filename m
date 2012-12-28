From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] Fix problem with cpufreq_pndemand or cpufreq_conservative
Date: Fri, 28 Dec 2012 16:17:24 -0600
Message-ID: <50DE1A74.4040607@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39580 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab2L1WR1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Dec 2012 17:17:27 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Since commit 2aacdff entitled "cpufreq: Move common part from governors to 
separate file", whenever the drivers that depend on this new file 
(cpufreq_ondemand or cpufreq_conservative) are built as modules, a new module 
named cpufreq_governor is created. It seems that kmake is smart enough to create 
a separate module whenever more than one module includes the same object file. 
As drivers/cpufreq/cpufreq_governor.c contains no MODULE directives, the 
resulting module has no license specified, which results in logging of a "module 
license 'unspecified' taints kernel". In addition, a number of globals are 
exported GPL only, and are therefore not available.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

This particular patch is the simplest possible; however, it hides the intent. I 
have prepared the longer version that makes the reason clearer by adding a new 
configuration variable that is dependent on the other two, and rearranges 
drivers/cpufreq/Makefile. That version could be submitted if that is what is 
desired. The changes to cpufreq_governor.c are the same as in this version.

Larry


       cpufreq_governor.c |    5 +++++
       1 file changed, 5 insertions(+)
---
Index: wireless-testing-new/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- wireless-testing-new.orig/drivers/cpufreq/cpufreq_governor.c
+++ wireless-testing-new/drivers/cpufreq/cpufreq_governor.c
@@ -25,6 +25,7 @@
  #include <linux/tick.h>
  #include <linux/types.h>
  #include <linux/workqueue.h>
+#include <linux/module.h>

  #include "cpufreq_governor.h"

@@ -316,3 +317,7 @@ second_time:
  	return 0;
  }
  EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);
+MODULE_AUTHOR("Alexander Clouter <alex@digriz.org.uk>");
+MODULE_DESCRIPTION("'cpufreq_governor' - A mini-module containing "
+		"common code for cpufreq_conservative and cpufreq_ondemand");
+MODULE_LICENSE("GPL");






