From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] cpufreq: mediatek: Register an Energy Model
Date: Wed,  6 Feb 2019 10:50:04 -0800
Message-ID: <20190206185004.54779-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Quentin Perret <quentin.perret@arm.com>, Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Try and register an Energy Model from mediatek-cpufreq to allow
interested subsystems like the task scheduler to use the provided
information.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- register the EM after setting the cpumask
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d398181..5250df762814e 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -465,6 +465,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	return 0;
 }
 
-- 
2.20.1.611.gfbb209baf1-goog
