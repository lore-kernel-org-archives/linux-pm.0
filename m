From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 03/16] soc: tegra: pmc: Fix sparse warning for tegra_pmc_init_tsense_reset
Date: Fri, 4 Dec 2015 14:57:04 +0000
Message-ID: <1449241037-22193-4-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Sparse reports the following warning for tegra_pmc_init_tsense_reset:

drivers/soc/tegra/pmc.c:741:6: warning: symbol
'tegra_pmc_init_tsense_reset' was not declared. Should it be static?

This function is only used internally by the PMC driver and so fix this
by making it static.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 99ca91f09929..5b6125ecd69a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -729,7 +729,7 @@ static void tegra_pmc_init(struct tegra_pmc *pmc)
 	tegra_pmc_writel(value, PMC_CNTRL);
 }
 
-void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
+static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
 {
 	static const char disabled[] = "emergency thermal reset disabled";
 	u32 pmu_addr, ctrl_id, reg_addr, reg_data, pinmux;
-- 
2.1.4
