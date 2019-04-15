From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 05/19] PM / devfreq: tegra: Replace write memory barrier with the read barrier
Date: Mon, 15 Apr 2019 17:54:51 +0300
Message-ID: <20190415145505.18397-6-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The write memory barrier isn't needed because the BUS buffer is flushed
by read after write that happens after the removed wmb(), we will also
use readl() instead of the relaxed version to ensure that read is indeed
completed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index d62fb1b0d9bb..f0f0d78f6cbf 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -243,8 +243,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 static void actmon_write_barrier(struct tegra_devfreq *tegra)
 {
 	/* ensure the update has reached the ACTMON */
-	wmb();
-	actmon_readl(tegra, ACTMON_GLB_STATUS);
+	readl(tegra->regs + ACTMON_GLB_STATUS);
 }
 
 static void actmon_isr_device(struct tegra_devfreq *tegra,
-- 
2.21.0
