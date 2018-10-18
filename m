From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [driver-core PATCH v4 3/6] device core: Consolidate locking and
 unlocking of parent and device
Date: Thu, 18 Oct 2018 09:46:38 +0200
Message-ID: <CAJZ5v0jkxNXiStNdoHWKwjpt5ExYGjSwdSft471PTpd9NK1XQw@mail.gmail.com>
References: <20181015150305.29520.86363.stgit@localhost.localdomain> <20181015150920.29520.32815.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015150920.29520.32815.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.h.duyck@linux.intel.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 15, 2018 at 5:09 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This patch is meant to try and consolidate all of the locking and unlocking
> of both the parent and device when attaching or removing a driver from a
> given device.
>
> To do that I first consolidated the lock pattern into two functions
> __device_driver_lock and __device_driver_unlock. After doing that I then
> created functions specific to attaching and detaching the driver while
> acquiring this locks. By doing this I was able to reduce the number of
> spots where we touch need_parent_lock from 12 down to 4.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/base.h |    2 +
>  drivers/base/bus.c  |   23 ++------------
>  drivers/base/dd.c   |   83 ++++++++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 75 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..3f22ebd6117a 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -124,6 +124,8 @@ extern int driver_add_groups(struct device_driver *drv,
>                              const struct attribute_group **groups);
>  extern void driver_remove_groups(struct device_driver *drv,
>                                  const struct attribute_group **groups);
> +int device_driver_attach(struct device_driver *drv, struct device *dev);
> +void device_driver_detach(struct device *dev);
>
>  extern char *make_class_name(const char *name, struct kobject *kobj);
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 8bfd27ec73d6..8a630f9bd880 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -184,11 +184,7 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
>
>         dev = bus_find_device_by_name(bus, NULL, buf);
>         if (dev && dev->driver == drv) {
> -               if (dev->parent && dev->bus->need_parent_lock)
> -                       device_lock(dev->parent);
> -               device_release_driver(dev);
> -               if (dev->parent && dev->bus->need_parent_lock)
> -                       device_unlock(dev->parent);
> +               device_driver_detach(dev);
>                 err = count;
>         }
>         put_device(dev);
> @@ -211,13 +207,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
>
>         dev = bus_find_device_by_name(bus, NULL, buf);
>         if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
> -               if (dev->parent && bus->need_parent_lock)
> -                       device_lock(dev->parent);
> -               device_lock(dev);
> -               err = driver_probe_device(drv, dev);
> -               device_unlock(dev);
> -               if (dev->parent && bus->need_parent_lock)
> -                       device_unlock(dev->parent);
> +               err = device_driver_attach(drv, dev);
>
>                 if (err > 0) {
>                         /* success */
> @@ -769,13 +759,8 @@ int bus_rescan_devices(struct bus_type *bus)
>   */
>  int device_reprobe(struct device *dev)
>  {
> -       if (dev->driver) {
> -               if (dev->parent && dev->bus->need_parent_lock)
> -                       device_lock(dev->parent);
> -               device_release_driver(dev);
> -               if (dev->parent && dev->bus->need_parent_lock)
> -                       device_unlock(dev->parent);
> -       }
> +       if (dev->driver)
> +               device_driver_detach(dev);
>         return bus_rescan_devices_helper(dev, NULL);
>  }
>  EXPORT_SYMBOL_GPL(device_reprobe);
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..e845cd2a87af 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -864,6 +864,60 @@ void device_initial_probe(struct device *dev)
>         __device_attach(dev, true);
>  }
>
> +/*
> + * __device_driver_lock - acquire locks needed to manipulate dev->drv
> + * @dev: Device we will update driver info for
> + * @parent: Parent device needed if the bus requires parent lock
> + *
> + * This function will take the required locks for manipulating dev->drv.
> + * Normally this will just be the @dev lock, but when called for a USB
> + * interface, @parent lock will be held as well.
> + */
> +static void __device_driver_lock(struct device *dev, struct device *parent)
> +{
> +       if (parent && dev->bus->need_parent_lock)
> +               device_lock(parent);
> +       device_lock(dev);
> +}
> +
> +/*
> + * __device_driver_lock - release locks needed to manipulate dev->drv
> + * @dev: Device we will update driver info for
> + * @parent: Parent device needed if the bus requires parent lock
> + *
> + * This function will release the required locks for manipulating dev->drv.
> + * Normally this will just be the the @dev lock, but when called for a
> + * USB interface, @parent lock will be released as well.
> + */
> +static void __device_driver_unlock(struct device *dev, struct device *parent)
> +{
> +       device_unlock(dev);
> +       if (parent && dev->bus->need_parent_lock)
> +               device_unlock(parent);
> +}
> +
> +/**
> + * device_driver_attach - attach a specific driver to a specific device
> + * @drv: Driver to attach
> + * @dev: Device to attach it to
> + *
> + * Manually attach driver to a device. Will acquire both @dev lock and
> + * @dev->parent lock if needed.
> + */
> +int device_driver_attach(struct device_driver *drv, struct device *dev)
> +{
> +       int ret = 0;
> +
> +       __device_driver_lock(dev, dev->parent);
> +
> +       if (!dev->driver)
> +               ret = driver_probe_device(drv, dev);
> +
> +       __device_driver_unlock(dev, dev->parent);
> +
> +       return ret;
> +}
> +
>  static int __driver_attach(struct device *dev, void *data)
>  {
>         struct device_driver *drv = data;
> @@ -891,14 +945,7 @@ static int __driver_attach(struct device *dev, void *data)
>                 return ret;
>         } /* ret > 0 means positive match */
>
> -       if (dev->parent && dev->bus->need_parent_lock)
> -               device_lock(dev->parent);
> -       device_lock(dev);
> -       if (!dev->driver)
> -               driver_probe_device(drv, dev);
> -       device_unlock(dev);
> -       if (dev->parent && dev->bus->need_parent_lock)
> -               device_unlock(dev->parent);
> +       device_driver_attach(drv, dev);
>
>         return 0;
>  }
> @@ -993,16 +1040,12 @@ void device_release_driver_internal(struct device *dev,
>                                     struct device_driver *drv,
>                                     struct device *parent)
>  {
> -       if (parent && dev->bus->need_parent_lock)
> -               device_lock(parent);
> +       __device_driver_lock(dev, parent);
>
> -       device_lock(dev);
>         if (!drv || drv == dev->driver)
>                 __device_release_driver(dev, parent);
>
> -       device_unlock(dev);
> -       if (parent && dev->bus->need_parent_lock)
> -               device_unlock(parent);
> +       __device_driver_unlock(dev, parent);
>  }
>
>  /**
> @@ -1028,6 +1071,18 @@ void device_release_driver(struct device *dev)
>  EXPORT_SYMBOL_GPL(device_release_driver);
>
>  /**
> + * device_driver_detach - detach driver from a specific device
> + * @dev: device to detach driver from
> + *
> + * Manually detach driver from device. Will acquire both @dev lock and
> + * @dev->parent lock if needed.
> + */
> +void device_driver_detach(struct device *dev)
> +{
> +       device_release_driver_internal(dev, NULL, dev->parent);
> +}
> +
> +/**
>   * driver_detach - detach driver from all devices it controls.
>   * @drv: driver.
>   */
>
