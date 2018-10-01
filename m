From: Evan Green <evgreen@google.com>
Subject: Re: [PATCH v3 1/2] interconnect: qcom: Add sdm845 interconnect
 provider driver
Date: Mon, 1 Oct 2018 11:45:35 -0700
Message-ID: <CAE=gft6+wKPzZCseAtDvFmLaxBk31RKGQ5qCMvEs57-38+ZEbw@mail.gmail.com>
References: <1535075814-17343-1-git-send-email-daidavid1@codeaurora.org> <1535075814-17343-2-git-send-email-daidavid1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535075814-17343-2-git-send-email-daidavid1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daidavid1@codeaurora.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, Lina Iyer <ilina@codeaurora.org>, seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com
List-Id: linux-pm@vger.kernel.org

Hi David. Apologies for my late review, this fell under the rug for a
little while.

On Thu, Aug 23, 2018 at 6:57 PM David Dai <daidavid1@codeaurora.org> wrote:
>
> Introduce Qualcomm SDM845 specific provider driver using the
> interconnect framework.
>
> Change-Id: I716b39068b4a211b8203b2a52d3037a5b84594ea
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom-sdm845.txt          |  22 +
>  drivers/interconnect/qcom/Kconfig                  |   8 +
>  drivers/interconnect/qcom/Makefile                 |   1 +
>  drivers/interconnect/qcom/sdm845.c                 | 844 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom.h            | 110 ++-
>  5 files changed, 984 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>
...
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> new file mode 100644
> index 0000000..57aba8a
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -0,0 +1,844 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/interconnect.h>

Nit: alphabetization here (io > in)

> +#include <linux/interconnect-provider.h>
> +#include <dt-bindings/interconnect/qcom.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

slab.h is not needed is it?

> +#include <linux/sort.h>
> +
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +#include <soc/qcom/tcs.h>
> +
> +#define BCM_TCS_CMD_COMMIT_SHFT                30
> +#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
> +#define BCM_TCS_CMD_VALID_SHFT         29
> +#define BCM_TCS_CMD_VALID_MASK         0x200010000

Did you mean to have that 0x10000 in there? In BCM_TCS_CMD you just
shift by 29, which would make that 0x10000 always zero.

> +#define BCM_TCS_CMD_VOTE_X_SHFT                14
> +#define BCM_TCS_CMD_VOTE_MASK          0x3fff
> +#define BCM_TCS_CMD_VOTE_Y_SHFT                0
> +#define BCM_TCS_CMD_VOTE_Y_MASK                0xfffc000

This VOTE_Y_MASK isn't used. Also, given that the shift is 0, it
doesn't look right.

