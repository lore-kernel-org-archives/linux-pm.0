From: Fengguang Wu <fengguang.wu@intel.com>
Subject: drivers/cpufreq/cpufreq_governor.c:46:53: sparse: incorrect type
 in argument 2 (different modifiers)
Date: Tue, 23 Oct 2012 12:51:33 +0800
Message-ID: <50862255.Foit2oXcLVE39lAk%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_50862255.5/0qfSWSHA4CZlZuz3CnN7XYMrezVzqwyW9eXLdAd51/Ctjw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31394 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2JWFBx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Oct 2012 01:01:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

This is a multi-part message in MIME format.

--=_50862255.5/0qfSWSHA4CZlZuz3CnN7XYMrezVzqwyW9eXLdAd51/Ctjw
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi viresh,

FYI, there are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   13f5e2d9a915373dd1573d8fe0214738bc69004f
commit: 83a73f712f2275033b2dc7f5c664988a1823ebc7 cpufreq: Move common part from governors to separate file, v2
date:   5 hours ago

+ drivers/cpufreq/cpufreq_governor.c:46:53: sparse: incorrect type in argument 2 (different modifiers)
drivers/cpufreq/cpufreq_governor.c:46:53:    expected unsigned long long [usertype] *wall
drivers/cpufreq/cpufreq_governor.c:46:53:    got unsigned long long [nocast] [usertype] *wall
+ drivers/cpufreq/cpufreq_governor.c:46:53: sparse: implicit cast from nocast type
drivers/cpufreq/cpufreq_governor.c:48:58: sparse: incorrect type in argument 2 (different modifiers)
drivers/cpufreq/cpufreq_governor.c:48:58:    expected unsigned long long [usertype] *last_update_time
drivers/cpufreq/cpufreq_governor.c:48:58:    got unsigned long long [nocast] [usertype] *wall
drivers/cpufreq/cpufreq_governor.c:48:58: sparse: implicit cast from nocast type

vim +46 drivers/cpufreq/cpufreq_governor.c

83a73f71 viresh kumar 2012-10-23  30  	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
83a73f71 viresh kumar 2012-10-23  31  	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
83a73f71 viresh kumar 2012-10-23  32  	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
83a73f71 viresh kumar 2012-10-23  33  
83a73f71 viresh kumar 2012-10-23  34  	idle_time = cur_wall_time - busy_time;
83a73f71 viresh kumar 2012-10-23  35  	if (wall)
83a73f71 viresh kumar 2012-10-23  36  		*wall = jiffies_to_usecs(cur_wall_time);
83a73f71 viresh kumar 2012-10-23  37  
83a73f71 viresh kumar 2012-10-23  38  	return jiffies_to_usecs(idle_time);
83a73f71 viresh kumar 2012-10-23  39  }
83a73f71 viresh kumar 2012-10-23  40  
83a73f71 viresh kumar 2012-10-23  41  cputime64_t get_cpu_idle_time(unsigned int cpu, cputime64_t *wall)
83a73f71 viresh kumar 2012-10-23  42  {
83a73f71 viresh kumar 2012-10-23  43  	u64 idle_time = get_cpu_idle_time_us(cpu, NULL);
83a73f71 viresh kumar 2012-10-23  44  
83a73f71 viresh kumar 2012-10-23  45  	if (idle_time == -1ULL)
83a73f71 viresh kumar 2012-10-23 @46  		return get_cpu_idle_time_jiffy(cpu, wall);
83a73f71 viresh kumar 2012-10-23  47  	else
83a73f71 viresh kumar 2012-10-23  48  		idle_time += get_cpu_iowait_time_us(cpu, wall);
83a73f71 viresh kumar 2012-10-23  49  
83a73f71 viresh kumar 2012-10-23  50  	return idle_time;
83a73f71 viresh kumar 2012-10-23  51  }
83a73f71 viresh kumar 2012-10-23  52  EXPORT_SYMBOL_GPL(get_cpu_idle_time);

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

--=_50862255.5/0qfSWSHA4CZlZuz3CnN7XYMrezVzqwyW9eXLdAd51/Ctjw
Content-Type: text/x-csrc;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cpufreq_governor.c"

/*
 * drivers/cpufreq/cpufreq_governor.c
 *
 * CPUFREQ governors common code
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <asm/cputime.h>
#include <linux/export.h>
#include <linux/kernel_stat.h>
#include <linux/tick.h>
#include <linux/types.h>
/*
 * Code picked from earlier governer implementations
 */
static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
{
	u64 idle_time;
	u64 cur_wall_time;
	u64 busy_time;

	cur_wall_time = jiffies64_to_cputime64(get_jiffies_64());

	busy_time = kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];

	idle_time = cur_wall_time - busy_time;
	if (wall)
		*wall = jiffies_to_usecs(cur_wall_time);

	return jiffies_to_usecs(idle_time);
}

cputime64_t get_cpu_idle_time(unsigned int cpu, cputime64_t *wall)
{
	u64 idle_time = get_cpu_idle_time_us(cpu, NULL);

	if (idle_time == -1ULL)
		return get_cpu_idle_time_jiffy(cpu, wall);
	else
		idle_time += get_cpu_iowait_time_us(cpu, wall);

	return idle_time;
}
EXPORT_SYMBOL_GPL(get_cpu_idle_time);

--=_50862255.5/0qfSWSHA4CZlZuz3CnN7XYMrezVzqwyW9eXLdAd51/Ctjw--
