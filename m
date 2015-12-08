From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/4]  cpufreq governors and Intel P state driver compatibility
Date: Tue,  8 Dec 2015 14:31:26 -0800
Message-ID: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60772 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbbLHWco (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 17:32:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, prarit@redhat.com, trenn@suse.de, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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


v2
- Suggestion by Viresh to remove callback to get policies
- Document update for cpufreq cpu-drivers
- Dropped powersave patch, so that it will still default to ondemand
as a possible option suggested by Thomas.

If it breaks any distros are user, who were using Intel P state driver with
powersave, please comment.

v1 
base version

To be done:
Intel P state document update

Srinivas Pandruvada (4):
  cpufreq: Add configurable generic policies
  cpufreq: Add ondemand as a generic policy
  Documentation: cpu-freq: update setpolicy documentation
  cpufreq: intel_pstate: Change powersave to ondemand policy

 Documentation/cpu-freq/cpu-drivers.txt |  9 +++++++--
 drivers/cpufreq/cpufreq.c              | 17 ++++++++++++++++-
 drivers/cpufreq/intel_pstate.c         | 14 ++++++++------
 include/linux/cpufreq.h                |  4 +++-
 4 files changed, 34 insertions(+), 10 deletions(-)

-- 
2.4.3

