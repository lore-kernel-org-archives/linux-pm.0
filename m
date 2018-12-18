From: Joseph Lo <josephl@nvidia.com>
Subject: [PATCH V3 13/20] cpufreq: dt-platdev: add Tegra210 to blacklist
Date: Tue, 18 Dec 2018 17:12:25 +0800
Message-ID: <20181218091232.23532-14-josephl@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181218091232.23532-1-josephl@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Tegra210 uses "tegra124-cpufreq" platform driver to register device data
for "cpufreq-dt" driver. So add it in the blacklist for
"cpufreq-dt-platdev" driver to drop that.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
*V3:
 - add ack tags
*V2:
 - new added in V2
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index b1c5468dca16..47729a22c159 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -119,6 +119,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt8176", },
 
 	{ .compatible = "nvidia,tegra124", },
+	{ .compatible = "nvidia,tegra210", },
 
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
-- 
2.20.1
