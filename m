From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC workqueue/driver-core PATCH 4/5] driver core: Use new
 async_schedule_dev command
Date: Fri, 28 Sep 2018 10:42:39 -0700
Message-ID: <CAPcyv4hZFQ99jnJnWBDDvrpiXq4zSAxo4C870tzfsN7eQ-8Y7Q@mail.gmail.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215155.13512.30900.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180926215155.13512.30900.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux-pm mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-nvdimm <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 26, 2018 at 2:52 PM Alexander Duyck
<alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
> This change makes it so that we use the device specific version of the
> async_schedule commands to defer various tasks related to devices. By doing
> this we should see a slight improvement in performance as any device that
> is sensitive to latency/locality in the setup will now be initializing on
> the node closest to the device.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/base/dd.c         |    4 ++--
>  drivers/base/power/main.c |   12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 5ba366c1cb83..81472dc44a70 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -826,7 +826,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>                          */
>                         dev_dbg(dev, "scheduling asynchronous probe\n");
>                         get_device(dev);
> -                       async_schedule(__device_attach_async_helper, dev);
> +                       async_schedule_dev(__device_attach_async_helper, dev);
>                 } else {
>                         pm_request_idle(dev);
>                 }
> @@ -927,7 +927,7 @@ static int __driver_attach(struct device *dev, void *data)
>                 if (!dev->driver) {
>                         get_device(dev);
>                         dev_set_drvdata(dev, drv);
> -                       async_schedule(__driver_attach_async_helper, dev);
> +                       async_schedule_dev(__driver_attach_async_helper, dev);
>                 }

Above looks good to me...

>                 device_unlock(dev);
>                 return 0;
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3f68e2919dc5..8495d9b1e9d0 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c

Let's split these changes into their own patch, just in case it causes
a suspend regression we can revert it independently of the async
probing change. It might also be worthwhile to have a positive
indication that this improves the latency of power transitions.
