Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DF47989C;
	Tue, 29 Sep 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671017; cv=none; b=M7GDKnij6cWk9iS6TV7HuzvlcCFuCmbBbc0gJhg09uS14oZclggEYGxGgDjBXXEoiwUJdM9aOHEUOcQ0hrqIOw+oT181xXsJWJ2grVw8nR7ShWtv+JVXzVDqqD3iGBMqD1IGYjUWnpKdGsxHwskSNDywkrOKd2tb6daGAxuvABE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671017; c=relaxed/simple;
	bh=JQEdZDp/5jIcLrMOa0B2Vqtk2O1ueNZMuEvb0gTumDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQwkQWTa5JpDp/bhGsN1+H1Gy/BRnjVmrBaSaleqylXT+rRj1F1g6vX7M/5Frrd432TOxw04THoG+ibB/mTzXPy6oEsJMLtIvn3TXzdMKloI7DOeqkJukXXOAJ1Rw7psEN9iQ3UHEgjOVwBlX3l+78DRfO3edL98qNv4W4fd6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSLx9zDZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSLx9zDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4741F00898;
	Tue, 29 Sep 2026 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671015;
	bh=v3C8QWPnmVlks9J6Eis9TaU4/avmA04BWYlBhkLwUBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cSLx9zDZUGLwxPqM5qip7f2DTNgsIgV5RLk5g+nAd94IQRzPD3KR9V7sw+oPP5/+X
	 jsk1ATDBZTTd4AxXg8ipT6MakxfwYEfHLd0QA1dtHIq6Zz9Fo6ch3J6rbMD2IzyiI/
	 J7Whd/CXu8fdV2W1zaOIpJuR64f8ovHBpmrsjc6poIBp5ssVHZc/p0TGy40cpI/rpb
	 siueQX2FG7BFWSdA1Fp5dbAcT7qnuOQvQbISMqCgtd1NNEYcrP5AnULCggxKpCXVGc
	 DWWcurY/WNxvDb9X0SGOUw+dJ2OxuivqoMXjrHWRWvrsRAJiPn6Va+TPKKe4C4kF2V
	 BViuKfX3M9UyA==
Message-ID: <ea7958f2-44bb-477e-b06a-44153489f396@kernel.org>
Date: Tue, 29 Sep 2026 09:36:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] interconnect: qcom: Add CAMNOC interconnect
 provider driver
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>
References: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
 <BL_JgUju90yJ83WelqJjGySbDZXaF6FONsvtmnFfm9fSkHcYKfQOQnCXainWwse1bgfCXlxKOhWSNLNPg2uXuQ==@protonmail.internalid>
 <20260819093211.1436275-3-atanas.filipov@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20260819093211.1436275-3-atanas.filipov@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2026 10:32, Atanas Filipov wrote:
