From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Date: Tue,  5 Feb 2019 09:52:25 -0800
Message-ID: <20190205175225.25923-2-mka@chromium.org>
References: <20190205175225.25923-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205175225.25923-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Quentin Perret <quentin.perret@arm.com>, Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Try and register an Energy Model from mediatek-cpufreq to allow
interested subsystems like the task scheduler to use the provided
information.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d398181..e6168ee582783 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -460,6 +460,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	cpumask_copy(policy->cpus, &info->cpus);
 	policy->freq_table = freq_table;
 	policy->driver_data = info;
-- 
2.20.1.611.gfbb209baf1-goog
