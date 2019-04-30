From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 2/4] drivers: devfreq: events: extend events by type
 of counted data
Date: Tue, 30 Apr 2019 16:34:30 +0900
Message-ID: <3557d507-0463-89de-4025-fbeaaef78bed@samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0@eucas1p2.samsung.com>
        <1555681688-19643-3-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555681688-19643-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
> This patch adds posibility to choose what type of data should be counted
> by the PPMU counter. Now the type comes from DT where the event has been
> defined. When there is no 'event-data-type' the default value is used,
> which is 'read data in bytes'.
> It is needed when you want to know not only read+write data bytes but
> i.e. only write data in byte, or number of read requests, etc.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 61 +++++++++++++++++++++++++------------
>  include/linux/devfreq-event.h       |  6 ++++
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index c61de0b..073bf2c 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -154,9 +154,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Set the event of Read/Write data count  */
> +	/* Set the event of proper data type monitoring */
>  	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
> +			   edev->desc->data_type);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -368,23 +368,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Set the event of Read/Write data count  */
> -	switch (id) {
> -	case PPMU_PMNCNT0:
> -	case PPMU_PMNCNT1:
> -	case PPMU_PMNCNT2:
> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
> -		if (ret < 0)
> -			return ret;
> -		break;
> -	case PPMU_PMNCNT3:
> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> -				PPMU_V2_EVT3_RW_DATA_CNT);
> -		if (ret < 0)
> -			return ret;
> -		break;
> -	}
> +	/* Set the event of proper data type monitoring */
> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> +			   edev->desc->data_type);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Reset cycle counter/performance counter and enable PPMU */
>  	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
> @@ -508,6 +496,7 @@ static int of_get_devfreq_events(struct device_node *np,
>  	struct device *dev = info->dev;
>  	struct device_node *events_np, *node;
>  	int i, j, count;
> +	int ret;
>  
>  	events_np = of_get_child_by_name(np, "events");
>  	if (!events_np) {
> @@ -544,6 +533,40 @@ static int of_get_devfreq_events(struct device_node *np,
>  		desc[j].driver_data = info;
>  
>  		of_property_read_string(node, "event-name", &desc[j].name);
> +		ret = of_property_read_u32(node, "event-data-type",
> +					   &desc[j].data_type);
> +		if (ret) {
> +			/* Set the event of proper data type counting.
> +			 * Check if the data type has been defined in DT,
> +			 * use default if not.
> +			 */
> +			if (of_device_is_compatible(np,
> +					"samsung,exynos-ppmu-v2")) {

It is not proper to compare the compatible string again
in the device driver. Instead, you can define the ppmu device type
as following and then use 'struct of_device_id' in order to
identify the device type.

	enum exynos_ppmu_type {
		EXYNOS_TYPE_PPMU,
		EXYNOS_TYPE_PPMU_V2,
	};

 static const struct of_device_id exynos_ppmu_id_match[] = {
        {
                .compatible = "samsung,exynos-ppmu",
-               .data = (void *)&exynos_ppmu_ops,
+               .data = (void *)EXYNOS_TYPE_PPMU,
        }, {
                .compatible = "samsung,exynos-ppmu-v2",
-               .data = (void *)&exynos_ppmu_v2_ops,
+               .data = (void *)EXYNOS_TYPE_PPMU_V2,
        },


The many device drivers in the mainline uses this code
in order to get the device type. You can refer the example
in the drivers/mfd/max14577.c.

(snip)


Example, I add the example. but it is not tested. 

--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/suspend.h>
@@ -23,6 +24,11 @@
 
 #include "exynos-ppmu.h"
 
+enum exynos_ppmu_type {
+       EXYNOS_TYPE_PPMU,
+       EXYNOS_TYPE_PPMU_V2,
+};
+
 struct exynos_ppmu_data {
        struct clk *clk;
 };
@@ -36,6 +42,7 @@ struct exynos_ppmu {
        struct regmap *regmap;
 
        struct exynos_ppmu_data ppmu;
+       enum exynos_ppmu_type ppmu_type;
 };
 
 #define PPMU_EVENT(name)                       \
 
        /* Reset cycle counter/performance counter and enable PPMU */
        ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
@@ -483,31 +476,23 @@ static const struct devfreq_event_ops exynos_ppmu_v2_ops = {
 static const struct of_device_id exynos_ppmu_id_match[] = {
        {
                .compatible = "samsung,exynos-ppmu",
-               .data = (void *)&exynos_ppmu_ops,
+               .data = (void *)EXYNOS_TYPE_PPMU,
        }, {
                .compatible = "samsung,exynos-ppmu-v2",
-               .data = (void *)&exynos_ppmu_v2_ops,
+               .data = (void *)EXYNOS_TYPE_PPMU_V2,
        },
        { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, exynos_ppmu_id_match);
 
-static struct devfreq_event_ops *exynos_bus_get_ops(struct device_node *np)
-{
-       const struct of_device_id *match;
-
-       match = of_match_node(exynos_ppmu_id_match, np);
-       return (struct devfreq_event_ops *)match->data;
-}
-
 static int of_get_devfreq_events(struct device_node *np,
                                 struct exynos_ppmu *info)
 {
        struct devfreq_event_desc *desc;
-       struct devfreq_event_ops *event_ops;
        struct device *dev = info->dev;
        struct device_node *events_np, *node;
        int i, j, count;
 
        events_np = of_get_child_by_name(np, "events");
        if (!events_np) {
@@ -515,7 +500,6 @@ static int of_get_devfreq_events(struct device_node *np,
                        "failed to get child node of devfreq-event devices\n");
                return -EINVAL;
        }
-       event_ops = exynos_bus_get_ops(np);
 
        count = of_get_child_count(events_np);
        desc = devm_kcalloc(dev, count, sizeof(*desc), GFP_KERNEL);
@@ -540,11 +524,38 @@ static int of_get_devfreq_events(struct device_node *np,
                        continue;
                }
 
-               desc[j].ops = event_ops;
+               switch (info->ppmu_type) {
+               case EXYNOS_TYPE_PPMU:
+                       desc[j].ops = &exynos_ppmu_ops;
+                       break;
+               case EXYNOS_TYPE_PPMU_V2:
+                       desc[j].ops = &exynos_ppmu_v2_ops;
+                       break;
+               }
+


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
