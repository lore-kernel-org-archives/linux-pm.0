From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
Date: Sun, 1 Jul 2018 14:06:21 +0300
Message-ID: <d52877d2-359f-6c79-01b9-739d0b2733ef@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
 <20180626233427.GR129942@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626233427.GR129942@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

Thanks for reviewing!

On 06/27/2018 02:34 AM, Matthias Kaehlcke wrote:
> Hi Georgi,
> 
> On Wed, Jun 20, 2018 at 03:11:34PM +0300, Georgi Djakov wrote:
>> This patch introduce a new API to get requirements and configure the
> 
> nit: s/introduce/introduces/

Thanks!

[..]

>> +	if (found) {
>> +		struct icc_path *path = path_allocate(dst, depth);
>> +
>> +		if (IS_ERR(path))
>> +			return path;
>> +
>> +		/* initialize the path */
>> +		for (i = 0; i < path->num_nodes; i++) {
>> +			node = path->reqs[i].node;
>> +			path->reqs[i].dev = dev;
>> +			node->provider->users++;
> 
> nit: doing the assignment of path->reqs[i].dev before assiging 'node'
> or after incrementing the 'users' would slightly improve readability.

Ok, will re-factor this a bit.

>> +static int apply_constraints(struct icc_path *path)
>> +{
>> +	struct icc_node *next, *prev = NULL;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +		struct icc_provider *p;
>> +
>> +		next = path->reqs[i].node;
>> +		/*
>> +		 * Both endpoints should be valid master-slave pairs of the
>> +		 * same interconnect provider that will be configured.
>> +		 */
>> +		if (!prev || next->provider != prev->provider)
>> +			continue;
>> +
>> +		p = next->provider;
>> +
>> +		aggregate_provider(p);
>> +
>> +		if (p->set) {
>> +			/* set the constraints */
>> +			ret = p->set(prev, next, p->avg_bw, p->peak_bw);
>> +		}
> 
> remove curly brackets
> 
> EDIT: actually the condition can be removed, icc_provider_add() fails
> when p->set is NULL.

Agree!

> 
>> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
>> +	struct icc_node *node;
>> +	struct icc_provider *p;
>> +	size_t i;
>> +	int ret = 0;
> 
> initialization is not necessary
> 

Ok.

>> +struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
>> +{
>> +	struct icc_node *src, *dst;
>> +	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>> +
>> +	src = node_find(src_id);
>> +	if (!src) {
>> +		dev_err(dev, "%s: invalid src=%d\n", __func__, src_id);
>> +		goto out;
>> +	}
>> +
>> +	dst = node_find(dst_id);
>> +	if (!dst) {
>> +		dev_err(dev, "%s: invalid dst=%d\n", __func__, dst_id);
>> +		goto out;
>> +	}
>> +
>> +	mutex_lock(&icc_lock);
>> +	path = path_find(dev, src, dst);
>> +	mutex_unlock(&icc_lock);
>> +	if (IS_ERR(path)) {
>> +		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>> +		goto out;
> 
> this goto isn't really needed

Ok.

>> +struct icc_node *icc_node_create(int id)
>> +{
>> +	struct icc_node *node;
>> +
>> +	/* check if node already exists */
>> +	node = node_find(id);
>> +	if (node)
>> +		goto out;
>> +
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node) {
>> +		node = ERR_PTR(-ENOMEM);
>> +		goto out;
>> +	}
>> +
>> +	mutex_lock(&icc_lock);
>> +
>> +	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
>> +	if (WARN(id < 0, "couldn't get idr")) {
> 
> kfree(node);

Thanks!

>> +int icc_node_add(struct icc_node *node, struct icc_provider *provider)
>> +{
>> +	mutex_lock(&icc_lock);
>> +
>> +	node->provider = provider;
>> +	list_add(&node->node_list, &provider->nodes);
>> +
>> +	mutex_unlock(&icc_lock);
>> +
>> +	return 0;
>> +}
> 
> The function returns always 0. Should probably be void so callers
> don't add pointless checks of the return value.

Agree, will change it!

>> +int icc_provider_add(struct icc_provider *provider)
>> +{
>> +	if (WARN_ON(!provider->set))
>> +		return -EINVAL;
>> +
>> +	mutex_init(&icc_lock);
> 
> Shouldn't this be mutex_lock()?

Yes, right!

>> +int icc_provider_del(struct icc_provider *provider)
>> +{
>> +	mutex_lock(&icc_lock);
>> +	if (provider->users) {
>> +		pr_warn("interconnect provider still has %d users\n",
>> +			provider->users);
>> +		mutex_unlock(&icc_lock);
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (!list_empty_careful(&provider->nodes)) {
>> +		pr_warn("interconnect provider still has nodes\n");
>> +		mutex_unlock(&icc_lock);
>> +		return -EEXIST;
>> +	}
> 
> Could this be just list_empty()? If I didn't miss something icc_lock
> is held in all paths that change p->nodes (assuming that all changes
> should be done through the interfaces in this file).

It could be. Will update it. I just always want to be careful!

> Actually this check will always fail if icc_node_add() was called for
> this provider, it doesn't seem nodes are ever removed.
> 

The provider driver is responsible for the node removal.

Thanks,
Georgi
