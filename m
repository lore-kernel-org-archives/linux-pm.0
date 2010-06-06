From: mark gross <640e9920@gmail.com>
Subject: Re: [RFC] pm_qos: reimplement using plists
Date: Sun, 6 Jun 2010 14:39:54 -0700
Message-ID: <20100606213954.GD8610@gvim.org>
References: <1275760688.7227.10.camel@mulgrave.site>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275760688.7227.10.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 05, 2010 at 12:58:08PM -0500, James Bottomley wrote:
> A lot of the pm_qos extremal value handling is really duplicating what a
> priority ordered list does, just in a less efficient fashion.  Simply
> redoing the implementation in terms of a plist gets rid of a lot of this
> junk (although there are several other strange things that could do with
> tidying up, like pm_qos_request_list has to carry the pm_qos_class with
> every node, simply because it doesn't get passed in to
> pm_qos_update_request even though every caller knows full well what
> parameter it's updating).
> 
> I think this redo is a win independent of android, so we should do
> something like this now.
> 
> There is one nasty that should probably be fixed in plists not open
> coded here: plist_first gives the highest priority value, but there's no
> corresponding API to give the lowest (even though you can get it from
> the head.nodes_list.prev) ... if the sched people are OK, I'll correct
> this with the final patch set.
> 
> James
> 
> ---
> 
>  kernel/pm_qos_params.c |  152 +++++++++++++++++++++++-------------------------
>  1 files changed, 73 insertions(+), 79 deletions(-)
> 
> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> index f42d3f7..241fa79 100644
> --- a/kernel/pm_qos_params.c
> +++ b/kernel/pm_qos_params.c
> @@ -30,6 +30,7 @@
>  /*#define DEBUG*/
>  
>  #include <linux/pm_qos_params.h>
> +#include <linux/plist.h>
>  #include <linux/sched.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> @@ -49,58 +50,51 @@
>   * held, taken with _irqsave.  One lock to rule them all
>   */
>  struct pm_qos_request_list {
> -	struct list_head list;
> -	union {
> -		s32 value;
> -		s32 usec;
> -		s32 kbps;
> -	};
> +	struct plist_node list;
>  	int pm_qos_class;
>  };
>  
> -static s32 max_compare(s32 v1, s32 v2);
> -static s32 min_compare(s32 v1, s32 v2);
> +enum pm_qos_type {
> +	PM_QOS_MAX,		/* return the largest value */
> +	PM_QOS_MIN,		/* return the smallest value */
> +};
>  
>  struct pm_qos_object {
> -	struct pm_qos_request_list requests;
> +	struct plist_head requests;
>  	struct blocking_notifier_head *notifiers;
>  	struct miscdevice pm_qos_power_miscdev;
>  	char *name;
>  	s32 default_value;
> -	atomic_t target_value;
> -	s32 (*comparitor)(s32, s32);
> +	enum pm_qos_type type;
>  };
>  
>  static struct pm_qos_object null_pm_qos;
>  static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
>  static struct pm_qos_object cpu_dma_pm_qos = {
> -	.requests = {LIST_HEAD_INIT(cpu_dma_pm_qos.requests.list)},
> +	.requests = {_PLIST_HEAD_INIT(cpu_dma_pm_qos.requests)},
>  	.notifiers = &cpu_dma_lat_notifier,
>  	.name = "cpu_dma_latency",
>  	.default_value = 2000 * USEC_PER_SEC,
> -	.target_value = ATOMIC_INIT(2000 * USEC_PER_SEC),
> -	.comparitor = min_compare
> +	.type = PM_QOS_MIN,
>  };
>  
>  static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
>  static struct pm_qos_object network_lat_pm_qos = {
> -	.requests = {LIST_HEAD_INIT(network_lat_pm_qos.requests.list)},
> +	.requests = {_PLIST_HEAD_INIT(network_lat_pm_qos.requests)},
>  	.notifiers = &network_lat_notifier,
>  	.name = "network_latency",
>  	.default_value = 2000 * USEC_PER_SEC,
> -	.target_value = ATOMIC_INIT(2000 * USEC_PER_SEC),
> -	.comparitor = min_compare
> +	.type = PM_QOS_MIN
>  };
>  
>  
>  static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
>  static struct pm_qos_object network_throughput_pm_qos = {
> -	.requests = {LIST_HEAD_INIT(network_throughput_pm_qos.requests.list)},
> +	.requests = {_PLIST_HEAD_INIT(network_throughput_pm_qos.requests)},
>  	.notifiers = &network_throughput_notifier,
>  	.name = "network_throughput",
>  	.default_value = 0,
> -	.target_value = ATOMIC_INIT(0),
> -	.comparitor = max_compare
> +	.type = PM_QOS_MAX,
>  };
>  
>  
> @@ -124,46 +118,40 @@ static const struct file_operations pm_qos_power_fops = {
>  	.release = pm_qos_power_release,
>  };
>  
> -/* static helper functions */
> -static s32 max_compare(s32 v1, s32 v2)
> +/* unlocked internal variant */
> +static inline int pm_qos_get_value(struct pm_qos_object *o)
>  {
> -	return max(v1, v2);
> -}
> +	if (plist_head_empty(&o->requests))
> +		return o->default_value;
>  
> -static s32 min_compare(s32 v1, s32 v2)
> -{
> -	return min(v1, v2);
> -}
> +	switch (o->type) {
> +	case PM_QOS_MIN:
> +		return list_entry(o->requests.node_list.prev, struct plist_node, plist.node_list)->prio;
>  
> +	case PM_QOS_MAX:
> +		return plist_first(&o->requests)->prio;
> +	}
> +}
>  
> -static void update_target(int pm_qos_class)
> +static void update_target(struct pm_qos_object *o, struct plist_node *node,
> +			  int del)
>  {
> -	s32 extreme_value;
> -	struct pm_qos_request_list *node;
>  	unsigned long flags;
> -	int call_notifier = 0;
> +	int prev_value, curr_value;
>  
>  	spin_lock_irqsave(&pm_qos_lock, flags);
> -	extreme_value = pm_qos_array[pm_qos_class]->default_value;
> -	list_for_each_entry(node,
> -			&pm_qos_array[pm_qos_class]->requests.list, list) {
> -		extreme_value = pm_qos_array[pm_qos_class]->comparitor(
> -				extreme_value, node->value);
> -	}
> -	if (atomic_read(&pm_qos_array[pm_qos_class]->target_value) !=
> -			extreme_value) {
> -		call_notifier = 1;
> -		atomic_set(&pm_qos_array[pm_qos_class]->target_value,
> -				extreme_value);
> -		pr_debug(KERN_ERR "new target for qos %d is %d\n", pm_qos_class,
> -			atomic_read(&pm_qos_array[pm_qos_class]->target_value));
> -	}
> +	prev_value = pm_qos_get_value(o);
> +	if (del)
> +		plist_del(node, &o->requests);
> +	else
> +		plist_add(node, &o->requests);
> +	curr_value = pm_qos_get_value(o);
>  	spin_unlock_irqrestore(&pm_qos_lock, flags);
>  
> -	if (call_notifier)
> -		blocking_notifier_call_chain(
> -				pm_qos_array[pm_qos_class]->notifiers,
> -					(unsigned long) extreme_value, NULL);
> +	if (prev_value != curr_value)
> +		blocking_notifier_call_chain(o->notifiers,
> +					     (unsigned long)curr_value,
> +					     NULL);
>  }
>  
>  static int register_pm_qos_misc(struct pm_qos_object *qos)
> @@ -196,7 +184,14 @@ static int find_pm_qos_object_by_minor(int minor)
>   */
>  int pm_qos_request(int pm_qos_class)
>  {
> -	return atomic_read(&pm_qos_array[pm_qos_class]->target_value);
> +	unsigned long flags;
> +	int value;
> +
> +	spin_lock_irqsave(&pm_qos_lock, flags);
> +	value = pm_qos_get_value(pm_qos_array[pm_qos_class]);
> +	spin_unlock_irqrestore(&pm_qos_lock, flags);
> +
> +	return value;
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_request);
>  
> @@ -214,21 +209,19 @@ EXPORT_SYMBOL_GPL(pm_qos_request);
>  struct pm_qos_request_list *pm_qos_add_request(int pm_qos_class, s32 value)
>  {
>  	struct pm_qos_request_list *dep;
> -	unsigned long flags;
>  
>  	dep = kzalloc(sizeof(struct pm_qos_request_list), GFP_KERNEL);
>  	if (dep) {
> +		struct pm_qos_object *o =  pm_qos_array[pm_qos_class];
> +		int new_value;
> +
>  		if (value == PM_QOS_DEFAULT_VALUE)
> -			dep->value = pm_qos_array[pm_qos_class]->default_value;
> +			new_value = o->default_value;
>  		else
> -			dep->value = value;
> +			new_value = value;
> +		plist_node_init(&dep->list, new_value);
>  		dep->pm_qos_class = pm_qos_class;
> -
> -		spin_lock_irqsave(&pm_qos_lock, flags);
> -		list_add(&dep->list,
> -			&pm_qos_array[pm_qos_class]->requests.list);
> -		spin_unlock_irqrestore(&pm_qos_lock, flags);
> -		update_target(pm_qos_class);
> +		update_target(o, &dep->list, 0);
>  	}
>  
>  	return dep;
> @@ -251,22 +244,27 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
>  	unsigned long flags;
>  	int pending_update = 0;
>  	s32 temp;
> +	struct pm_qos_object *o;
>  
> -	if (pm_qos_req) { /*guard against callers passing in null */
> -		spin_lock_irqsave(&pm_qos_lock, flags);
> -		if (new_value == PM_QOS_DEFAULT_VALUE)
> -			temp = pm_qos_array[pm_qos_req->pm_qos_class]->default_value;
> -		else
> -			temp = new_value;
> +	if (!pm_qos_req) /*guard against callers passing in null */
> +		return;

need a better test to see if the pm_qos_req is in the plist or not as we
move to a caller allocated design.

>  
> -		if (temp != pm_qos_req->value) {
> -			pending_update = 1;
> -			pm_qos_req->value = temp;
> -		}
> +	o = pm_qos_array[pm_qos_req->pm_qos_class];
> +
> +	if (new_value == PM_QOS_DEFAULT_VALUE)
> +		temp = o->default_value;
> +	else
> +		temp = new_value;
> +
> +	if (temp != pm_qos_req->list.prio) {
> +		pending_update = 1;
> +		spin_lock_irqsave(&pm_qos_lock, flags);
> +		plist_del(&pm_qos_req->list, &o->requests);
> +		plist_node_init(&pm_qos_req->list, temp);
>  		spin_unlock_irqrestore(&pm_qos_lock, flags);
> -		if (pending_update)
> -			update_target(pm_qos_req->pm_qos_class);
>  	}
> +	if (pending_update)
> +		update_target(o, &pm_qos_req->list, 0);
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_update_request);
>  
> @@ -280,19 +278,15 @@ EXPORT_SYMBOL_GPL(pm_qos_update_request);
>   */
>  void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
>  {
> -	unsigned long flags;
> -	int qos_class;
> +	struct pm_qos_object *o;
>  
>  	if (pm_qos_req == NULL)
>  		return;
>  		/* silent return to keep pcm code cleaner */

need a way to tell if the request is in the list or not so we don't
crater removing a plist node that isn't in the list.

>  
> -	qos_class = pm_qos_req->pm_qos_class;
> -	spin_lock_irqsave(&pm_qos_lock, flags);
> -	list_del(&pm_qos_req->list);
> +	o = pm_qos_array[pm_qos_req->pm_qos_class];
> +	update_target(o, &pm_qos_req->list, 1);
>  	kfree(pm_qos_req);
> -	spin_unlock_irqrestore(&pm_qos_lock, flags);
> -	update_target(qos_class);
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_remove_request);
>

I like it.

--mgross
  
