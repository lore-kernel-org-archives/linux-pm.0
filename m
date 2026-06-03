Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1A3C6A38
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527297; cv=none; b=J1m4U4N/geV/48ZsfTvLbACVwvi3LJiNyy5Htq8YnQWaE39MSpF+0Qy2OPuwil79W2lA0dpUcgOf+Wg9O433ocDo/apd3N1mna3s1I2X6XDzep9rh6BzxA9hs/2c9VYlVLrHSZONjediMhgO5AKSSPL7GlyT+6KBuvZnxXuyzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527297; c=relaxed/simple;
	bh=EPMI7DCE37nSjt9Ex/1o+56sJPnrjphSFvIbrzqCcG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4oPi2wIE4Z/c8pUKEF5eQzFHgLSJUozJsKYXPIwgkL9yBJ4ZNSSm8pTw4ONQ+65SrYO2JIBKFtDnnTTS4R6mI8GdHLofGEu06MZibHpmm9CANbpYyykPxFVVfrXGQBmirNuW2CbzP2u+yQ8x1jYCKqKTiTxS+7JMxOfNVngpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TM/8JfnZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZTfy/D0v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TM/8JfnZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZTfy/D0v"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653Hw1jZ3234473
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 22:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g4NoLES+Y6RKixutpEbG860lmzjYy+mynRRPEoFmsdw=; b=TM/8JfnZXDAhmHun
	bK4oYjPMqFq8pyapSZaVOQoFvWwbvec77IPcI/KMvE9FJGeS0LqHzzNfOJf8OqBt
	elH15Dh8UVQkno0E62McFRnuqfW2yMQeUWvJynel/a2qZZkKrUi1IIUVMUg0hPxb
	Owx3piNxyxZNkZJmawIZji1PgwMIZVx7g8eAP2KLoiiN7IRLyD+o+VYE7r1DpFeQ
	uuT2ce2cgWa2UgkTDg+7DOyG1MeCyYqsz2XAAsJf3h2RxbEQqXxo1IAdYW1MnEOu
	NDpZRWhscx2W1wod1lnWmXSt2gZk7SB/79+BrA6rpXZbXlX/Vh1Lk6tKmPHSkhOc
	wJqr+w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s11tm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 22:54:53 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6e9280ea589so49955137.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780527292; x=1781132092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4NoLES+Y6RKixutpEbG860lmzjYy+mynRRPEoFmsdw=;
        b=ZTfy/D0v7Njj655WGAw4vtXKgcpn2AgKhVynHTgOFCwtyvTBYEgLiFT+WLgwXLR4Ip
         xCXJhnB+1QjudzoGsoKqkJr2nT+7Ux1A1oqbxoruSdGQYll1JnK+KIsSfG5t+nG+sAN0
         xSYXTU00MxTzxHE439xO8TVN4upT5cc+bamkGCHxt39Mb37LxduN0hdopLpiZblLJbmW
         8pHKXSn9/gINvBPjRcXFIui4M9yKeZBD4+DLooIBZPgeZsIYaAqYSyJr+wK0KWXDUcvx
         imHFg1gUTZb1uFhSVJXmA4zqmfQws7negHd2sz6kzKRFpXr9KQQiFKWzROWoId4tD90g
         PcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527292; x=1781132092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4NoLES+Y6RKixutpEbG860lmzjYy+mynRRPEoFmsdw=;
        b=D7fooyaosGbMQR2UMrZEod/XOHj6XwwIvl65qOlndWIFqxYHaVSd/gQvz6khSjI3SN
         +sQazJSz0PxVIgKzkE1tbCXKilDZ5vfQCwDKw/hkAmmrhYvyMc0rA0X9U7RSeTGCbpQs
         sEozVOHvMBSq1/nCDF0WwqlwanCYy3tXmIvqSDu9pFuABIT2fWmZjaf3lkFpekDsfno+
         WyMyTV3/y6Hb5TN4aMS9D+6Gka4iz1lN4K1lMz6SH5aTXBnHHr+nc98CCEKCAXI5iOGJ
         WYGi2fk6lddRIQEWrEcZh77wxNT150/esPZsKqno6QSPpSOy952dkyVnxTRJ7IsKMQMs
         06rg==
