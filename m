From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
Date: Sun, 1 Jul 2018 14:03:32 +0300
Message-ID: <891a2332-8744-bd64-4a0b-047e8a71ab38@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
 <CAE=gft4sSdFL7J27WdTuYCtfLPAyv8xOAizYhmtfK5UkTbP5-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAE=gft4sSdFL7J27WdTuYCtfLPAyv8xOAizYhmtfK5UkTbP5-A@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Evan Green <evgreen@chromium.org>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org, Saravana Kannan <skannan@codeaurora.org>, abailon@baylibre.com, khilman@baylibre.com, linux-arm-msm@vger.kernel.org, daidavid1@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Evan,

Thanks for reviewing!

On 06/26/2018 11:57 PM, Evan Green wrote:
> Hi Georgi. Thanks for the new spin of this.
> 
> On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
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

[..]

>> +
>> +static struct icc_node *node_find(const int id)
>> +{
>> +       struct icc_node *node;
>> +
>> +       mutex_lock(&icc_lock);
>> +       node = idr_find(&icc_idr, id);
>> +       mutex_unlock(&icc_lock);
> 
> I wonder if this is too low of a level to be dealing with the lock. I
> notice that everywhere you use this function, you afterwards
> immediately grab the lock and do more stuff. Maybe this function
> should have a comment saying it assumes the lock is already held, and
> then you can grab the lock in the callers, since you're doing that
> anyway.

Ok, will try to do better next time.

>> +
>> +       return node;
>> +}
>> +
>> +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
>> +{
>> +       struct icc_node *node = dst;
>> +       struct icc_path *path;
>> +       size_t i;
>> +
>> +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
>> +                      GFP_KERNEL);
>> +       if (!path)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       path->num_nodes = num_nodes;
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
>> +
>> +               path->reqs[i].node = node;
>> +               /* reference to previous node was saved during path traversal */
>> +               node = node->reverse;
>> +       }
>> +
>> +       return path;
>> +}
>> +
>> +static struct icc_path *path_find(struct device *dev, struct icc_node *src,
>> +                                 struct icc_node *dst)
>> +{
> 
> I personally prefer a comment somewhere indicating that this function
> assumes icc_lock is already held. Not sure if that's conventional or
> not.
> 

Right, Rob and Matthias have also provided useful feedback on this! Thanks!

[..]

>> +       /* reset the traversed state */
>> +       list_for_each_entry(provider, &icc_provider_list, provider_list) {
>> +               list_for_each_entry(n, &provider->nodes, node_list)
>> +                       if (n->is_traversed)
>> +                               n->is_traversed = false;
> 
> Remove the conditional, just set is_traversed to false.
> 

Agree.

>> +       }
>> +
>> +       if (found) {
>> +               struct icc_path *path = path_allocate(dst, depth);
> 
> Is the path supposed to include the source? For instance, if the dst
> were a neighbor, depth would be one, so only dst would be in the path.
> It seems like it might be worthwhile to have the source in there too.

Agree that it would be logical to include the complete path. Will fix
the depth.

>> +
>> +               if (IS_ERR(path))
>> +                       return path;
>> +
>> +               /* initialize the path */
>> +               for (i = 0; i < path->num_nodes; i++) {
>> +                       node = path->reqs[i].node;
>> +                       path->reqs[i].dev = dev;
>> +                       node->provider->users++;
> 
> Should this loop live inside path_allocate? I'm unsure, but maybe at
> least path->reqs[i].dev = dev, since it feels like standard
> initialization of the path.
> 

Ok, will move it and also change the function name from path_allocate()
to path_init().

>> +
>> +/**
>> + * icc_put() - release the reference to the icc_path
>> + * @path: interconnect path
>> + *
>> + * Use this function to release the constraints on a path when the path is
>> + * no longer needed. The constraints will be re-aggregated.
>> + */
>> +void icc_put(struct icc_path *path)
>> +{
>> +       struct icc_node *node;
>> +       size_t i;
>> +       int ret;
>> +
>> +       if (!path || WARN_ON_ONCE(IS_ERR(path)))
> 
> Why only once?
> 

Will change to WARN_ON.

[..]

>> +void icc_node_remove(int id)
>> +{
>> +       struct icc_node *node;
>> +
>> +       node = node_find(id);
>> +       if (node) {
>> +               mutex_lock(&icc_lock);
>> +               idr_remove(&icc_idr, node->id);
> 
> Should we throw a warning if there are any paths that go through this
> node (ie req_list is non-empty)?
> 

Sounds good, will do it.
>> +               mutex_unlock(&icc_lock);
>> +       }
>> +
>> +       kfree(node);
>> +}
>> +EXPORT_SYMBOL_GPL(icc_node_remove);

[..]

>> +/**
>> + * icc_link_remove() - remove a link between two nodes
>> + * @src: pointer to source node
>> + * @dst: pointer to destination node
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_link_remove(struct icc_node *src, struct icc_node *dst)
>> +{
>> +       struct icc_node **new;
>> +       int ret = 0;
>> +       int i, j;
>> +
>> +       if (IS_ERR_OR_NULL(src))
>> +               return PTR_ERR(src);
>> +
>> +       if (IS_ERR_OR_NULL(dst))
>> +               return PTR_ERR(dst);
> 
> I wonder if we should return a fixed error in these cases like
> -EINVAL, rather than handing through whatever crazy value is in
> src/dst.

Ok, agree.

>> +
>> +       mutex_lock(&icc_lock);
>> +
>> +       new = krealloc(src->links,
>> +                      (src->num_links - 1) * sizeof(*src->links),
>> +                      GFP_KERNEL);
>> +       if (!new) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       for (i = 0, j = 0; j < src->num_links; j++) {
>> +               if (src->links[j] == dst)
>> +                       continue;
>> +
>> +               new[i++] = src->links[j];
>> +       }
>> +
>> +       src->links = new;
>> +       src->num_links--;
> 
> My understanding is that once you call realloc and it succeeds, you
> must assume your old memory is gone and your new memory is only as big
> as the new size you request. So you shouldn't call krealloc until
> you've fixed the array up. Is the order of the links array important?
> If not, you could just take the element at the end and stick it in the
> slot that's being deleted. Then decrease the size and do your realloc.

Sorry, this was obviously untested. Your suggestions is good.

[..]

>> +
>> +/**
>> + * icc_provider_del() - delete previously added interconnect provider
>> + * @icc_provider: the interconnect provider that will be removed from topology
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_provider_del(struct icc_provider *provider)
>> +{
>> +       mutex_lock(&icc_lock);
>> +       if (provider->users) {
>> +               pr_warn("interconnect provider still has %d users\n",
>> +                       provider->users);
>> +               mutex_unlock(&icc_lock);
>> +               return -EBUSY;
>> +       }
>> +
>> +       if (!list_empty_careful(&provider->nodes)) {
>> +               pr_warn("interconnect provider still has nodes\n");
>> +               mutex_unlock(&icc_lock);
>> +               return -EEXIST;
> 
> How come you're returning different error codes for these two cases?
> The error in both cases is effectively "you failed to clean up after
> yourself", so maybe EBUSY makes sense for both of them. The pr_warn
> helps to differentiate between the two for debugging.

Ok.

>> +       }
>> +
>> +       list_del(&provider->provider_list);
>> +       mutex_unlock(&icc_lock);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_provider_del);
>> +

[..]

>> +struct icc_node {
>> +       int                     id;
>> +       const char              *name;
>> +       struct icc_node         **links;
>> +       size_t                  num_links;
>> +
>> +       struct icc_provider     *provider;
>> +       struct list_head        node_list;
>> +       struct list_head        orphan_list;
> 
> Is this used?

Ah, I thought I had already removed it!

>> +       struct list_head        search_list;
>> +       struct icc_node         *reverse;
>> +       bool                    is_traversed;
>> +       struct hlist_head       req_list;
>> +       u32                     avg_bw;
>> +       u32                     peak_bw;
>> +       void                    *data;
>> +};
>> +

[..]

>> +static inline int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
>> +       return 0;
> 
> I was originally going to suggest that this should return a failure.
> Then I talked myself out of it, saying that if the interconnect
> framework is not compiled in, then clients should assume all their bus
> needs are already met. I guess this is the correct assumption?

Yes, exactly!

Thanks,
Georgi
