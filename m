From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
Date: Thu, 12 Apr 2018 16:06:06 +0300
Message-ID: <2e1f70b5-e62e-33c2-4bcc-c1414c1083c4@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org>
 <20180406173846.GC130399@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406173846.GC130399@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 04/06/2018 08:38 PM, Matthias Kaehlcke wrote:
> On Fri, Mar 09, 2018 at 11:09:52PM +0200, Georgi Djakov wrote:
>> This patch introduce a new API to get requirements and configure the
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
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  Documentation/interconnect/interconnect.rst |  96 ++++++
>>  drivers/Kconfig                             |   2 +
>>  drivers/Makefile                            |   1 +
>>  drivers/interconnect/Kconfig                |  10 +
>>  drivers/interconnect/Makefile               |   1 +
>>  drivers/interconnect/core.c                 | 489 ++++++++++++++++++++++++++++
>>  include/linux/interconnect-provider.h       | 109 +++++++
>>  include/linux/interconnect.h                |  40 +++
>>  8 files changed, 748 insertions(+)
>>  create mode 100644 Documentation/interconnect/interconnect.rst
>>  create mode 100644 drivers/interconnect/Kconfig
>>  create mode 100644 drivers/interconnect/Makefile
>>  create mode 100644 drivers/interconnect/core.c
>>  create mode 100644 include/linux/interconnect-provider.h
>>  create mode 100644 include/linux/interconnect.h
>>
>> diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
>> new file mode 100644
>> index 000000000000..23eba68e8424
>> --- /dev/null
>> +++ b/Documentation/interconnect/interconnect.rst

[..]

>> +Terminology
>> +-----------
>> +
>> +Interconnect provider is the software definition of the interconnect hardware.
>> +The interconnect providers on the above diagram are M NoC, S NoC, C NoC and Mem
>> +NoC.
> 
> Should P NoC be part of that list?
> 

Yes, it should be!

>> +
>> +Interconnect node is the software definition of the interconnect hardware
>> +port. Each interconnect provider consists of multiple interconnect nodes,
>> +which are connected to other SoC components including other interconnect
>> +providers. The point on the diagram where the CPUs connects to the memory is
>> +called an interconnect node, which belongs to the Mem NoC interconnect provider.
>> +
>> +Interconnect endpoints are the first or the last element of the path. Every
>> +endpoint is a node, but not every node is an endpoint.
>> +
>> +Interconnect path is everything between two endpoints including all the nodes
>> +that have to be traversed to reach from a source to destination node. It may
>> +include multiple master-slave pairs across several interconnect providers.
>> +
>> +Interconnect consumers are the entities which make use of the data paths exposed
>> +by the providers. The consumers send requests to providers requesting various
>> +throughput, latency and priority. Usually the consumers are device drivers, that
>> +send request based on their needs. An example for a consumer is a video decoder
>> +that supports various formats and image sizes.
>> +
>> +Interconnect providers
>> +----------------------

[..]

>> +static void node_aggregate(struct icc_node *node)
>> +{
>> +	struct icc_req *r;
>> +	u32 agg_avg = 0;
> 
> Should this be u64 to avoid overflow in case of a large number of
> constraints and high bandwidths?

These values are proposed to be in kbps and u32 seems to be enough for
now, but in the future we can switch to u64 if needed.

> 
>> +	u32 agg_peak = 0;
>> +
>> +	hlist_for_each_entry(r, &node->req_list, req_node) {
>> +		/* sum(averages) and max(peaks) */
>> +		agg_avg += r->avg_bw;
>> +		agg_peak = max(agg_peak, r->peak_bw);
>> +	}
>> +
>> +	node->avg_bw = agg_avg;
> 
> Is it really intended to store the sum of averages here rather than
> the overall average?

Yes, the intention is to sum all the averages in total, so that the
hardware is set in a state that would be able to handle the total
bandwidth passing through a node.

Also in the next version of this patch i have changed this part a bit,
so that the aggregation could be customized and made platform specific,
as different platforms could use their own aggregation algorithms other
than the default sum/max.

> 
>> +	node->peak_bw = agg_peak;
>> +}
>> +
>> +static void provider_aggregate(struct icc_provider *provider, u32 *avg_bw,
>> +			       u32 *peak_bw)
>> +{
>> +	struct icc_node *n;
>> +	u32 agg_avg = 0;
> 
> See above.
> 
>> +	u32 agg_peak = 0;
>> +
>> +	/* aggregate for the interconnect provider */
>> +	list_for_each_entry(n, &provider->nodes, node_list) {
>> +		/* sum the average and max the peak */
>> +		agg_avg += n->avg_bw;
>> +		agg_peak = max(agg_peak, n->peak_bw);
>> +	}
>> +
>> +	*avg_bw = agg_avg;
> 
> See above.
> 
>> +	*peak_bw = agg_peak;
>> +}
>> +

[..]

>> +/**
>> + * struct icc_node - entity that is part of the interconnect topology
>> + *
>> + * @id: platform specific node id
>> + * @name: node name used in debugfs
>> + * @links: a list of targets where we can go next when traversing
>> + * @num_links: number of links to other interconnect nodes
>> + * @provider: points to the interconnect provider of this node
>> + * @node_list: list of interconnect nodes associated with @provider
>> + * @search_list: list used when walking the nodes graph
>> + * @reverse: pointer to previous node when walking the nodes graph
>> + * @is_traversed: flag that is used when walking the nodes graph
>> + * @req_list: a list of QoS constraint requests associated with this node
>> + * @avg_bw: aggregated value of average bandwidth
>> + * @peak_bw: aggregated value of peak bandwidth
>> + * @data: pointer to private data
>> + */
>> +struct icc_node {
>> +	int			id;
>> +	const char              *name;
>> +	struct icc_node		**links;
>> +	size_t			num_links;
>> +
>> +	struct icc_provider	*provider;
>> +	struct list_head	node_list;
>> +	struct list_head	orphan_list;
> 
> orphan_list is not used (nor documented)

It's not used anymore. Will remove!

Thanks,
Georgi
