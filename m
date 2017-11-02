From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 1/3] interconnect: Add generic on-chip interconnect API
Date: Thu, 2 Nov 2017 18:00:42 +0200
Message-ID: <26225878-8fed-b990-d02f-5253190de77a@linaro.org>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
 <20170908171830.13813-2-georgi.djakov@linaro.org>
 <CAHLCerOKEY_My9OKDMV_ns3dTAgBMPkRS2hdS7iYwFoX5rxOPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:54698 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbdKBQAu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2017 12:00:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id a2so7095883lfh.11
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2017 09:00:49 -0700 (PDT)
In-Reply-To: <CAHLCerOKEY_My9OKDMV_ns3dTAgBMPkRS2hdS7iYwFoX5rxOPA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, robh+dt@kernel.org, khilman@baylibre.com, Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, seansw@qti.qualcomm.com, davidai@quicinc.com, LKML <linux-kernel@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi Amit,

On 11/02/2017 09:28 AM, Amit Kucheria wrote:
[..>> +Interconnect node is the software definition of the interconnect
hardware
>> +port. Each interconnect provider consists of multiple interconnect nodes,
>> +which are connected to other SoC components including other interconnect
>> +providers. The point on the diagram where the CPUs connects to the memory is
>> +called an interconnect node, which belongs to the Mem NoC interconnect provider.
>> +
>> +Interconnect endpoits are the first or the last element of the path. Every
> 
> s/endpoits/endpoints
> 

Ok!

>> +endpoint is a node, but not every node is an endpoint.
>> +
>> +Interconnect path is everything between two endpoints including all the nodes
>> +that have to be traversed to reach from a source to destination node. It may
>> +include multiple master-slave pairs across several interconnect providers.
>> +
>> +Interconnect consumers are the entities which make use of the data paths exposed
>> +by the providers. The consumers send requests to providers requesting various
>> +throughput, latency and priority. Usually the consumers are device drivers, that
>> +send request based on their needs. An example for a consumer is a a video
> 
> typo: is a video>

Ok!

[..]
>> +/**
>> + * interconnect_set() - set constraints on a path between two endpoints
>> + * @path: reference to the path returned by interconnect_get()
>> + * @creq: request from the consumer, containing its requirements
>> + *
>> + * This function is used by an interconnect consumer to express its own needs
>> + * in term of bandwidth and QoS for a previously requested path between two
>> + * endpoints. The requests are aggregated and each node is updated accordingly.
>> + *
>> + * Returns 0 on success, or an approproate error code otherwise.
>> + */
>> +int interconnect_set(struct interconnect_path *path,
>> +                    struct interconnect_creq *creq)
>> +{
>> +       struct interconnect_node *next, *prev = NULL;
>> +       size_t i;
>> +       int ret = 0;
>> +
>> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +               next = path->reqs[i].node;
>> +
>> +               /*
>> +                * Both endpoints should be valid and master-slave pairs of
> 
> Losing the 'and' improves readability.
> 

Ok!

>> +                * the same interconnect provider that will be configured.
>> +                */
>> +               if (!next || !prev)
>> +                       continue;
>> +               if (next->icp != prev->icp)
>> +                       continue;
>> +
>> +               mutex_lock(&next->icp->lock);
>> +
>> +               /* update the consumer request for this path */
>> +               path->reqs[i].avg_bw = creq->avg_bw;
>> +               path->reqs[i].peak_bw = creq->peak_bw;
>> +
>> +               /* aggregate all requests */
>> +               interconnect_aggregate_icn(next);
>> +               interconnect_aggregate_icp(next->icp);
>> +
>> +               if (next->icp->ops->set) {
>> +                       /* commit the aggregated constraints */
>> +                       ret = next->icp->ops->set(prev, next, &next->icp->creq);
>> +               }
> 
> A comment here on how the contraints are propagated along the path
> would be good. At the moment, this seems to go to each provider along
> the path, take the provider lock and set the new constraints, then
> move on to the next provider. Is there any need to make the changes
> along the entire path "atomic"?

Yes, the above is correct. There is no such need at least for the
hardware i am currently playing with. We can add support for that later
if needed.

> 
> I'm trying to understand what happens in the case where a new request
> comes along while the previous path is still be traversed.

It just gets aggregated and set and this seems to not be an issue as the
paths are valid. Now I am trying to keep it simple and if anything needs
serialization we can add some locking later.

> 
>> +               mutex_unlock(&next->icp->lock);
>> +               if (ret)
>> +                       goto out;
>> +       }
>> +
>> +out:
>> +       return ret;
>> +}
>> +
>> +/**
>> + * interconnect_get() - return a handle for path between two endpoints
> 
> This is not used currently by the msm8916 platform driver? Is this
> expected to be called by leaf device drivers or by higher layer bus
> drivers? I suspect a mix of the two, but an example would be nice.

This is called by a consumer driver to express its for example bandwidth
needs between various endpoints. Will add some examples.

[..]
>> +/**
>> + * struct icp - interconnect provider (controller) entity that might
>> + * provide multiple interconnect controls
>> + *
>> + * @icp_list: list of the registered interconnect providers
>> + * @nodes: internal list of the interconnect provider nodes
>> + * @ops: pointer to device specific struct icp_ops
>> + * @dev: the device this interconnect provider belongs to
>> + * @lock: a lock to protect creq and users
>> + * @creq: the actual state of constraints for this interconnect provider
>> + * @users: count of active users
>> + * @data: pointer to private data
>> + */
>> +struct icp {
>> +       struct list_head        icp_list;
>> +       struct list_head        nodes;
>> +       const struct icp_ops    *ops;
>> +       struct device           *dev;
>> +       struct mutex            lock;
>> +       struct interconnect_creq creq;
>> +       int                     users;
>> +       void                    *data;
>> +};
> 
> Use interconnect_provider here instead of icp for the sake of
> consistency. Same for icp_ops. Or replace everything with any of the
> other suggested alternatives. My suggestion to the name pool is 'xcon'
> where x == inter.

Yes i am working on better naming, thanks!

BR,
Georgi
