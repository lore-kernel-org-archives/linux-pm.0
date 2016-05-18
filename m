From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/6] cpufreq: minor cleanups
Date: Wed, 18 May 2016 17:55:25 +0530
Message-ID: <cover.1463574213.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35575 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbcERMZi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 08:25:38 -0400
Received: by mail-pa0-f47.google.com with SMTP id gj5so17390468pac.2
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 05:25:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Rafael,

These are few cleanup patches for cpufreq governors, they shouldn't be
doing any functional changes.

Rebased over bleeding-edge.

--
viresh

Viresh Kumar (6):
  cpufreq: governor: Remove prints from allocation failures
  cpufreq: governor: Remove unnecessary bits from print message
  cpufreq: schedutil: Improve prints messages with pr_fmt
  cpufreq: conservative: Remove declaration of cs_dbs_gov
  cpufreq: Reuse gov_attr_* macros in schedutil governor
  cpufreq: governor: Create cpufreq_policy_apply_limits()

 drivers/cpufreq/cpufreq_conservative.c |  6 +-----
 drivers/cpufreq/cpufreq_governor.c     |  9 ++-------
 drivers/cpufreq/cpufreq_governor.h     |  8 --------
 drivers/cpufreq/cpufreq_ondemand.c     |  4 +---
 include/linux/cpufreq.h                | 16 ++++++++++++++++
 kernel/sched/cpufreq_schedutil.c       | 21 ++++++++-------------
 6 files changed, 28 insertions(+), 36 deletions(-)

-- 
2.7.1.410.g6faf27b

