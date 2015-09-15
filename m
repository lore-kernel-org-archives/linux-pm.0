From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Tue, 15 Sep 2015 13:28:49 +0530
Message-ID: <20150915075849.GC6350@linux>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
 <11470100.cEo24Tpcgr@vostro.rjw.lan>
 <20150910012222.GN5266@linux>
 <1725227.VMGKuhRxma@vostro.rjw.lan>
 <20150911161802.GR9650@linux>
 <20150915073921.GA6350@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150915073921.GA6350@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 15-09-15, 13:09, Viresh Kumar wrote:
> I would have sent a patch for this, but I thought you would like to
> edit the original patch itself to not break git bisect.

But in case you are applying it separately, here is the fix.

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 15 Sep 2015 13:09:54 +0530
Subject: [PATCH] cpufreq: cpufreq_cpu_get_raw() isn't a static function
 anymore

Its used outside of the core file and is exported as well. Drop the
'static' keyword from its declaration and fix below build error:

linux/drivers/cpufreq/cpufreq.c:241:31: error: static declaration of
'cpufreq_cpu_get_raw' follows non-static declaration

Fixes: 503655f70d9b ("cpufreq: acpi-cpufreq: Use cpufreq_cpu_get_raw() in ->get()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a8252bb0f80c..ef5ed9470de9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -238,7 +238,7 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_init);
 
-static struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
