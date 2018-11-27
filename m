From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order of
 operations for deferred probe and remove
Date: Mon, 26 Nov 2018 18:35:05 -0800
Message-ID: <CAPcyv4ieNzbx5iN74ZCAKDesgYt_67iM_DC-A35M=Z9jfR+YAQ@mail.gmail.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
 <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.h.duyck@linux.intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>, bvanassche@acm.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 5, 2018 at 1:12 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This patch adds an additional bit to the device struct named async_probe.
> This additional bit allows us to guarantee ordering between probe and
> remove operations.
>
> This allows us to guarantee that if we execute a remove operation or a
> driver load attempt on a given interface it will not attempt to update the
> driver member asynchronously following the earlier operation. Previously
> this guarantee was not present and could result in us attempting to remove
> a driver from an interface only to have it show up later when it is
> asynchronously loaded.
>
> One change I made in addition is I replaced the use of "bool X:1" to define
> the bitfield to a "u8 X:1" setup in order to resolve some checkpatch
> warnings.

The usage of "us" in the changelog through me off, please reword this
to explicitly state the subject like: "The additional bit allows the
driver core to guarantee ordering between probe and remove
operations."

> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/base/dd.c      |  104 +++++++++++++++++++++++++++---------------------
>  include/linux/device.h |    9 ++--
>  2 files changed, 64 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e74cefeb5b69..ed19cf0d6f9a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -472,6 +472,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>                  drv->bus->name, __func__, drv->name, dev_name(dev));
>         WARN_ON(!list_empty(&dev->devres_head));
>
> +       /* clear async_probe flag as we are no longer deferring driver load */
> +       dev->async_probe = false;
>  re_probe:
>         dev->driver = drv;
>
> @@ -771,6 +773,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>
>         device_lock(dev);
>
> +       /* nothing to do if async_probe has been cleared */
> +       if (!dev->async_probe)
> +               goto out_unlock;
> +
>         if (dev->parent)
>                 pm_runtime_get_sync(dev->parent);
>
> @@ -781,7 +787,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>
>         if (dev->parent)
>                 pm_runtime_put(dev->parent);
> -
> +out_unlock:
>         device_unlock(dev);
>
>         put_device(dev);
> @@ -826,6 +832,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>                          */
>                         dev_dbg(dev, "scheduling asynchronous probe\n");
>                         get_device(dev);
> +                       dev->async_probe = true;
>                         async_schedule(__device_attach_async_helper, dev);
>                 } else {
>                         pm_request_idle(dev);
> @@ -971,62 +978,69 @@ EXPORT_SYMBOL_GPL(driver_attach);
>   */
>  static void __device_release_driver(struct device *dev, struct device *parent)
>  {
> -       struct device_driver *drv;
> +       struct device_driver *drv = dev->driver;
>
> -       drv = dev->driver;
> -       if (drv) {
> -               while (device_links_busy(dev)) {
> -                       __device_driver_unlock(dev, parent);
> +       /*
> +        * In the event that we are asked to release the driver on an
> +        * interface that is still waiting on a probe we can just terminate
> +        * the probe by setting async_probe to false. When the async call
> +        * is finally completed it will see this state and just exit.
> +        */
> +       dev->async_probe = false;
> +       if (!drv)
> +               return;

Patch 4 deleted the async_synchronize_full() that would have flushed
in-flight ->probe() relative to the current ->remove(). If remove runs
before probe then would seem to be deadlock condition, but if
->remove() runs before probe then dev->driver is NULL and we abort. So
I'm struggling to see what value dev->async_probe provides over
dev->driver?
