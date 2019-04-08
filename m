From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 2/3] interconnect: qcom: Add QCS404 interconnect provider
 driver
Date: Mon, 8 Apr 2019 17:33:53 +0300
Message-ID: <0ca7862f-31ba-748a-945d-a925a40a16de@linaro.org>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-3-georgi.djakov@linaro.org>
 <20190405145756.GN1843@tuxbook-pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405145756.GN1843@tuxbook-pro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Bjorn,

Thanks for reviewing!

On 4/5/19 17:57, Bjorn Andersson wrote:
> On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
> [..]
>> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
>> new file mode 100644
>> index 000000000000..42d36db13ec0
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/qcs404.c
>> @@ -0,0 +1,488 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 Linaro Ltd
>> + */
>> +
>> +#include <dt-bindings/interconnect/qcom,qcs404.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/soc/qcom/smd-rpm.h>
>> +
>> +#include "qcs404_ids.h"
>> +
>> +#define RPM_BUS_MASTER_REQ	0x73616d62
>> +#define RPM_BUS_SLAVE_REQ	0x766c7362
>> +#define RPM_KEY_BW		0x00007762
>> +
>> +#define to_qcom_provider(_provider) \
>> +	container_of(_provider, struct qcom_icc_provider, provider)
>> +
>> +struct qcom_smd_rpm *qcs404_rpm;
> 
> static

Ok!

>> +
> [..]
>> +#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
>> +		     _numlinks, ...)					\
>> +		static struct qcom_icc_node _name = {			\
>> +		.name = #_name,						\
>> +		.id = _id,						\
>> +		.buswidth = _buswidth,					\
>> +		.mas_rpm_id = _mas_rpm_id,				\
>> +		.slv_rpm_id = _slv_rpm_id,				\
>> +		.num_links = _numlinks,					\
> 
> If you write this as ARRAY_SIZE(((int[]){ __VA_ARGS__ })), you don't
> need the manually entered _numlinks number.

This is a really nice idea!

> 
>> +		.links = { __VA_ARGS__ },				\
>> +	}
>> +
> [..]
[..]
>> +
>> +	return ret;
> 
> ret is 0, return 0; and you can skip setting ret = 0 above.

Ok!

>> +}
>> +
>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +	const struct qcom_icc_desc *desc;
>> +	struct icc_onecell_data *data;
>> +	struct icc_provider *provider;
>> +	struct qcom_icc_node **qnodes;
>> +	struct qcom_icc_provider *qp;
>> +	struct icc_node *node;
>> +	size_t num_nodes, i;
>> +	int ret;
>> +
>> +	/* wait for RPM */
> 
> This isn't waiting, it's getting the reference. That said if you make
> these sit on mmio bus you would need to EPROBE_DEFER on the rpm-child
> not being probed yet (and by that it would be a wait).

Agree that it's a reference. The mmio registers are mostly qos related
and seem not required for just requesting bandwidth, so we can add them
later if we want to support priorities and different port modes like
limiter, regulator etc.

>> +	qcs404_rpm = dev_get_drvdata(pdev->dev.parent);
>> +	if (!qcs404_rpm) {
>> +		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	desc = of_device_get_match_data(&pdev->dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	qnodes = desc->nodes;
>> +	num_nodes = desc->num_nodes;
>> +
>> +	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
>> +	if (!qp)
>> +		return -ENOMEM;
>> +
>> +	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> 
> Please use the clk_bulk interface instead.

Ok, will do.

>> +	if (IS_ERR(qp->bus_clk))
>> +		return PTR_ERR(qp->bus_clk);
>> +
>> +	ret = clk_prepare_enable(qp->bus_clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "error enabling bus_clk: %d\n", ret);
> 
> clk_prepare_enable() will complain if it fails to enable the clock, so
> no need to add another print.

Ok, right!

[..]>> +
>> +	platform_set_drvdata(pdev, qp);
>> +
>> +	return ret;
> 
> ret is 0 here, so just return 0;

Ok!

>> +err:
>> +	list_for_each_entry(node, &provider->nodes, node_list) {
>> +		icc_node_del(node);
>> +		icc_node_destroy(node->id);
>> +	}
>> +	clk_disable_unprepare(qp->bus_clk);
>> +	clk_disable_unprepare(qp->bus_a_clk);
>> +	icc_provider_del(provider);
>> +
>> +	return ret;
>> +}
> [..]
>> diff --git a/drivers/interconnect/qcom/qcs404_ids.h b/drivers/interconnect/qcom/qcs404_ids.h
> 
> You use these defines in the driver, so I think this file should be the
> one in include/dt-bindings...

The ids in this header are in a single global namespace in order to
build the internal topology and could be used for drivers that support
only platform data (although not sure if there would be any).

> 
> [..]
>> diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h
> 

These header is using per NoC local ids and should be used on DT enabled
platforms.

Thanks,
Georgi
