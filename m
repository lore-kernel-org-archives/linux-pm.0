From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: [PATCH] cpufreq: cpufreq-cpu0: clk_round_rate() can return a zero
 upon error
Date: Mon, 25 Nov 2013 18:01:18 -0800
Message-ID: <alpine.DEB.2.02.1311251559460.23090@tamien>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mike Turquette <mturquette@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
---
Applies on v3.13-rc1.  See also:

http://marc.info/?l=linux-arm-kernel&m=138542591313620&w=2

  drivers/cpufreq/cpufreq-cpu0.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index d4585ce2346c..0faf756f6197 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -44,7 +44,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
  	int ret;

  	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
-	if (freq_Hz < 0)
+	if (freq_Hz <= 0)
  		freq_Hz = freq_table[index].frequency * 1000;

  	freq_exact = freq_Hz;
