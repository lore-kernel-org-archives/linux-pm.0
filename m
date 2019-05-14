From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC V2 10/11] interconnect: mediatek: Add mt8183 interconnect
 provider driver
Date: Tue, 14 May 2019 09:43:36 +0300
Message-ID: <b8db4f70-4b95-5a98-38b4-9990bae023b4@linaro.org>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
 <1556614265-12745-11-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556614265-12745-11-git-send-email-henryc.chen@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Henry Chen <henryc.chen@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <swboyd@chromium.org>, Nicolas Boichat <drinkcat@google.com>, Fan Chen <fan.chen@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Henry,

On 4/30/19 11:51, Henry Chen wrote:
> Introduce Mediatek MT8183 specific provider driver using the
> interconnect framework.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/interconnect/Kconfig           |   1 +
>  drivers/interconnect/Makefile          |   1 +
>  drivers/interconnect/mediatek/Kconfig  |  13 ++
>  drivers/interconnect/mediatek/Makefile |   5 +
>  drivers/interconnect/mediatek/mt8183.c | 223 +++++++++++++++++++++++++++++++++
>  5 files changed, 243 insertions(+)
>  create mode 100644 drivers/interconnect/mediatek/Kconfig
>  create mode 100644 drivers/interconnect/mediatek/Makefile
>  create mode 100644 drivers/interconnect/mediatek/mt8183.c
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 07a8276..ac41ea6 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -11,5 +11,6 @@ menuconfig INTERCONNECT
>  if INTERCONNECT
>  
>  source "drivers/interconnect/qcom/Kconfig"
> +source "drivers/interconnect/mediatek/Kconfig"
>  
>  endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 28f2ab0..253f24a3 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -4,3 +4,4 @@ icc-core-objs				:= core.o
>  
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> +obj-$(CONFIG_INTERCONNECT_MTK)		+= mediatek/
> diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect/mediatek/Kconfig
> new file mode 100644
> index 0000000..0686494
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/Kconfig
> @@ -0,0 +1,13 @@
> +config INTERCONNECT_MTK
> +	bool "Mediatek Network-on-Chip interconnect drivers"
> +	depends on ARCH_MEDIATEK
> +	help
> +	  Support for Mediatek's Network-on-Chip interconnect hardware.
> +
> +config INTERCONNECT_MTK_MT8183
> +	tristate "Mediatek MT8183 interconnect driver"
> +	depends on INTERCONNECT_MTK
> +	depends on (MTK_DVFSRC && OF)
> +	help
> +	  This is a driver for the Mediatek Network-on-Chip on mt8183-based
> +	  platforms.
> diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
> new file mode 100644
> index 0000000..a39ceee
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +mtk-mt8183-objs			:= mt8183.o
> +
> +obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mtk-mt8183.o
> \ No newline at end of file
> diff --git a/drivers/interconnect/mediatek/mt8183.c b/drivers/interconnect/mediatek/mt8183.c
> new file mode 100644
> index 0000000..38ffe0b
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/mt8183.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <dt-bindings/interconnect/mtk,mt8183.h>
> +#include <linux/device.h>
> +#include <linux/interconnect.h>

This is not needed.

> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <soc/mediatek/mtk_dvfsrc.h>
> +
> +#define MT8183_MAX_LINKS	6
> +
> +/**
> + * struct mtk_icc_node - Mediatek specific interconnect nodes
> + * @name: the node name used in debugfs
> + * @ep: true if the node is an end point.
> + * @id: a unique node identifier
> + * @links: an array of nodes where we can go next while traversing
> + * @num_links: the total number of @links
> + * @buswidth: width of the interconnect between a node and the bus

Maybe mention the units?

> + * @sum_avg: current sum aggregate value of all avg bw requests
> + * @max_peak: current max aggregate value of all peak bw requests

units?

> + */
> +struct mtk_icc_node {
> +	unsigned char *name;
> +	bool ep;
> +	u16 id;
> +	u16 links[MT8183_MAX_LINKS];
> +	u16 num_links;
> +	u16 buswidth;
> +	u64 sum_avg;
> +	u64 max_peak;
> +};
> +
> +struct mtk_icc_desc {
> +	struct mtk_icc_node **nodes;
> +	size_t num_nodes;
> +};
> +
> +#define DEFINE_MNODE(_name, _id, _buswidth, _ep, _numlinks, ...)	\

We can drop the _numlinks and..

> +		static struct mtk_icc_node _name = {			\
> +		.name = #_name,						\
> +		.id = _id,						\
> +		.buswidth = _buswidth,					\
> +		.ep = _ep,						\
> +		.num_links = _numlinks,					\

..just use 	.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ }))

