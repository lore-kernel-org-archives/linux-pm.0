Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B623E330
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476152; cv=none; b=I6CHitdCtlOZH6vv+nJJ1rBdwthVYPifNPuqIJrHvdeCsXYZ++jthjsIQGnKhxGUZxB5uFZytaP+P1hipVN+cE4wqMx/ou4/lIAaSW3bo835oQoU3H63nrp+iPYJu2wX3GIBUfx4n+dWPuAYyNLxRmkZKPfzUUDs6BKDvtHExF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476152; c=relaxed/simple;
	bh=VjFgkcngnDyDi/6uf8HEAoafHucYPSUi6POvzSEjLaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V62Q7GUldmPGlIEo6Iw7i58kzojeeiSQuzd2M4+XXOl+dywWSsjs2r2vxSSG0CI1HghOx5DCocBwLXxtbd87ep3G+m55RF9iMHk/ncqqcKEeqTTLuCqTmhLjxnPy2VJutfGrmoKv9jqlq0/UW+e+knjIjh/hyx7itA8Np5pJwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzhRRI3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzhRRI3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FBFC2BCFD
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 05:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476152;
	bh=VjFgkcngnDyDi/6uf8HEAoafHucYPSUi6POvzSEjLaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mzhRRI3SVZ1aCFRMzQ+pmz2Gs+jRAME4gQ3VM40UWafxza8TThPla3CebYvtF89/8
	 OnKYFRpILVl6tTozQeWvQyw8Ujh0/1yKpeYNEqsiEB/kh9ENUYddxFFksgH54xgWh2
	 RwczW6CiLAprVg+zCatORUea5sxhNKR306DctcpaOZZOzpVtBr/TBucTTO+ycb+egI
	 YUOGT6sHKMNF6j1w/HMJtqR8kd4g4lm6ckGXIYkItq2Y1rDTwW8NoXIsiujC0cUldQ
	 0+enev0tH7DwXdNnSEkGnYu+Xs9PT3NSU6A5qxMAj8t3WxltLLRub6a3IR3V0A5zkR
	 xckoJz/em9igg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so6037293a12.0
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 22:09:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+7LrSIPuYik0zl77IlL8R7Z6iv4bdHrftrQ7ZaFK07hzhR93M1sQQlKtPYcA9rzIn6NFeFGSrvtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5yMkU5ej44DObLuviULP0jw7GGX91z58b5yxeR/zbR5ms7vR
	TfMXh869XEpdZtaKbf+cT6bagn1ryfSozHNxDasNzsq/L12R1LGhSBOc++u3zuNuNeybE2S6u0P
	OCo93TDoHS9F8LpNUuO/L9ixftdtscZM=
X-Received: by 2002:a05:6402:a587:10b0:66b:f527:c69d with SMTP id
 4fb4d7f45d1cf-67d63d8b66emr8455569a12.8.1778476150384; Sun, 10 May 2026
 22:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org> <20260508123910.114273-3-ulf.hansson@linaro.org>
In-Reply-To: <20260508123910.114273-3-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 10 May 2026 22:08:58 -0700
X-Gmail-Original-Message-ID: <CACRMN=fseD6-ODYnOEE42S9VKAb2F33kRv_VPYBGyPsitG2how@mail.gmail.com>
X-Gm-Features: AVHnY4Jyso8e2fZ7k8KjZKga2UrlRCr0usLugmNfu4YcyYocZL-OkXg90ISdkts
Message-ID: <CACRMN=fseD6-ODYnOEE42S9VKAb2F33kRv_VPYBGyPsitG2how@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> The common sync_state support isn't fine grained enough for some types of
> suppliers, like power domains for example. Especially when a supplier
> provides multiple independent power domains, each with their own set of
> consumers. In these cases we need to wait for all consumers for all the
> provided power domains before invoking the supplier's ->sync_state().
>
> To allow a more fine grained sync_state support to be implemented on per
> supplier's driver basis, let's add a new optional callback. As soon as
> there is an update worth to consider in regards to managing sync_state fo=
r
> a supplier device, __device_links_queue_sync_state() queues the device in=
 a
> list, allowing the new callback to be invoked when flushing the list in
> device_links_flush_sync_list().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Re-worked the approach to use a list to queue/flush devices for
>         ->queue_sync_state(). This should make sure the device lock is be=
ing
>         held when it's needed, as pointed out by Danilo.
>

