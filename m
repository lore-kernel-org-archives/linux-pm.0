From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [driver-core PATCH v10 6/9] driver core: Attach devices on CPU local to device node
Date: Thu, 31 Jan 2019 00:45:42 +0100
Message-ID: <2520015.o9hhCCUgSl@aspire.rjw.lan>
References: <154818223154.18753.12374915684623789884.stgit@ahduyck-desk1.amr.corp.intel.com> <154818237710.18753.13303508368380513033.stgit@ahduyck-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154818237710.18753.13303508368380513033.stgit@ahduyck-desk1.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com, bvanassche@acm.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 22, 2019 7:39:37 PM CET Alexander Duyck wrote:
> Call the asynchronous probe routines on a CPU local to the device node. By
> doing this we should be able to improve our initialization time
> significantly as we can avoid having to access the device from a remote
> node which may introduce higher latency.
> 
> For example, in the case of initializing memory for NVDIMM this can have a
> significant impact as initialing 3TB on remote node can take up to 39
> seconds while initialing it on a local node only takes 23 seconds. It is
> situations like this where we will see the biggest improvement.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/dd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 627ad05064e0..aa6a9c613595 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -829,7 +829,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>  			 */
>  			dev_dbg(dev, "scheduling asynchronous probe\n");
>  			get_device(dev);
> -			async_schedule(__device_attach_async_helper, dev);
> +			async_schedule_dev(__device_attach_async_helper, dev);
>  		} else {
>  			pm_request_idle(dev);
>  		}
> @@ -989,7 +989,7 @@ static int __driver_attach(struct device *dev, void *data)
>  		if (!dev->driver) {
>  			get_device(dev);
>  			dev->p->async_driver = drv;
> -			async_schedule(__driver_attach_async_helper, dev);
> +			async_schedule_dev(__driver_attach_async_helper, dev);
>  		}
>  		device_unlock(dev);
>  		return 0;
> 
> 
