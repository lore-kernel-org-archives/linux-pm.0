From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH RFC 06/15] cpufreq: replace **** with a hug
Date: Fri, 30 Nov 2018 11:27:15 -0800
Message-ID: <20181130192737.15053-7-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

In order to comply with the CoC, replace **** with a hug.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/cpufreq/powernow-k7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index d6cb052b0a75..302315ad3786 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -574,7 +574,7 @@ static int acer_cpufreq_pst(const struct dmi_system_id *d)
 }
 
 /*
- * Some Athlon laptops have really fucked PST tables.
+ * Some Athlon laptops have really hugged PST tables.
  * A BIOS update is all that can save them.
  * Mention this, and disable cpufreq.
  */
-- 
2.19.1
