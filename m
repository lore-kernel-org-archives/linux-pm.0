From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v4 09/16] PM / devfreq: tegra: Avoid inconsistency of current frequency value
Date: Thu,  2 May 2019 02:38:08 +0300
Message-ID: <20190501233815.32643-10-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The frequency value potentially could change in-between. It doesn't
cause any real problem at all right now, but that could change in the
future. Hence let's avoid the inconsistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index ea0da05cd7f2..5265d735419f 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -509,13 +509,15 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
+	unsigned long cur_freq;
 
-	stat->current_frequency = tegra->cur_freq * KHZ;
+	cur_freq = READ_ONCE(tegra->cur_freq);
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
 
 	/* The below are to be used by the other governors */
+	stat->current_frequency = cur_freq * KHZ;
 
 	actmon_dev = &tegra->devices[MCALL];
 
@@ -526,7 +528,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
+	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
-- 
2.21.0
