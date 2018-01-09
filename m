From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 03/16] iio: adc: axp20x_adc: make it possible
 to probe from DT
Date: Tue,  9 Jan 2018 10:33:34 +0100
Message-ID: <5cf35ebd799555aca6201b86d635656266eda40c.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBRMZ2LJAKGQECNEU52I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

To prepare for a future patch that will add a DT node for the ADC, make
axp20x_adc able to probe from DT and get the per-variant data from
of_device_id.data since platform_device_id.driver_data won't be set when
probing by DT.

Leave the ability to probe via platform for driver compatibility with
old DTs.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/iio/adc/axp20x_adc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 3fc1b06..f8c4c62 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -515,6 +515,13 @@ static const struct axp_data axp22x_data = {
 	.maps = axp22x_maps,
 };
 
+static const struct of_device_id axp20x_adc_of_match[] = {
+	{ .compatible = "x-powers,axp20x-adc", .data = (void *)&axp20x_data, },
+	{ .compatible = "x-powers,axp22x-adc", .data = (void *)&axp22x_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
+
 static const struct platform_device_id axp20x_adc_id_match[] = {
 	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
 	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
@@ -543,7 +550,16 @@ static int axp20x_probe(struct platform_device *pdev)
 	indio_dev->dev.of_node = pdev->dev.of_node;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	info->data = (struct axp_data *)platform_get_device_id(pdev)->driver_data;
+	if (!pdev->dev.of_node) {
+		const struct platform_device_id *tmp;
+
+		tmp = platform_get_device_id(pdev);
+		info->data = (struct axp_data *)tmp->driver_data;
+	} else {
+		struct device *dev = &pdev->dev;
+
+		info->data = (struct axp_data *)of_device_get_match_data(dev);
+	}
 
 	indio_dev->name = platform_get_device_id(pdev)->name;
 	indio_dev->info = info->data->iio_info;
@@ -606,6 +622,7 @@ static int axp20x_remove(struct platform_device *pdev)
 static struct platform_driver axp20x_adc_driver = {
 	.driver = {
 		.name = "axp20x-adc",
+		.of_match_table = of_match_ptr(axp20x_adc_of_match),
 	},
 	.id_table = axp20x_adc_id_match,
 	.probe = axp20x_probe,
-- 
git-series 0.9.1
