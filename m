From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 07/16] soc: tegra: pmc: Remove non-existing power partitions for T210
Date: Fri, 4 Dec 2015 14:57:08 +0000
Message-ID: <1449241037-22193-8-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The power partitions L2, HEG, CELP and C1NC do not exist for T210 but were
incorrectly documented in the TRM. These will be removed from the TRM and
so also remove their definitions for T210.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index f94d970089ce..28d3106d3add 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1013,17 +1013,13 @@ static const char * const tegra210_powergates[] = {
 	[TEGRA_POWERGATE_3D] = "3d",
 	[TEGRA_POWERGATE_VENC] = "venc",
 	[TEGRA_POWERGATE_PCIE] = "pcie",
-	[TEGRA_POWERGATE_L2] = "l2",
 	[TEGRA_POWERGATE_MPE] = "mpe",
-	[TEGRA_POWERGATE_HEG] = "heg",
 	[TEGRA_POWERGATE_SATA] = "sata",
 	[TEGRA_POWERGATE_CPU1] = "cpu1",
 	[TEGRA_POWERGATE_CPU2] = "cpu2",
 	[TEGRA_POWERGATE_CPU3] = "cpu3",
-	[TEGRA_POWERGATE_CELP] = "celp",
 	[TEGRA_POWERGATE_CPU0] = "cpu0",
 	[TEGRA_POWERGATE_C0NC] = "c0nc",
-	[TEGRA_POWERGATE_C1NC] = "c1nc",
 	[TEGRA_POWERGATE_SOR] = "sor",
 	[TEGRA_POWERGATE_DIS] = "dis",
 	[TEGRA_POWERGATE_DISB] = "disb",
-- 
2.1.4
