From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH 4/4] cpufreq-dt: defer probing if OPP table is not ready
Date: Tue, 16 Dec 2014 15:09:39 -0800
Message-ID: <1418771379-24369-5-git-send-email-dtor@chromium.org>
References: <1418771379-24369-1-git-send-email-dtor@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418771379-24369-1-git-send-email-dtor@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

cpufreq-dt driver supports mode when OPP table is provided by platform
code and not device tree. However on certain platforms code that fills
OPP table may run after cpufreq driver tries to initialize, so let's
report -EPROBE_DEFER if we do not find any entires in OPP table for the
CPU.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/cpufreq/cpufreq-dt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index f56147a..fde97d6 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -211,6 +211,17 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	/* OPPs might be populated at runtime, don't check for error here */
 	of_init_opp_table(cpu_dev);
 
+	/*
+	 * But we need OPP table to function so if it is not there let's
+	 * give platform code chance to provide it for us.
+	 */
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		pr_debug("OPP table is not ready, deferring probe\n");
+		ret = -EPROBE_DEFER;
+		goto out_free_opp;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-- 
2.2.0.rc0.207.ga3a616c
