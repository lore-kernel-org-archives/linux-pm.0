From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: governor: Drop pointless goto from cpufreq_governor_init()
Date: Mon, 08 Feb 2016 23:57:22 +0100
Message-ID: <121264863.5TXTuENuar@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is silly to jump around "return 0", so don't do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of the bleeding-edge branch of linux-pm.git.

Thanks,
Rafael

---
 drivers/cpufreq/cpufreq_governor.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -394,12 +394,11 @@ static int cpufreq_governor_init(struct
 
 	ret = sysfs_create_group(get_governor_parent_kobj(policy),
 				 get_sysfs_attr(gov));
-	if (ret)
-		goto reset_gdbs_data;
+	if (!ret)
+		return 0;
 
-	return 0;
+	/* Failure, so roll back. */
 
-reset_gdbs_data:
 	policy->governor_data = NULL;
 
 	if (!have_governor_per_policy())
