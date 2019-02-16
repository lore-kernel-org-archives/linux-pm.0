From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
Date: Sat, 16 Feb 2019 10:18:26 -0500
Message-ID: <20190216151826.11584-4-tiny.windzz@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190216151826.11584-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

This variable is not used after initialization, so
remove it. And in order to unify the code style,
move the location where the dev_get_drvdata is called
by the way.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c59d2eee5d30..c89ba7b834ff 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -573,10 +573,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
-	struct tegra_devfreq *tegra;
-	int ret = 0;
-
-	tegra = dev_get_drvdata(devfreq->dev.parent);
+	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
@@ -600,7 +597,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 static struct devfreq_governor tegra_devfreq_governor = {
-- 
2.17.0
