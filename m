From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v5 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
Date: Sun, 1 Jul 2018 15:12:47 +0300
Message-ID: <8e2218b4-a193-3bb4-b732-3608a4019977@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-7-georgi.djakov@linaro.org>
 <CAE=gft6pbLzeLLtpWd-jHbvYuURi=SpODOVqgY7mdHhmz=ZP9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft6pbLzeLLtpWd-jHbvYuURi=SpODOVqgY7mdHhmz=ZP9A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Evan,

On 06/26/2018 11:48 PM, Evan Green wrote:
> On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
>>

[..]

>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/msm8916.c
>> @@ -0,0 +1,495 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Linaro Ltd
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#include <dt-bindings/interconnect/qcom.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/interconnect-provider.h>
> 
> Nit: the previous two should be swapped for alphabetization.

Ok.

>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include "smd-rpm.h"
>> +
>> +#define RPM_MASTER_FIELD_BW    0x00007762
> 
> This is unused, since it moved into that other file.

Ok.

[..]

>> +/**
>> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
>> + * @name: the node name used in debugfs
>> + * @links: an array of nodes where we can go next while traversing
>> + * @id: a unique node identifier
>> + * @num_links: the total number of @links
>> + * @port: the offset index into the masters QoS register space
>> + * @buswidth: width of the interconnect between a node and the bus (bytes)
>> + * @ap_owned: the AP CPU does the writing to QoS registers
>> + * @rpm: reference to the RPM SMD driver
>> + * @qos_mode: QoS mode for ap_owned resources
>> + * @mas_rpm_id:        RPM id for devices that are bus masters
>> + * @slv_rpm_id:        RPM id for devices that are bus slaves
>> + * @rate: current bus clock rate in Hz
>> + */
>> +struct qcom_icc_node {
>> +       unsigned char *name;
>> +       u16 links[MSM8916_MAX_LINKS];
>> +       u16 id;
>> +       u16 num_links;
>> +       u16 port;
>> +       u16 buswidth;
>> +       bool ap_owned;
>> +       struct qcom_smd_rpm *rpm;
> 
> This is unused.

Ok, will remove.

>> +       enum qcom_qos_mode qos_mode;
>> +       int mas_rpm_id;
>> +       int slv_rpm_id;
>> +       u64 rate;
>> +};
>> +

[..]

