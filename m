Return-Path: <SRS0=/XJp=SH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AAEC4360F
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F09205F4
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yE2fQiVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfDEO6O (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:58:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37767 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEO6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Apr 2019 10:58:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so3428332pfr.4
        for <linux-pm@vger.kernel.org>; Fri, 05 Apr 2019 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbqM8U+UT8TlJRDdTx6i0r3+7AMpV+HHsD4RBzwsE1M=;
        b=yE2fQiVaUAb+762cZEjF7qCSw6XleQ080csYPCKX6ABHKbQd46swY8I5YS6ykomlbO
         hJ+gK0e9jIKwc7ToUtNabS6i4Ow9U1bwkUMBOVOuL9mfEadfGjGPGNA85QfJzmQDMaj8
         9IBekh4Kn2Fi6m3W3SO+RgM4m0PI2yk+1fjWPgU45Zjv3CITNE+d8LY/GY2b2zNH9r27
         SC0Av95D3GFfjmSunOStyhpVWHZUR3IASmZNH5tFlal8LSN9ZB5gO8bfSHlzFGXIU8Ow
         vPUSnY7QYowlQo0DtMCv29voCE9KYLlMyPu0Njoo3u7WqPKzY6m/w8mV3JdQvPeg0wtg
         sMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbqM8U+UT8TlJRDdTx6i0r3+7AMpV+HHsD4RBzwsE1M=;
        b=qFLH2RmMkZqK5SzzSvSONMebECsQB/q1U9tsDGBh4+i/mRA/8LZKkwYulR5muPCMrY
         IsR2cem0Fg51ENhczD1lBO8HSpn9+dfHTk8hljj1D0zCpre7K8djs9fQD67REovkbqbc
         2tcLIHi/HiutM9fUIEWC1XRGPDb7XeS8UuUw1HijuPqD7CAE5ws9MezFbiYHe0xuxCNg
         TaP3htdiEA6r7Fl4d2YIic5qPBJ0BwhgPxriYjsfvflAWUZ5O04y2fAPNO1a3/z9Fuoj
         UAPRG12/BInxXZNjZqFGL/FY/Pmmg79IXoCuHW73gJ1tzHbY3dB9rrXEXFYS7YVhdSmQ
         O33A==
X-Gm-Message-State: APjAAAXpqqNBkm9JNJuuQSZPKvhCO3eB0KjG1GZqOGUe4MR9yRil6VBG
        UM4l0rsV3fzgvP4Gx4/szIgtMQ==
X-Google-Smtp-Source: APXvYqyM9nftOBkqco24wvGC3lRT+uSe82duWmBuHlL3Wf3fR2ko0UlVnbsc4uiwodgsVr2FGCPg5Q==
X-Received: by 2002:aa7:820c:: with SMTP id k12mr12853766pfi.177.1554476293529;
        Fri, 05 Apr 2019 07:58:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k65sm37639999pfb.68.2019.04.05.07.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 07:58:12 -0700 (PDT)
Date:   Fri, 5 Apr 2019 21:57:56 +0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] interconnect: qcom: Add QCS404 interconnect provider
 driver
Message-ID: <20190405145756.GN1843@tuxbook-pro>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405035446.31886-3-georgi.djakov@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190405145756.tOUcKjzXF5Szt4Meg0Vbkc0Z0dgjWpkdIjxsYo668TQ@z>

On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
[..]
> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> new file mode 100644
> index 000000000000..42d36db13ec0
> --- /dev/null
> +++ b/drivers/interconnect/qcom/qcs404.c
> @@ -0,0 +1,488 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Linaro Ltd
> + */
> +
> +#include <dt-bindings/interconnect/qcom,qcs404.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +#include "qcs404_ids.h"
> +
> +#define RPM_BUS_MASTER_REQ	0x73616d62
> +#define RPM_BUS_SLAVE_REQ	0x766c7362
> +#define RPM_KEY_BW		0x00007762
> +
> +#define to_qcom_provider(_provider) \
> +	container_of(_provider, struct qcom_icc_provider, provider)
> +
> +struct qcom_smd_rpm *qcs404_rpm;

static

