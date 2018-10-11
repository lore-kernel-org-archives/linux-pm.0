From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [workqueue/driver-core PATCH v2 2/5] async: Add support for
 queueing on specific NUMA node
Date: Thu, 11 Oct 2018 12:47:40 +0200
Message-ID: <20181011104740.GB30183@kroah.com>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230747.10609.15866.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010230747.10609.15866.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: tj@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 04:08:21PM -0700, Alexander Duyck wrote:
> This patch introduces four new variants of the async_schedule_ functions
> that allow scheduling on a specific NUMA node.
> 
> The first two functions are async_schedule_near and
> async_schedule_near_domain which end up mapping to async_schedule and
> async_schedule_domain but provide NUMA node specific functionality. They
> replace the original functions which were moved to inline function
> definitions that call the new functions while passing NUMA_NO_NODE.
> 
> The second two functions are async_schedule_dev and
> async_schedule_dev_domain which provide NUMA specific functionality when
> passing a device as the data member and that device has a NUMA node other
> than NUMA_NO_NODE.
> 
> The main motivation behind this is to address the need to be able to
> schedule device specific init work on specific NUMA nodes in order to
> improve performance of memory initialization.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
> 
> v1->v2:
>     Replaced call to queue_work_near with call to queue_work_node
> 
>  include/linux/async.h |   36 +++++++++++++++++++++++++++++++++---
>  kernel/async.c        |   47 ++++++++++++++++++++++-------------------------
>  2 files changed, 55 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/async.h b/include/linux/async.h
> index 6b0226bdaadc..1f6cb0d50263 100644
> --- a/include/linux/async.h
> +++ b/include/linux/async.h
> @@ -14,6 +14,8 @@
>  
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/numa.h>
> +#include <linux/device.h>
>  
>  typedef u64 async_cookie_t;
>  typedef void (*async_func_t) (void *data, async_cookie_t cookie);
> @@ -37,9 +39,37 @@ struct async_domain {
>  	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
>  				      .registered = 0 }
>  
> -extern async_cookie_t async_schedule(async_func_t func, void *data);
> -extern async_cookie_t async_schedule_domain(async_func_t func, void *data,
> -					    struct async_domain *domain);
> +async_cookie_t async_schedule_near(async_func_t func, void *data,
> +				   int node);
> +async_cookie_t async_schedule_near_domain(async_func_t func, void *data,
> +					  int node,
> +					  struct async_domain *domain);
> +
> +static inline async_cookie_t async_schedule(async_func_t func, void *data)
> +{
> +	return async_schedule_near(func, data, NUMA_NO_NODE);
> +}
> +
> +static inline async_cookie_t
> +async_schedule_domain(async_func_t func, void *data,
> +		      struct async_domain *domain)
> +{
> +	return async_schedule_near_domain(func, data, NUMA_NO_NODE, domain);
> +}
> +
> +static inline async_cookie_t
> +async_schedule_dev(async_func_t func, struct device *dev)
> +{
> +	return async_schedule_near(func, dev, dev_to_node(dev));
> +}
> +
> +static inline async_cookie_t
> +async_schedule_dev_domain(async_func_t func, struct device *dev,
> +			  struct async_domain *domain)
> +{
> +	return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
> +}

No kerneldoc for these functions?  We lost it for
async_schedule_domain() which used to be documented before this patch :(

thanks,

greg k-h
