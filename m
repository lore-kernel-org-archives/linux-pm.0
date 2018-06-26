From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
Date: Tue, 26 Jun 2018 16:34:27 -0700
Message-ID: <20180626233427.GR129942@google.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620121141.15403-2-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Georgi,

On Wed, Jun 20, 2018 at 03:11:34PM +0300, Georgi Djakov wrote:
> This patch introduce a new API to get requirements and configure the

nit: s/introduce/introduces/

> interconnect buses across the entire chipset to fit with the current
> demand.
> 
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) between endpoints and
> set the desired constraints on this data flow path. The providers receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>
> ...
>
> +static struct icc_path *path_find(struct device *dev, struct icc_node *src,
> +				  struct icc_node *dst)
> +{
> +	struct icc_node *n, *node = NULL;
> +	struct icc_provider *provider;
> +	struct list_head traverse_list;
> +	struct list_head edge_list;
> +	struct list_head visited_list;
> +	size_t i, depth = 0;
> +	bool found = false;
> +	int ret = -EPROBE_DEFER;
> +
> +	INIT_LIST_HEAD(&traverse_list);
> +	INIT_LIST_HEAD(&edge_list);
> +	INIT_LIST_HEAD(&visited_list);
> +
> +	list_add_tail(&src->search_list, &traverse_list);
> +	src->reverse = NULL;
> +
> +	do {
> +		list_for_each_entry_safe(node, n, &traverse_list, search_list) {
> +			if (node == dst) {
> +				found = true;
> +				list_add(&node->search_list, &visited_list);
> +				break;
> +			}
> +			for (i = 0; i < node->num_links; i++) {
> +				struct icc_node *tmp = node->links[i];
> +
> +				if (!tmp) {
> +					ret = -ENOENT;
> +					goto out;
> +				}
> +
> +				if (tmp->is_traversed)
> +					continue;
> +
> +				tmp->is_traversed = true;
> +				tmp->reverse = node;
> +				list_add(&tmp->search_list, &edge_list);
> +			}
> +		}
> +		if (found)
> +			break;
> +
> +		list_splice_init(&traverse_list, &visited_list);
> +		list_splice_init(&edge_list, &traverse_list);
> +
> +		/* count the hops away from the source */
> +		depth++;
> +
> +	} while (!list_empty(&traverse_list));
> +
> +out:
> +	/* reset the traversed state */
> +	list_for_each_entry(provider, &icc_provider_list, provider_list) {
> +		list_for_each_entry(n, &provider->nodes, node_list)
> +			if (n->is_traversed)
> +				n->is_traversed = false;
> +	}
> +
> +	if (found) {
> +		struct icc_path *path = path_allocate(dst, depth);
> +
> +		if (IS_ERR(path))
> +			return path;
> +
> +		/* initialize the path */
> +		for (i = 0; i < path->num_nodes; i++) {
> +			node = path->reqs[i].node;
> +			path->reqs[i].dev = dev;
> +			node->provider->users++;

nit: doing the assignment of path->reqs[i].dev before assiging 'node'
or after incrementing the 'users' would slightly improve readability.

> +static int apply_constraints(struct icc_path *path)
> +{
> +	struct icc_node *next, *prev = NULL;
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < path->num_nodes; i++, prev = next) {
> +		struct icc_provider *p;
> +
> +		next = path->reqs[i].node;
> +		/*
> +		 * Both endpoints should be valid master-slave pairs of the
> +		 * same interconnect provider that will be configured.
> +		 */
> +		if (!prev || next->provider != prev->provider)
> +			continue;
> +
> +		p = next->provider;
> +
> +		aggregate_provider(p);
> +
> +		if (p->set) {
> +			/* set the constraints */
> +			ret = p->set(prev, next, p->avg_bw, p->peak_bw);
> +		}

remove curly brackets

EDIT: actually the condition can be removed, icc_provider_add() fails
when p->set is NULL.

> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> +{
> +	struct icc_node *node;
> +	struct icc_provider *p;
> +	size_t i;
> +	int ret = 0;

initialization is not necessary

> +struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
> +{
> +	struct icc_node *src, *dst;
> +	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> +
> +	src = node_find(src_id);
> +	if (!src) {
> +		dev_err(dev, "%s: invalid src=%d\n", __func__, src_id);
> +		goto out;
> +	}
> +
> +	dst = node_find(dst_id);
> +	if (!dst) {
> +		dev_err(dev, "%s: invalid dst=%d\n", __func__, dst_id);
> +		goto out;
> +	}
> +
> +	mutex_lock(&icc_lock);
> +	path = path_find(dev, src, dst);
> +	mutex_unlock(&icc_lock);
> +	if (IS_ERR(path)) {
> +		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +		goto out;

this goto isn't really needed

> +struct icc_node *icc_node_create(int id)
> +{
> +	struct icc_node *node;
> +
> +	/* check if node already exists */
> +	node = node_find(id);
> +	if (node)
> +		goto out;
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node) {
> +		node = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	mutex_lock(&icc_lock);
> +
> +	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +	if (WARN(id < 0, "couldn't get idr")) {

kfree(node);

> +int icc_node_add(struct icc_node *node, struct icc_provider *provider)
> +{
> +	mutex_lock(&icc_lock);
> +
> +	node->provider = provider;
> +	list_add(&node->node_list, &provider->nodes);
> +
> +	mutex_unlock(&icc_lock);
> +
> +	return 0;
> +}

The function returns always 0. Should probably be void so callers
don't add pointless checks of the return value.

> +int icc_provider_add(struct icc_provider *provider)
> +{
> +	if (WARN_ON(!provider->set))
> +		return -EINVAL;
> +
> +	mutex_init(&icc_lock);

Shouldn't this be mutex_lock()?

> +int icc_provider_del(struct icc_provider *provider)
> +{
> +	mutex_lock(&icc_lock);
> +	if (provider->users) {
> +		pr_warn("interconnect provider still has %d users\n",
> +			provider->users);
> +		mutex_unlock(&icc_lock);
> +		return -EBUSY;
> +	}
> +
> +	if (!list_empty_careful(&provider->nodes)) {
> +		pr_warn("interconnect provider still has nodes\n");
> +		mutex_unlock(&icc_lock);
> +		return -EEXIST;
> +	}

Could this be just list_empty()? If I didn't miss something icc_lock
is held in all paths that change p->nodes (assuming that all changes
should be done through the interfaces in this file).

Actually this check will always fail if icc_node_add() was called for
this provider, it doesn't seem nodes are ever removed.

Cheers

Matthias
