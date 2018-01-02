From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 01/12] PM / AVS: rockchip-io: account for const type of
 of_device_id.data
Date: Tue,  2 Jan 2018 14:27:57 +0100
Message-ID: <1514899688-27844-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This driver creates a number of const structures that it stores in the
data field of an of_device_id array.

The data field of an of_device_id structure has type const void *, so
there is no need for a const-discarding cast when putting const values
into such a structure.

Furthermore, adding const to the declaration of the location that
receives a const value from such a field ensures that the compiler
will continue to check that the value is not modified.  The
const-discarding cast on the extraction from the data field is
thus no longer needed.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/avs/rockchip-io-domain.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff -u -p a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -76,7 +76,7 @@ struct rockchip_iodomain_supply {
 struct rockchip_iodomain {
 	struct device *dev;
 	struct regmap *grf;
-	struct rockchip_iodomain_soc_data *soc_data;
+	const struct rockchip_iodomain_soc_data *soc_data;
 	struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
 };
 
@@ -382,43 +382,43 @@ static const struct rockchip_iodomain_so
 static const struct of_device_id rockchip_iodomain_match[] = {
 	{
 		.compatible = "rockchip,rk3188-io-voltage-domain",
-		.data = (void *)&soc_data_rk3188
+		.data = &soc_data_rk3188
 	},
 	{
 		.compatible = "rockchip,rk3228-io-voltage-domain",
-		.data = (void *)&soc_data_rk3228
+		.data = &soc_data_rk3228
 	},
 	{
 		.compatible = "rockchip,rk3288-io-voltage-domain",
-		.data = (void *)&soc_data_rk3288
+		.data = &soc_data_rk3288
 	},
 	{
 		.compatible = "rockchip,rk3328-io-voltage-domain",
-		.data = (void *)&soc_data_rk3328
+		.data = &soc_data_rk3328
 	},
 	{
 		.compatible = "rockchip,rk3368-io-voltage-domain",
-		.data = (void *)&soc_data_rk3368
+		.data = &soc_data_rk3368
 	},
 	{
 		.compatible = "rockchip,rk3368-pmu-io-voltage-domain",
-		.data = (void *)&soc_data_rk3368_pmu
+		.data = &soc_data_rk3368_pmu
 	},
 	{
 		.compatible = "rockchip,rk3399-io-voltage-domain",
-		.data = (void *)&soc_data_rk3399
+		.data = &soc_data_rk3399
 	},
 	{
 		.compatible = "rockchip,rk3399-pmu-io-voltage-domain",
-		.data = (void *)&soc_data_rk3399_pmu
+		.data = &soc_data_rk3399_pmu
 	},
 	{
 		.compatible = "rockchip,rv1108-io-voltage-domain",
-		.data = (void *)&soc_data_rv1108
+		.data = &soc_data_rv1108
 	},
 	{
 		.compatible = "rockchip,rv1108-pmu-io-voltage-domain",
-		.data = (void *)&soc_data_rv1108_pmu
+		.data = &soc_data_rv1108_pmu
 	},
 	{ /* sentinel */ },
 };
@@ -443,7 +443,7 @@ static int rockchip_iodomain_probe(struc
 	platform_set_drvdata(pdev, iod);
 
 	match = of_match_node(rockchip_iodomain_match, np);
-	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
+	iod->soc_data = match->data;
 
 	parent = pdev->dev.parent;
 	if (parent && parent->of_node) {