X-Forwarded-Encrypted: i=1; AFNElJ+ITj0ZgP373lsFInPmAZSb9blvInjYRrzCVzcY9ezGlF1tcTiX1R25zkMKpw/jqrWPZhk080w2og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAz6ZbINIyGANdPNEP9xKpvkr0gbjclqJrvqusp8gD28Wn/1qh
	xCGIp5NGxl+uAyk7/soeQ86bBeFDmiDKIrzwtLBJGo4IixqkGRj/ZdGnwpepHpxxuDWK43ZlON7
	qY+AcMW+6/ApwF1byOc6UEgpTxKS6hHitrBpoDzPFndHEfvBwXn6nL8FgLx7xMA==
X-Gm-Gg: Acq92OF9ByhViSoQsXus848a0ZEHoW59qHSnzE3VJUppncbDM+FTTAbT/kchx/bQdU8
	P50+q0ofOOwgCaiUs6A8Nvk+xvZ63zqRfw4u3aMrNoBPJTXcDnj5eN6NT8Yp4ybPxjuqUt/H4Pa
	QLjOEksNEBIjXVdpPBY2xTe9L24MUMitASl/CqmpGjBHtwtSWlhMAJvaS8vzXYoXheU+gyx0XwK
	I46YzaNdM8oUC+Kw7HVQBqtMnbsXJC6gpl7dmnxwptlWJGvx8Zbirw+3Ux5SUe/U/GuygkwEXdE
	1acdfmXsTHybs6ENJB5k7MG070Be0eMyhME9yRKqTzsP/6gsw3XADh9WJgbg+z3wQxdPZ6bxeTE
	keu9ai2T81Uvx6BdPvte3MKaeBYCyDY42Ato/8+/M0TX3HVrCgSVTrRJB//DCFP+3z1W7PMMX9G
	7CELZE4fpnvGRC2mpl1SklSP9PjauG0LdGxXSbBDEB4VfiUA==
X-Received: by 2002:a05:6102:5129:b0:613:e996:3014 with SMTP id ada2fe7eead31-6ec7237dad6mr3448541137.20.1780527292306;
        Wed, 03 Jun 2026 15:54:52 -0700 (PDT)
X-Received: by 2002:a05:6102:5129:b0:613:e996:3014 with SMTP id ada2fe7eead31-6ec7237dad6mr3448525137.20.1780527291750;
        Wed, 03 Jun 2026 15:54:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fba62sm890057e87.19.2026.06.03.15.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 15:54:50 -0700 (PDT)
Date: Thu, 4 Jun 2026 01:54:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: add MSM8x60 NoC driver
Message-ID: <f36o7gjzvnf3rmys2z6f2pq47ndx2py6mqsjnkhdcfnnn44hvc@wcfrbcvin5w3>
References: <20260603163410.2312712-1-github.com@herrie.org>
 <20260603163410.2312712-3-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603163410.2312712-3-github.com@herrie.org>
X-Proofpoint-ORIG-GUID: DUEr07jydvTIaSQW9evASpguvawdrub5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyMyBTYWx0ZWRfX6ATs9zck0Lgt
 N3UcJIBdyphu/x52goHKYEyhuD7hVOddcXBcyGhLxYzFQ9PRfw5bG6+GtiEdB4pNdKUxU56ih8Z
 ZHToXro0IEk4OeYsEChCgGGgE/amoMp6PwpwMKdjtVPB82QvF4HIoOODFzbP6f3tGyFiYPNjiP5
 1ZcVa0FGZWl+2DpJnSZDzYUrtMGPfEnTeyaIe6If7TUFgGOKW9t43AKz0dJeyLCAuL2k0naOQjM
 ts8Qaq9YBP1DHXwFWP336uZojTxGHfLLzQEMFskJOPYuIv+RI0lf1zQ6bxD8eFUDvhFWrYu4bB3
 vJPzjfXLMQTz2FTTPQlgQDamOiJowWf3UXAD4jT0X+lnEMKP+1FcphGrQVzrMIchnVGeO1+HIcW
 9vzFuU5aY6snNnxk4CrFvGR3TEzUre33eZWu07nGe9Uf5sr0eg9TYUSnbn139P2agErtYfUKn6a
 RtoxF/8cnAh8zolhlDQ==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a20b0bd cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=cTwmTnRGAAAA:8
 a=vW-hlcJimHXVMuZkqwUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=GUWCSGlMWfG-xDt5EnV5:22
