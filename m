From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect
 API
Date: Wed, 5 Dec 2018 17:57:19 +0200
Message-ID: <c2dc1f5c-46ab-b5aa-0069-b5b50e7e2182@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-2-georgi.djakov@linaro.org>
 <CAE=gft5jWZgzRTNB4m0ES+g=rpjACYWVissmEQ+pgPGKEffgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft5jWZgzRTNB4m0ES+g=rpjACYWVissmEQ+pgPGKEffgog@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>, maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Evan,

On 12/1/18 02:38, Evan Green wrote:
> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> This patch introduces a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) between endpoints and
>> set the desired constraints on this data flow path. The providers receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
> 
> Strange word ordering. Consider something like: "Then the providers
> configure each node participating in the topology"
> 
> ...Or a slightly different flavor: "Then the providers configure each
> node along the path to support a bandwidth that satisfies all
> bandwidth requests that cross through that node".
> 

This sounds better!

>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> Reviewed-by: Evan Green <evgreen@chromium.org>
> 
> This already has my reviewed by, and I still stand by it, but I
> couldn't help finding some nits anyway. Sorry :)

Thanks for finding them!

>> ---
>>  Documentation/interconnect/interconnect.rst |  94 ++++
>>  drivers/Kconfig                             |   2 +
>>  drivers/Makefile                            |   1 +
>>  drivers/interconnect/Kconfig                |  10 +
>>  drivers/interconnect/Makefile               |   5 +
>>  drivers/interconnect/core.c                 | 569 ++++++++++++++++++++
>>  include/linux/interconnect-provider.h       | 125 +++++
>>  include/linux/interconnect.h                |  51 ++
>>  8 files changed, 857 insertions(+)
>>  create mode 100644 Documentation/interconnect/interconnect.rst
>>  create mode 100644 drivers/interconnect/Kconfig
>>  create mode 100644 drivers/interconnect/Makefile
>>  create mode 100644 drivers/interconnect/core.c
>>  create mode 100644 include/linux/interconnect-provider.h
>>  create mode 100644 include/linux/interconnect.h
>>
[..]
>> +/*
>> + * We want the path to honor all bandwidth requests, so the average and peak
>> + * bandwidth requirements from each consumer are aggregated at each node.
>> + * The aggregation is platform specific, so each platform can customize it by
>> + * implementing it's own aggregate() function.
> 
> Grammar police: remove the apostrophe in its.
> 

Oops.

>> + */
>> +
>> +static int aggregate_requests(struct icc_node *node)
>> +{
>> +       struct icc_provider *p = node->provider;
>> +       struct icc_req *r;
>> +
>> +       node->avg_bw = 0;
>> +       node->peak_bw = 0;
>> +
>> +       hlist_for_each_entry(r, &node->req_list, req_node)
>> +               p->aggregate(node, r->avg_bw, r->peak_bw,
>> +                            &node->avg_bw, &node->peak_bw);
>> +
>> +       return 0;
>> +}
>> +
>> +static int apply_constraints(struct icc_path *path)
>> +{
>> +       struct icc_node *next, *prev = NULL;
>> +       int ret = -EINVAL;
>> +       int i;
>> +
>> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +               struct icc_provider *p;
>> +
>> +               next = path->reqs[i].node;
>> +               /*
>> +                * Both endpoints should be valid master-slave pairs of the
>> +                * same interconnect provider that will be configured.
>> +                */
>> +               if (!prev || next->provider != prev->provider)
>> +                       continue;
> 
> I wonder if we should explicitly ban paths where we bounce through an
> odd number of nodes within one provider. Otherwise, set() won't be
> called on all nodes in the path. Or, if we wanted to support those
> kinds of topologies, you could call set with one of the nodes set to
> NULL to represent either the ingress or egress bandwidth to this NoC.
> This doesn't necessarily need to be addressed in this series, but is
> something that other providers might bump into when implementing their
> topologies.
> 

Yes, we can do something like this. But i prefer that we first add
support for more platforms and then according to the requirements we can
work out something.

[..]

>> +       new = krealloc(src->links,
>> +                      (src->num_links) * sizeof(*src->links),
> 
> These parentheses aren't needed.

Sure!

>> +                      GFP_KERNEL);
>> +       if (new)
>> +               src->links = new;
>> +

[..]

>> +
>> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
> 
> This is missing the closing >

Thanks!

>> +MODULE_DESCRIPTION("Interconnect Driver Core");
>> +MODULE_LICENSE("GPL v2");
> ...
>> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
>> new file mode 100644
>> index 000000000000..04b2966ded9f
>> --- /dev/null
>> +++ b/include/linux/interconnect.h
>> @@ -0,0 +1,51 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef __LINUX_INTERCONNECT_H
>> +#define __LINUX_INTERCONNECT_H
>> +
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +
>> +/* macros for converting to icc units */
>> +#define bps_to_icc(x)  (1)
>> +#define kBps_to_icc(x) (x)
>> +#define MBps_to_icc(x) (x * 1000)
>> +#define GBps_to_icc(x) (x * 1000 * 1000)
>> +#define kbps_to_icc(x) (x / 8 + ((x) % 8 ? 1 : 0))
>> +#define Mbps_to_icc(x) (x * 1000 / 8 )
> 
> Remove extra space before )

Done.

>> +#define Gbps_to_icc(x) (x * 1000 * 1000 / 8)
>> +
>> +struct icc_path;
>> +struct device;
>> +
>> +#if IS_ENABLED(CONFIG_INTERCONNECT)
>> +
>> +struct icc_path *icc_get(struct device *dev, const int src_id,
>> +                        const int dst_id);
>> +void icc_put(struct icc_path *path);
>> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>> +
>> +#else
>> +
>> +static inline struct icc_path *icc_get(struct device *dev, const int src_id,
>> +                                      const int dst_id)
>> +{
>> +       return NULL;
>> +}
>> +
>> +static inline void icc_put(struct icc_path *path)
>> +{
>> +}
>> +
>> +static inline int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
>> +       return 0;
> 
> Should this really succeed?

Yes, it should succeed if the framework is not enabled. The drivers
should handle the case of whether the framework is enabled or not when
icc_get() or of_icc_get() returns NULL. Based on that they should decide
if can continue without interconnect support or not.

BR,
Georgi