> +		.links = { __VA_ARGS__ },				\
> +}
> +
> +DEFINE_MNODE(ddr_emi, SLAVE_DDR_EMI, 1024, 1, 0, 0);
> +DEFINE_MNODE(mcusys, MASTER_MCUSYS, 256, 0, 1, SLAVE_DDR_EMI);
> +DEFINE_MNODE(gpu, MASTER_GPU, 256, 0, 1, SLAVE_DDR_EMI);
> +DEFINE_MNODE(mmsys, MASTER_MMSYS, 256, 0, 1, SLAVE_DDR_EMI);
> +DEFINE_MNODE(mm_vpu, MASTER_MM_VPU, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_disp, MASTER_MM_DISP, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_vdec, MASTER_MM_VDEC, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_venc, MASTER_MM_VENC, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_cam, MASTER_MM_CAM, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_img, MASTER_MM_IMG, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_mdp, MASTER_MM_MDP, 128, 0, 1, MASTER_MMSYS);
> +
> +static struct mtk_icc_node *mt8183_icc_nodes[] = {
> +	&ddr_emi,
> +	&mcusys,
> +	&gpu,
> +	&mmsys,
> +	&mm_vpu,
> +	&mm_disp,
> +	&mm_vdec,
> +	&mm_venc,
> +	&mm_cam,
> +	&mm_img,
> +	&mm_mdp,
> +};
> +
> +static struct mtk_icc_desc mt8183_icc = {
> +	.nodes = mt8183_icc_nodes,
> +	.num_nodes = ARRAY_SIZE(mt8183_icc_nodes),
> +};
> +
> +static int mt8183_icc_aggregate(struct icc_node *node, u32 avg_bw,
> +			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	struct mtk_icc_node *in;
> +
> +	in = node->data;
> +
> +	*agg_avg += avg_bw;
> +	*agg_peak = max_t(u32, *agg_peak, peak_bw);
> +
> +	in->sum_avg = *agg_avg;
> +	in->max_peak = *agg_peak;
> +
> +	return 0;
> +}
> +
> +static int mt8183_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	int ret = 0;
> +	struct mtk_icc_node *node;
> +
> +	node = dst->data;
> +	if (node->ep) {
> +		pr_debug("sum_avg (%llu), max_peak (%llu)\n",
> +			node->sum_avg, node->max_peak);
> +		mtk_dvfsrc_send_request(src->provider->dev->parent,
> +					MTK_DVFSRC_CMD_BW_REQUEST,
> +					node->max_peak);
> +	}
> +
> +	return ret;
> +}
> +
> +static int mt8183_icc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	const struct mtk_icc_desc *desc;
> +	struct icc_node *node;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct mtk_icc_node **mnodes;
> +	size_t num_nodes, i, j;
> +
> +	desc = of_device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	mnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	provider = devm_kzalloc(&pdev->dev, sizeof(*provider), GFP_KERNEL);
> +	if (!provider)
> +		return -ENOMEM;
> +
> +	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	provider->dev = &pdev->dev;
> +	provider->set = mt8183_icc_set;
> +	provider->aggregate = mt8183_icc_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->data = data;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error adding interconnect provider\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < num_nodes; i++) {
> +		node = icc_node_create(mnodes[i]->id);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = mnodes[i]->name;
> +		node->data = mnodes[i];
> +		icc_node_add(node, provider);
> +
> +		dev_dbg(&pdev->dev, "registered node %s, num link: %d\n",
> +			mnodes[i]->name, mnodes[i]->num_links);
> +
> +		/* populate links */
> +		for (j = 0; j < mnodes[i]->num_links; j++)
> +			icc_link_create(node, mnodes[i]->links[j]);
> +
> +		data->nodes[i] = node;
> +	}
> +	data->num_nodes = num_nodes;
> +
> +	platform_set_drvdata(pdev, provider);
> +
> +	return ret;

just return 0;

> +err:
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		icc_node_del(node);
> +		icc_node_destroy(node->id);
> +	}
> +
> +	icc_provider_del(provider);
> +	return ret;
> +}
> +
> +static int mt8183_icc_remove(struct platform_device *pdev)
> +{
> +	struct icc_provider *provider = platform_get_drvdata(pdev);
> +	struct icc_node *n;
> +
> +	list_for_each_entry(n, &provider->nodes, node_list) {
> +		icc_node_del(n);
> +		icc_node_destroy(n->id);
> +	}
> +
> +	return icc_provider_del(provider);
> +}
> +
> +static const struct of_device_id mt8183_icc_of_match[] = {
> +	{ .compatible = "mediatek,mt8183-emi-icc", .data = &mt8183_icc },

A separate -icc compatible should not be needed.

Thanks,
Georgi
