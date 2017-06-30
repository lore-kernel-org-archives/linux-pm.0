From: Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/3] interconnect: Add generic interconnect controller
 API
Date: Fri, 30 Jun 2017 15:52:13 +0300
Message-ID: <93a7ab62-8b64-a757-1b5f-9a8bdd1751a4@linaro.org>
References: <20170627174903.27978-1-georgi.djakov@linaro.org>
 <20170627174903.27978-2-georgi.djakov@linaro.org>
 <CAKfTPtCLf-JAKM5MD-pe-az3xUF_4nYtYvnsZpztmtaqk0C4PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKfTPtCLf-JAKM5MD-pe-az3xUF_4nYtYvnsZpztmtaqk0C4PQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, mturquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Sweeney, Sean" <seansw-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, "Dai, David" <davidai-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Vincent,

On 06/28/2017 08:45 PM, Vincent Guittot wrote:
> Hi Georgi,
> 
> On 27 June 2017 at 19:49, Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> 
> [snip]
> 
>> +
>> +static int interconnect_aggregate(struct interconnect_node *node,
>> +                                 struct interconnect_creq *creq)
>> +{
>> +       int ret = 0;
>> +
>> +       mutex_lock(&node->icp->lock);
>> +
>> +       if (node->icp->ops->aggregate) {
>> +               ret = node->icp->ops->aggregate(node, creq);
>> +               if (ret) {
>> +                       pr_info("%s: error (%d)\n", __func__, ret);
>> +                       goto out;
>> +               }
>> +       } else {
>> +               /* do not aggregate by default */
>> +               struct icp *icp = node->icp;
>> +
>> +               icp->creq.avg_bw = creq->avg_bw;
>> +               icp->creq.peak_bw = creq->peak_bw;
> 
> Does it means that by default the last caller defines the bandwidth
> for everybody ?
> IMHO, having a default aggregation policy that sums the avg_bw of all
> request of the node
> and that gets the max of peak_bw of all request of a node is better
> 

Yes, i had this in one of the previous versions, but then i removed the
aggregation by default. Will put it back. Thanks!

>> +       }
>> +
>> +out:
>> +       mutex_unlock(&node->icp->lock);
>> +       return ret;
>> +}
>> +
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
>> +               if (!next || !prev)
> 
> This needs a comment with an explanation about why you don't do
> anything in this case

Ok.

> 
>> +                       continue;
>> +
>> +               if (next->icp != prev->icp)
> 
> This needs a comment with an explanation about why you don't do
> anything in this case

Ok.

> 
>> +                       continue;
>> +
>> +               /* aggregate requests from consumers */
> 
> you should update the path->reqs[i].avg_bw and path->reqs[i].peak_bw
> with creq values
> before aggregating the requests from the different consumer of a node ?
> 
>               path->reqs[i].avg_bw = creq->avg_bw
>               path->reqs[i].peak_bw = creq->peak_bw

I am updating them currently in the vendor implementation of the
aggregate() function, but this was probably not the right place,
so i will move it here instead. Thanks for the comments!

BR,
Georgi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
