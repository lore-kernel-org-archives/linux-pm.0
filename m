From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 5/7] interconnect: qcom: Add msm8916 interconnect
 provider driver
Date: Wed, 6 Jun 2018 18:03:21 +0300
Message-ID: <21c5adcc-dc18-73a1-e07a-d84f2e6ae534@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-6-georgi.djakov@linaro.org>
 <CAE=gft4LT_JSGytuiSx5uwzfeGc0DK140+D4c_J8FVUHioHdcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4LT_JSGytuiSx5uwzfeGc0DK140+D4c_J8FVUHioHdcg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Evan,

On 12.05.18 г. 0:29, Evan Green wrote:
> Hi Georgi,
> 
> On Fri, Mar 9, 2018 at 1:11 PM Georgi Djakov <georgi.djakov@linaro.org>
> wrote:
> 
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
> 
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>    drivers/interconnect/Kconfig        |   5 +
>>    drivers/interconnect/Makefile       |   1 +
>>    drivers/interconnect/qcom/Kconfig   |  11 +
>>    drivers/interconnect/qcom/Makefile  |   2 +
>>    drivers/interconnect/qcom/msm8916.c | 482
> ++++++++++++++++++++++++++++++++++++
>>    include/linux/interconnect/qcom.h   | 350 ++++++++++++++++++++++++++
>>    6 files changed, 851 insertions(+)
>>    create mode 100644 drivers/interconnect/qcom/Kconfig
>>    create mode 100644 drivers/interconnect/qcom/msm8916.c
>>    create mode 100644 include/linux/interconnect/qcom.h
> ...
>> diff --git a/drivers/interconnect/qcom/msm8916.c
> b/drivers/interconnect/qcom/msm8916.c
>> new file mode 100644
>> index 000000000000..d5b54f8261c8
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/msm8916.c
> ...
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
>> +       INIT_LIST_HEAD(&provider->nodes);
>> +       provider->data = qp;
>> +
>> +       ret = icc_add_provider(provider);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "error adding interconnect
> provider\n");
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
>> +               dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
>> +                       qnodes[i]->name, node->id);
>> +
>> +               /* populate links */
>> +               for (j = 0; j < qnodes[i]->num_links; j++)
>> +                       if (qnodes[i]->links[j])
>> +                               icc_link_create(node,
> qnodes[i]->links[j]);
>> +
>> +               ret = qcom_icc_init(node);
>> +               if (ret)
>> +                       dev_err(&pdev->dev, "%s init error (%d)\n",
> node->name,
>> +                               ret);
> 
> Don't you want to call qcom_icc_init before icc_link_create? As soon as
> icc_link_create is called, the node is connected to the graph, and
> qcom_icc_set can be called.
> 

I agree.

>> +       }
>> +
>> +       platform_set_drvdata(pdev, provider);
>> +
>> +       return ret;
>> +err:
>> +       icc_del_provider(provider);
>> +       return ret;
>> +}
>> +
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +       struct icc_provider *provider = platform_get_drvdata(pdev);
>> +
>> +       icc_del_provider(provider);
> 
> Presumably in the framework nodes and links ought to get cleaned up
> somewhere too, right? As it is now, the devm code frees provider when this
> device is removed, even though provider is still very connected in the
> graph via the nodes and links.

Sorry, this part is incomplete. Will implement the rest of the cleanup code.

>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id qnoc_of_match[] = {
>> +       { .compatible = "qcom,msm8916-pnoc", .data = &msm8916_pnoc },
>> +       { .compatible = "qcom,msm8916-snoc", .data = &msm8916_snoc },
>> +       { .compatible = "qcom,msm8916-bimc", .data = &msm8916_bimc },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>> +
>> +static struct platform_driver qnoc_driver = {
>> +       .probe = qnoc_probe,
>> +       .remove = qnoc_remove,
>> +       .driver = {
>> +               .name = "qnoc-msm8916",
>> +               .of_match_table = qnoc_of_match,
>> +       },
>> +};
>> +module_platform_driver(qnoc_driver);
>> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
>> +MODULE_DESCRIPTION("Qualcomm msm8916 NoC driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/interconnect/qcom.h
> b/include/linux/interconnect/qcom.h
>> new file mode 100644
>> index 000000000000..2cd378d2f575
>> --- /dev/null
>> +++ b/include/linux/interconnect/qcom.h
>> @@ -0,0 +1,350 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Qualcomm interconnect IDs
>> + *
>> + * Copyright (c) 2018, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef __QCOM_INTERCONNECT_IDS_H
>> +#define __QCOM_INTERCONNECT_IDS_H
>> +
>> +#define FAB_BIMC 0
>> +#define FAB_SYS_NOC 1024
>> +#define FAB_MMSS_NOC 2048
>> +#define FAB_OCMEM_NOC 3072
>> +#define FAB_PERIPH_NOC 4096
>> +#define FAB_CONFIG_NOC 5120
>> +#define FAB_OCMEM_VNOC 6144
> 
> Looks like you're still following that downstream convention of NoCs being
> divisible by 1024, masters in 1-512, and slaves in 512-1023, then I don't
> know about the 10000s. This was documented somewhere downstream, can you
> add that documentation somewhere in here?

Yes, i am currently following the existing IDs. The 10000s are the nodes
used for the interconnects between the NoCs. I don't think it's worth
documenting this, as the plan is to switch to arbitrary numbers.

Thanks,
Georgi
