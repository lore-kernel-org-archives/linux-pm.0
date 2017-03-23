From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC v0 1/2] interconnect: Add generic interconnect controller
 API
Date: Thu, 23 Mar 2017 17:21:03 +0200
Message-ID: <b4bd7615-c5cd-7c5b-0e2c-c7a35aac7da0@linaro.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
 <20170301182235.19154-2-georgi.djakov@linaro.org>
 <149023211030.54062.1219073679182388814@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <149023211030.54062.1219073679182388814@resonance>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, gregkh@linuxfoundation.org, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/23/2017 03:21 AM, Michael Turquette wrote:
> Hi Georgi,
>
> Quoting Georgi Djakov (2017-03-01 10:22:34)
>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> new file mode 100644
>> index 000000000000..c62d86e4c52d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> @@ -0,0 +1,91 @@
>> +Interconnect Provider Device Tree Bindings
>> +=========================================
>
> I agree with Rob to skip the DT bindings for now. However I did review
> this privately in February and I'll re-post my review comments here for
> when the bindings do get discussed at a later date:
>

Thanks!

>> +Optional properties:
>> +interconnect-port : A phandle and interconnect provider specifier as defined by
>> +               bindings of the interconnect provider specified by phandle.
>> +               This denotes the port to which the interconnect consumer is
>> +               wired. It is used when there are multiple interconnect providers
>> +               that have one or multiple links between them.
>
> Go ahead and remove the interconnect-port property description from the
> provider part of the binding. It should be sufficient to say,
> "interconnect providers can also be interconnect consumers, such as in
> the case where two network-on-chip fabrics interface directly".
>

Sounds good. Done.

>> +
>> +Example:
>> +
>> +               snoc: snoc@0580000 {
>> +                       compatible = "qcom,msm-bus-snoc";
>> +                       reg = <0x580000 0x14000>;
>> +                       #interconnect-cells = <1>;
>> +                       clock-names = "bus_clk", "bus_a_clk";
>> +                       clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +                       status = "okay";
>> +                       interconnect-port = <&bimc MAS_SNOC_CFG>,
>> +                                       <&bimc SNOC_BIMC_0_MAS>,
>> +                                       <&bimc SNOC_BIMC_1_MAS>,
>> +                                       <&pnoc SNOC_PNOC_SLV>;
>> +               };
>> +               bimc: bimc@0400000 {
>> +                       compatible = "qcom,msm-bus-bimc";
>> +                       reg = <0x400000 0x62000>;
>> +                       #interconnect-cells = <1>;
>> +                       clock-names = "bus_clk", "bus_a_clk";
>> +                       clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
>> +                       status = "okay";
>> +                       interconnect-port = <&snoc BIMC_SNOC_MAS>;
>> +               };
>> +               pnoc: pnoc@500000 {
>> +                       compatible = "qcom,msm-bus-pnoc";
>> +                       reg = <0x500000 0x11000>;
>> +                       #interconnect-cells = <1>;
>> +                       clock-names = "bus_clk", "bus_a_clk";
>> +                       clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
>> +                       status = "okay";
>> +                       interconnect-port = <&snoc PNOC_SNOC_SLV>;
>> +               };
>> +
>> += interconnect consumers =
>> +
>> +The interconnect consumers are device nodes which consume the interconnect
>> +path(s) provided by the interconnect provider. There can be multiple
>> +interconnect providers on a SoC and the consumer may consume multiple paths
>> +from different providers depending on usecase and the components it has to
>> +interact with.
>> +
>> +Required-properties:
>> +interconnect-port : A phandle and interconnect provider specifier as defined by
>> +               bindings of the interconnect provider specified by phandle.
>> +               This denotes the port to which the interconnect consumer is
>> +               wired.
>> +interconnect-path : List of phandles to the data path endpoints.
>
> More copy/paste from February review:
>
> "Path" means everything between the endpoints (e.g. the details of the
> graph traversal), whereas this DT property is really only meant to
> defint the target endpoint. Let's rename it to interconnect-target.
>
> When referring to endpoints I think we should some pairing terminology
> like: src,dst or local,remote or initiator,target.
>
> So how about:
> s/interconnect-port/interconnect-sources/
> s/interconnect-path/interconnect-targets/
>
> This keeps things symmetrical and the (source,target) pair just makes
> sense. I used plural as well since there can be multiple ports.
>
> It might even make sense to shorten it with: source-ports, target-ports
>

