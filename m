From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] cpufreq: Pass updated policy to driver ->setpolicy() callback
Date: Wed, 20 Feb 2019 00:26:30 +0100
Message-ID: <1982548.ex0OEcQ4PI@aspire.rjw.lan>
References: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The invocation of the ->setpolicy() cpufreq driver callback should
be equivalent to calling cpufreq_governor_limits(policy) for drivers
with internal governors, but in fact it isn't so, because the
temporary new_policy object is passed to it instead of the updated
policy.

That is a bit confusing, so make cpufreq_set_policy() pass the
updated policy to the driver ->setpolicy() callback.

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2286,7 +2286,7 @@ static int cpufreq_set_policy(struct cpu
 	if (cpufreq_driver->setpolicy) {
 		policy->policy = new_policy->policy;
 		pr_debug("setting range\n");
-		return cpufreq_driver->setpolicy(new_policy);
+		return cpufreq_driver->setpolicy(policy);
 	}
 
 	if (new_policy->governor == policy->governor) {