> Add an ICC provider for the Qualcomm Camera NOC (CAMNOC). Multiple
> camera sub-devices share CAM_CC_CAMNOC_AXI_CLK; direct clk_set_rate()
> calls from each consumer cause a last-writer-wins race.
> 
> Each consumer obtains an ICC path to SLAVE_CAMNOC_AXI and votes via
> icc_set_bw(). The ICC core aggregates votes (max peak_bw) and the
> set() callback converts the result to clk_set_rate(). Consumers
> encode the required frequency as peak_bw in kBps.
> 
> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
> ---
>   drivers/interconnect/qcom/Kconfig       |  10 +
>   drivers/interconnect/qcom/Makefile      |   2 +
>   drivers/interconnect/qcom/qcom-camnoc.c | 279 ++++++++++++++++++++++++
>   3 files changed, 291 insertions(+)
>   create mode 100644 drivers/interconnect/qcom/qcom-camnoc.c
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 5b8a094ca4ed..9d9d238019a0 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -135,6 +135,16 @@ config INTERCONNECT_QCOM_NORD
>   	  the RPMh hardware and communicates via Bus Clock Manager (BCM)
>   	  through the Resource State Coordinator (RSC).
> 
> +config INTERCONNECT_QCOM_CAMNOC
> +	tristate "Qualcomm CAMNOC interconnect driver"
> +	depends on INTERCONNECT_QCOM || COMPILE_TEST
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  Say y here to support the Camera Network-on-Chip (CAMNOC)
> +	  interconnect driver for Qualcomm SoCs. It aggregates bandwidth
> +	  requests from camera sub-devices (IFE, JPEG, BPS, etc.) and
> +	  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
> +
>   config INTERCONNECT_QCOM_OSM_L3
>   	tristate "Qualcomm OSM L3 interconnect driver"
>   	depends on INTERCONNECT_QCOM || COMPILE_TEST
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 1c7d410b40cc..52a5998ae6a8 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -18,6 +18,7 @@ qnoc-msm8974-objs			:= msm8974.o
>   qnoc-msm8976-objs			:= msm8976.o
>   qnoc-msm8996-objs			:= msm8996.o
>   qnoc-nord-objs				:= nord.o
> +icc-camnoc-objs				:= qcom-camnoc.o
>   icc-osm-l3-objs				:= osm-l3.o
>   qnoc-qcm2290-objs			:= qcm2290.o
>   qnoc-qcs404-objs			:= qcs404.o
> @@ -66,6 +67,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_MSM8976) += qnoc-msm8976.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) += qnoc-msm8996.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_NORD) += qnoc-nord.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_CAMNOC) += icc-camnoc.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) += qnoc-qcm2290.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
> diff --git a/drivers/interconnect/qcom/qcom-camnoc.c b/drivers/interconnect/qcom/qcom-camnoc.c
> new file mode 100644
> index 000000000000..9a703b052b2d
> --- /dev/null
> +++ b/drivers/interconnect/qcom/qcom-camnoc.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Qualcomm Camera NOC (CAMNOC) interconnect provider.
> + *
> + * CAMNOC is the internal AXI interconnect within the Qualcomm camera
> + * subsystem. Multiple camera sub-devices (IFE, JPEG, BPS, etc.) share
> + * CAM_CC_CAMNOC_AXI_CLK. This driver acts as an ICC provider so that
> + * each sub-device can independently vote for bandwidth; the ICC core
> + * aggregates the votes (max of peak_bw across all consumers) and this
> + * driver translates the result into a clk_set_rate() call, avoiding
> + * the last-writer-wins race that occurs with direct clk_set_rate().
> + *
> + * Consumers express their required clock rate directly as peak_bw in
> + * kBps (e.g. 400000 for 400 MHz).  The driver converts kBps → Hz:
> + *   rate_hz = peak_bw_kBps * 1000
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/interconnect.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/interconnect/qcom,camnoc.h>
> +
> +#define to_camnoc_provider(_p) \
> +	container_of(_p, struct qcom_camnoc_icc_provider, provider)
> +
> +struct qcom_camnoc_icc_provider {
> +	struct clk *clk;
> +	struct icc_provider provider;
> +};
> +
> +struct qcom_camnoc_node {
> +	const char *name;
> +	u16 buswidth;
> +};
> +
> +/* IFE */
> +static const struct qcom_camnoc_node camnoc_master_ife_0 = {
> +	.name = "master-camnoc-ife-0", .buswidth = 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_0_rdi = {
> +	.name = "master-camnoc-ife-0-rdi", .buswidth = 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_1 = {
> +	.name = "master-camnoc-ife-1", .buswidth = 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_1_rdi = {
> +	.name = "master-camnoc-ife-1-rdi", .buswidth = 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_0 = {
> +	.name = "master-camnoc-ife-lite-0", .buswidth = 8
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_1 = {
> +	.name = "master-camnoc-ife-lite-1", .buswidth = 8
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_2 = {
> +	.name = "master-camnoc-ife-lite-2", .buswidth = 8
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_3 = {
> +	.name = "master-camnoc-ife-lite-3", .buswidth = 8
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_4 = {
> +	.name = "master-camnoc-ife-lite-4", .buswidth = 8
> +};
> +
> +/* BPS */
> +static const struct qcom_camnoc_node camnoc_master_bps = {
> +	.name = "master-camnoc-bps", .buswidth = 16
> +};
> +
> +/* IPE */
> +static const struct qcom_camnoc_node camnoc_master_ipe_0 = {
> +	.name = "master-camnoc-ipe-0", .buswidth = 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ipe_1 = {
> +	.name = "master-camnoc-ipe-1", .buswidth = 16
> +};
> +
> +/* JPEG */
> +static const struct qcom_camnoc_node camnoc_master_jpeg = {
> +	.name = "master-camnoc-jpeg", .buswidth = 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_jpeg_dma = {
> +	.name = "master-camnoc-jpeg-dma", .buswidth = 16
> +};
> +
> +/* CDM */
> +static const struct qcom_camnoc_node camnoc_master_cdm = {
> +	.name = "master-camnoc-cdm", .buswidth = 4
> +};
> +
> +/* FD */
> +static const struct qcom_camnoc_node camnoc_master_fd = {
> +	.name = "master-camnoc-fd", .buswidth = 16
> +};
> +
> +/* SBI */
> +static const struct qcom_camnoc_node camnoc_master_sbi = {
> +	.name = "master-camnoc-sbi", .buswidth = 16
> +};
> +
> +/* ICP */
> +static const struct qcom_camnoc_node camnoc_master_icp = {
> +	.name = "master-camnoc-icp", .buswidth = 8
> +};
> +
> +/* Slave */
> +static const struct qcom_camnoc_node camnoc_slave_axi = {
> +	.name = "slave-camnoc-axi", .buswidth = 32
> +};
> +
> +static const struct qcom_camnoc_node * const camnoc_nodes[] = {
> +	[MASTER_CAMNOC_IFE_0]      = &camnoc_master_ife_0,
> +	[MASTER_CAMNOC_IFE_0_RDI]  = &camnoc_master_ife_0_rdi,
> +	[MASTER_CAMNOC_IFE_1]      = &camnoc_master_ife_1,
> +	[MASTER_CAMNOC_IFE_1_RDI]  = &camnoc_master_ife_1_rdi,
> +	[MASTER_CAMNOC_IFE_LITE_0] = &camnoc_master_ife_lite_0,
> +	[MASTER_CAMNOC_IFE_LITE_1] = &camnoc_master_ife_lite_1,
> +	[MASTER_CAMNOC_IFE_LITE_2] = &camnoc_master_ife_lite_2,
> +	[MASTER_CAMNOC_IFE_LITE_3] = &camnoc_master_ife_lite_3,
> +	[MASTER_CAMNOC_IFE_LITE_4] = &camnoc_master_ife_lite_4,
> +	[MASTER_CAMNOC_BPS]        = &camnoc_master_bps,
> +	[MASTER_CAMNOC_IPE_0]      = &camnoc_master_ipe_0,
> +	[MASTER_CAMNOC_IPE_1]      = &camnoc_master_ipe_1,
> +	[MASTER_CAMNOC_JPEG]       = &camnoc_master_jpeg,
> +	[MASTER_CAMNOC_JPEG_DMA]   = &camnoc_master_jpeg_dma,
> +	[MASTER_CAMNOC_CDM]        = &camnoc_master_cdm,
> +	[MASTER_CAMNOC_FD]         = &camnoc_master_fd,
> +	[MASTER_CAMNOC_SBI]        = &camnoc_master_sbi,
> +	[MASTER_CAMNOC_ICP]        = &camnoc_master_icp,
> +	[SLAVE_CAMNOC_AXI]         = &camnoc_slave_axi,
> +};

This will fill up quickly given the number of entries. This should be 
moved to a separate file.

> +
> +#define CAMNOC_NUM_NODES	ARRAY_SIZE(camnoc_nodes)
> +
> +static int qcom_camnoc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +
> +	return 0;
> +}

What's going on here ? This sets everything to zero always ?

> +
> +static int qcom_camnoc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct qcom_camnoc_icc_provider *cp =
> +		to_camnoc_provider(src->provider);
> +	unsigned long rate;
> +
> +	/*
> +	 * peak_bw is the aggregated max across all consumers (kBps).
> +	 * Consumers encode the required clock frequency directly as kBps,
> +	 * so the conversion is simply: rate_hz = peak_bw * 1000.
> +	 * A vote of 0 means no requirement; leave the clock at its minimum.
> +	 */
> +	rate = icc_units_to_bps(dst->peak_bw);
> +
> +	return clk_set_rate(cp->clk, rate);
> +}
> +
> +static void qcom_camnoc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_camnoc_icc_provider *cp = platform_get_drvdata(pdev);
> +
> +	icc_provider_deregister(&cp->provider);
> +	icc_nodes_remove(&cp->provider);
> +}
> +
> +static int qcom_camnoc_probe(struct platform_device *pdev)
> +{
> +	struct qcom_camnoc_icc_provider *cp;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct icc_node *node;
> +	unsigned int i;
> +	int ret;
> +
> +	cp = devm_kzalloc(&pdev->dev, sizeof(*cp), GFP_KERNEL);
> +	if (!cp)
> +		return -ENOMEM;
> +
> +	cp->clk = devm_clk_get(&pdev->dev, "camnoc_axi");
> +	if (IS_ERR(cp->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(cp->clk),
> +				     "failed to get camnoc_axi clock\n");
> +
> +	data = devm_kzalloc(&pdev->dev,
> +			    struct_size(data, nodes, CAMNOC_NUM_NODES),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->num_nodes = CAMNOC_NUM_NODES;
> +
> +	provider = &cp->provider;
> +	provider->dev = &pdev->dev;
> +	provider->get_bw = qcom_camnoc_get_bw;
> +	provider->set = qcom_camnoc_set;
> +	provider->aggregate = icc_std_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	provider->data = data;
> +
> +	icc_provider_init(provider);
> +
> +	for (i = 0; i < CAMNOC_NUM_NODES; i++) {
> +		node = icc_node_create_dyn();
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err_remove;
> +		}
> +
> +		ret = icc_node_set_name(node, provider, camnoc_nodes[i]->name);
> +		if (ret) {
> +			icc_node_destroy(node->id);
> +			goto err_remove;
> +		}
> +
> +		node->data = (void *)camnoc_nodes[i];
> +		icc_node_add(node, provider);
> +		data->nodes[i] = node;
> +	}
> +
> +	/* Link every master to the single CAMNOC AXI slave. */
> +	for (i = 0; i < CAMNOC_NUM_NODES - 1; i++) {
> +		if (camnoc_nodes[i] == &camnoc_slave_axi)
> +			continue;
> +		ret = icc_link_nodes(data->nodes[i],
> +				     &data->nodes[SLAVE_CAMNOC_AXI]);
> +		if (ret)
> +			goto err_remove;
> +	}
> +
> +	ret = icc_provider_register(provider);
> +	if (ret)
> +		goto err_remove;
> +
> +	platform_set_drvdata(pdev, cp);
> +
> +	return 0;
> +
> +err_remove:
> +	icc_nodes_remove(provider);
> +	return ret;
> +}
> +
> +static const struct of_device_id qcom_camnoc_of_match[] = {
> +	{ .compatible = "qcom,sm8250-cam-virt" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_camnoc_of_match);
> +
> +static struct platform_driver qcom_camnoc_driver = {
> +	.probe  = qcom_camnoc_probe,
> +	.remove = qcom_camnoc_remove,
> +	.driver = {
> +		.name           = "qcom-camnoc-icc",
> +		.of_match_table = qcom_camnoc_of_match,
> +		.sync_state     = icc_sync_state,
> +	},
> +};
> +module_platform_driver(qcom_camnoc_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm CAMNOC interconnect driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
> 
> 

