From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 23/25] thermal: exynos: fix error return code
Date: Sun, 29 Dec 2013 23:47:38 +0100
Message-ID: <1388357260-4843-24-git-send-email-Julia.Lawall@lip6.fr>
References: <1388357260-4843-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388357260-4843-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Set the return variable to an error code as done elsewhere in the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}

// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.

 drivers/thermal/samsung/exynos_tmu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 32f38b9..0d96a51 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -205,6 +205,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 skip_calib_data:
 	if (pdata->max_trigger_level > MAX_THRESHOLD_LEVS) {
 		dev_err(&pdev->dev, "Invalid max trigger level\n");
+		ret = -EINVAL;
 		goto out;
 	}
 
