From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: intel_pstate: fix intel_pstate_exit_perf_limits prototype
Date: Fri, 25 Nov 2016 17:50:20 +0100
Message-ID: <20161125165036.195969-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The addition of the generic governor support marked the
intel_pstate_exit_perf_limits as inline, which fixed a warning,
but it introduced another warning:

drivers/cpufreq/intel_pstate.c: In function ‘intel_pstate_exit_perf_limits’:
drivers/cpufreq/intel_pstate.c:483:1: error: no return statement in function returning non-void [-Werror=return-type]

This changes it back to a 'void' return type, and changes the
corresponding intel_pstate_init_acpi_perf_limits() function to
be inline as well for consistency.

Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 7159dbde0160..8921686b8cd2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -474,11 +474,11 @@ static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 }
 
 #else
-static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
+static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
 }
 
-static inline int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 {
 }
 #endif
-- 
2.9.0
