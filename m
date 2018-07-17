From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on many-CPU systems
Date: Tue, 17 Jul 2018 18:14:58 +0200
Message-ID: <5423012.ZZnfdYddaT@aspire.rjw.lan>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <306375154.NhdH6AhdAd@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <306375154.NhdH6AhdAd@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The firmware interface used by the pcc-cpufreq driver is
fundamentally not scalable and using it for dynamic CPU performance
scaling on systems with many CPUs leads to degraded performance.

For this reason, disable dynamic CPU performance scaling on systems
with pcc-cpufreq where the number of CPUs present at the driver init
time is greater than 4.  Also make the driver print corresponding
complaints to the kernel log.

Reported-by: Andreas Herrmann <aherrmann@suse.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Rework the messages printed in the problematic case.

---
 drivers/cpufreq/pcc-cpufreq.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-pm/drivers/cpufreq/pcc-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/pcc-cpufreq.c
+++ linux-pm/drivers/cpufreq/pcc-cpufreq.c
@@ -589,6 +589,15 @@ static int __init pcc_cpufreq_init(void)
 		return ret;
 	}
 
+	if (num_present_cpus() > 4) {
+		pcc_cpufreq_driver.flags |= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING;
+		pr_err("%s: Too many CPUs, dynamic performance scaling disabled\n",
+		       __func__);
+		pr_err("%s: Try to enable a different scaling driver through BIOS settings\n",
+		       __func__);
+		pr_err("%s: and complain to the system vendor\n", __func__);
+	}
+
 	ret = cpufreq_register_driver(&pcc_cpufreq_driver);
 
 	return ret;