>> +static int qcom_icc_init(struct icc_node *node)
>> +{
>> +       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
>> +       int ret;
>> +
>> +       /* TODO: init qos and priority */
>> +
>> +       clk_set_rate(qp->bus_clk, INT_MAX);
> 
> Vroom! What's the rationale here? I wonder if it might be better to
> avoid touching the clocks initially, and expect that the boot loader
> sets up a decent initial set of bus frequencies for consumers that
> never enable bus scaling? Otherwise, I worry that this driver becomes
> basically an essential driver for the platform solely because of this
> line and the one below, when really it might not be.

The idea is to run the interconnects at max rate until consumers start
sending requests, but i understand your worry and we can live without
this for now. The better solution would be to set maximum bandwidth and
remove it at late_init (after consumers are registered) or use this
patchset: https://lkml.org/lkml/2018/3/21/897
Actually I have some patches which add support for interconnects to keep
the bandwidth constraints active until consumers are registered. The
whole boot constraint thing adds complexity and introduces some
overhead, but hopefully can be optimized.

>> +       ret = clk_prepare_enable(qp->bus_clk);
>> +       if (ret)
>> +               pr_info("%s: error enabling bus clk (%d)\n", __func__, ret);
>> +       clk_set_rate(qp->bus_a_clk, INT_MAX);
>> +       ret = clk_prepare_enable(qp->bus_a_clk);
>> +       if (ret)
>> +               pr_info("%s: error enabling bus_a clk (%d)\n", __func__, ret);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw, u32 peak_bw,
>> +                             u32 *agg_avg, u32 *agg_peak)
>> +{
>> +       *agg_avg += avg_bw;
>> +       *agg_peak = max(*agg_peak, peak_bw);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
>> +                       u32 avg, u32 peak)
>> +{
>> +       struct qcom_icc_provider *qp;
>> +       struct qcom_icc_node *qn;
>> +       struct icc_node *node;
>> +       struct icc_provider *provider;
>> +       u64 avg_bw = icc_units_to_bps(avg);
>> +       u64 peak_bw = icc_units_to_bps(peak);
>> +       u64 rate = 0;
>> +       int ret = 0;
>> +
>> +       if (!src)
>> +               node = dst;
>> +       else
>> +               node = src;
>> +
>> +       qn = node->data;
>> +       provider = node->provider;
>> +       qp = to_qcom_provider(node->provider);
>> +
>> +       /* set bandwidth */
>> +       if (qn->ap_owned) {
>> +               /* TODO: set QoS */
>> +       } else {
>> +               /* send message to the RPM processor */
>> +               if (qn->mas_rpm_id != -1) {
>> +                       ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>> +                                                   RPM_BUS_MASTER_REQ,
>> +                                                   qn->mas_rpm_id,
>> +                                                   avg_bw);
> 
> You don't check for failure here, and potentially clobber failure with
> success. Unless only one of mas_rpm_id and slv_rpm_id is ever set. But
> no, I see SNOC_INT_0/1 set both. Same for below.

Ok, will add error checking.

>> +               }
>> +
>> +               if (qn->slv_rpm_id != -1) {
>> +                       ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>> +                                                   RPM_BUS_SLAVE_REQ,
>> +                                                   qn->slv_rpm_id,
>> +                                                   avg_bw);
>> +               }
>> +       }
>> +
>> +       rate = max(avg_bw, peak_bw);
>> +
>> +       do_div(rate, qn->buswidth);
>> +
>> +       if (qn->rate != rate) {
>> +               ret = clk_set_rate(qp->bus_clk, rate);
>> +               if (ret) {
>> +                       pr_err("set clk rate %lld error %d\n", rate, ret);
>> +                       return ret;
>> +               }
>> +
>> +               ret = clk_set_rate(qp->bus_a_clk, rate);
>> +               if (ret) {
>> +                       pr_err("set clk rate %lld error %d\n", rate, ret);
>> +                       return ret;
>> +               }
>> +
>> +               qn->rate = rate;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +       const struct qcom_icc_desc *desc;
>> +       struct qcom_icc_node **qnodes;
>> +       struct qcom_icc_provider *qp;
>> +       struct resource *res;
>> +       struct icc_provider *provider;
>> +       size_t num_nodes, i;
>> +       int ret;
>> +
>> +       /* wait for RPM */
>> +       if (!qcom_icc_rpm_smd_available())
>> +               return -EPROBE_DEFER;
>> +
>> +       desc = of_device_get_match_data(&pdev->dev);
>> +       if (!desc)
>> +               return -EINVAL;
>> +
>> +       qnodes = desc->nodes;
>> +       num_nodes = desc->num_nodes;
>> +
>> +       qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
>> +       if (!qp)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       qp->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(qp->base))
>> +               return PTR_ERR(qp->base);
>> +
>> +       qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
>> +       if (IS_ERR(qp->bus_clk))
>> +               return PTR_ERR(qp->bus_clk);
>> +
>> +       qp->bus_a_clk = devm_clk_get(&pdev->dev, "bus_a_clk");
>> +       if (IS_ERR(qp->bus_a_clk))
>> +               return PTR_ERR(qp->bus_a_clk);
>> +
>> +       provider = &qp->provider;
>> +       provider->dev = &pdev->dev;
>> +       provider->set = &qcom_icc_set;
>> +       provider->aggregate = &qcom_icc_aggregate;
>> +       INIT_LIST_HEAD(&provider->nodes);
>> +       provider->data = qp;
>> +
>> +       ret = icc_provider_add(provider);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "error adding interconnect provider\n");
>> +               return ret;
>> +       }
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               struct icc_node *node;
>> +               int ret;
>> +               size_t j;
>> +
>> +               node = icc_node_create(qnodes[i]->id);
>> +               if (IS_ERR(node)) {
>> +                       ret = PTR_ERR(node);
>> +                       goto err;
>> +               }
>> +
>> +               node->name = qnodes[i]->name;
>> +               node->data = qnodes[i];
>> +               icc_node_add(node, provider);
>> +
>> +               dev_dbg(&pdev->dev, "registered node %s\n", node->name);
>> +
>> +               ret = qcom_icc_init(node);
>> +               if (ret)
>> +                       dev_err(&pdev->dev, "%s init error (%d)\n", node->name,
>> +                               ret);
>> +
>> +               /* populate links */
>> +               for (j = 0; j < qnodes[i]->num_links; j++)
>> +                       if (qnodes[i]->links[j])
>> +                               icc_link_create(node, qnodes[i]->links[j]);
>> +       }
>> +
>> +       platform_set_drvdata(pdev, provider);
>> +
>> +       return ret;
>> +err:
>> +       icc_provider_del(provider);
>> +       return ret;
>> +}
>> +
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +       struct icc_provider *provider = platform_get_drvdata(pdev);
>> +
>> +       icc_provider_del(provider);
> 
> This function can fail, so you should probably pass the failure along.
> 

Ok! Thank you!

BR,
Georgi
