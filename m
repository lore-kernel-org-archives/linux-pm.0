From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [RFC v0 1/2] interconnect: Add generic interconnect controller
 API
Date: Thu, 02 Mar 2017 18:07:22 -0800
Message-ID: <58B8CFDA.3080303@codeaurora.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org> <20170301182235.19154-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdCCCIP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2017 21:08:15 -0500
In-Reply-To: <20170301182235.19154-2-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, gregkh@linuxfoundation.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org

On 03/01/2017 10:22 AM, Georgi Djakov wrote:
> This patch introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect controllers and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   .../bindings/interconnect/interconnect.txt         |  91 +++++++
>   Documentation/interconnect/interconnect.txt        |  68 +++++
>   drivers/Kconfig                                    |   2 +
>   drivers/Makefile                                   |   1 +
>   drivers/interconnect/Kconfig                       |  10 +
>   drivers/interconnect/Makefile                      |   1 +
>   drivers/interconnect/interconnect.c                | 285 +++++++++++++++++++++
>   include/linux/interconnect-consumer.h              |  70 +++++
>   include/linux/interconnect-provider.h              |  92 +++++++
>   9 files changed, 620 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>   create mode 100644 Documentation/interconnect/interconnect.txt
>   create mode 100644 drivers/interconnect/Kconfig
>   create mode 100644 drivers/interconnect/Makefile
>   create mode 100644 drivers/interconnect/interconnect.c
>   create mode 100644 include/linux/interconnect-consumer.h
>   create mode 100644 include/linux/interconnect-provider.h
>
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..c62d86e4c52d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,91 @@
> +Interconnect Provider Device Tree Bindings
> +=========================================
> +
> +The purpose of this document is to define a common set of generic interconnect
> +providers/consumers properties.
> +
> +
> += interconnect providers =
> +
> +The interconnect provider binding is intended to represent the interconnect
> +controllers in the system. Each provider registers a set of interconnect
> +nodes, which expose the interconnect related capabilities of the interconnect
> +to consumer drivers. These capabilities can be throughput, latency, priority
> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> +depending on the usecase.
> +
> +Required properties:
> +- compatible : contains the interconnect provider vendor specific compatible
> +	       string
> +- reg : register space of the interconnect controller hardware
> +- #interconnect-cells : number of cells in a interconnect specifier needed to
> +		       encode the interconnect node id.
> +
> +
> +Optional properties:
> +interconnect-port : A phandle and interconnect provider specifier as defined by
> +		bindings of the interconnect provider specified by phandle.
> +		This denotes the port to which the interconnect consumer is
> +		wired. It is used when there are multiple interconnect providers
> +		that have one or multiple links between them.
> +
> +Example:
> +
> +		snoc: snoc@0580000 {
> +			compatible = "qcom,msm-bus-snoc";
> +			reg = <0x580000 0x14000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			status = "okay";
> +			interconnect-port = <&bimc MAS_SNOC_CFG>,
> +					<&bimc SNOC_BIMC_0_MAS>,
> +					<&bimc SNOC_BIMC_1_MAS>,
> +					<&pnoc SNOC_PNOC_SLV>;
> +		};
> +		bimc: bimc@0400000 {
> +			compatible = "qcom,msm-bus-bimc";
> +			reg = <0x400000 0x62000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +			status = "okay";
> +			interconnect-port = <&snoc BIMC_SNOC_MAS>;
> +		};
> +		pnoc: pnoc@500000 {
> +			compatible = "qcom,msm-bus-pnoc";
> +			reg = <0x500000 0x11000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
> +			status = "okay";
> +			interconnect-port = <&snoc PNOC_SNOC_SLV>;
> +		};
> +
> += interconnect consumers =
> +
> +The interconnect consumers are device nodes which consume the interconnect
> +path(s) provided by the interconnect provider. There can be multiple
> +interconnect providers on a SoC and the consumer may consume multiple paths
> +from different providers depending on usecase and the components it has to
> +interact with.
> +
> +Required-properties:
> +interconnect-port : A phandle and interconnect provider specifier as defined by
> +		bindings of the interconnect provider specified by phandle.
> +		This denotes the port to which the interconnect consumer is
> +		wired.
> +interconnect-path : List of phandles to the data path endpoints.
> +interconnect-path-names : List of interconnect path name strings sorted in the
> +		same order as the interconnect-path property.  Consumers drivers
> +		will use interconnect-path-names to match the link names with
> +		interconnect specifiers.
> +
> +Example:
> +
> +	sdhci@07864000 {
> +		...
> +		interconnect-port = <&pnoc MAS_PNOC_SDCC_2>;
> +		interconnect-path = <&blsp1_uart2>;
> +		interconnect-path-names = "spi";
> +	};
> diff --git a/Documentation/interconnect/interconnect.txt b/Documentation/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..051d3955f28b
> --- /dev/null
> +++ b/Documentation/interconnect/interconnect.txt
> @@ -0,0 +1,68 @@
> +GENERIC SYSTEM INTERCONNECT CONTROLLER SUBSYSTEM
> +===============================================
> +
> +1. Introduction
> +---------------
> +This framework is designed to provide a standard kernel interface to control
> +the settings of the interconnects on a SoC. These settings can be throughput,
> +latency and priority between multiple interconnected devices. This can be
> +controlled dynamically in order to save power or provide maximum performance.
> +
> +The interconnect controller is a hardware with configurable parameters, which
> +can be set on a data path according to the requests received from various
> +drivers. An example of interconnect controllers are the interconnects between
> +various components on chipsets. There can be multiple interconnects on a SoC
> +that can be multi-tiered.
> +
> +Below is a simplified diagram of a real-world SoC topology. The interconnect
> +providers are the memory front end and the NoCs.
> +
> ++----------------+    +----------------+
> +| HW Accelerator |--->|      M NoC     |<---------------+
> ++----------------+    +----------------+                |
> +                        |      |                    +------------+
> +          +-------------+      V       +------+     |            |
> +          |                +--------+  | PCIe |     |            |
> +          |                | Slaves |  +------+     |            |
> +          |                +--------+     |         |   C NoC    |
> +          V                               V         |            |
> ++------------------+   +------------------------+   |            |   +-----+
> +|                  |-->|                        |-->|            |-->| CPU |
> +|                  |-->|                        |<--|            |   +-----+
> +|      Memory      |   |         S NoC          |   +------------+
> +|                  |<--|                        |---------+    |
> +|                  |<--|                        |<------+ |    |   +--------+
> ++------------------+   +------------------------+       | |    +-->| Slaves |
> +   ^     ^    ^           ^                             | |        +--------+
> +   |     |    |           |                             | V
> ++-----+  |  +-----+    +-----+  +---------+   +----------------+   +--------+
> +| CPU |  |  | GPU |    | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> ++-----+  |  +-----+    +-----+  +---------+   +----------------+   +--------+
> +         |
> +     +-------+
> +     | Modem |
> +     +-------+
> +
> +2. Interconnect providers
> +------------------------
> +Interconnect provider is an entity that implements methods to initialize and
> +configure a interconnect controller hardware.
> +
> +An interconnect controller should register with the interconnect provider core
> +with interconnect_add_provider().
> +
> +A previously registered interconnect provider is unregistered with
> +interconnect_del_provider().
> +
> +3. Interconnect consumers
> +------------------------
> +Interconnect consumers are the entities which make use of the data paths exposed
> +by the providers. The consumers send requests to providers requesting various
> +throughput, latency and priority. Usually the consumers are device drivers, that
> +send request based on their needs.
> +
> +The interconnect framework provide the following APIs to consumers:
> +
> +struct interconnect_path *interconnect_get(struct device *dev, const char *id);
> +void interconnect_put(struct interconnect_path *path);
> +int interconnect_set(interconnect_path *path, u32 bandwidth);
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index d2ac339de85f..6e4d80e98f5c 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -198,4 +198,6 @@ source "drivers/hwtracing/intel_th/Kconfig"
>
>   source "drivers/fpga/Kconfig"
>
> +source "drivers/interconnect/Kconfig"
> +
>   endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 795d0ca714bf..d5b4733f3875 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -172,3 +172,4 @@ obj-$(CONFIG_STM)		+= hwtracing/stm/
>   obj-$(CONFIG_ANDROID)		+= android/
>   obj-$(CONFIG_NVMEM)		+= nvmem/
>   obj-$(CONFIG_FPGA)		+= fpga/
> +obj-$(CONFIG_INTERCONNECT)	+= interconnect/
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> new file mode 100644
> index 000000000000..103524b59905
> --- /dev/null
> +++ b/drivers/interconnect/Kconfig
> @@ -0,0 +1,10 @@
> +menuconfig INTERCONNECT
> +	bool "On-Chip Interconnect management support"
> +	help
> +	  Support for management of the on-chip interconnects.
> +
> +	  This framework is designed to provide a generic interface for
> +          managing the interconnects in a SoC.
> +
> +	  If unsure, say no.
> +
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> new file mode 100644
> index 000000000000..184da73ce0d2
> --- /dev/null
> +++ b/drivers/interconnect/Makefile
> @@ -0,0 +1 @@
> +obj-y  += interconnect.o
> diff --git a/drivers/interconnect/interconnect.c b/drivers/interconnect/interconnect.c
> new file mode 100644
> index 000000000000..dadd1ffdbc50
> --- /dev/null
> +++ b/drivers/interconnect/interconnect.c
> @@ -0,0 +1,285 @@
> +/*
> + * Copyright (c) 2017, Linaro Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/interconnect-consumer.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +static DEFINE_MUTEX(interconnect_provider_list_mutex);
> +static LIST_HEAD(interconnect_provider_list);
> +
> +static struct interconnect_node *find_node(struct device_node *np)
> +{
> +	struct interconnect_node *node = ERR_PTR(-EPROBE_DEFER);
> +	int ret;
> +	struct of_phandle_args args;
> +	struct icp *i, *icp = NULL;
> +
> +	/* find the target interconnect provider device_node */
> +	ret = of_parse_phandle_with_args(np, "interconnect-port",
> +					 "#interconnect-cells", 0, &args);
> +	if (ret) {
> +		pr_err("%s interconnect provider not found (%d)\n", __func__,
> +		       ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	mutex_lock(&interconnect_provider_list_mutex);
> +
> +	/* find the interconnect provider of the target node */
> +	list_for_each_entry(i, &interconnect_provider_list, icp_list) {
> +		if (args.np == i->of_node) {
> +			icp = i;
> +			node = icp->ops->xlate(&args, icp->data);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&interconnect_provider_list_mutex);
> +
> +	of_node_put(args.np);
> +
> +	if (!icp) {
> +		pr_err("%s interconnect provider %s not found\n", __func__,
> +		       args.np->name);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	if (IS_ERR(node)) {
> +		pr_err("%s interconnect node %s not found (%ld)\n", __func__,
> +		       args.np->name, PTR_ERR(node));
> +		return node;
> +	}
> +
> +	return node;
> +}
> +
> +static int find_path(struct interconnect_node *src,
> +		     struct interconnect_node *dst,
> +		     struct interconnect_path *path)
> +{
> +	struct list_head edge_list;
> +	struct list_head traverse_list;
> +	struct interconnect_path *tmp_path;
> +	struct interconnect_node *node = NULL;
> +	size_t i;
> +	bool found = false;
> +
> +	INIT_LIST_HEAD(&traverse_list);
> +	INIT_LIST_HEAD(&edge_list);
> +
> +	tmp_path = kzalloc(sizeof(*tmp_path), GFP_KERNEL);
> +	if (!tmp_path)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&tmp_path->node_list);
> +
> +	list_add_tail(&src->search_list, &traverse_list);
> +
> +	do {
> +		list_for_each_entry(node, &traverse_list, search_list) {
> +			if (node == dst) {
> +				found = true;
> +				list_add(&node->search_list,
> +					 &tmp_path->node_list);
> +				break;
> +			}
> +			for (i = 0; i < node->num_links; i++) {
> +				struct interconnect_node *tmp = node->links[i];
> +
> +				/* try DT lookup */
> +				if (!tmp) {
> +					tmp = find_node(node->icp->of_node);
> +					if (IS_ERR(tmp))
> +						return PTR_ERR(tmp);
> +				}
> +
> +				if (tmp->is_traversed)
> +					continue;
> +
> +				tmp->is_traversed = true;
> +				tmp->reverse = node;
> +				list_add_tail(&tmp->search_list, &edge_list);
> +			}
> +		}
> +		if (found)
> +			break;
> +
> +		list_splice_init(&traverse_list, &tmp_path->node_list);
> +		list_splice_init(&edge_list, &traverse_list);
> +
> +	} while (!list_empty(&traverse_list));
> +
> +	/* reset the is_traversed state */
> +	list_for_each_entry(node, &path->node_list, search_list) {
> +		node->is_traversed = false;
> +	}
> +
> +	/* add the path */
> +	node = list_first_entry(&tmp_path->node_list, struct interconnect_node,
> +				search_list);
> +	while (node) {
> +		list_add_tail(&node->search_list, &path->node_list);
> +		node = node->reverse;
> +	}
> +
> +	kfree(tmp_path);
> +
> +	return 0;
> +}
> +
> +int interconnect_set(struct interconnect_path *path, u32 bandwidth)
> +{
> +	struct interconnect_node *node;
> +
> +	list_for_each_entry(node, &path->node_list, search_list) {
> +		if (node->icp->ops->set)
> +			node->icp->ops->set(node, bandwidth);

This ops needs to take a "source" and "dest" input and you'll need to 
pass in the prev/next nodes of each "node" in this list. This is needed 
so that each interconnect know the local source/destination and can make 
the aggregation decisions correctly based on the internal implementation 
of the interconnect. For the first and last nodes in the list, the 
source and destination nodes can be NULL, respectively.

> +	}
> +
> +	return 0;
> +}
> +
> +struct interconnect_path *interconnect_get(struct device *dev, const char *id)
> +{
> +	struct device_node *np;
> +	struct platform_device *dst_pdev;
> +	struct interconnect_node *src, *dst, *node;
> +	struct interconnect_path *path;
> +	int ret, index;
> +
> +	if (WARN_ON(!dev || !id))
> +		return ERR_PTR(-EINVAL);
> +
> +	src = find_node(dev->of_node);
> +	if (IS_ERR(src))
> +		return ERR_CAST(src);
> +
> +	index = of_property_match_string(dev->of_node,
> +					 "interconnect-path-names", id);
> +	if (index < 0) {
> +		dev_err(dev, "missing interconnect-path-names DT property on %s\n",
> +			dev->of_node->full_name);
> +		return ERR_PTR(index);
> +	}
> +
> +	/* get the destination endpoint device_node */
> +	np = of_parse_phandle(dev->of_node, "interconnect-path", index);
> +
> +	dst_pdev = of_find_device_by_node(np);
> +	if (!dst_pdev) {
> +		dev_err(dev, "error finding device by node %s\n", np->name);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	dst = find_node(np);
> +	if (IS_ERR(dst))
> +		return ERR_CAST(dst);
> +
> +	/* find a path between the source and destination */
> +	path = kzalloc(sizeof(*path), GFP_KERNEL);
> +	if (!path)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&path->node_list);
> +	path->src_dev = dev;
> +	path->dst_dev = &dst_pdev->dev;
> +
> +	/* TODO: cache the path */
> +	ret = find_path(src, dst, path);
> +	if (ret) {
> +		dev_err(dev, "error finding path between %p and %p (%d)\n",
> +			src, dst, ret);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	list_for_each_entry(node, &path->node_list, search_list) {
> +		struct icn_qos *req;
> +
> +		/*
> +		 * Create icn_qos for each separate link between the nodes.
> +		 * They may have different constraints and may belong to
> +		 * different interconnect providers.
> +		 */
> +		req = kzalloc(sizeof(*req), GFP_KERNEL);
> +		if (!req)
> +			return ERR_PTR(-ENOMEM);
> +
> +		req->path = path;
> +		req->bandwidth = 0;
> +		hlist_add_head(&req->node, &node->qos_list);
> +	}
> +
> +	return path;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_get);
> +
> +void interconnect_put(struct interconnect_path *path)
> +{
> +	struct interconnect_node *node;
> +	struct icn_qos *req;
> +	struct hlist_node *tmp;
> +
> +	if (IS_ERR(path))
> +		return;
> +
> +	list_for_each_entry(node, &path->node_list, search_list) {
> +		hlist_for_each_entry_safe(req, tmp, &node->qos_list, node) {
> +			if (req->path == path) {
> +				hlist_del(&req->node);
> +				kfree(req);
> +			}

Should we go through and remove any bandwidth votes that were made on 
this path before we free it?

> +		}
> +	}
> +
> +	kfree(path);
> +}
> +EXPORT_SYMBOL_GPL(interconnect_put);
> +
> +int interconnect_add_provider(struct icp *icp)
> +{
> +	struct interconnect_node *node;
> +
> +	WARN(!icp->ops->xlate, "%s: .xlate is not implemented\n", __func__);
> +	WARN(!icp->ops->set, "%s: .set is not implemented\n", __func__);
> +
> +	mutex_lock(&interconnect_provider_list_mutex);
> +	list_add(&icp->icp_list, &interconnect_provider_list);
> +	mutex_unlock(&interconnect_provider_list_mutex);
> +
> +	list_for_each_entry(node, &icp->nodes, icn_list) {
> +		INIT_HLIST_HEAD(&node->qos_list);
> +	}
> +
> +	dev_info(icp->dev, "added interconnect provider %s\n", icp->name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_add_provider);
> +
> +int interconnect_del_provider(struct icp *icp)
> +{
> +	mutex_lock(&interconnect_provider_list_mutex);
> +	of_node_put(icp->of_node);
> +	list_del(&icp->icp_list);

If there's a path with an active vote, we should probably return a 
-EBUSY to prevent deleting a provider that's actively used?

> +	mutex_unlock(&interconnect_provider_list_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_del_provider);
> diff --git a/include/linux/interconnect-consumer.h b/include/linux/interconnect-consumer.h
> new file mode 100644
> index 000000000000..8bd5bb3e4196
> --- /dev/null
> +++ b/include/linux/interconnect-consumer.h
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright (c) 2017, Linaro Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _LINUX_INTERCONNECT_CONSUMER_H
> +#define _LINUX_INTERCONNECT_CONSUMER_H
> +
> +struct interconnect_node;
> +
> +/**
> + * struct interconnect_path - interconnect path structure
> + *
> + * @node_list: list of the interconnect nodes
> + * @src_dev: source endpoint
> + * @dst_dev: destination endpoint
> + */
> +struct interconnect_path {
> +	struct list_head node_list;
> +	struct device *src_dev;
> +	struct device *dst_dev;
> +};
> +
> +/**
> + * interconnect_get() - get an interconnect path from a given id
> + *
> + * @dev: the source device which will set constraints on the path
> + * @id: endpoint node string identifier
> + *
> + * This function will search for a path between the source device (caller)
> + * and a destination endpoint. It returns an interconnect_path handle on
> + * success. Use interconnect_put() to release constraints when the they
> + * are not needed anymore.
> + *
> + * This function returns a handle on success, or ERR_PTR() otherwise.
> + */
> +struct interconnect_path *interconnect_get(struct device *dev, const char *id);
> +
> +/**
> + * interconnect_put() - release the reference to the interconnect path
> + *
> + * @path: interconnect path
> + *
> + * Use this function to release the path and free the memory when setting
> + * constraints on the path is no longer needed.
> + */
> +void interconnect_put(struct interconnect_path *path);
> +
> +/**
> + * interconnect_set() - set constraints on a path between two endpoints
> + * @path: reference to the path returned by interconnect_get()
> + * @bandwidth: the requested bandwidth in kpbs between the path endpoints
> + *
> + * This function sends a request for bandwidth between the two endpoints,
> + * (path). It aggragates the requests for constraints and updates each node
> + * accordingly.
> + *
> + * Returns 0 on success, or an approproate error code otherwise.
> + */
> +int interconnect_set(struct interconnect_path *path, u32 bandwidth);
> +
> +#endif /* _LINUX_INTERCONNECT_CONSUMER_H */
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> new file mode 100644
> index 000000000000..af1ca739ce52
> --- /dev/null
> +++ b/include/linux/interconnect-provider.h
> @@ -0,0 +1,92 @@
> +/*
> + * Copyright (c) 2017, Linaro Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _LINUX_INTERCONNECT_PROVIDER_H
> +#define _LINUX_INTERCONNECT_PROVIDER_H
> +
> +#include <linux/interconnect-consumer.h>
> +
> +/**
> + * struct icp_ops - platform specific callback operations for interconnect
> + * providers that will be called from drivers
> + *
> + * @set: set constraints on interconnect
> + * @xlate: provider-specific callback for mapping nodes from phandle arguments
> + */
> +struct icp_ops {
> +	int (*set)(struct interconnect_node *node, u32 bandwidth);
> +	struct interconnect_node *(*xlate)(struct of_phandle_args *spec, void *data);
> +};
> +
> +/**
> + * struct icp - interconnect provider (controller) entity that might
> + * provide multiple interconnect controls
> + *
> + * @icp_list: list of the registered interconnect providers
> + * @nodes: internal list of the interconnect provider nodes
> + * @ops: pointer to device specific struct icp_ops
> + * @dev: the device this interconnect provider belongs to
> + * @of_node: the corresponding device tree node as phandle target
> + * @data: pointer to private data
> + */
> +struct icp {
> +	struct list_head	icp_list;
> +	struct list_head	nodes;
> +	const struct icp_ops	*ops;
> +	struct device		*dev;
> +	const char		*name;
> +	struct device_node	*of_node;
> +	void			*data;
> +};
> +
> +/**
> + * struct interconnect_node - entity that is part of the interconnect topology
> + *
> + * @links: links to other interconnect nodes
> + * @num_links: number of interconnect nodes
> + * @icp: points to the interconnect provider struct this node belongs to
> + * @icn_list: list of interconnect nodes
> + * @search_list: list used when walking the nodes graph
> + * @reverse: pointer to previous node when walking the nodes graph
> + * @is_traversed: flag that is used when walking the nodes graph
> + * @qos_list: a list of QoS constraints
> + */
> +struct interconnect_node {
> +	struct interconnect_node **links;
> +	size_t			num_links;
> +
> +	struct icp		*icp;
> +	struct list_head	icn_list;
> +	struct list_head	search_list;
> +	struct interconnect_node *reverse;
> +	bool			is_traversed;
> +	struct hlist_head	qos_list;
> +};
> +
> +/**
> + * struct icn_qos - constraints that are attached to each node
> + *
> + * @node: linked list node
> + * @path: the interconnect path which is using this constraint
> + * @bandwidth: an integer describing the bandwidth in kbps
> + */
> +struct icn_qos {
> +	struct hlist_node node;
> +	struct interconnect_path *path;
> +	u32 bandwidth;
> +};
> +
> +int interconnect_add_provider(struct icp *icp);
> +int interconnect_del_provider(struct icp *icp);
> +
> +#endif /* _LINUX_INTERCONNECT_PROVIDER_H */
>


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
