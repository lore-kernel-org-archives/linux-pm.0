From: Andreas Herrmann <aherrmann@suse.com>
Subject: [PATCH v3 2/2] cpufreq/pcc-cpufreq: Make use of map_load_to_freq op
Date: Mon, 26 Sep 2016 11:05:57 +0200
Message-ID: <20160926090557.GA29668@suselix.suse.de>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160923165632.GA9786@suselix.suse.de>
 <20160923170744.GC9786@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:32851 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933666AbcIZJGJ (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Mon, 26 Sep 2016 05:06:09 -0400
Content-Disposition: inline
In-Reply-To: <20160923170744.GC9786@suselix.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>


Commit 6393d6a102 (cpufreq: ondemand: Eliminate the deadband effect)
introduced a performance regression for systems using pcc-cpufreq and
ondemand governor. This is measurable with different workloads. E.g.
wall-clock time for kernel compilation significantly increased.

The elimination of the deadband effect significantly increased the
number of frequency changes with pcc-cpufreq.

Provide a pcc-cpufreq specific function that reintroduces the mapping
of load to frequency which was used before commit 6393d6a102 and hence
re-introduces the deadband effect for this cpufreq driver.

Performance results (kernel compile with different number of jobs)
based on 4.8.0-rc7 (with and w/o my patches on top) from
an HP ProLiant DL580 Gen8 system using pcc-cpufreq:
 - Intel(R) Xeon(R) CPU E7-4890 v2 @ 2.80GHz
 - 60 CPUs, 128GB RAM
                                                       pcc specific
            generic_map_load_to_freq function     map_load_to_freq function
 # of jobs    user    sys   elapsed   % CPU      user    sys   elapsed   % CPU
    2        445.56  111.22  273.35   203.00    413.19  102.34  250.97   205.00
    4        445.61  126.10  143.12   399.00    390.56  120.79  127.25   401.20
    8        483.51  150.84   82.17   771.40    354.22  140.09   64.20   769.60
   16        628.01  185.54   55.02  1477.80    384.20  148.69   37.07  1436.60
   32        818.58  205.51   37.02  2765.40    496.70  152.77   25.15  2581.40
   64        406.22   51.84   13.84  3308.80    399.48   49.13   12.80  3505.80
  120        413.61   49.06   14.54  3181.00    406.52   46.89   13.60  3331.60

Link: https://marc.info/?i=20160819121814.GA17296%40suselix.suse.de
Signed-off-by: Andreas Herrmann <aherrmann@suse.com>
---
 drivers/cpufreq/Kconfig.x86   |  2 +-
 drivers/cpufreq/pcc-cpufreq.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

Kbuild test robot detected a build issue with my patch:

   drivers/built-in.o: In function `pcc_cpufreq_cpu_exit':
>> pcc-cpufreq.c:(.text+0x321019): undefined reference to `od_unregister_map_load_to_freq_handler'
   drivers/built-in.o: In function `pcc_cpufreq_cpu_init':
>> pcc-cpufreq.c:(.text+0x32136a): undefined reference to `od_register_map_load_to_freq_handler'

for configs that selected X86_PCC_CPUFREQ but not
CPU_FREQ_GOV_ONDEMAND.

This new patch version adds the required build dependency as my change
makes pcc-cpufreq dependent on cpufreq_ondemand.
Sorry for the omission in the previous patch version.


Regards,

Andreas

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index adbd1de..f159726 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -18,7 +18,7 @@ config X86_INTEL_PSTATE
 
 config X86_PCC_CPUFREQ
 	tristate "Processor Clocking Control interface driver"
-	depends on ACPI && ACPI_PROCESSOR
+	depends on CPU_FREQ_GOV_ONDEMAND && ACPI && ACPI_PROCESSOR
 	help
 	  This driver adds support for the PCC interface.
 
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 3f0ce2a..1522747 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -39,6 +39,8 @@
 
 #include <acpi/processor.h>
 
+#include "cpufreq_governor.h"
+
 #define PCC_VERSION	"1.10.00"
 #define POLL_LOOPS 	300
 
@@ -534,6 +536,12 @@ out_free:
 	return ret;
 }
 
+static unsigned int pcc_map_load_to_freq(struct cpufreq_policy *policy,
+					unsigned int load)
+{
+	return (load * policy->cpuinfo.max_freq / 100);
+}
+
 static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -555,6 +563,8 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->min = policy->cpuinfo.min_freq =
 		ioread32(&pcch_hdr->minimum_frequency) * 1000;
 
+	od_register_map_load_to_freq_handler(pcc_map_load_to_freq);
+
 	pr_debug("init: policy->max is %d, policy->min is %d\n",
 		policy->max, policy->min);
 out:
@@ -563,6 +573,7 @@ out:
 
 static int pcc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
+	od_unregister_map_load_to_freq_handler();
 	return 0;
 }
 
-- 
1.9.1

