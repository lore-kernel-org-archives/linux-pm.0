From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 3/3] interconnect: Add Qualcomm msm8916 interconnect
 provider driver
Date: Thu, 2 Nov 2017 18:00:57 +0200
Message-ID: <cc1c87cd-a42e-a37c-8962-721e6f04bbd1@linaro.org>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
 <20170908171830.13813-4-georgi.djakov@linaro.org>
 <CAHLCerNO=yznzCdyNt13EYeuSW_b-Rb1dRFnq=MZtXoMLWkkUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHLCerNO=yznzCdyNt13EYeuSW_b-Rb1dRFnq=MZtXoMLWkkUA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, robh+dt@kernel.org, khilman@baylibre.com, Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, seansw@qti.qualcomm.com, davidai@quicinc.com, LKML <linux-kernel@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Amit,

On 11/02/2017 09:28 AM, Amit Kucheria wrote:
> On Fri, Sep 8, 2017 at 10:48 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms. This patch contains only a partial topology to make reviewing
>> easier.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/Kconfig                     |   5 +
>>  drivers/interconnect/Makefile                    |   1 +
>>  drivers/interconnect/qcom/Kconfig                |  11 +
>>  drivers/interconnect/qcom/Makefile               |   1 +
>>  drivers/interconnect/qcom/interconnect_msm8916.c | 375 +++++++++++++++++++++++
>>  include/linux/interconnect/qcom-msm8916.h        |  92 ++++++
>>  6 files changed, 485 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/Kconfig
>>  create mode 100644 drivers/interconnect/qcom/Makefile
>>  create mode 100644 drivers/interconnect/qcom/interconnect_msm8916.c
>>  create mode 100644 include/linux/interconnect/qcom-msm8916.h
>>
>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
>> index 1e50e951cdc1..b123a76e2f9d 100644
>> --- a/drivers/interconnect/Kconfig
>> +++ b/drivers/interconnect/Kconfig
>> @@ -8,3 +8,8 @@ menuconfig INTERCONNECT
>>
>>           If unsure, say no.
>>
>> +if INTERCONNECT
>> +
>> +source "drivers/interconnect/qcom/Kconfig"
>> +
>> +endif
>> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
>> index d9da6a6c3560..62a01de24aeb 100644
>> --- a/drivers/interconnect/Makefile
>> +++ b/drivers/interconnect/Makefile
>> @@ -1 +1,2 @@
>>  obj-$(CONFIG_INTERCONNECT)  += interconnect.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> new file mode 100644
>> index 000000000000..86465dc37bd4
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -0,0 +1,11 @@
>> +config INTERCONNECT_QCOM
>> +       bool "Qualcomm Network-on-Chip interconnect drivers"
>> +       depends on INTERCONNECT
>> +       depends on ARCH_QCOM || COMPILE_TEST
>> +       default y
>> +
>> +config INTERCONNECT_QCOM_MSM8916
>> +       tristate "Qualcomm MSM8916 interconnect driver"
>> +       depends on INTERCONNECT_QCOM
>> +       help
>> +         This is a driver for the Qualcomm Network-on-Chip on msm8916-based platforms.
>> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
>> new file mode 100644
>> index 000000000000..0831080e1100
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += interconnect_msm8916.o
>> diff --git a/drivers/interconnect/qcom/interconnect_msm8916.c b/drivers/interconnect/qcom/interconnect_msm8916.c
>> new file mode 100644
>> index 000000000000..9b001e100974
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/interconnect_msm8916.c
>> @@ -0,0 +1,375 @@
>> +/*
>> + * Copyright (C) 2017 Linaro Ltd
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/interconnect/qcom-msm8916.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#define to_qcom_icp(_icp) \
>> +       container_of(_icp, struct qcom_interconnect_provider, icp)
>> +#define to_qcom_node(_node) \
>> +       container_of(_node, struct qcom_interconnect_node, node)
>> +
>> +enum qcom_bus_type {
>> +       QCOM_BUS_TYPE_NOC = 0,
>> +       QCOM_BUS_TYPE_MEM,
>> +};
>> +
>> +struct qcom_interconnect_provider {
>> +       struct icp              icp;
>> +       void __iomem            *base;
>> +       struct clk              *bus_clk;
>> +       struct clk              *bus_a_clk;
>> +       u32                     base_offset;
>> +       u32                     qos_offset;
>> +       enum qcom_bus_type      type;
>> +};
>> +
>> +struct qcom_interconnect_node {
>> +       struct interconnect_node node;
>> +       unsigned char *name;
>> +       struct interconnect_node *links[8];
> 
> Magic number 8. Replace with 8916_MAX_LINKS or something.
> 

Ok, sure!

>> +       u16 id;
>> +       u16 num_links;
>> +       u16 port;
>> +       u16 buswidth;
> 
> Comment on what a buswidth is just to be clear
> 

Ok!

>> +       u64 rate;
> 
> Comment on units

Ok!

> 
>> +};
>> +
>> +static struct qcom_interconnect_node snoc_int_0;
>> +static struct qcom_interconnect_node snoc_int_1;
>> +static struct qcom_interconnect_node snoc_int_bimc;
>> +static struct qcom_interconnect_node snoc_bimc_0_mas;
>> +static struct qcom_interconnect_node pnoc_snoc_slv;
>> +
>> +static struct qcom_interconnect_node snoc_bimc_0_slv;
> 
> IMO, saving an 'a' and 'e' is not worth it for the sake of
> readability. Just use 'slave' and 'master' in the names.
> 

Currently i prefer to keep it this way. Maybe i can put a comment
somewhere.

>> +static struct qcom_interconnect_node slv_ebi_ch0;
>> +
>> +static struct qcom_interconnect_node pnoc_int_1;
>> +static struct qcom_interconnect_node mas_pnoc_sdcc_1;
>> +static struct qcom_interconnect_node mas_pnoc_sdcc_2;
>> +static struct qcom_interconnect_node pnoc_snoc_mas;
>> +
>> +struct qcom_interconnect_desc {
>> +       struct qcom_interconnect_node **nodes;
>> +       size_t num_nodes;
>> +};
>> +
>> +static struct qcom_interconnect_node snoc_int_0 = {
>> +       .id = 10004,
>> +       .name = "snoc-int-0",
>> +#if 0
> 
> Please get rid if these.
> 

I have included only a small part of the topology for this SoC for
simplicity. Will remove them.

>> +       .links = { &snoc_pnoc_mas.node },
>> +       .num_links = 1,
>> +#endif
>> +       .buswidth = 8,
>> +};
>> +
>> +static struct qcom_interconnect_node snoc_int_1 = {
>> +       .id = 10005,
>> +       .name = "snoc-int-1",
>> +#if 0
>> +       .links = { &slv_apss.node, &slv_cats_0.node, &slv_cats_1.node },
>> +       .num_links = 3,
>> +#endif
>> +       .buswidth = 8,
>> +};
>> +
>> +static struct qcom_interconnect_node snoc_int_bimc = {
>> +       .id = 10006,
>> +       .name = "snoc-bimc",
>> +       .links = { &snoc_bimc_0_mas.node },
>> +       .num_links = 1,
>> +       .buswidth = 8,
>> +};
>> +
>> +static struct qcom_interconnect_node snoc_bimc_0_mas = {
>> +       .id = 10007,
>> +       .name = "snoc-bimc-0-mas",
>> +       .links = { &snoc_bimc_0_slv.node },
>> +       .num_links = 1,
>> +       .buswidth = 8,
>> +};
>> +
>> +static struct qcom_interconnect_node pnoc_snoc_slv = {
>> +       .id = 10011,
>> +       .name = "snoc-pnoc",
>> +       .links = { &snoc_int_0.node, &snoc_int_bimc.node, &snoc_int_1.node },
>> +       .num_links = 3,
>> +       .buswidth = 8,
>> +};
> 
> 
> Suggest replacing this list of definitions with a macro such as:
> 
> #define DEFINE_XCON_NODE(_name, _id, numlinks, buswidth, ...) \
>              static struct qcom_interconnect_node _name;                       \
>              static struct qcom_interconnect_node _name = {                  \
>                    .id = _id,
>                                  \
>                    .name = _name,
>                         \
>                    .buswidth = buswidth,
>                       \
>                    .num_links = numlinks,
>                     \
>                    .links = { __VA_ARGS__ },
>                 \
>             };
> 
> 
> This will reduce these definitions to a series of definitions as
> follows that improves readability.
> 
> DEFINE_XCON_NODE(snoc_int_0, 10004, 1, 8, &snoc_pnoc_mas.node)
> DEFINE_XCON_NODE(snoc_int_1, 10005, 3, 8, &snoc_apss.node,
> &slv_cats_0.node, &slv_cats_1.node)
> DEFINE_XCON_NODE(snoc_int_bimc, 10006, 1, 8, &snoc_bimc_0_mas.node)
> 
> If fact you could take it one step further and move the definitions
> under the provider definition below directly.
> 

Will do it. Thanks!

[..]

>> +static struct qcom_interconnect_node *msm8916_pnoc_nodes[] = {
>> +       [PNOC_INT_1] = &pnoc_int_1,
>> +       [MAS_PNOC_SDCC_1] = &mas_pnoc_sdcc_1,
>> +       [MAS_PNOC_SDCC_2] = &mas_pnoc_sdcc_2,
>> +       [PNOC_SNOC_MAS] = &pnoc_snoc_mas,
>> +};
> 
> There are big holes in this node array definition because the index
> values are not contiguous. Are you planning fill these in later for
> each of the providers?
> 

Yes, exactly. I trying to keep this patch as small as possible to be
more review friendly. At some time will add the full topology.

Thanks for the comments!

BR,
Georgi