Agree that the port/path pairs might be confusing. Currently my
favorites are interconnect-src and interconnect-dst.

>> +interconnect-path-names : List of interconnect path name strings sorted in the
>> +               same order as the interconnect-path property.  Consumers drivers
>> +               will use interconnect-path-names to match the link names with
>> +               interconnect specifiers.
>
> Let's not use string names. No reason to copy the clkdev-style of
> resource lookups when an integer id will do just fine.
>

Yes, this is on my TODO list. Anyway for the platform data i will be 
using integers only.

>> +
>> +Example:
>> +
>> +       sdhci@07864000 {
>> +               ...
>> +               interconnect-port = <&pnoc MAS_PNOC_SDCC_2>;
>> +               interconnect-path = <&blsp1_uart2>;
>
> interconnect-path (err, port-target?) should not point to a consumer
> device node, it should point to the local port of the consumer device.
>
> How about:
>
> 	sdhci@07864000 {
> 		...
> 		interconnect-sources = <&pnoc 123>;
> 		interconnect-targets = <&pnoc 456>, <&snoc 789>;
> 	};
>
> And the magic numbers above (123, 456, 789) can be replaced by
> human-readable macros via the DT include chroot. E.g:
>
> 	interconnect-source = <&pnoc USB_OTG>;
> 	interconnect-target = <&pnoc OMG_WTF>, <&pnoc BBQ>;
>
>> +               interconnect-path-names = "spi";
>> +       };
>> diff --git a/Documentation/interconnect/interconnect.txt b/Documentation/interconnect/interconnect.txt
>> new file mode 100644
>> index 000000000000..051d3955f28b
>> --- /dev/null
>> +++ b/Documentation/interconnect/interconnect.txt
>> @@ -0,0 +1,68 @@
> ...
>> +The interconnect framework provide the following APIs to consumers:
>> +
>> +struct interconnect_path *interconnect_get(struct device *dev, const char *id);
>
> Replace strings with an integer offset for the port.
>

Yep.

>> diff --git a/drivers/interconnect/interconnect.c b/drivers/interconnect/interconnect.c
>> new file mode 100644
>> index 000000000000..dadd1ffdbc50
>> --- /dev/null
>> +++ b/drivers/interconnect/interconnect.c
>> @@ -0,0 +1,285 @@
> ...
>> +struct interconnect_path *interconnect_get(struct device *dev, const char *id)
>
> If the consumer device has more than one local port (e.g. source), it
> must be specified along the target port, right?
>

Yes, we may add it to the arguments and use 0 for the default case when 
we have only one source port. The platform i am currently playing with
only supports only one source port, but we can easy add support for
multiple sources.

