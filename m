Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282F33F8B4;
	Thu, 27 Aug 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822746; cv=none; b=VAs7x+guMYGKEyts9giarx/b2oRL+l7E78s9V/yjDcydmovcWBZhp3T5mOjnmT3qC6BWHRyD5QZluGPTVZMqIUi/lvAwHoz1L/9dEZCmn9M+dJ9EPXsXLCkJ2uFeWUTlzmtVqNCinVfYoktxtlhD5wO323MCePH/4h/Z97wXy7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822746; c=relaxed/simple;
	bh=RZjmR9q3jrx/PKiqPTeIBpOVcrpjQ1zCM1N9LZyzEic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlcG2jFRQCVCeoU3S8dLTBT5OiP9FhqwMJIBPqoS2qviTRpBmw/hM0EjWOqmk0mkmN6Cq/77f3dBdF1MM9BK3nnx+FHxmLkkS/weVl2pTYvJfjwRfDWZXYvUvrv0CVnRr1G3e6JYARum/nC4YTleNMDTKLS99+7EhjRjMHI+Osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUHvJGsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUHvJGsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD67A1F000E9;
	Thu, 27 Aug 2026 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787822744;
	bh=5iuu6oQOV13rRPLbowkvqMfKcFgdwhTyKjWaPY0AwFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZUHvJGsyE/vAxFcgN1HSo8TaYA4jBRtAtIIY25E5uXZkGcFUusN1x9x8z3qd+oL+5
	 jlLn5tc0cN3lXYea8LPnm0ApRQx/272ZjrXPHKLTwMipocckJvGCVCB3QojSVjmbl3
	 8NqbhaxvsHRcqvy9LNcbHHbt/whktvzXpo6YUjKvM25bWkmlTOtkbGZYTHxcUd5P1n
	 tB/GiL7HZZXJPhAk0ag11M1VrZ6yAjAVT3K4o7emyp0C8GXcBoF/3ByW1P7BLPCPjy
	 f1vGqjPgqfN9O82vvkDkpkBl2njR1Ne7Vr1BSKkm9C5fLJFHB6KNOY7W8zzdp1tZqd
	 I4e361sKq1deg==
Date: Thu, 27 Aug 2026 11:25:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] interconnect: qcom: Add CAMNOC interconnect
 provider driver
Message-ID: <20260827-adept-traditional-earwig-e2c8c6@quoll>
References: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
 <20260819093211.1436275-3-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260819093211.1436275-3-atanas.filipov@oss.qualcomm.com>

On Wed, Aug 19, 2026 at 12:32:10PM +0300, Atanas Filipov wrote:
> Add an ICC provider for the Qualcomm Camera NOC (CAMNOC). Multiple
> camera sub-devices share CAM_CC_CAMNOC_AXI_CLK; direct clk_set_rate()
> calls from each consumer cause a last-writer-wins race.
>=20
> Each consumer obtains an ICC path to SLAVE_CAMNOC_AXI and votes via
> icc_set_bw(). The ICC core aggregates votes (max peak_bw) and the
> set() callback converts the result to clk_set_rate(). Consumers
> encode the required frequency as peak_bw in kBps.
>=20
> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig       |  10 +
>  drivers/interconnect/qcom/Makefile      |   2 +
>  drivers/interconnect/qcom/qcom-camnoc.c | 279 ++++++++++++++++++++++++
>  3 files changed, 291 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/qcom-camnoc.c
>=20
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qco=
m/Kconfig
> index 5b8a094ca4ed..9d9d238019a0 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -135,6 +135,16 @@ config INTERCONNECT_QCOM_NORD
>  	  the RPMh hardware and communicates via Bus Clock Manager (BCM)
>  	  through the Resource State Coordinator (RSC).
> =20
> +config INTERCONNECT_QCOM_CAMNOC
> +	tristate "Qualcomm CAMNOC interconnect driver"
> +	depends on INTERCONNECT_QCOM || COMPILE_TEST
> +	depends on ARM64 || COMPILE_TEST