X-Proofpoint-GUID: DUEr07jydvTIaSQW9evASpguvawdrub5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030223

On Wed, Jun 03, 2026 at 06:34:10PM +0200, Herman van Hazendonk wrote:
> Add a Qualcomm interconnect driver for the MSM8x60 family modelling the
> four NoC fabrics (APPSS, System, MMSS, DFAB) that connect masters and
> slaves on these Scorpion-class SoCs. The driver implements the
> interconnect-provider API to manage bandwidth between specific masters
> and slaves via the RPM arbitration tables.
> 
> Each fabric carries:
>   - A bus clock (managed via clk_bulk APIs) whose rate is the
>     aggregated bandwidth divided by the fabric bus width, with a
>     minimum floor of 384 MHz to prevent USB starvation observed when
>     the fabric drops to the previously-used 266 MHz minimum.
>   - An RPM arbitration buffer (arb / bwsum) that the RPM firmware
>     consumes via its shared-memory protocol; commits go via the
>     qcom-rpm driver's set_resource API.
> 
> msm8660_get_rpm() pins the supplier with device_link_add() before
> reading drvdata so an unbind/rebind window cannot leave a stale
> qcom_rpm pointer. clk_bulk_prepare_enable is paired with a
> devm_add_action_or_reset cleanup so an EPROBE_DEFER from the RPM
> lookup does not leak the prepare/enable refcount across retries. The
> fabric rate cap uses min_t(u64,...) so a bandwidth request exceeding
> 4 GiB/s cannot wrap through u32 truncation into a near-zero clock
> rate that would halt the interconnect.

Thanks for working on this.

> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  drivers/interconnect/qcom/Kconfig             |   14 +
>  drivers/interconnect/qcom/Makefile            |    2 +
>  drivers/interconnect/qcom/msm8660.c           | 1147 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,msm8660.h   |    6 +-
>  4 files changed, 1166 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/interconnect/qcom/msm8660.c
> 
> +
> +/*
> + * RPM fabric arbitration data format (from legacy vendor kernel msm_bus_fabric.c):
> + *
> + * Each u16 arb entry: bit 15 = tier (1=TIER1 high priority), bits 14-0 = BW
> + * Bandwidth is in 128KB units (bytes >> 17).
> + * Two u16 values are packed into each u32 RPM register word.
> + *
> + * Buffer layout: [bwsum pairs] [arb pairs]
> + * bwsum[slave_port] = total bandwidth to that slave
> + * arb[(tier-1)*nmasters + master_port] = per-master arbitration entry
> + */
> +#define ARB_BWMASK		0x7FFF
> +#define ARB_TIERMASK		0x8000
> +#define ARB_TIER1		1
> +#define ARB_TIER2		2
> +
> +static const struct clk_bulk_data msm8660_afab_clocks[] = {
> +	{ .id = "bus" },
> +	{ .id = "bus_a" },
> +	{ .id = "ebi1" },
> +	{ .id = "ebi1_a" },

What clocks are those? Please provide the actual dt-bindings schema
(together with the examples). In the past we had bus / bus_a clocks for
the SMD-RPM-based interconnects, but lyter they were ripped out and
replaced with the direct voting for the resources.

> +};
> +
> +
> +/*
> + * Node definitions with RPM port mapping.
> + *
> + * DEFINE_QNODE(_name, _id, _buswidth, _mas_port, _slv_port, _tier, links...)
> + *
> + * _mas_port: master port index for RPM ARB array (-1 if not a master)
> + * _slv_port: slave port index for RPM bwsum array (-1 if not a slave)
> + * _tier: master priority tier (ARB_TIER1=1, ARB_TIER2=2, 0 if N/A)
> + */
> +#define DEFINE_QNODE(_name, _id, _buswidth, _mas, _slv, _tier, ...)	\

Please expand the macro.

> +	static struct msm8660_icc_node _name = {			\
> +		.name = #_name,						\
> +		.id = _id,						\
> +		.buswidth = _buswidth,					\
> +		.num_links = COUNT_ARGS(__VA_ARGS__),			\
> +		.links = { __VA_ARGS__ },				\
> +		.mas_port = _mas,					\
> +		.slv_port = _slv,					\
> +		.mas_tier = _tier,					\
> +	}
> +

