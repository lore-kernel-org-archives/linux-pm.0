From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/9 v2] thermal: exynos: constify thermal_zone_of_device_ops
 structures
Date: Tue,  8 Aug 2017 17:08:59 +0200
Message-ID: <1502204943-20075-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1502204943-20075-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1502204943-20075-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, bhumirks@gmail.com
List-Id: linux-pm@vger.kernel.org

The thermal_zone_of_device_ops structure is only passed as the fourth
argument to thermal_zone_of_sensor_register, which is declared as const.
Thus the thermal_zone_of_device_ops structure itself can be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

v2: This patch was present in the original series

 drivers/thermal/samsung/exynos_tmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 7b8ef09..ed805c7 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1286,7 +1286,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops exynos_sensor_ops = {
+static const struct thermal_zone_of_device_ops exynos_sensor_ops = {
 	.get_temp = exynos_get_temp,
 	.set_emul_temp = exynos_tmu_set_emulation,
 };
