From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v3 3/3] interconnect: Add Qualcomm msm8916 interconnect
 provider driver
Date: Thu, 2 Nov 2017 12:58:50 +0530
Message-ID: <CAHLCerNO=yznzCdyNt13EYeuSW_b-Rb1dRFnq=MZtXoMLWkkUA@mail.gmail.com>
References: <20170908171830.13813-1-georgi.djakov@linaro.org> <20170908171830.13813-4-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908171830.13813-4-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, robh+dt@kernel.org, khilman@baylibre.com, Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, seansw@qti.qualcomm.com, davidai@quicinc.com, LKML <linux-kernel@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 8, 2017 at 10:48 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> Add driver for the Qualcomm interconnect buses found in msm8916 based
> platforms. This patch contains only a partial topology to make reviewing
> easier.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/Kconfig                     |   5 +
>  drivers/interconnect/Makefile                    |   1 +
>  drivers/interconnect/qcom/Kconfig                |  11 +
>  drivers/interconnect/qcom/Makefile               |   1 +
>  drivers/interconnect/qcom/interconnect_msm8916.c | 375 +++++++++++++++++++++++
>  include/linux/interconnect/qcom-msm8916.h        |  92 ++++++
>  6 files changed, 485 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/interconnect_msm8916.c
>  create mode 100644 include/linux/interconnect/qcom-msm8916.h
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 1e50e951cdc1..b123a76e2f9d 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -8,3 +8,8 @@ menuconfig INTERCONNECT
>
>           If unsure, say no.
>
> +if INTERCONNECT
> +
> +source "drivers/interconnect/qcom/Kconfig"
> +
> +endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index d9da6a6c3560..62a01de24aeb 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_INTERCONNECT)  += interconnect.o
> +obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> new file mode 100644
> index 000000000000..86465dc37bd4
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -0,0 +1,11 @@
> +config INTERCONNECT_QCOM
> +       bool "Qualcomm Network-on-Chip interconnect drivers"
> +       depends on INTERCONNECT
> +       depends on ARCH_QCOM || COMPILE_TEST
> +       default y
> +
> +config INTERCONNECT_QCOM_MSM8916
> +       tristate "Qualcomm MSM8916 interconnect driver"
> +       depends on INTERCONNECT_QCOM
> +       help
> +         This is a driver for the Qualcomm Network-on-Chip on msm8916-based platforms.
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> new file mode 100644
> index 000000000000..0831080e1100
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += interconnect_msm8916.o
> diff --git a/drivers/interconnect/qcom/interconnect_msm8916.c b/drivers/interconnect/qcom/interconnect_msm8916.c
> new file mode 100644
> index 000000000000..9b001e100974
> --- /dev/null
> +++ b/drivers/interconnect/qcom/interconnect_msm8916.c
> @@ -0,0 +1,375 @@
> +/*
> + * Copyright (C) 2017 Linaro Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/interconnect/qcom-msm8916.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define to_qcom_icp(_icp) \
> +       container_of(_icp, struct qcom_interconnect_provider, icp)
> +#define to_qcom_node(_node) \
> +       container_of(_node, struct qcom_interconnect_node, node)
> +
> +enum qcom_bus_type {
> +       QCOM_BUS_TYPE_NOC = 0,
> +       QCOM_BUS_TYPE_MEM,
> +};
> +
> +struct qcom_interconnect_provider {
> +       struct icp              icp;
> +       void __iomem            *base;
> +       struct clk              *bus_clk;
> +       struct clk              *bus_a_clk;
> +       u32                     base_offset;
> +       u32                     qos_offset;
> +       enum qcom_bus_type      type;
> +};
> +
> +struct qcom_interconnect_node {
> +       struct interconnect_node node;
> +       unsigned char *name;
> +       struct interconnect_node *links[8];

Magic number 8. Replace with 8916_MAX_LINKS or something.

> +       u16 id;
> +       u16 num_links;
> +       u16 port;
> +       u16 buswidth;

Comment on what a buswidth is just to be clear

> +       u64 rate;

Comment on units

> +};
> +
> +static struct qcom_interconnect_node snoc_int_0;
> +static struct qcom_interconnect_node snoc_int_1;
> +static struct qcom_interconnect_node snoc_int_bimc;
> +static struct qcom_interconnect_node snoc_bimc_0_mas;
> +static struct qcom_interconnect_node pnoc_snoc_slv;
> +
> +static struct qcom_interconnect_node snoc_bimc_0_slv;

IMO, saving an 'a' and 'e' is not worth it for the sake of
readability. Just use 'slave' and 'master' in the names.

> +static struct qcom_interconnect_node slv_ebi_ch0;
> +
> +static struct qcom_interconnect_node pnoc_int_1;
> +static struct qcom_interconnect_node mas_pnoc_sdcc_1;
> +static struct qcom_interconnect_node mas_pnoc_sdcc_2;
> +static struct qcom_interconnect_node pnoc_snoc_mas;
> +
> +struct qcom_interconnect_desc {
> +       struct qcom_interconnect_node **nodes;
> +       size_t num_nodes;
> +};
> +
> +static struct qcom_interconnect_node snoc_int_0 = {
> +       .id = 10004,
> +       .name = "snoc-int-0",
> +#if 0

Please get rid if these.

> +       .links = { &snoc_pnoc_mas.node },
> +       .num_links = 1,
> +#endif
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node snoc_int_1 = {
> +       .id = 10005,
> +       .name = "snoc-int-1",
> +#if 0
> +       .links = { &slv_apss.node, &slv_cats_0.node, &slv_cats_1.node },
> +       .num_links = 3,
> +#endif
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node snoc_int_bimc = {
> +       .id = 10006,
> +       .name = "snoc-bimc",
> +       .links = { &snoc_bimc_0_mas.node },
> +       .num_links = 1,
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node snoc_bimc_0_mas = {
> +       .id = 10007,
> +       .name = "snoc-bimc-0-mas",
> +       .links = { &snoc_bimc_0_slv.node },
> +       .num_links = 1,
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node pnoc_snoc_slv = {
> +       .id = 10011,
> +       .name = "snoc-pnoc",
> +       .links = { &snoc_int_0.node, &snoc_int_bimc.node, &snoc_int_1.node },
> +       .num_links = 3,
> +       .buswidth = 8,
> +};


Suggest replacing this list of definitions with a macro such as:

#define DEFINE_XCON_NODE(_name, _id, numlinks, buswidth, ...) \
             static struct qcom_interconnect_node _name;                       \
             static struct qcom_interconnect_node _name = {                  \
                   .id = _id,
                                 \
                   .name = _name,
                        \
                   .buswidth = buswidth,
                      \
                   .num_links = numlinks,
                    \
                   .links = { __VA_ARGS__ },
                \
            };


This will reduce these definitions to a series of definitions as
follows that improves readability.

DEFINE_XCON_NODE(snoc_int_0, 10004, 1, 8, &snoc_pnoc_mas.node)
DEFINE_XCON_NODE(snoc_int_1, 10005, 3, 8, &snoc_apss.node,
&slv_cats_0.node, &slv_cats_1.node)
DEFINE_XCON_NODE(snoc_int_bimc, 10006, 1, 8, &snoc_bimc_0_mas.node)

If fact you could take it one step further and move the definitions
under the provider definition below directly.

> +static struct qcom_interconnect_node *msm8916_snoc_nodes[] = {
> +       [SNOC_INT_0] = &snoc_int_0,
> +       [SNOC_INT_1] = &snoc_int_1,
> +       [SNOC_INT_BIMC] = &snoc_int_bimc,
> +       [SNOC_BIMC_0_MAS] = &snoc_bimc_0_mas,
> +       [PNOC_SNOC_SLV] = &pnoc_snoc_slv,
> +};
> +
> +static struct qcom_interconnect_desc msm8916_snoc = {
> +       .nodes = msm8916_snoc_nodes,
> +       .num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
> +};
> +
> +static struct qcom_interconnect_node snoc_bimc_0_slv = {
> +       .id = 10025,
> +       .name = "snoc_bimc_0_slv",
> +       .links = { &slv_ebi_ch0.node },
> +       .num_links = 1,
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node slv_ebi_ch0 = {
> +       .id = 512,
> +       .name = "slv-ebi-ch0",
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node *msm8916_bimc_nodes[] = {
> +       [SNOC_BIMC_0_SLV] = &snoc_bimc_0_slv,
> +       [SLV_EBI_CH0] = &slv_ebi_ch0,
> +};
> +
> +static struct qcom_interconnect_desc msm8916_bimc = {
> +       .nodes = msm8916_bimc_nodes,
> +       .num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
> +};
> +
> +static struct qcom_interconnect_node pnoc_int_1 = {
> +       .id = 10013,
> +       .name = "pnoc-int-1",
> +       .links = { &pnoc_snoc_mas.node },
> +       .num_links = 1,
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node mas_pnoc_sdcc_1 = {
> +       .id = 78,
> +       .name = "mas-pnoc-sdcc-1",
> +       .links = { &pnoc_int_1.node },
> +       .num_links = 1,
> +       .port = 7,
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node mas_pnoc_sdcc_2 = {
> +       .id = 81,
> +       .name = "mas-pnoc-sdcc-2",
> +       .links = { &pnoc_int_1.node },
> +       .num_links = 1,
> +       .port = 8,
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node pnoc_snoc_mas = {
> +       .id = 10010,
> +       .name = "pnoc-snoc-mas",
> +       .links = { &pnoc_snoc_slv.node },
> +       .num_links = 1,
> +       .buswidth = 8,
> +};
> +
> +static struct qcom_interconnect_node *msm8916_pnoc_nodes[] = {
> +       [PNOC_INT_1] = &pnoc_int_1,
> +       [MAS_PNOC_SDCC_1] = &mas_pnoc_sdcc_1,
> +       [MAS_PNOC_SDCC_2] = &mas_pnoc_sdcc_2,
> +       [PNOC_SNOC_MAS] = &pnoc_snoc_mas,
> +};

There are big holes in this node array definition because the index
values are not contiguous. Are you planning fill these in later for
each of the providers?

> +static struct qcom_interconnect_desc msm8916_pnoc = {
> +       .nodes = msm8916_pnoc_nodes,
> +       .num_nodes = ARRAY_SIZE(msm8916_pnoc_nodes),
> +};
> +
> +static int qcom_interconnect_init(struct interconnect_node *node)
> +{
> +       struct qcom_interconnect_node *qn = to_qcom_node(node);
> +
> +       /* populate default values */
> +       if (!qn->buswidth)
> +               qn->buswidth = 8;
> +
> +       /* TODO: init qos and priority */
> +
> +       return 0;