[...]

> +/*
> + * Look up the RPM that owns fabric arbitration writes.
> + *
> + * Returns NULL if the DT does not have a "qcom,rpm" phandle (in which
> + * case the caller silently drops RPM ARB and runs the fabric purely
> + * via clk_set_rate).
> + *
> + * Returns ERR_PTR(-EPROBE_DEFER) if the RPM device exists in DT but
> + * its driver has not finished probing yet, or if device_link_add()
> + * fails. The caller is expected to propagate this so the interconnect
> + * driver gets retried once the RPM is ready.
> + *
> + * On success returns the qcom_rpm handle and pins the RPM device
> + * lifetime to ours via a consumer-supplier device link, so the
> + * devres-allocated qcom_rpm cannot be freed while we still hold a
> + * pointer to it.
> + */
> +static struct qcom_rpm *msm8660_get_rpm(struct device *dev)
> +{
> +	struct device_node *rpm_np;
> +	struct platform_device *rpm_pdev;
> +	struct device_link *link;
> +	struct qcom_rpm *rpm;
> +
> +	rpm_np = of_parse_phandle(dev->of_node, "qcom,rpm", 0);
> +	if (!rpm_np) {
> +		dev_dbg(dev, "no qcom,rpm phandle, RPM ARB disabled\n");
> +		return NULL;

Here and further, return dev_err_ptr_probe().

> +	}
> +
> +	rpm_pdev = of_find_device_by_node(rpm_np);
> +	of_node_put(rpm_np);
> +	if (!rpm_pdev) {
> +		dev_dbg(dev, "RPM device not found yet, deferring probe\n");
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	/*
> +	 * Pin the supplier BEFORE reading its drvdata. The device link
> +	 * (MANAGED, the default state) prevents the RPM driver from being
> +	 * unbound while we hold the link, which closes the window where a
> +	 * concurrent unbind+rebind could free the qcom_rpm pointer between
> +	 * dev_get_drvdata() and the link being established. If the link
> +	 * cannot be added (e.g. supplier is in the process of being
> +	 * removed) we defer and retry.
> +	 */
> +	link = device_link_add(dev, &rpm_pdev->dev,
> +			       DL_FLAG_AUTOREMOVE_CONSUMER);
> +	put_device(&rpm_pdev->dev);
> +	if (!link) {
> +		dev_warn(dev, "failed to add device link to RPM, deferring\n");
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	/*
> +	 * Safe to read drvdata now: the device link pins the supplier so
> +	 * it cannot be unbound until our consumer (this interconnect
> +	 * provider) is unbound first.
> +	 */
> +	rpm = dev_get_drvdata(&rpm_pdev->dev);
> +	if (!rpm) {
> +		dev_dbg(dev, "RPM not ready, deferring probe\n");
> +		device_link_remove(dev, &rpm_pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	return rpm;
> +}
> +
> +static int msm8660_icc_probe(struct platform_device *pdev)
> +{
> +	const struct msm8660_icc_desc *desc;
> +	struct msm8660_icc_node * const *qnodes;
> +	struct msm8660_icc_provider *qp;
> +	struct device *dev = &pdev->dev;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct icc_node *node;
> +	size_t num_nodes, i;
> +	int ret;
> +
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	qnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
> +	if (!qp)
> +		return -ENOMEM;
> +
> +	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	data->num_nodes = num_nodes;
> +
> +	qp->bus_clks = devm_kmemdup(dev, desc->bus_clks,
> +				    desc->num_clks * sizeof(*desc->bus_clks),
> +				    GFP_KERNEL);
> +	if (!qp->bus_clks)
> +		return -ENOMEM;
> +
> +	qp->num_clks = desc->num_clks;
> +
> +	/*
> +	 * MSM8660 fabric clocks are managed by RPM firmware and may not be
> +	 * available in mainline Linux yet. Once the clock provider exists,
> +	 * we want to honour it; until then we run without per-fabric clock
> +	 * scaling. The crucial part is that -EPROBE_DEFER means "the
> +	 * provider exists but hasn't probed yet" and MUST be propagated so
> +	 * we get retried; only other errors (genuine -ENOENT, etc.) get
> +	 * downgraded to "no clocks, continue".

Please limit to -ENOENT only.

> +	 */
> +	ret = devm_clk_bulk_get_optional(dev, qp->num_clks, qp->bus_clks);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;
> +	if (ret) {
> +		dev_warn(dev, "Failed to get bus clocks: %d (continuing without clock scaling)\n",
> +			 ret);
> +		qp->num_clks = 0;
> +	}
> +
> +	if (qp->num_clks) {
> +		ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
> +		if (ret) {
> +			dev_warn(dev, "Failed to enable bus clocks: %d\n", ret);
> +			qp->num_clks = 0;
> +		} else {
> +			/*
> +			 * Register the cleanup right after a successful
> +			 * prepare_enable so any later -EPROBE_DEFER or other
> +			 * probe error path (e.g. msm8660_get_rpm failing
> +			 * with -EPROBE_DEFER below) does not leak a clock
> +			 * prepare/enable reference across the retry.
> +			 */
> +			ret = devm_add_action_or_reset(dev,
> +				msm8660_icc_clk_release, qp);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	/* Set up RPM fabric arbitration */
> +	qp->desc = desc;
> +	if (desc->rpm_resource >= 0) {
> +		qp->rpm = msm8660_get_rpm(dev);
> +		if (IS_ERR(qp->rpm))
> +			return PTR_ERR(qp->rpm);
> +		if (qp->rpm) {
> +			int arb_size = desc->nmasters * desc->ntieredslaves;
> +
> +			qp->bwsum = devm_kcalloc(dev, desc->nslaves,
> +						 sizeof(u16), GFP_KERNEL);
> +			qp->arb = devm_kcalloc(dev, arb_size,
> +					       sizeof(u16), GFP_KERNEL);
> +			qp->rpm_buf = devm_kcalloc(dev, desc->rpm_buf_size,
> +						   sizeof(u32), GFP_KERNEL);
> +			if (!qp->bwsum || !qp->arb || !qp->rpm_buf) {
> +				dev_warn(dev, "RPM buffer alloc failed, ARB disabled\n");
> +				qp->rpm = NULL;
> +			} else {
> +				int rc;
> +
> +				dev_info(dev, "RPM fabric ARB enabled (%d masters, %d slaves, %d tiered)\n",
> +					 desc->nmasters, desc->nslaves,
> +					 desc->ntieredslaves);
> +
> +				/*
> +				 * One-shot sleep-context vote of zero bandwidth.
> +				 * Without an explicit SLEEP_STATE write, RPM has no
> +				 * fabric bandwidth target for deep-sleep and may
> +				 * keep the active vote applied indefinitely,
> +				 * preventing DDR from dropping its rate when CPUs
> +				 * power-collapse. The buffer is devm_kcalloc'd so
> +				 * it is all-zero at this point — written before
> +				 * any consumer can drive an active vote that would
> +				 * dirty it.
> +				 *
> +				 * msm8660_rpm_commit() writes ACTIVE_STATE only;
> +				 * SLEEP_STATE remains zero for the provider's
> +				 * lifetime, so this vote does not need refreshing.
> +				 */
> +				rc = qcom_rpm_write(qp->rpm,
> +						    QCOM_RPM_SLEEP_STATE,
> +						    desc->rpm_resource,
> +						    qp->rpm_buf,
> +						    desc->rpm_buf_size);
> +				if (rc)
> +					dev_warn(dev, "RPM fabric sleep vote failed: %d\n",
> +						 rc);
> +			}
> +		}
> +	}
> +
> +	provider = &qp->provider;
> +	provider->dev = dev;
> +	provider->set = msm8660_icc_set;
> +	provider->aggregate = msm8660_icc_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	provider->data = data;
> +	provider->get_bw = msm8660_get_bw;
> +
> +	icc_provider_init(provider);
> +
> +	for (i = 0; i < num_nodes; i++) {
> +		size_t j;
> +
> +		if (!qnodes[i])
> +			continue;
> +
> +		node = icc_node_create(qnodes[i]->id);

Please switch to the dynamic ICC node numbers (see icc-rpmh)

> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err_remove_nodes;
> +		}
> +
> +		node->name = qnodes[i]->name;
> +		node->data = qnodes[i];
> +		icc_node_add(node, provider);
> +

-- 
With best wishes
Dmitry
