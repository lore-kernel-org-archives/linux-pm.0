From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 19/26] intel_pstate: constify local structures
Date: Sun, 11 Sep 2016 15:06:01 +0200
Message-ID: <1473599168-30561-20-git-send-email-Julia.Lawall@lip6.fr>
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: joe@perches.com, kernel-janitors@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

For structure types defined in the same file or local header files, find
top-level static structure declarations that have the following
properties:
1. Never reassigned.
2. Address never taken
3. Not passed to a top-level macro call
4. No pointer or array-typed field passed to a function or stored in a
variable.
Declare structures having all of these properties as const.

Done using Coccinelle.
Based on a suggestion by Joe Perches <joe@perches.com>.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The semantic patch seems too long for a commit log, but is in the cover
letter.

 drivers/cpufreq/intel_pstate.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bdbe936..4b5f8c3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1029,7 +1029,7 @@ static struct cpu_defaults core_params = {
 	},
 };
 
-static struct cpu_defaults silvermont_params = {
+static const struct cpu_defaults silvermont_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
@@ -1050,7 +1050,7 @@ static struct cpu_defaults silvermont_params = {
 	},
 };
 
-static struct cpu_defaults airmont_params = {
+static const struct cpu_defaults airmont_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
@@ -1071,7 +1071,7 @@ static struct cpu_defaults airmont_params = {
 	},
 };
 
-static struct cpu_defaults knl_params = {
+static const struct cpu_defaults knl_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
@@ -1091,7 +1091,7 @@ static struct cpu_defaults knl_params = {
 	},
 };
 
-static struct cpu_defaults bxt_params = {
+static const struct cpu_defaults bxt_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