Hi Ulf,

Thanks for working on this!

And please bear with my slow replies.

> ---
>  drivers/base/base.h           | 18 ++++++++
>  drivers/base/core.c           | 77 ++++++++++++++++++++++++++---------
>  drivers/base/driver.c         |  7 ++++
>  include/linux/device.h        |  2 +
>  include/linux/device/driver.h |  7 ++++
>  5 files changed, 91 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 30b416588617..c8be24af92c3 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -196,6 +196,24 @@ static inline void dev_sync_state(struct device *dev=
)
>                 dev->driver->sync_state(dev);
>  }
>
> +static inline bool dev_has_queue_sync_state(struct device *dev)

Let's please pick a better name. This is too similar to the actual
queue function you call __device_links_queue_sync_state() and is very
confusing. Maybe something that has a meaning along the lines of
"another consumer probed". So, maybe:
* consumer_probed()
* change_of_active_consumers()

I'm going to refer to this new callback as "consumer_probed()" in the
rest of my replies so I can keep it straight in my head.

> +{
> +       struct device_driver *drv;
> +
> +       if (!dev)
> +               return false;
> +       drv =3D READ_ONCE(dev->driver);
> +       if (drv && drv->queue_sync_state)
> +               return true;
> +       return false;
> +}
> +
> +static inline void dev_queue_sync_state(struct device *dev)
> +{
> +       if (dev->driver && dev->driver->queue_sync_state)
> +               dev->driver->queue_sync_state(dev);
> +}
> +
>  int driver_add_groups(const struct device_driver *drv, const struct attr=
ibute_group **groups);
>  void driver_remove_groups(const struct device_driver *drv, const struct =
attribute_group **groups);
>  void device_driver_detach(struct device *dev);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d49420e066de..f1f95b3c81e5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1101,15 +1101,18 @@ int device_links_check_suppliers(struct device *d=
ev)
>  /**
>   * __device_links_queue_sync_state - Queue a device for sync_state() cal=
lback
>   * @dev: Device to call sync_state() on
> - * @list: List head to queue the @dev on
> + * @s_list: List head for the sync_state to queue the @dev on
> + * @q_list: List head for the queue_sync_state to queue the @dev on
>   *
>   * Queues a device for a sync_state() callback when the device links wri=
te lock
>   * isn't held. This allows the sync_state() execution flow to use device=
 links
>   * APIs.  The caller must ensure this function is called with
> - * device_links_write_lock() held.
> + * device_links_write_lock() held.  Note, if the optional queue_sync_sta=
te()
> + * callback has been assigned too, the device is queued for that list to=
 allow a
> + * more fine grained support to be implemented on per supplier basis.

Why not keep this in the same format as the existing doc? Something like:
If option list xxx is provided, queues the device for the
consumer_probed() callback.

>   *
>   * This function does a get_device() to make sure the device is not free=
d while
> - * on this list.
> + * on the corresponding list.
>   *
>   * So the caller must also ensure that device_links_flush_sync_list() is=
 called
>   * as soon as the caller releases device_links_write_lock().  This is ne=
cessary
> @@ -1117,7 +1120,8 @@ int device_links_check_suppliers(struct device *dev=
)
>   * put_device() is called on this device.
>   */
>  static void __device_links_queue_sync_state(struct device *dev,
> -                                           struct list_head *list)
> +                                           struct list_head *s_list,
> +                                           struct list_head *q_list)
>  {
>         struct device_link *link;
>
> @@ -1129,8 +1133,14 @@ static void __device_links_queue_sync_state(struct=
 device *dev,
>         list_for_each_entry(link, &dev->links.consumers, s_node) {
>                 if (!device_link_test(link, DL_FLAG_MANAGED))
>                         continue;
> -               if (link->status !=3D DL_STATE_ACTIVE)
> +               if (link->status !=3D DL_STATE_ACTIVE) {
> +                       if (dev_has_queue_sync_state(dev) &&
> +                           list_empty(&dev->links.queue_sync)) {
> +                               get_device(dev);
> +                               list_add_tail(&dev->links.queue_sync, q_l=
ist);
> +                       }
>                         return;
> +               }
>         }
>
>         /*
> @@ -1144,25 +1154,28 @@ static void __device_links_queue_sync_state(struc=
t device *dev,
>                 return;
>
>         get_device(dev);
> -       list_add_tail(&dev->links.defer_sync, list);
> +       list_add_tail(&dev->links.defer_sync, s_list);
>  }
>
>  /**
> - * device_links_flush_sync_list - Call sync_state() on a list of devices
> - * @list: List of devices to call sync_state() on
> + * device_links_flush_sync_list - Call sync_state callbacks for the devi=
ces
> + * @s_list: List of devices to call sync_state() on
> + * @q_list: List of devices to call queue_sync_state() on
>   * @dont_lock_dev: Device for which lock is already held by the caller
>   *
> - * Calls sync_state() on all the devices that have been queued for it. T=
his
> - * function is used in conjunction with __device_links_queue_sync_state(=
). The
> - * @dont_lock_dev parameter is useful when this function is called from =
a
> - * context where a device lock is already held.
> + * Calls sync_state() and queue_sync_state() on all the devices that hav=
e been
> + * queued for it. This function is used in conjunction with
> + * __device_links_queue_sync_state(). The @dont_lock_dev parameter is us=
eful
> + * when this function is called from a context where a device lock is al=
ready
> + * held.
>   */
> -static void device_links_flush_sync_list(struct list_head *list,
> +static void device_links_flush_sync_list(struct list_head *s_list,
> +                                        struct list_head *q_list,
>                                          struct device *dont_lock_dev)
>  {
>         struct device *dev, *tmp;
>
> -       list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
> +       list_for_each_entry_safe(dev, tmp, s_list, links.defer_sync) {
>                 list_del_init(&dev->links.defer_sync);
>
>                 if (dev !=3D dont_lock_dev)
> @@ -1175,6 +1188,25 @@ static void device_links_flush_sync_list(struct li=
st_head *list,
>
>                 put_device(dev);
>         }
> +
> +       if (!q_list)
> +               return;
> +
> +       list_for_each_entry_safe(dev, tmp, q_list, links.queue_sync) {
> +               list_del_init(&dev->links.queue_sync);
> +
> +               if (dev !=3D dont_lock_dev)
> +                       device_lock(dev);
> +
> +               device_links_write_lock();
> +               dev_queue_sync_state(dev);
> +               device_links_write_unlock();
> +
> +               if (dev !=3D dont_lock_dev)
> +                       device_unlock(dev);
> +
> +               put_device(dev);
> +       }
>  }
>
>  void device_links_supplier_sync_state_pause(void)
> @@ -1188,6 +1220,7 @@ void device_links_supplier_sync_state_resume(void)
>  {
>         struct device *dev, *tmp;
>         LIST_HEAD(sync_list);
> +       LIST_HEAD(queue_list);
>
>         device_links_write_lock();
>         if (!defer_sync_state_count) {
> @@ -1204,12 +1237,12 @@ void device_links_supplier_sync_state_resume(void=
)
>                  * sync_list because defer_sync is used for both lists.
>                  */
>                 list_del_init(&dev->links.defer_sync);
> -               __device_links_queue_sync_state(dev, &sync_list);
> +               __device_links_queue_sync_state(dev, &sync_list, &queue_l=
ist);
>         }
>  out:
>         device_links_write_unlock();
>
> -       device_links_flush_sync_list(&sync_list, NULL);
> +       device_links_flush_sync_list(&sync_list, &queue_list, NULL);
>  }
>
>  static int sync_state_resume_initcall(void)
> @@ -1296,6 +1329,7 @@ void device_links_driver_bound(struct device *dev)
>  {
>         struct device_link *link, *ln;
>         LIST_HEAD(sync_list);
> +       LIST_HEAD(queue_list);
>
>         /*
>          * If a device binds successfully, it's expected to have created =
all
> @@ -1351,7 +1385,7 @@ void device_links_driver_bound(struct device *dev)
>         if (defer_sync_state_count)
>                 __device_links_supplier_defer_sync(dev);
>         else
> -               __device_links_queue_sync_state(dev, &sync_list);
> +               __device_links_queue_sync_state(dev, &sync_list, &queue_l=
ist);

This path is really meant only for situations when the device has no
consumers. So, I don't think fine grained control is relevant.

>
>         list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node)=
 {
>                 struct device *supplier;
> @@ -1393,14 +1427,15 @@ void device_links_driver_bound(struct device *dev=
)
>                 if (defer_sync_state_count)
>                         __device_links_supplier_defer_sync(supplier);
>                 else
> -                       __device_links_queue_sync_state(supplier, &sync_l=
ist);
> +                       __device_links_queue_sync_state(supplier, &sync_l=
ist,
> +                                                       &queue_list);
>         }
>
>         dev->links.status =3D DL_DEV_DRIVER_BOUND;
>
>         device_links_write_unlock();
>
> -       device_links_flush_sync_list(&sync_list, dev);
> +       device_links_flush_sync_list(&sync_list, &queue_list, dev);
>  }
>
>  /**
> @@ -1516,6 +1551,7 @@ void device_links_driver_cleanup(struct device *dev=
)
>         }
>
>         list_del_init(&dev->links.defer_sync);
> +       list_del_init(&dev->links.queue_sync);
>         __device_links_no_driver(dev);
>
>         device_links_write_unlock();
> @@ -1808,7 +1844,7 @@ void fw_devlink_probing_done(void)
>         class_for_each_device(&devlink_class, NULL, &sync_list,
>                               fw_devlink_dev_sync_state);
>         device_links_write_unlock();
> -       device_links_flush_sync_list(&sync_list, NULL);
> +       device_links_flush_sync_list(&sync_list, NULL, NULL);
>  }
>
>  /**
> @@ -3169,6 +3205,7 @@ void device_initialize(struct device *dev)
>         INIT_LIST_HEAD(&dev->links.consumers);
>         INIT_LIST_HEAD(&dev->links.suppliers);
>         INIT_LIST_HEAD(&dev->links.defer_sync);
> +       INIT_LIST_HEAD(&dev->links.queue_sync);
>         dev->links.status =3D DL_DEV_NO_DRIVER;
>         dev_assign_dma_coherent(dev, dma_default_coherent);
>         swiotlb_dev_init(dev);
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 8ab010ddf709..b8f4d08bbd58 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -239,6 +239,13 @@ int driver_register(struct device_driver *drv)
>                 pr_warn("Driver '%s' needs updating - please use "
>                         "bus_type methods\n", drv->name);
>
> +       if (drv->queue_sync_state && !drv->sync_state &&
> +           !drv->bus->sync_state) {
> +               pr_err("Driver '%s' or its bus_type needs ->sync_state()"=
,
> +                      drv->name);
> +               return -EINVAL;
> +       }
> +
>         other =3D driver_find(drv->name, drv->bus);
>         if (other) {
>                 pr_err("Error: Driver '%s' is already registered, "
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 56a96e41d2c9..6848b0a2c2d9 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -414,12 +414,14 @@ enum device_removable {
>   * @suppliers: List of links to supplier devices.
>   * @consumers: List of links to consumer devices.
>   * @defer_sync: Hook to global list of devices that have deferred sync_s=
tate.
> + * @defer_sync: Hook to global list of devices scheduled for queue_sync_=
state.
>   * @status: Driver status information.
>   */
>  struct dev_links_info {
>         struct list_head suppliers;
>         struct list_head consumers;
>         struct list_head defer_sync;
> +       struct list_head queue_sync;
>         enum dl_dev_state status;
>  };
>
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.=
h
> index bbc67ec513ed..bc9ae1cbe03c 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -68,6 +68,12 @@ enum probe_type {
>   *             be called at late_initcall_sync level. If the device has
>   *             consumers that are never bound to a driver, this function
>   *             will never get called until they do.
> + * @queue_sync_state: Similar to the ->sync_state() callback, but called=
 to
> + *             allow syncing device state to software state in a more fi=
ne
> + *             grained way. It is called when there is an updated state =
that
> + *             may be worth to consider for any of the consumers linked =
to
> + *             this device. If implemented, the ->sync_state() callback =
is
> + *             required too.

Let's make it clear that if a device gets sync_state() callback, it
needs to sync the state independent of whether it has received any/all
"consumer_probed()".

Thanks,
Saravana


>   * @remove:    Called when the device is removed from the system to
>   *             unbind a device from this driver.
>   * @shutdown:  Called at shut-down time to quiesce the device.
> @@ -110,6 +116,7 @@ struct device_driver {
>
>         int (*probe) (struct device *dev);
>         void (*sync_state)(struct device *dev);
> +       void (*queue_sync_state)(struct device *dev);
>         int (*remove) (struct device *dev);
>         void (*shutdown) (struct device *dev);
>         int (*suspend) (struct device *dev, pm_message_t state);
> --
> 2.43.0
>
