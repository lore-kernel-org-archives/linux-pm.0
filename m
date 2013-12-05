From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] cpufreq_ at32ap-cpufreq.c: Fix section mismatch
Date: Thu,  5 Dec 2013 10:59:57 +0100
Message-ID: <1386237597-1211-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hskinnemoen@gmail.com, egtvedt@samfundet.no, heiko@sntech.de
Cc: Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pm@vger.kernel.org

The function at32_cpufreq_driver_init was marked as __init but will be
called from inside the cpufreq framework. This lead to the following a
section mismatch during compilation:

WARNING: drivers/built-in.o(.data+0x2448): Section mismatch in reference
from the variable at32_driver to the function
.init.text:at32_cpufreq_driver_init()
The variable at32_driver references
the function __init at32_cpufreq_driver_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/cpufreq/at32ap-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
index e0c38d9..372c426 100644
--- a/drivers/cpufreq/at32ap-cpufreq.c
+++ b/drivers/cpufreq/at32ap-cpufreq.c
@@ -83,7 +83,7 @@ static int at32_set_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
-static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
+static int at32_cpufreq_driver_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-- 
1.8.1.2