missing default ARCH_QCOM

> +	help
> +	  Say y here to support the Camera Network-on-Chip (CAMNOC)
> +	  interconnect driver for Qualcomm SoCs. It aggregates bandwidth
> +	  requests from camera sub-devices (IFE, JPEG, BPS, etc.) and
> +	  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
> +
>  config INTERCONNECT_QCOM_OSM_L3
>  	tristate "Qualcomm OSM L3 interconnect driver"
>  	depends on INTERCONNECT_QCOM || COMPILE_TEST
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qc=
om/Makefile
> index 1c7d410b40cc..52a5998ae6a8 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -18,6 +18,7 @@ qnoc-msm8974-objs			:=3D msm8974.o
>  qnoc-msm8976-objs			:=3D msm8976.o
>  qnoc-msm8996-objs			:=3D msm8996.o
>  qnoc-nord-objs				:=3D nord.o
> +icc-camnoc-objs				:=3D qcom-camnoc.o
>  icc-osm-l3-objs				:=3D osm-l3.o
>  qnoc-qcm2290-objs			:=3D qcm2290.o
>  qnoc-qcs404-objs			:=3D qcs404.o
> @@ -66,6 +67,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) +=3D qnoc-msm89=
74.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8976) +=3D qnoc-msm8976.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) +=3D qnoc-msm8996.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_NORD) +=3D qnoc-nord.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_CAMNOC) +=3D icc-camnoc.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) +=3D icc-osm-l3.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) +=3D qnoc-qcm2290.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) +=3D qnoc-qcs404.o
> diff --git a/drivers/interconnect/qcom/qcom-camnoc.c b/drivers/interconne=
ct/qcom/qcom-camnoc.c
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
> + * kBps (e.g. 400000 for 400 MHz).  The driver converts kBps =E2=86=92 H=
z:
> + *   rate_hz =3D peak_bw_kBps * 1000
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
> +static const struct qcom_camnoc_node camnoc_master_ife_0 =3D {
> +	.name =3D "master-camnoc-ife-0", .buswidth =3D 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_0_rdi =3D {
> +	.name =3D "master-camnoc-ife-0-rdi", .buswidth =3D 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_1 =3D {
> +	.name =3D "master-camnoc-ife-1", .buswidth =3D 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_1_rdi =3D {
> +	.name =3D "master-camnoc-ife-1-rdi", .buswidth =3D 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_0 =3D {
> +	.name =3D "master-camnoc-ife-lite-0", .buswidth =3D 8
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_1 =3D {
> +	.name =3D "master-camnoc-ife-lite-1", .buswidth =3D 8
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_2 =3D {
> +	.name =3D "master-camnoc-ife-lite-2", .buswidth =3D 8
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_3 =3D {
> +	.name =3D "master-camnoc-ife-lite-3", .buswidth =3D 8
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ife_lite_4 =3D {
> +	.name =3D "master-camnoc-ife-lite-4", .buswidth =3D 8
> +};
> +
> +/* BPS */
> +static const struct qcom_camnoc_node camnoc_master_bps =3D {
> +	.name =3D "master-camnoc-bps", .buswidth =3D 16
> +};
> +
> +/* IPE */
> +static const struct qcom_camnoc_node camnoc_master_ipe_0 =3D {
> +	.name =3D "master-camnoc-ipe-0", .buswidth =3D 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_ipe_1 =3D {
> +	.name =3D "master-camnoc-ipe-1", .buswidth =3D 16
> +};
> +
> +/* JPEG */
> +static const struct qcom_camnoc_node camnoc_master_jpeg =3D {
> +	.name =3D "master-camnoc-jpeg", .buswidth =3D 16
> +};
> +
> +static const struct qcom_camnoc_node camnoc_master_jpeg_dma =3D {
> +	.name =3D "master-camnoc-jpeg-dma", .buswidth =3D 16
> +};
> +
> +/* CDM */
> +static const struct qcom_camnoc_node camnoc_master_cdm =3D {
> +	.name =3D "master-camnoc-cdm", .buswidth =3D 4
> +};
> +
> +/* FD */
> +static const struct qcom_camnoc_node camnoc_master_fd =3D {
> +	.name =3D "master-camnoc-fd", .buswidth =3D 16
> +};
> +
> +/* SBI */
> +static const struct qcom_camnoc_node camnoc_master_sbi =3D {
> +	.name =3D "master-camnoc-sbi", .buswidth =3D 16
> +};
> +
> +/* ICP */
> +static const struct qcom_camnoc_node camnoc_master_icp =3D {
> +	.name =3D "master-camnoc-icp", .buswidth =3D 8
> +};
> +
> +/* Slave */
> +static const struct qcom_camnoc_node camnoc_slave_axi =3D {
> +	.name =3D "slave-camnoc-axi", .buswidth =3D 32
> +};
> +
> +static const struct qcom_camnoc_node * const camnoc_nodes[] =3D {
> +	[MASTER_CAMNOC_IFE_0]      =3D &camnoc_master_ife_0,
> +	[MASTER_CAMNOC_IFE_0_RDI]  =3D &camnoc_master_ife_0_rdi,
> +	[MASTER_CAMNOC_IFE_1]      =3D &camnoc_master_ife_1,
> +	[MASTER_CAMNOC_IFE_1_RDI]  =3D &camnoc_master_ife_1_rdi,
> +	[MASTER_CAMNOC_IFE_LITE_0] =3D &camnoc_master_ife_lite_0,
> +	[MASTER_CAMNOC_IFE_LITE_1] =3D &camnoc_master_ife_lite_1,
> +	[MASTER_CAMNOC_IFE_LITE_2] =3D &camnoc_master_ife_lite_2,
> +	[MASTER_CAMNOC_IFE_LITE_3] =3D &camnoc_master_ife_lite_3,
> +	[MASTER_CAMNOC_IFE_LITE_4] =3D &camnoc_master_ife_lite_4,
> +	[MASTER_CAMNOC_BPS]        =3D &camnoc_master_bps,
> +	[MASTER_CAMNOC_IPE_0]      =3D &camnoc_master_ipe_0,
> +	[MASTER_CAMNOC_IPE_1]      =3D &camnoc_master_ipe_1,
> +	[MASTER_CAMNOC_JPEG]       =3D &camnoc_master_jpeg,
> +	[MASTER_CAMNOC_JPEG_DMA]   =3D &camnoc_master_jpeg_dma,
> +	[MASTER_CAMNOC_CDM]        =3D &camnoc_master_cdm,
> +	[MASTER_CAMNOC_FD]         =3D &camnoc_master_fd,
> +	[MASTER_CAMNOC_SBI]        =3D &camnoc_master_sbi,
> +	[MASTER_CAMNOC_ICP]        =3D &camnoc_master_icp,
> +	[SLAVE_CAMNOC_AXI]         =3D &camnoc_slave_axi,
> +};
> +
> +#define CAMNOC_NUM_NODES	ARRAY_SIZE(camnoc_nodes)
> +
> +static int qcom_camnoc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg =3D 0;
> +	*peak =3D 0;
> +
> +	return 0;
> +}
> +
> +static int qcom_camnoc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct qcom_camnoc_icc_provider *cp =3D
> +		to_camnoc_provider(src->provider);
> +	unsigned long rate;
> +
> +	/*
> +	 * peak_bw is the aggregated max across all consumers (kBps).
> +	 * Consumers encode the required clock frequency directly as kBps,
> +	 * so the conversion is simply: rate_hz =3D peak_bw * 1000.
> +	 * A vote of 0 means no requirement; leave the clock at its minimum.
> +	 */
> +	rate =3D icc_units_to_bps(dst->peak_bw);
> +
> +	return clk_set_rate(cp->clk, rate);

This driver does nothing to the ICC hardware, no votes. It only
translates kbps to Hz. This is not the purpose of ICC drivers.

Looks heavily incomplete.

Best regards,
Krzysztof

