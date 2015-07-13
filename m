From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 06/19] clk: tegra: remove TEGRA_PLL_USE_LOCK for PLLD/PLLD2
Date: Mon, 13 Jul 2015 13:39:44 +0100
Message-ID: <1436791197-32358-7-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8428 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbGMMkj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 08:40:39 -0400
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

From: Vince Hsu <vinceh@nvidia.com>

Tegra114 has a HW bug that the PLLD/PLLD2 lock bit cannot be asserted when
the DIS power domain is during up-powergating process but the clamp to this
domain is not removed yet. That causes a timeout and aborts the power
sequence, although the PLLD/PLLD2 has already locked. To remove the false
alarm, we don't use the lock for PLLD/PLLD2. Just wait 1ms and treat the
clocks as locked.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 8237d16b4075..2e5c20c7c088 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -456,8 +456,7 @@ static struct tegra_clk_pll_params pll_d_params = {
 	.lock_delay = 1000,
 	.div_nmp = &pllp_nmp,
 	.freq_table = pll_d_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON |
-		 TEGRA_PLL_USE_LOCK,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON,
 };
 
 static struct tegra_clk_pll_params pll_d2_params = {
@@ -474,8 +473,7 @@ static struct tegra_clk_pll_params pll_d2_params = {
 	.lock_delay = 1000,
 	.div_nmp = &pllp_nmp,
 	.freq_table = pll_d_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON |
-		 TEGRA_PLL_USE_LOCK,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON,
 };
 
 static struct pdiv_map pllu_p[] = {
-- 
2.1.4

