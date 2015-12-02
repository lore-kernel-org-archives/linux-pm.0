From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 12/12] cpufreq: arm-big-little: warn on invalid regulator
Date: Wed,  2 Dec 2015 22:19:27 +0100
Message-ID: <1449091167-20758-13-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Ben Gamari <ben@smart-cactus.org>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 drivers/cpufreq/arm_big_little.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 2d5761c..5d30c26 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -158,6 +158,9 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate_kHz)
 		volt_old = regulator_get_voltage(reg[cluster]);
 		pr_debug("%s: cpu %d, cluster: %d, Found OPP: %ld kHz, %ld uV\n",
 			__func__, cpu, cluster, opp_freq / 1000, volt);
+	} else {
+		pr_err("%s: cpu %d, cluster: %d, Have no regulator\n",
+					 __func__, cpu, cluster);
 	}
 
 	pr_debug("%s: cpu %d, cluster: %d, %u MHz, %ld mV --> %u MHz, %ld mV\n",
-- 
2.6.2
