From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH] cpufreq: Support of Energy Performance preference
Date: Tue, 15 Nov 2016 14:59:42 -0800
Message-ID: <1479250783-74336-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, morten.rasmussen@arm.com, Juri.Lelli@arm.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This change allows user to provide hints to P-State selection algorithm
to be more more performance centric or more energy centric.

Even if this change only impacts intel_pstate driver, this change is
submitted as RFC to check if we need a generic method in cpufreq to
support such configuration.

If other SoCs don't allow such configuration, then this change can be only
in intel_pstate using local cpufreq attributes as it is implemented now.

Srinivas Pandruvada (1):
  cpufreq: intel_pstate: Support of energy performance hint using HWP

 drivers/cpufreq/intel_pstate.c | 194 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

-- 
2.7.4
