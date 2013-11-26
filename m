From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: [PATCH] cpufreq: SPEAr: clk_round_rate() can return a zero upon
 error
Date: Mon, 25 Nov 2013 18:04:34 -0800
Message-ID: <alpine.DEB.2.02.1311251801210.23090@tamien>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Treat both negative and zero return values from clk_round_rate()
as errors.  This is needed since subsequent patches will convert
clk_round_rate()'s return value to be an unsigned type, rather
than a signed type, since some clock sources can generate rates
higher than (2^31)-1 Hz.

Eventually, when calling clk_round_rate(), only a return value of
zero will be considered a error.  All other values will be
considered valid rates.  The comparison against values less than
0 is kept to preserve the correct behavior in the meantime.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Applies on v3.13-rc1.  See also:

http://marc.info/?l=linux-arm-kernel&m=138542591313620&w=2

  drivers/cpufreq/spear-cpufreq.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index d02ccd19c9c4..45ea4c094542 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -138,7 +138,7 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
  	}

  	newfreq = clk_round_rate(srcclk, newfreq * mult);
-	if (newfreq < 0) {
+	if (newfreq <= 0) {
  		pr_err("clk_round_rate failed for cpu src clock\n");
  		return newfreq;
  	}
