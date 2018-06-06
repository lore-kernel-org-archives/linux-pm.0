From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
Date: Wed, 6 Jun 2018 18:08:19 +0300
Message-ID: <3f0e5606-c28d-6bd9-387e-23be1d0185fc@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org>
 <CAHLCerNmBAbu4UcQ+uksXN8z-o-kxLct9ryfy5qBY0Z2jDNRGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHLCerNmBAbu4UcQ+uksXN8z-o-kxLct9ryfy5qBY0Z2jDNRGg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Saravana Kannan <skannan@codeaurora.org>, seansw@qti.qualcomm.com, khilman@baylibre.com, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, davidai@quicinc.com, Vincent Guittot <vincent.guittot@linaro.org>, lakml <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Amit,

On 25.05.18 г. 11:26, Amit Kucheria wrote:
> On Fri, Mar 9, 2018 at 11:09 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
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
[..]

>> +Interconnect consumers
>> +----------------------
>> +
>> +Interconnect consumers are the clients which use the interconnect APIs to
>> +get paths between endpoints and set their bandwidth/latency/QoS requirements
>> +for these interconnect paths.
>> +
> 
> This document is missing a section on the locking semantics of the
> framework. Does the core ensure that the entire path is locked for
> set() to propagate?

Yes, the core will ensure that the path is locked. Will add this to the
function description.

[..]

>> +
>> +static int path_init(struct icc_path *path)
>> +{
>> +       struct icc_node *node;
>> +       size_t i;
>> +
>> +       for (i = 0; i < path->num_nodes; i++) {
>> +               node = path->reqs[i].node;
>> +
>> +               mutex_lock(&node->provider->lock);
>> +               node->provider->users++;
>> +               mutex_unlock(&node->provider->lock);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
> 
> Consider adding some comments for node_aggregate and
> provider_aggregate's aggregation algorithm
> 
> "We want the path to honor all bandwidth requests, so the average
> bandwidth requirements from each consumer are aggregated at each node
> and provider level. The peak bandwidth requirements will then be the
> highest of all the peak bw requests"
> 
> or something to the effect that.

Ok, thanks.

>> +static void node_aggregate(struct icc_node *node)
>> +{
>> +       struct icc_req *r;
>> +       u32 agg_avg = 0;
>> +       u32 agg_peak = 0;
>> +
>> +       hlist_for_each_entry(r, &node->req_list, req_node) {
>> +               /* sum(averages) and max(peaks) */
>> +               agg_avg += r->avg_bw;
>> +               agg_peak = max(agg_peak, r->peak_bw);
>> +       }
>> +
>> +       node->avg_bw = agg_avg;
>> +       node->peak_bw = agg_peak;
>> +}
>> +
>> +static void provider_aggregate(struct icc_provider *provider, u32 *avg_bw,
>> +                              u32 *peak_bw)
>> +{
>> +       struct icc_node *n;
>> +       u32 agg_avg = 0;
>> +       u32 agg_peak = 0;
>> +
>> +       /* aggregate for the interconnect provider */
> 
> You could get rid of this, the function name says as much.

Ok.

>> +       list_for_each_entry(n, &provider->nodes, node_list) {
>> +               /* sum the average and max the peak */
>> +               agg_avg += n->avg_bw;
>> +               agg_peak = max(agg_peak, n->peak_bw);
>> +       }
>> +
>> +       *avg_bw = agg_avg;
>> +       *peak_bw = agg_peak;
>> +}
>> +
>> +static int constraints_apply(struct icc_path *path)
>> +{
>> +       struct icc_node *next, *prev = NULL;
>> +       int i;
>> +
>> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +               struct icc_provider *provider;
>> +               u32 avg_bw = 0;
>> +               u32 peak_bw = 0;
>> +               int ret;
>> +
>> +               next = path->reqs[i].node;
>> +               /*
>> +                * Both endpoints should be valid master-slave pairs of the
>> +                * same interconnect provider that will be configured.
>> +                */
>> +               if (!next || !prev)
>> +                       continue;
>> +
>> +               if (next->provider != prev->provider)
>> +                       continue;
>> +
>> +               provider = next->provider;
>> +               mutex_lock(&provider->lock);
>> +
>> +               /* aggregate requests for the provider */
> 
> Get rid of comment.

Ok.

>> +               provider_aggregate(provider, &avg_bw, &peak_bw);
>> +
>> +               if (provider->set) {
>> +                       /* set the constraints */
>> +                       ret = provider->set(prev, next, avg_bw, peak_bw);
>> +               }
>> +
>> +               mutex_unlock(&provider->lock);
>> +
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * icc_set() - set constraints on an interconnect path between two endpoints
>> + * @path: reference to the path returned by icc_get()
>> + * @avg_bw: average bandwidth in kbps
>> + * @peak_bw: peak bandwidth in kbps
>> + *
>> + * This function is used by an interconnect consumer to express its own needs
>> + * in term of bandwidth and QoS for a previously requested path between two
>> + * endpoints. The requests are aggregated and each node is updated accordingly.
>> + *
>> + * Returns 0 on success, or an approproate error code otherwise.
> 
> *appropriate*

Ok.

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
> 
> 
>> + * @avg_bw: aggregated value of average bandwidth
>> + * @peak_bw: aggregated value of peak bandwidth
> 
> Consider changing to "aggregated value of {average|peak} bandwidth
> requests from all consumers"

Ok, will clarify.

Thanks,
Georgi
