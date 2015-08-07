From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 1/6] cpufreq: make scaling_boost_freqs sysfs attr
 available when boost is enabled
Date: Fri, 07 Aug 2015 13:12:56 +0200
Message-ID: <1594902.Dv5JKhve0y@amdc1976>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <5184469.cOpIkgzX4h@amdc1976> <20150807104156.GE6939@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150807104156.GE6939@linux>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Friday, August 07, 2015 04:11:56 PM Viresh Kumar wrote:
> On 07-08-15, 12:34, Bartlomiej Zolnierkiewicz wrote:
> > > I would suggest you sending such patches as reply to the earlier
> > > threads only, instead of a new chain. This will save your time.
> > 
> > Please explain it more.  This patch needs to be first for cpufreq-dt
> > switch to be complete.  scaling_boost_freqs is available currently
> > for exynos-cpufreq users when boost is enabled and ideally we would
> > like it to be available immediately after the switch to cpufreq-dt.
> 
> I wasn't talking about the ordering of the patches here, but when to
> send patches.
> 
> So, you now sent these patches again, but what you could have done
> is: only send the first patch in reply to the earlier thread. And ask
> if it looks fine. If yes, resend the whole series properly or keep
> fixing there only..
> 
> That makes things really fast. You don't have to resend the series and
> people wouldn't stay away from it. I stayed away from this series to
> find enough available time to see your 6 patches. Had it been just a
> reply, I would have replied immediately like now.
> 
> Look at how updated versions in the same mail chain in case of OPP
> series..

Please find updated patch below.  It can be moved just before
patch #6 and all patches in the series would still apply fine.

---------------------8<-------------------

>From 993ebb6fc632ec7b61654c9610c90ff4dca4be34 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 7 Aug 2015 13:07:51 +0200
Subject: [PATCH] cpufreq-dt: make scaling_boost_freqs sysfs attr available
 when boost is enabled

Make scaling_boost_freqs sysfs attribute is available when
cpufreq-dt driver is used and boost support is enabled.

Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 11 ++++++++++-
 include/linux/cpufreq.h      |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index b9259ab..c6a3b98 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -36,6 +36,12 @@ struct private_data {
 	unsigned int voltage_tolerance; /* in percentage */
 };
 
+static struct freq_attr *cpufreq_dt_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,   /* Extra space for boost-attr if required */
+	NULL,
+};
+
 static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct dev_pm_opp *opp;
@@ -182,6 +188,8 @@ try_again:
 	return ret;
 }
 
+static struct cpufreq_driver dt_cpufreq_driver;
+
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
@@ -336,6 +344,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		ret = cpufreq_enable_boost_support();
 		if (ret)
 			goto out_free_cpufreq_table;
+		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
 	policy->cpuinfo.transition_latency = transition_latency;
@@ -411,7 +420,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.exit = cpufreq_exit,
 	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
-	.attr = cpufreq_generic_attr,
+	.attr = cpufreq_dt_attr,
 };
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95f0186..657542d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -609,6 +609,7 @@ struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
 
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
+extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
 extern struct freq_attr *cpufreq_generic_attr[];
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table);
-- 
1.9.1
