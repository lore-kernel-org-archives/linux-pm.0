From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] thermal: tegra: Make tegra210_tsensor_thermtrips static
Date: Mon, 13 May 2019 21:55:59 +0800
Message-ID: <20190513135559.43836-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-pm@vger.kernel.org

Fix sparse warning:

drivers/thermal/tegra/tegra210-soctherm.c:211:33: warning:
 symbol 'tegra210_tsensor_thermtrips' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/tegra/tegra210-soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index d31b500..d0ff793 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -208,7 +208,7 @@ static const struct tegra_soctherm_fuse tegra210_soctherm_fuse = {
 	.fuse_spare_realignment = 0,
 };
 
-struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] = {
+static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] = {
 	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
 	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
 	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
-- 
2.7.4
