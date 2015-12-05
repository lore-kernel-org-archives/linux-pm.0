From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/4] cpufreq governors and Intel P state driver compatibility
Date: Fri,  4 Dec 2015 16:08:34 -0800
Message-ID: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbbLEAJs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:09:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Intel P State driver implements two policies, performance and powersave.
The powersave policy is similar to ondemand cpufreq governor when using
acpi-cpufreq. This causes lots of confusion among users. This results
in invalid comparison of performance when acpi-cpufreq and Intel P state
performance is compared.

The reason Intel P state called powersave when it actually implemented
ondemand style P State selection, because the cpufreq core only allows
two generic policies "performance and powersave" for drivers which has
setpolicy() interface. All drivers using this interface are forced to
support these two policies.

This patchset adds feature to have configurable generic policies and
allows ondemand as one of the policy. With this approach, Intel P state
now adds support for ondemand policy and power save policy both in
addition to performance.

To be done:
cpufreq and Intel P state documentation update:
Once this approach is OK, will submit a patch to update.

Srinivas Pandruvada (4):
  cpufreq: Add configurable generic policies
  cpufreq: Add ondemand as a generic policy
  cpufreq: intel_pstate: Change powersave to ondemand policy
  cpufreq: intel_pstate: Add powersave policy support

 drivers/cpufreq/cpufreq.c      | 22 +++++++++++++-
 drivers/cpufreq/intel_pstate.c | 66 +++++++++++++++++++++++++++++++++---------
 include/linux/cpufreq.h        |  6 +++-
 3 files changed, 79 insertions(+), 15 deletions(-)

-- 
2.4.3

