From: Fengguang Wu <fengguang.wu@intel.com>
Subject: drivers/cpufreq/cpufreq.c:51:17: sparse: symbol
 'cpufreq_online_mask' was not declared. Should it be static?
Date: Fri, 11 Jan 2013 22:03:01 +0800
Message-ID: <20130111140301.GA25489@localhost>
References: <50f017f7.SoVcNexmm6uNvfQX%yuanhan.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35882 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816Ab3AKODK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Jan 2013 09:03:10 -0500
Content-Disposition: inline
In-Reply-To: <50f017f7.SoVcNexmm6uNvfQX%yuanhan.liu@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Viresh,

FYI, there are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   f3bb59ab652c781155b1c5e42ef7e29bf936d86b
commit: 536ff06aba714c1d2d53cfca86b1a2e455842387 cpufreq: Don't use cpu removed during cpufreq_driver_unregister
date:   15 hours ago

drivers/cpufreq/cpufreq.c:43:8: sparse: symbol 'cpufreq_cpu_data' was not declared. Should it be static?
   drivers/cpufreq/cpufreq.c:46:8: sparse: symbol 'cpufreq_cpu_governor' was not declared. Should it be static?
>> drivers/cpufreq/cpufreq.c:51:17: sparse: symbol 'cpufreq_online_mask' was not declared. Should it be static?
   drivers/cpufreq/cpufreq.c:72:8: sparse: symbol 'cpufreq_policy_cpu' was not declared. Should it be static?
   drivers/cpufreq/cpufreq.c:73:8: sparse: symbol 'cpu_policy_rwsem' was not declared. Should it be static?

Please consider folding the attached diff :-)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

--zYM0uCDKw75PZbzx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="make-it-static-536ff06.diff"

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 271d3be..26dbf40 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -48,7 +48,7 @@ static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
 static DEFINE_SPINLOCK(cpufreq_driver_lock);
 
 /* Used when we unregister cpufreq driver */
-struct cpumask	cpufreq_online_mask;
+static struct cpumask	cpufreq_online_mask;
 
 /*
  * cpu_policy_rwsem is a per CPU reader-writer semaphore designed to cure

--zYM0uCDKw75PZbzx--