>> +{
>> +       struct device_node *np;
>> +       struct platform_device *dst_pdev;
>> +       struct interconnect_node *src, *dst, *node;
>> +       struct interconnect_path *path;
>> +       int ret, index;
>> +
>> +       if (WARN_ON(!dev || !id))
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       src = find_node(dev->of_node);
>> +       if (IS_ERR(src))
>> +               return ERR_CAST(src);
>
> Does this assume that dev only has a single local port?

Currently yes.

>
>> +
>> +       index = of_property_match_string(dev->of_node,
>> +                                        "interconnect-path-names", id);
>> +       if (index < 0) {
>> +               dev_err(dev, "missing interconnect-path-names DT property on %s\n",
>> +                       dev->of_node->full_name);
>> +               return ERR_PTR(index);
>> +       }
>> +
>> +       /* get the destination endpoint device_node */
>> +       np = of_parse_phandle(dev->of_node, "interconnect-path", index);
>> +
>> +       dst_pdev = of_find_device_by_node(np);
>> +       if (!dst_pdev) {
>> +               dev_err(dev, "error finding device by node %s\n", np->name);
>> +               return ERR_PTR(-ENODEV);
>> +       }
>> +
>> +       dst = find_node(np);
>> +       if (IS_ERR(dst))
>> +               return ERR_CAST(dst);
>
> Some of the above can be simplified by using a symbolic constant integer
> instead of a string name for the index.
>
>> diff --git a/include/linux/interconnect-consumer.h b/include/linux/interconnect-consumer.h
>> new file mode 100644
>> index 000000000000..8bd5bb3e4196
>> --- /dev/null
>> +++ b/include/linux/interconnect-consumer.h
>> @@ -0,0 +1,70 @@
>> +/*
>> + * Copyright (c) 2017, Linaro Ltd.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef _LINUX_INTERCONNECT_CONSUMER_H
>> +#define _LINUX_INTERCONNECT_CONSUMER_H
>> +
>> +struct interconnect_node;
>> +
>> +/**
>> + * struct interconnect_path - interconnect path structure
>> + *
>> + * @node_list: list of the interconnect nodes
>> + * @src_dev: source endpoint
>> + * @dst_dev: destination endpoint
>> + */
>> +struct interconnect_path {
>> +       struct list_head node_list;
>> +       struct device *src_dev;
>> +       struct device *dst_dev;
>> +};
>
> Don't expose the definition of interconnect_path to users. They should
> only have an opaque handle to the interconnect_path object.

Agree. Done.

>
>> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
>> new file mode 100644
>> index 000000000000..af1ca739ce52
>> --- /dev/null
>> +++ b/include/linux/interconnect-provider.h
>> @@ -0,0 +1,92 @@
>> +/*
>> + * Copyright (c) 2017, Linaro Ltd.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef _LINUX_INTERCONNECT_PROVIDER_H
>> +#define _LINUX_INTERCONNECT_PROVIDER_H
>> +
>> +#include <linux/interconnect-consumer.h>
>> +
>> +/**
>> + * struct icp_ops - platform specific callback operations for interconnect
>> + * providers that will be called from drivers
>> + *
>> + * @set: set constraints on interconnect
>> + * @xlate: provider-specific callback for mapping nodes from phandle arguments
>> + */
>> +struct icp_ops {
>> +       int (*set)(struct interconnect_node *node, u32 bandwidth);
>> +       struct interconnect_node *(*xlate)(struct of_phandle_args *spec, void *data);
>> +};
>> +
>> +/**
>> + * struct icp - interconnect provider (controller) entity that might
>> + * provide multiple interconnect controls
>> + *
>> + * @icp_list: list of the registered interconnect providers
>> + * @nodes: internal list of the interconnect provider nodes
>> + * @ops: pointer to device specific struct icp_ops
>> + * @dev: the device this interconnect provider belongs to
>> + * @of_node: the corresponding device tree node as phandle target
>> + * @data: pointer to private data
>> + */
>> +struct icp {
>> +       struct list_head        icp_list;
>> +       struct list_head        nodes;
>> +       const struct icp_ops    *ops;
>> +       struct device           *dev;
>> +       const char              *name;
>> +       struct device_node      *of_node;
>> +       void                    *data;
>> +};
>
> Does this need to be defined for provider drivers?
>

At the moment, this data is directly populated by the provider drivers,
but we could re-factor this - define ops for each node, introduce a 
register_node(provider, node) function and populate the rest of the
data within the framework.

>> +
>> +/**
>> + * struct interconnect_node - entity that is part of the interconnect topology
>> + *
>> + * @links: links to other interconnect nodes
>> + * @num_links: number of interconnect nodes
>> + * @icp: points to the interconnect provider struct this node belongs to
>> + * @icn_list: list of interconnect nodes
>> + * @search_list: list used when walking the nodes graph
>> + * @reverse: pointer to previous node when walking the nodes graph
>> + * @is_traversed: flag that is used when walking the nodes graph
>> + * @qos_list: a list of QoS constraints
>> + */
>> +struct interconnect_node {
>> +       struct interconnect_node **links;
>> +       size_t                  num_links;
>> +
>> +       struct icp              *icp;
>> +       struct list_head        icn_list;
>> +       struct list_head        search_list;
>> +       struct interconnect_node *reverse;
>> +       bool                    is_traversed;
>> +       struct hlist_head       qos_list;
>> +};
>
> Don't define this publicly. Should just be declared as an opaque handle.
>

Some data may be used by provider drivers, the qos_list for example, 
which contains a list of constraints. The other way around would be to
make the constraints provider specific or create functions for accessing
this data?

>> +
>> +/**
>> + * struct icn_qos - constraints that are attached to each node
>> + *
>> + * @node: linked list node
>> + * @path: the interconnect path which is using this constraint
>> + * @bandwidth: an integer describing the bandwidth in kbps
>> + */
>> +struct icn_qos {
>> +       struct hlist_node node;
>> +       struct interconnect_path *path;
>> +       u32 bandwidth;
>> +};
>
>
> Don't define this publicly. Should just be declared as an opaque handle.

Create a function for setting QoS/constrains on a node?

Thanks,
Georgi