> +
> +#define BCM_TCS_CMD(commit, valid, vote_x, vote_y) \
> +       ((commit << BCM_TCS_CMD_COMMIT_SHFT) |\
> +       (valid << BCM_TCS_CMD_VALID_SHFT) |\
> +       ((cpu_to_le32(vote_x) &\
> +       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |\
> +       ((cpu_to_le32(vote_y) &\
> +       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
> +
> +#define to_qcom_provider(_provider) \
> +       container_of(_provider, struct qcom_icc_provider, provider)
> +
> +#define DEFINE_QNODE(_name, _id, _channels, _buswidth,                 \
> +                       _numlinks, ...)                                 \
> +               static struct qcom_icc_node _name = {                   \
> +               .id = _id,                                              \
> +               .name = #_name,                                         \
> +               .channels = _channels,                                  \
> +               .buswidth = _buswidth,                                  \
> +               .num_links = _numlinks,                                 \
> +               .links = { __VA_ARGS__ },                               \
> +       }
> +
> +#define DEFINE_QBCM(_name, _bcmname, _keepalive, _numnodes, ...)       \
> +               static struct qcom_icc_bcm _name = {                    \
> +               .name = _bcmname,                                       \
> +               .keepalive = _keepalive,                                \
> +               .num_nodes = _numnodes,                                 \
> +               .nodes = { __VA_ARGS__ },                               \
> +       }
> +
> +struct qcom_icc_provider {
> +       struct icc_provider     provider;
> +       void __iomem            *base;
> +       struct device           *dev;
> +       struct qcom_icc_bcm     **bcms;
> +       size_t num_bcms;
> +};
> +
> +/**
> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(BCM)
> + * @unit: bcm threshold values are in magnitudes of this

I'm having a little trouble understanding this comment, I think it
could be crispened up. So this is a divisor that applies when
converting a bytes/second bandwidth value to an RPMh message. Yes?

> + * @width: prototype width

So this is a multiplier that's applied when converting a bytes/second
bandwidth into an RPMh message?

> + * @vcd: virtual clock domain that this bcm belongs to
> + */
> +
> +struct bcm_db {
> +       u32 unit;
> +       u16 width;
> +       u8 vcd;
> +       u8 reserved;
> +};
> +
> +#define SDM845_MAX_LINKS       43
> +#define SDM845_MAX_BCMS                30
> +#define SDM845_MAX_BCM_PER_NODE        2
> +#define SDM845_MAX_VCD         10
> +
> +/**
> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
> + * @name: the node name used in debugfs
> + * @links: an array of nodes where we can go next while traversing
> + * @id: a unique node identifier
> + * @num_links: the total number of @links
> + * @channels: num of channels at this node
> + * @buswidth: width of the interconnect between a node and the bus
> + * @sum_avg: current sum aggregate value of all avg bw requests
> + * @max_peak: current max aggregate value of all peak bw requests
> + * @bcms: list of bcms associated with this logical node
> + * @num_bcm: num of @bcms
> + */
> +struct qcom_icc_node {
> +       const char *name;
> +       u16 links[SDM845_MAX_LINKS];
> +       u16 id;
> +       u16 num_links;
> +       u16 channels;
> +       u16 buswidth;
> +       u64 sum_avg;
> +       u64 max_peak;
> +       struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
> +       size_t num_bcms;
> +};
> +
> +/**
> + * struct qcom_icc_bcm - Qualcomm specific hardware accelerator nodes
> + * known as Bus Clock Manager(BCM)
> + * @name: the bcm node name used to fetch BCM data from command db
> + * @type: latency or bandwidth bcm
> + * @addr: address offsets used when voting to RPMH
> + * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
> + * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
> + * @dirty: flag used to indicate whether or bcm needs to be committed
> + * @aux_data: auxiliary data used when calculating threshold values and
> + * communicating with RPMh
> + * @list: used to link to other bcms when compiling lists for commit
> + * @num_nodes: total number of @num_nodes
> + * @nodes: list of qcom_icc_nodes that this BCM encapsulates
> + */
> +
> +struct qcom_icc_bcm {
> +       const char *name;
> +       u32 type;
> +       u32 addr;
> +       u64 vote_x;
> +       u64 vote_y;
> +       bool dirty;
> +       bool keepalive;
> +       struct bcm_db aux_data;
> +       struct list_head list;
> +       size_t num_nodes;
> +       struct qcom_icc_node *nodes[];
> +};
> +
> +struct qcom_icc_fabric {
> +       struct qcom_icc_node **nodes;
> +       size_t num_nodes;
> +       u32 base_offset;
> +       u32 qos_offset;
> +};
> +
> +struct qcom_icc_desc {
> +       struct qcom_icc_node **nodes;
> +       size_t num_nodes;
> +       struct qcom_icc_bcm **bcms;
> +       size_t num_bcms;
> +};
> +
...
> +
> +static int qcom_tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x,
> +                                       u64 vote_y, u32 addr, bool commit)
> +{
> +       int ret = 0;
> +       bool valid = true;
> +
> +       if (!cmd)
> +               return ret;
> +
> +       if (vote_x == 0 && vote_y == 0)
> +               valid = false;
> +
> +       if (vote_x > BCM_TCS_CMD_VOTE_MASK)
> +               vote_x = BCM_TCS_CMD_VOTE_MASK;
> +
> +       if (vote_y > BCM_TCS_CMD_VOTE_MASK)
> +               vote_y = BCM_TCS_CMD_VOTE_MASK;
> +
> +       cmd->addr = addr;
> +       cmd->data = BCM_TCS_CMD(commit, valid, vote_x, vote_y);
> +
> +       /*
> +        * Set the wait for completion flag on commands that have the commit
> +        * set, in order to indicate to the RSC to not release the TCS slot
> +        * until hardware has acknowledged that this transaction has completed.
> +        */
> +       if (commit)
> +               cmd->wait = true;
> +
> +       return ret;

This function appears never to be able to fail. Perhaps remove ret and
change return type to void.

> +}
> +
> +static void qcom_tcs_list_gen(struct list_head *bcm_list,
> +                                       struct tcs_cmd *tcs_list, int *n)
> +{
> +       struct qcom_icc_bcm *bcm;
> +       bool commit;
> +       size_t idx = 0, batch = 0, cur_vcd_size = 0;
> +
> +       memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
> +
> +       list_for_each_entry(bcm, bcm_list, list) {
> +               commit = false;
> +               cur_vcd_size++;
> +               if ((list_is_last(&bcm->list, bcm_list)) ||
> +                       bcm->aux_data.vcd !=
> +                       list_is_last(&bcm->list, bcm_list)) {

Whoa, I think this fixup got scrozzed. The old logic was...
+               if ((bcm->aux_data.vcd !=
+                       list_next_entry(bcm, list)->aux_data.vcd) ||
+                       list_is_last(&bcm->list, bcm_list)) {
...and I think all you were trying to do was reverse the order of the
two conditionals so list_is_last happened first. Something happened
along the way.

> +                       commit = true;
> +                       cur_vcd_size = 0;
> +               }
> +               qcom_tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
> +                               bcm->addr, commit);
> +               idx++;
> +               n[batch]++;
> +               /*
> +                * Batch the BCMs in such a way that we do not split them in
> +                * multiple payloads when they are under the same VCD. This is
> +                * to ensure that every BCM is committed since we only set the
> +                * commit bit on the last BCM request of every VCD.
> +                */
> +               if (n[batch] >= MAX_RPMH_PAYLOAD) {
> +                       if (!commit) {
> +                               n[batch] -= cur_vcd_size;
> +                               n[batch+1] = cur_vcd_size;
> +                       }
> +                       batch++;
> +               }
> +       }
> +}
> +
> +static void qcom_icc_bcm_aggregate(struct qcom_icc_bcm *bcm)
> +{
> +       size_t i;
> +       u64 agg_avg = 0;
> +       u64 agg_peak = 0;
> +
> +       for (i = 0; i < bcm->num_nodes; i++) {
> +               agg_avg = max(agg_avg,
> +                       bcm->nodes[i]->sum_avg * bcm->aux_data.width /
> +                       (bcm->nodes[i]->buswidth * bcm->nodes[i]->channels));
> +               agg_peak = max(agg_peak,
> +                       bcm->nodes[i]->max_peak * bcm->aux_data.width /
> +                       bcm->nodes[i]->buswidth);
> +       }
> +
> +       bcm->vote_x = (u64)(agg_avg * 1000ULL / bcm->aux_data.unit);
> +       bcm->vote_y = (u64)(agg_peak * 1000ULL / bcm->aux_data.unit);
> +
> +       if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
> +               bcm->vote_x = 1;
> +               bcm->vote_y = 1;
> +       }
> +
> +       bcm->dirty = false;
> +}
> +
> +static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw,
> +                               u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +       size_t i;
> +       struct qcom_icc_node *qn;
> +
> +       qn = node->data;
> +
> +       *agg_avg += avg_bw;
> +       *agg_peak = max_t(u64, agg_peak, peak_bw);

This should be u32 instead of u64. My compiler complains about this.

> +
> +       qn->sum_avg = *agg_avg;
> +       qn->max_peak = *agg_peak;
> +
> +       for (i = 0; i < qn->num_bcms; i++)
> +               qn->bcms[i]->dirty = true;
> +
> +       return 0;
> +}
> +
> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
...
