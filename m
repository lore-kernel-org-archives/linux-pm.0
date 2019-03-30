From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 21/67] thermal: samsung: Fix incorrect check after code merge
Date: Fri, 29 Mar 2019 20:50:01 -0400
Message-ID: <20190330005047.25998-21-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 3b5236cc5d086dd3ddd01113ee9255421aab9fab ]

Merge commit 19785cf93b6c ("Merge branch 'linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal")
broke the code introduced by commit ffe6e16f14fa ("thermal: exynos: Reduce
severity of too early temperature read"). Restore the original code from
the mentioned commit to finally fix the warning message during boot:

thermal thermal_zone0: failed to read out thermal zone (-22)

Reported-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 19785cf93b6c ("Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 48eef552cba4..fc9399d9c082 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -666,7 +666,7 @@ static int exynos_get_temp(void *p, int *temp)
 	struct exynos_tmu_data *data = p;
 	int value, ret = 0;
 
-	if (!data || !data->tmu_read || !data->enabled)
+	if (!data || !data->tmu_read)
 		return -EINVAL;
 	else if (!data->enabled)
 		/*
-- 
2.19.1
