From: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
Subject: Re: [driver-core PATCH v5 7/9] driver core: Attach devices on CPU
 local to device node
Date: Tue, 06 Nov 2018 16:24:12 -0800
Message-ID: <1541550252.196084.200.camel@acm.org>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
 <154145233508.29224.9891071445860629874.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <154145233508.29224.9891071445860629874.stgit-+uVpp3jiz/RcxmDmkzA3yGt3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
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

On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
> This change makes it so that we call the asynchronous probe routines on a
> CPU local to the device node. By doing this we should be able to improve
> our initialization time significantly as we can avoid having to access the
> device from a remote node which may introduce higher latency.
> 
> For example, in the case of initializing memory for NVDIMM this can have a
> significant impact as initialing 3TB on remote node can take up to 39
> seconds while initialing it on a local node only takes 23 seconds. It is
> situations like this where we will see the biggest improvement.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/base/dd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 2fdfe45bb6ea..cf7681309ee3 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -834,7 +834,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>  			dev_dbg(dev, "scheduling asynchronous probe\n");
>  			get_device(dev);
>  			dev->async_probe = true;
> -			async_schedule(__device_attach_async_helper, dev);
> +			async_schedule_dev(__device_attach_async_helper, dev);
>  		} else {
>  			pm_request_idle(dev);
>  		}
> @@ -992,7 +992,7 @@ static int __driver_attach(struct device *dev, void *data)
>  		if (!dev->driver) {
>  			get_device(dev);
>  			dev_set_drv_async(dev, drv);
> -			async_schedule(__driver_attach_async_helper, dev);
> +			async_schedule_dev(__driver_attach_async_helper, dev);
>  		}
>  		device_unlock(dev);
>  		return 0;

Reviewed-by: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
