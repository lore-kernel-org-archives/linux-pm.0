From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] cpufreq: dt-platdev: allow RK3399 to have separate
 tunables per cluster
Date: Fri, 5 Oct 2018 12:00:58 -0700
Message-ID: <20181005190058.GA234868@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Derek Basehore <dbasehore@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

RK3899 has one cluster with 4 small cores, and another one with 2 big
cores, with cores in different clusters having different OPPs and thus
needing separate set of tunables. Let's enable this via
"have_governor_per_policy" platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2 changes: commit message updated.

Not tested, but we had a patch unconditionally enabling
CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag in tree we used to ship devices
based on RK3399 platform.

 drivers/cpufreq/cpufreq-dt-platdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index fe14c57de6ca..040ec0f711f9 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -78,7 +78,10 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "rockchip,rk3328", },
 	{ .compatible = "rockchip,rk3366", },
 	{ .compatible = "rockchip,rk3368", },
-	{ .compatible = "rockchip,rk3399", },
+	{ .compatible = "rockchip,rk3399",
+	  .data = &(struct cpufreq_dt_platform_data)
+		{ .have_governor_per_policy = true, },
+	},
 
 	{ .compatible = "st-ericsson,u8500", },
 	{ .compatible = "st-ericsson,u8540", },
-- 
2.19.0.605.g01d371f741-goog


-- 
Dmitry
