From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC v1 1/3] interconnect: Add generic interconnect controller API
Date: Wed, 31 May 2017 18:02:04 +0200
Message-ID: <CAKfTPtD5-RAx6y00ovnNeC-41vjaeiHBjSQRyS44j6iL77Wtsw@mail.gmail.com>
References: <20170515153527.27649-1-georgi.djakov@linaro.org> <20170515153527.27649-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34247 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdEaQC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 12:02:27 -0400
Received: by mail-lf0-f47.google.com with SMTP id 99so12177297lfu.1
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2017 09:02:26 -0700 (PDT)
In-Reply-To: <20170515153527.27649-2-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, mturquette <mturquette@baylibre.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, skannan@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, "Sweeney, Sean" <seansw@qti.qualcomm.com>, "Dai, David" <davidai@quicinc.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org

On 15 May 2017 at 17:35, Georgi Djakov <georgi.djakov@linaro.org> wrote:
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
>  Documentation/interconnect/interconnect.txt |  65 ++++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   1 +
>  drivers/interconnect/interconnect.c         | 317 ++++++++++++++++++++++++++++
>  include/linux/interconnect-consumer.h       |  84 ++++++++
>  include/linux/interconnect-provider.h       | 110 ++++++++++
>  8 files changed, 590 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.txt
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/interconnect.c
>  create mode 100644 include/linux/interconnect-consumer.h
>  create mode 100644 include/linux/interconnect-provider.h
>
> diff --git a/Documentation/interconnect/interconnect.txt b/Documentation/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..f761a2fb553c
> --- /dev/null
> +++ b/Documentation/interconnect/interconnect.txt
> @@ -0,0 +1,65 @@
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
> +The interconnect framework consumer API functions are documented in
> +include/linux/interconnect-consumer.h
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index d2ac339de85f..6e4d80e98f5c 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -198,4 +198,6 @@ source "drivers/hwtracing/intel_th/Kconfig"
>
>  source "drivers/fpga/Kconfig"
>
> +source "drivers/interconnect/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 795d0ca714bf..d5b4733f3875 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -172,3 +172,4 @@ obj-$(CONFIG_STM)           += hwtracing/stm/
>  obj-$(CONFIG_ANDROID)          += android/
>  obj-$(CONFIG_NVMEM)            += nvmem/
>  obj-$(CONFIG_FPGA)             += fpga/
> +obj-$(CONFIG_INTERCONNECT)     += interconnect/
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> new file mode 100644
> index 000000000000..1e50e951cdc1
> --- /dev/null
> +++ b/drivers/interconnect/Kconfig
> @@ -0,0 +1,10 @@
> +menuconfig INTERCONNECT
> +       tristate "On-Chip Interconnect management support"
> +       help
> +         Support for management of the on-chip interconnects.
> +
> +         This framework is designed to provide a generic interface for
> +          managing the interconnects in a SoC.
> +
> +         If unsure, say no.
> +
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> new file mode 100644
> index 000000000000..d9da6a6c3560
> --- /dev/null
> +++ b/drivers/interconnect/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_INTERCONNECT)  += interconnect.o
> diff --git a/drivers/interconnect/interconnect.c b/drivers/interconnect/interconnect.c
> new file mode 100644
> index 000000000000..633ee157226f
> --- /dev/null
> +++ b/drivers/interconnect/interconnect.c
> @@ -0,0 +1,317 @@
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
> +#include <linux/interconnect-consumer.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +static DEFINE_MUTEX(interconnect_provider_list_mutex);
> +static LIST_HEAD(interconnect_provider_list);
> +
> +/**
> + * struct interconnect_path - interconnect path structure
> + *
> + * @nodes: array of the nodes in this path
> + * @num_nodes: number of hops (nodes)
> + */
> +struct interconnect_path {
> +       struct interconnect_node **nodes;
> +       size_t num_nodes;
> +};

You should better start the struct with size_t num_nodes and put the
array of struct interconnect_node **nodes at the end like below
struct interconnect_path {
       size_t num_nodes;
       struct interconnect_node *nodes[];
};

Then you can do only one allocation for everything
kzalloc(sizeof(*path) + number * sizeof(*node), GFP_KERNEL);


