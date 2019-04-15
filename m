From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 06/19] PM / devfreq: tegra: Fix missed error checking on devfreq initialization failure
Date: Mon, 15 Apr 2019 17:54:52 +0300
Message-ID: <20190415145505.18397-7-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The code doesn't check for devfreq initialization failure, fix it.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index f0f0d78f6cbf..aa0478464b35 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -707,6 +707,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 						 &tegra_devfreq_profile,
 						 "tegra_actmon",
 						 NULL);
+	if (IS_ERR(tegra->devfreq)) {
+		err = PTR_ERR(tegra->devfreq);
+		return err;
+	}
 
 	return 0;
 }
-- 
2.21.0
