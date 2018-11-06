From: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
Subject: Re: [driver-core PATCH v5 4/9] driver core: Move
 async_synchronize_full call
Date: Mon, 05 Nov 2018 17:04:49 -0800
Message-ID: <1541466289.196084.176.camel@acm.org>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
 <154145231976.29224.39638353241256116.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <154145231976.29224.39638353241256116.stgit-+uVpp3jiz/RcxmDmkzA3yGt3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
> This patch moves the async_synchronize_full call out of
> __device_release_driver and into driver_detach.
> 
> The idea behind this is that the async_synchronize_full call will only
> guarantee that any existing async operations are flushed. This doesn't do
> anything to guarantee that a hotplug event that may occur while we are
> doing the release of the driver will not be asynchronously scheduled.
> 
> By moving this into the driver_detach path we can avoid potential deadlocks
> as we aren't holding the device lock at this point and we should not have
> the driver we want to flush loaded so the flush will take care of any
> asynchronous events the driver we are detaching might have scheduled.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/base/dd.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 76c40fe69463..e74cefeb5b69 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -975,9 +975,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  
>  	drv = dev->driver;
>  	if (drv) {
> -		if (driver_allows_async_probing(drv))
> -			async_synchronize_full();
> -
>  		while (device_links_busy(dev)) {
>  			__device_driver_unlock(dev, parent);
>  
> @@ -1087,6 +1084,9 @@ void driver_detach(struct device_driver *drv)
>  	struct device_private *dev_prv;
>  	struct device *dev;
>  
> +	if (driver_allows_async_probing(drv))
> +		async_synchronize_full();
> +
>  	for (;;) {
>  		spin_lock(&drv->p->klist_devices.k_lock);
>  		if (list_empty(&drv->p->klist_devices.k_list)) {

Have you considered to move that async_synchronize_full() call into
bus_remove_driver()? Verifying the correctness of this patch requires to
check whether the async_synchronize_full() comes after the
klist_remove(&drv->p->knode_bus) call. That verification is easier when
the async_synchronize_full() call occurs in bus_remove_driver() instead
of in driver_detach().

Thanks,

Bart.