> +
> +static struct interconnect_node *node_find(const char *dev_id, int con_id)
> +{
> +       struct icp *icp;
> +       struct interconnect_node *node = ERR_PTR(-EPROBE_DEFER);
> +       int match, best = 0;
> +
> +       mutex_lock(&interconnect_provider_list_mutex);
> +
> +       list_for_each_entry(icp, &interconnect_provider_list, icp_list) {
> +               struct interconnect_node *n;
> +
> +               match = 0;
> +
> +               list_for_each_entry(n, &icp->nodes, icn_list) {
> +                       if (n->dev_id) {
> +                               if (!dev_id || strncmp(n->dev_id, dev_id,
> +                                                      strlen(dev_id)))
> +                                       continue;
> +                               match += 2;
> +                       }
> +                       if (n->con_id) {
> +                               if (!con_id || n->con_id != con_id)
> +                                       continue;
> +                               match += 1;
> +                       }
> +
> +                       if (match > best) {
> +                               node = n;
> +                               if (match == 3)
> +                                       goto out;
> +
> +                               best = match;
> +                       }
> +               }
> +       }
> +
> +out:
> +       mutex_unlock(&interconnect_provider_list_mutex);
> +
> +       return node;
> +}
> +
> +static struct interconnect_path *path_find(struct interconnect_node *src,
> +                                          struct interconnect_node *dst)
> +{
> +       struct list_head edge_list;
> +       struct list_head traverse_list;
> +       struct list_head tmp_list;
> +       struct interconnect_path *path = ERR_PTR(-EPROBE_DEFER);
> +       struct interconnect_node *node = NULL;
> +       size_t i, number = 1;
> +       bool found = false;
> +
> +       INIT_LIST_HEAD(&traverse_list);
> +       INIT_LIST_HEAD(&edge_list);
> +       INIT_LIST_HEAD(&tmp_list);
> +
> +       list_add_tail(&src->search_list, &traverse_list);
> +
> +       do {
> +               list_for_each_entry(node, &traverse_list, search_list) {
> +                       if (node == dst) {
> +                               found = true;
> +                               list_add(&node->search_list, &tmp_list);
> +                               break;
> +                       }
> +                       for (i = 0; i < node->num_links; i++) {
> +                               struct interconnect_node *tmp = node->links[i];
> +
> +                               if (!tmp) {
> +                                       WARN_ON(1);
> +                                       return ERR_PTR(-ENOENT);
> +                               }
> +
> +                               if (tmp->is_traversed)
> +                                       continue;
> +
> +                               tmp->is_traversed = true;
> +                               tmp->reverse = node;
> +                               list_add_tail(&tmp->search_list, &edge_list);
> +                       }
> +               }
> +               if (found)
> +                       break;
> +
> +               list_splice_init(&traverse_list, &tmp_list);
> +               list_splice_init(&edge_list, &traverse_list);
> +
> +               /* count the number of nodes */
> +               number++;
> +
> +       } while (!list_empty(&traverse_list));
> +
> +       /* reset the traversed state */
> +       list_for_each_entry(node, &tmp_list, search_list) {
> +               node->is_traversed = false;
> +       }
> +
> +       if (found) {
> +               path = kzalloc(sizeof(*path), GFP_KERNEL);
> +               if (!path)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               path->nodes = kcalloc(number, sizeof(*node), GFP_KERNEL);
> +               if (!path->nodes) {
> +                       kfree(path);
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +
> +               path->num_nodes = number;
> +
> +               /* start from the destination and go back to source */
> +               node = dst;
> +
> +               for (i = 0; i < number; i++) {
> +                       path->nodes[i] = node;
> +                       node = node->reverse;
> +               }
> +       }
> +
> +       return path;
> +}
> +
> +int interconnect_set(struct interconnect_path *path, u32 bandwidth)
> +{
> +       struct interconnect_node *next, *prev = NULL;
> +       size_t i;
> +
> +       for (i = 0; i < path->num_nodes; i++) {
> +               struct icn_qos *req;
> +               u32 agg_bw = 0;
> +
> +               next = path->nodes[i];
> +
> +               /* aggregate requests */
> +               hlist_for_each_entry(req, &next->qos_list, node) {
> +                       if (req->path == path) {
> +                               /* update the bandwidth for the path */
> +                               req->bandwidth = bandwidth;
> +                       }
> +
> +                       agg_bw += req->bandwidth;
> +               }
> +
> +               if (next->icp->ops->set)
> +                       next->icp->ops->set(prev, next, agg_bw);
> +
> +               prev = next;
> +
> +               /* is this the last node? */
> +               if (i == path->num_nodes - 1) {
> +                       if (next->icp->ops->set)
> +                               next->icp->ops->set(next, NULL, agg_bw);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +struct interconnect_path *interconnect_get(const char *sdev, const int sid,
> +                                          const char *ddev, const int did)
> +{
> +       struct interconnect_node *src, *dst, *node;
> +       struct interconnect_path *path;
> +       size_t i;
> +
> +       src = node_find(sdev, sid);
> +       if (IS_ERR(src))
> +               return ERR_CAST(src);
> +
> +       dst = node_find(ddev, did);
> +       if (IS_ERR(dst))
> +               return ERR_CAST(dst);
> +
> +       /* TODO: cache the path */
> +       path = path_find(src, dst);
> +       if (IS_ERR(path)) {
> +               pr_err("error finding path between %p and %p (%ld)\n",
> +                      src, dst, PTR_ERR(path));
> +               return path;
> +       }
> +
> +       for (i = 0; i < path->num_nodes; i++) {
> +               struct icn_qos *req;
> +
> +               node = path->nodes[i];
> +
> +               pr_debug("%s: i=%lu node=%p\n", __func__, i, node);
> +
> +               /*
> +                * Create icn_qos for each separate link between the nodes.
> +                * They may have different constraints and may belong to
> +                * different interconnect providers.
> +                */
> +               req = kzalloc(sizeof(*req), GFP_KERNEL);
> +               if (!req)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               req->path = path;
> +               req->bandwidth = 0;
> +
> +               hlist_add_head(&req->node, &node->qos_list);
> +
> +               node->icp->users++;
> +       }
> +
> +       return path;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_get);
> +
> +void interconnect_put(struct interconnect_path *path)
> +{
> +       struct interconnect_node *node;
> +       struct icn_qos *req;
> +       struct hlist_node *tmp;
> +       size_t i;
> +       int ret;
> +
> +       if (IS_ERR(path))
> +               return;
> +
> +       for (i = 0; i < path->num_nodes; i++) {
> +               node = path->nodes[i];
> +
> +               hlist_for_each_entry_safe(req, tmp, &node->qos_list, node) {
> +                       if (req->path == path) {
> +                               /*
> +                                * Remove the constraints from the path,
> +                                * update the nodes and free the memory
> +                                */
> +                               ret = interconnect_set(path, 0);
> +                               if (ret)
> +                                       pr_err("%s error %d\n", __func__, ret);
> +
> +                               hlist_del(&req->node);
> +                               kfree(req);
> +                       }
> +               }
> +
> +               node->icp->users--;
> +       }
> +
> +       kfree(path);
> +}
> +EXPORT_SYMBOL_GPL(interconnect_put);
> +
> +int interconnect_add_provider(struct icp *icp)
> +{
> +       struct interconnect_node *node;
> +
> +       WARN(!icp->ops->set, "%s: .set is not implemented\n", __func__);
> +
> +       mutex_lock(&interconnect_provider_list_mutex);
> +       list_add(&icp->icp_list, &interconnect_provider_list);
> +       mutex_unlock(&interconnect_provider_list_mutex);
> +
> +       list_for_each_entry(node, &icp->nodes, icn_list) {
> +               INIT_HLIST_HEAD(&node->qos_list);
> +       }
> +
> +       dev_info(icp->dev, "interconnect provider is added to topology\n");
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_add_provider);
> +
> +int interconnect_del_provider(struct icp *icp)
> +{
> +       if (icp->users)
> +               return -EBUSY;
> +
> +       mutex_lock(&interconnect_provider_list_mutex);
> +       list_del(&icp->icp_list);
> +       mutex_unlock(&interconnect_provider_list_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_del_provider);
> +
> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
> +MODULE_DESCRIPTION("Interconnect Driver Core");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/interconnect-consumer.h b/include/linux/interconnect-consumer.h
> new file mode 100644
> index 000000000000..e187efa6c20a
> --- /dev/null
> +++ b/include/linux/interconnect-consumer.h
> @@ -0,0 +1,84 @@
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
> +struct interconnect_path;
> +
> +#if IS_ENABLED(CONFIG_INTERCONNECT)
> +
> +/**
> + * interconnect_get() - get an interconnect path between two endpoits
> + *
> + * @sdev: source device identifier
> + * @sid: source device port identifier
> + * @ddev: destination device identifier
> + * @did: destination device port identifier
> + *
> + * This function will search for a path between the source device (caller)
> + * and a destination endpoint. It returns an interconnect_path handle on
> + * success. Use interconnect_put() to release constraints when the they
> + * are not needed anymore.
> + *
> + * This function returns a handle on success, or ERR_PTR() otherwise.
> + */
> +struct interconnect_path *interconnect_get(const char *sdev, const int sid,
> +                                          const char *ddev, const int did);
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
> +#else
> +
> +inline struct interconnect_path *interconnect_get(const char *sdev,
> +                                                        const int sid,
> +                                                        const char *ddev,
> +                                                        const int did)
> +{
> +       return ERR_PTR(-ENOSYS);
> +}
> +
> +inline void interconnect_put(struct interconnect_path *path)
> +{
> +}
> +
> +inline int interconnect_set(struct interconnect_path *path, u32 bandwidth)
> +{
> +       return -ENOSYS;
> +}
> +
> +#endif /* CONFIG_INTERCONNECT */
> +
> +#endif /* _LINUX_INTERCONNECT_CONSUMER_H */
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> new file mode 100644
> index 000000000000..733d5c3e00b7
> --- /dev/null
> +++ b/include/linux/interconnect-provider.h
> @@ -0,0 +1,110 @@
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
> + */
> +struct icp_ops {
> +       int (*set)(struct interconnect_node *src, struct interconnect_node *dst, u32 bandwidth);
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
> + * @users: count of active users
> + * @data: pointer to private data
> + */
> +struct icp {
> +       struct list_head        icp_list;
> +       struct list_head        nodes;
> +       const struct icp_ops    *ops;
> +       struct device           *dev;
> +       int                     users;
> +       void                    *data;
> +};
> +
> +/**
> + * struct interconnect_node - entity that is part of the interconnect topology
> + *
> + * @links: links to other interconnect nodes
> + * @num_links: number of links to other interconnect nodes
> + * @icp: points to the interconnect provider of this node
> + * @icn_list: list of interconnect nodes
> + * @search_list: list used when walking the nodes graph
> + * @reverse: pointer to previous node when walking the nodes graph
> + * @is_traversed: flag that is used when walking the nodes graph
> + * @qos_list: a list of QoS constraints
> + * @dev_id: device id
> + * @con_id: connection id
> + */
> +struct interconnect_node {
> +       struct interconnect_node **links;
> +       size_t                  num_links;
> +
> +       struct icp              *icp;
> +       struct list_head        icn_list;
> +       struct list_head        search_list;
> +       struct interconnect_node *reverse;
> +       bool                    is_traversed;
> +       struct hlist_head       qos_list;
> +
> +       const char              *dev_id;
> +       int                     con_id;
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
> +       struct hlist_node node;
> +       struct interconnect_path *path;
> +       u32 bandwidth;
> +};
> +
> +#if IS_ENABLED(CONFIG_INTERCONNECT)
> +
> +int interconnect_add_provider(struct icp *icp);
> +int interconnect_del_provider(struct icp *icp);
> +
> +#else
> +
> +static inline int interconnect_add_provider(struct icp *icp)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline int interconnect_del_provider(struct icp *icp)
> +{
> +       return -ENOSYS;
> +}
> +
> +#endif /* CONFIG_INTERCONNECT */
> +
> +#endif /* _LINUX_INTERCONNECT_PROVIDER_H */
