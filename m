From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] Correct the processing for base_frequency
Date: Mon, 25 Mar 2019 09:04:38 -0700
Message-ID: <20190325160440.7575-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pprakash@codeaurora.org, wangxiongfeng2@huawei.com, srinivas.pandruvada@linux.intel.com
List-Id: linux-pm@vger.kernel.org

The base_frequency display in cpufreq sysfs for intel_pstate gets the
guaranteed ratio by reading CPPC guaranteed performance register as a
first preference before falling back to x86 MSR for Hardware P-state
Capabilities. The current code in cppc_acpi.c assumed that "guaranteed
performance register" can be an integer field, which is invalid as per
ACPI spec. So this change explicitly check for INTEGER values for
invalid BIOS/firmware and ignore. 
Also guaranteed performance register field is optional and when not
present, nominal performance can be used as the guaranteed performance.
But spec calls that this is true only in non-autonomous mode. So
no change is made in cppc_acpi.c to make nominal as guaranteed in this
case to avoid dependency on autonomous and non-autonomous mode. Instead
a change is added to intel_pstate driver, which is specific to x86 to
make nominal as guaranteed when guaranteed performance field is absent
or has invalid value.
Also we are working to clarify this non-autonomous mode requirement
through ACPI standard body.

v2:
Changes done as suggested by Rafael.


Srinivas Pandruvada (2):
  ACPI / CPPC: Fix processing for guaranteed performance
  cpufreq: intel_pstate: Also use cppc nominal_perf for base_frequency

 drivers/acpi/cppc_acpi.c       | 9 +++++++--
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.17.2
