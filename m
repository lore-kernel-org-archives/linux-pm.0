From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 02/16] soc: tegra: pmc: Add missing structure members to kernel-doc
Date: Fri, 4 Dec 2015 14:57:03 +0000
Message-ID: <1449241037-22193-3-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Some members of the tegra_pmc structure are missing from the kernel-doc
comment for this structure. Add the missing members.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index bc34cf7482fb..99ca91f09929 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -113,8 +113,10 @@ struct tegra_pmc_soc {
 
 /**
  * struct tegra_pmc - NVIDIA Tegra PMC
+ * @dev: pointer to PMC device structure
  * @base: pointer to I/O remapped register region
  * @clk: pointer to pclk clock
+ * @soc: pointer to SoC data structure
  * @rate: currently configured rate of pclk
  * @suspend_mode: lowest suspend mode available
  * @cpu_good_time: CPU power good time (in microseconds)
-- 
2.1.4
