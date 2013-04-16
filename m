From: Alex Shi <alex.shi@intel.com>
Subject: bltk-game regressions on snb laptop
Date: Tue, 16 Apr 2013 15:14:31 +0800
Message-ID: <516CFA57.3060709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47439 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127Ab3DPHPG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Apr 2013 03:15:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>

LKP found a performance and performance/watt regression on commit
aa77a52764a92216b61, acpi-cpufreq: Don't set policy->related_cpus from
.init.

The commit removed the related_cpus setting, plus Our laptop has no
coordinate type setting in BIOS. So the related_cpus is only include the
cpu self, then the policy->cpus are impacted and only has self too.

With ondemand governor, the bad commit cause bltk-game benchmark drop to
18fps from 50fps, the performance/watt value also dropped a lot.
bltk-game runs 9 thread on the 4core*HT laptop.

As Arjan and Len mentioned, the commit is correct in logical,
policy->cpus should only include the cpu self.
So I don't know where is the problem, maybe ondemand or some place
others. Anyway, I just report the issue to you.

-- 
Thanks Alex