> +
[..]
> +#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
> +		     _numlinks, ...)					\
> +		static struct qcom_icc_node _name = {			\
> +		.name = #_name,						\
> +		.id = _id,						\
> +		.buswidth = _buswidth,					\
> +		.mas_rpm_id = _mas_rpm_id,				\
> +		.slv_rpm_id = _slv_rpm_id,				\
> +		.num_links = _numlinks,					\

If you write this as ARRAY_SIZE(((int[]){ __VA_ARGS__ })), you don't
need the manually entered _numlinks number.

> +		.links = { __VA_ARGS__ },				\
> +	}
> +
[..]
> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct qcom_icc_provider *qp;
> +	struct qcom_icc_node *qn;
> +	struct icc_provider *provider;
> +	struct icc_node *n;
> +	u64 sum_bw;
> +	u64 max_peak_bw;
> +	u64 rate;
> +	u32 agg_avg = 0;
> +	u32 agg_peak = 0;
> +	int ret = 0;
> +
> +	qn = src->data;
> +	provider = src->provider;
> +	qp = to_qcom_provider(provider);
> +
> +	list_for_each_entry(n, &provider->nodes, node_list)
> +		qcom_icc_aggregate(n, n->avg_bw, n->peak_bw,
> +				   &agg_avg, &agg_peak);
> +
> +	sum_bw = icc_units_to_bps(agg_avg);
> +	max_peak_bw = icc_units_to_bps(agg_peak);
> +
> +	/* send message to the RPM processor */
> +	if (qn->mas_rpm_id != -1) {
> +		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> +					    RPM_BUS_MASTER_REQ,
> +					    qn->mas_rpm_id,
> +					    sum_bw);
> +		if (ret) {
> +			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
> +			       qn->mas_rpm_id, ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (qn->slv_rpm_id != -1) {
> +		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> +					    RPM_BUS_SLAVE_REQ,
> +					    qn->slv_rpm_id,
> +					    sum_bw);
> +		if (ret) {
> +			pr_err("qcom_icc_rpm_smd_send slv error %d\n",
> +			       ret);
> +			return ret;
> +		}
> +	}
> +
> +	rate = max(sum_bw, max_peak_bw);
> +
> +	do_div(rate, qn->buswidth);
> +
> +	if (qn->rate != rate) {
> +		ret = clk_set_rate(qp->bus_clk, rate);
> +		if (ret) {
> +			pr_err("set clk rate %lld error %d\n", rate, ret);
> +			return ret;
> +		}
> +
> +		ret = clk_set_rate(qp->bus_a_clk, rate);
> +		if (ret) {
> +			pr_err("set clk rate %lld error %d\n", rate, ret);
> +			return ret;
> +		}
> +
> +		qn->rate = rate;
> +	}
> +
> +	return ret;

ret is 0, return 0; and you can skip setting ret = 0 above.

> +}
> +
> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +	const struct qcom_icc_desc *desc;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct qcom_icc_node **qnodes;
> +	struct qcom_icc_provider *qp;
> +	struct icc_node *node;
> +	size_t num_nodes, i;
> +	int ret;
> +
> +	/* wait for RPM */

This isn't waiting, it's getting the reference. That said if you make
these sit on mmio bus you would need to EPROBE_DEFER on the rpm-child
not being probed yet (and by that it would be a wait).

> +	qcs404_rpm = dev_get_drvdata(pdev->dev.parent);
> +	if (!qcs404_rpm) {
> +		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
> +		return -ENODEV;
> +	}
> +
> +	desc = of_device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	qnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
> +	if (!qp)
> +		return -ENOMEM;
> +
> +	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");

Please use the clk_bulk interface instead.

> +	if (IS_ERR(qp->bus_clk))
> +		return PTR_ERR(qp->bus_clk);
> +
> +	ret = clk_prepare_enable(qp->bus_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error enabling bus_clk: %d\n", ret);

clk_prepare_enable() will complain if it fails to enable the clock, so
no need to add another print.

> +		return ret;
> +	}
> +
> +	qp->bus_a_clk = devm_clk_get(&pdev->dev, "bus_a_clk");
> +	if (IS_ERR(qp->bus_a_clk))
> +		return PTR_ERR(qp->bus_a_clk);
> +
> +	ret = clk_prepare_enable(qp->bus_a_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error enabling bus_a_clk: %d\n", ret);
> +		clk_disable_unprepare(qp->bus_clk);
> +		return ret;
> +	}
> +
> +	provider = &qp->provider;
> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->dev = &pdev->dev;
> +	provider->set = qcom_icc_set;
> +	provider->aggregate = qcom_icc_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	provider->data = data;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error adding interconnect provider\n");
> +		clk_disable_unprepare(qp->bus_clk);
> +		clk_disable_unprepare(qp->bus_a_clk);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < num_nodes; i++) {
> +		size_t j;
> +
> +		node = icc_node_create(qnodes[i]->id);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = qnodes[i]->name;
> +		node->data = qnodes[i];
> +		icc_node_add(node, provider);
> +
> +		dev_dbg(&pdev->dev, "registered node %s\n", node->name);
> +
> +		/* populate links */
> +		for (j = 0; j < qnodes[i]->num_links; j++)
> +			icc_link_create(node, qnodes[i]->links[j]);
> +
> +		data->nodes[i] = node;
> +	}
> +	data->num_nodes = num_nodes;
> +
> +	platform_set_drvdata(pdev, qp);
> +
> +	return ret;

ret is 0 here, so just return 0;

> +err:
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		icc_node_del(node);
> +		icc_node_destroy(node->id);
> +	}
> +	clk_disable_unprepare(qp->bus_clk);
> +	clk_disable_unprepare(qp->bus_a_clk);
> +	icc_provider_del(provider);
> +
> +	return ret;
> +}
[..]
> diff --git a/drivers/interconnect/qcom/qcs404_ids.h b/drivers/interconnect/qcom/qcs404_ids.h

You use these defines in the driver, so I think this file should be the
one in include/dt-bindings...

[..]
> diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h

...and that this is an accidental include(?)

Regards,
Bjorn
