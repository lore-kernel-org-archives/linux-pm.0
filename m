Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38312D21B
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648507; cv=none; b=R72hixtsX0uuvGQhtOeV/piFRIdzmOtj+OFgrqSjFp0rwVDcnCMXIvJAm27OmS5TIFQTxWTuS9CproxjeH9apv5N4kU+Zn9uu58+7g7YLLGczBwMJHXnDFouZSCbAeh6l9a7srCRPnKOuL1v+P9YDhPDY6zEqcbMzpaVa/fpMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648507; c=relaxed/simple;
	bh=SgdyJpkErT45191oBzv8/mmZMYMvkPQ+SSf9Wq8CFNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjCBNzIzxJPtrDzC7yH7uSlQhVb1WAOdLJpHZjjzYzxIXQZq11FsWsnhsFt3KcMhZTphytAXRG51fH1s0kSpwRzyzjShliG06K5Pm/ijrkoWWxN2dQIz6F1KJc64Oc7a7iOz/QrQo2hWDr38aDUAa/A/2uyvRlHDY+ZVsYz+QJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbFOTJOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbFOTJOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E5BC2BCB7
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778648506;
	bh=SgdyJpkErT45191oBzv8/mmZMYMvkPQ+SSf9Wq8CFNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YbFOTJOQv/J2xw2uBaWmxctho3yuwj34dKqv512XwkX5kxkA0ZOKnQvKRvm2wov+U
	 K8X/+XKPz+iFloRYz2rRoUfUp60QnX3pzvdWPJSQAYTFYAnH22bKH7cUBNpduGzObX
	 USpeQ15P68uCoEJxQ546n3fAY8bb4iLIt3oHfG3VvFeO3nwfQhYRZ6HWlnuIsGoOs7
	 NMMN2t1hGmYJnAly9CKIPgCtEI49VuVj/UdMts3xbHq1KRaLtIb27QoS16o6vBItGv
	 eAf6OlyySyRlEf1goJbu4TAU2c3Je09QOlzK/QJs5Wq325HdiqQlDgmHCnQq4DRhHA
	 OGiZ3ABFX07Iw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6815add87f0so1077100a12.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 22:01:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+DJl6cbv+lz9Q+zVBjb7KqEDzEKX8P/vq7uL8LAkQn7gR68igIblxB4o2WhUO6RxtFwCW2ZqNp/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MRasWgntkLMpGuQxBxRirjTxWVw4KuDulQ623hS9+Utp8gko
	BJiB32IytSay0NkC7lsy01T2mie2N0CLizMn4Iwdpq1pz+6jiEmKn4fixYLV0iZ7zH1a1edCo8Q
	wMWuXiWGnBg//Mvhl4SqcNiDuO6gtTFk=
X-Received: by 2002:aa7:d689:0:b0:67e:fea7:68a with SMTP id
 4fb4d7f45d1cf-68255afe8b2mr506591a12.10.1778648505272; Tue, 12 May 2026
 22:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-3-ulf.hansson@linaro.org> <CACRMN=fseD6-ODYnOEE42S9VKAb2F33kRv_VPYBGyPsitG2how@mail.gmail.com>
 <CAPDyKFq+F=zn_Coicb9LzyMtQ=b2Lrd+3Czx6r4ReY-DNyb9eg@mail.gmail.com>
In-Reply-To: <CAPDyKFq+F=zn_Coicb9LzyMtQ=b2Lrd+3Czx6r4ReY-DNyb9eg@mail.gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Tue, 12 May 2026 22:01:28 -0700
X-Gmail-Original-Message-ID: <CACRMN=dZFvbXjZGqTvFdNVyXfyvS6YtWNKQnej9A1jihGJHcqA@mail.gmail.com>
X-Gm-Features: AVHnY4Ljbmr44nAGAx7p39M429gsmtpNStbNRwWRGcWCGcsqtEH3K3FUntwIZDQ
Message-ID: <CACRMN=dZFvbXjZGqTvFdNVyXfyvS6YtWNKQnej9A1jihGJHcqA@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
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

On Mon, May 11, 2026 at 2:43=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 11 May 2026 at 07:09, Saravana Kannan <saravanak@kernel.org> wrot=
e:
> >
> > On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > >
> > > The common sync_state support isn't fine grained enough for some type=
s of
> > > suppliers, like power domains for example. Especially when a supplier
> > > provides multiple independent power domains, each with their own set =
of
> > > consumers. In these cases we need to wait for all consumers for all t=
he
> > > provided power domains before invoking the supplier's ->sync_state().
> > >
> > > To allow a more fine grained sync_state support to be implemented on =
per
> > > supplier's driver basis, let's add a new optional callback. As soon a=
s
> > > there is an update worth to consider in regards to managing sync_stat=
e for
> > > a supplier device, __device_links_queue_sync_state() queues the devic=
e in a
> > > list, allowing the new callback to be invoked when flushing the list =
in
> > > device_links_flush_sync_list().
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v3:
> > >         - Re-worked the approach to use a list to queue/flush devices=
 for
> > >         ->queue_sync_state(). This should make sure the device lock i=
s being
> > >         held when it's needed, as pointed out by Danilo.
> > >
> >
> > Hi Ulf,
> >
> > Thanks for working on this!
> >
> > And please bear with my slow replies.
>
> I will try, but taking more than 2 months to reply isn't sustainable,
> I think. Let's hope you can get some more bandwidth for reviews when
> moving forward.
>
> >
> > > ---
> > >  drivers/base/base.h           | 18 ++++++++
> > >  drivers/base/core.c           | 77 ++++++++++++++++++++++++++-------=
--
> > >  drivers/base/driver.c         |  7 ++++
> > >  include/linux/device.h        |  2 +
> > >  include/linux/device/driver.h |  7 ++++
> > >  5 files changed, 91 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > index 30b416588617..c8be24af92c3 100644
> > > --- a/drivers/base/base.h
> > > +++ b/drivers/base/base.h
> > > @@ -196,6 +196,24 @@ static inline void dev_sync_state(struct device =
*dev)
> > >                 dev->driver->sync_state(dev);
> > >  }
> > >
> > > +static inline bool dev_has_queue_sync_state(struct device *dev)
> >
> > Let's please pick a better name. This is too similar to the actual
> > queue function you call __device_links_queue_sync_state() and is very
> > confusing. Maybe something that has a meaning along the lines of
> > "another consumer probed". So, maybe:
> > * consumer_probed()
> > * change_of_active_consumers()
>
> The whole point of naming it "queue_sync_state" was exactly to refer
> to __device_links_queue_sync_state(). The point is, the callback can't
> be invoked unless __device_links_queue_sync_state() has been called
> for the device first.
>
> Not sure why you think that is confusing? To me, that is rather the
> opposite. :-)


sync_state() is a callback telling the driver that it's okay to sync
the state of the hardware with the software.

queue_sync_state() means nothing to the driver. It's just leaking an
internal implementation detail (name of the internal function) to the
driver that's not really relevant. What you are really telling the
driver is that some additional consumers have probed.

> Before deciding on another name, note also that
> __device_links_queue_sync_state() is called when resuming sync_state
> from device_links_supplier_sync_state_resume() and from
> device_links_driver_bound(). I am not sure "consumer_probed" a good
> name that covers both of these cases; what do you think?

Yes, I'm well aware of that :) The contract of sync_state() is that
it'll come after a point where it's safe to sync the state. Not "as
soon as it's safe" -- meaning no timing guarantee. Really, this is
just to make sure sync_state() doesn't come before late initcalls
(because a lot of frameworks make assumptions around it) are done and
before all the top level devices are added.

So, even today, sync_state() can come a bit late. In general, the
driver framework doesn't guarantee immediate action. There is no
guarantee that a drive probe will be called as soon as it's registered
(if there is a device) and vice versa. The same will be true for a
"consumer_probed()" callback too.

Also, your implementation is literally trying to check which consumers
have probed and which ones haven't. So something like
"consumer_probed()" or "consumer_change()" should work well and is
actually meaningful for a driver developer.

>
> >
> > I'm going to refer to this new callback as "consumer_probed()" in the
> > rest of my replies so I can keep it straight in my head.
> >
> > > +{
> > > +       struct device_driver *drv;
> > > +
> > > +       if (!dev)
> > > +               return false;
> > > +       drv =3D READ_ONCE(dev->driver);
> > > +       if (drv && drv->queue_sync_state)
> > > +               return true;
> > > +       return false;
> > > +}
> > > +
> > > +static inline void dev_queue_sync_state(struct device *dev)
> > > +{
> > > +       if (dev->driver && dev->driver->queue_sync_state)
> > > +               dev->driver->queue_sync_state(dev);
> > > +}
> > > +
> > >  int driver_add_groups(const struct device_driver *drv, const struct =
attribute_group **groups);
> > >  void driver_remove_groups(const struct device_driver *drv, const str=
uct attribute_group **groups);
> > >  void device_driver_detach(struct device *dev);
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index d49420e066de..f1f95b3c81e5 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -1101,15 +1101,18 @@ int device_links_check_suppliers(struct devic=
e *dev)
> > >  /**
> > >   * __device_links_queue_sync_state - Queue a device for sync_state()=
 callback
> > >   * @dev: Device to call sync_state() on
> > > - * @list: List head to queue the @dev on
> > > + * @s_list: List head for the sync_state to queue the @dev on
> > > + * @q_list: List head for the queue_sync_state to queue the @dev on
> > >   *
> > >   * Queues a device for a sync_state() callback when the device links=
 write lock
> > >   * isn't held. This allows the sync_state() execution flow to use de=
vice links
> > >   * APIs.  The caller must ensure this function is called with
> > > - * device_links_write_lock() held.
> > > + * device_links_write_lock() held.  Note, if the optional queue_sync=
_state()
> > > + * callback has been assigned too, the device is queued for that lis=
t to allow a
> > > + * more fine grained support to be implemented on per supplier basis=
.
> >
> > Why not keep this in the same format as the existing doc? Something lik=
e:
> > If option list xxx is provided, queues the device for the
> > consumer_probed() callback.
>
> Okay, let me clarify this.

Thanks

>
> >
> > >   *
> > >   * This function does a get_device() to make sure the device is not =
freed while
> > > - * on this list.
> > > + * on the corresponding list.
> > >   *
> > >   * So the caller must also ensure that device_links_flush_sync_list(=
) is called
> > >   * as soon as the caller releases device_links_write_lock().  This i=
s necessary
> > > @@ -1117,7 +1120,8 @@ int device_links_check_suppliers(struct device =
*dev)
> > >   * put_device() is called on this device.
> > >   */
> > >  static void __device_links_queue_sync_state(struct device *dev,
> > > -                                           struct list_head *list)
> > > +                                           struct list_head *s_list,
> > > +                                           struct list_head *q_list)
> > >  {
> > >         struct device_link *link;
> > >
> > > @@ -1129,8 +1133,14 @@ static void __device_links_queue_sync_state(st=
ruct device *dev,
> > >         list_for_each_entry(link, &dev->links.consumers, s_node) {
> > >                 if (!device_link_test(link, DL_FLAG_MANAGED))
> > >                         continue;
> > > -               if (link->status !=3D DL_STATE_ACTIVE)
> > > +               if (link->status !=3D DL_STATE_ACTIVE) {
> > > +                       if (dev_has_queue_sync_state(dev) &&
> > > +                           list_empty(&dev->links.queue_sync)) {
> > > +                               get_device(dev);
> > > +                               list_add_tail(&dev->links.queue_sync,=
 q_list);
> > > +                       }
> > >                         return;
> > > +               }
> > >         }
> > >
> > >         /*
> > > @@ -1144,25 +1154,28 @@ static void __device_links_queue_sync_state(s=
truct device *dev,
> > >                 return;
> > >
> > >         get_device(dev);
> > > -       list_add_tail(&dev->links.defer_sync, list);
> > > +       list_add_tail(&dev->links.defer_sync, s_list);
> > >  }
> > >
> > >  /**
> > > - * device_links_flush_sync_list - Call sync_state() on a list of dev=
ices
> > > - * @list: List of devices to call sync_state() on
> > > + * device_links_flush_sync_list - Call sync_state callbacks for the =
devices
> > > + * @s_list: List of devices to call sync_state() on
> > > + * @q_list: List of devices to call queue_sync_state() on
> > >   * @dont_lock_dev: Device for which lock is already held by the call=
er
> > >   *
> > > - * Calls sync_state() on all the devices that have been queued for i=
t. This
> > > - * function is used in conjunction with __device_links_queue_sync_st=
ate(). The
> > > - * @dont_lock_dev parameter is useful when this function is called f=
rom a
> > > - * context where a device lock is already held.
> > > + * Calls sync_state() and queue_sync_state() on all the devices that=
 have been
> > > + * queued for it. This function is used in conjunction with
> > > + * __device_links_queue_sync_state(). The @dont_lock_dev parameter i=
s useful
> > > + * when this function is called from a context where a device lock i=
s already
> > > + * held.
> > >   */
> > > -static void device_links_flush_sync_list(struct list_head *list,
> > > +static void device_links_flush_sync_list(struct list_head *s_list,
> > > +                                        struct list_head *q_list,
> > >                                          struct device *dont_lock_dev=
)
> > >  {
> > >         struct device *dev, *tmp;
> > >
> > > -       list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
> > > +       list_for_each_entry_safe(dev, tmp, s_list, links.defer_sync) =
{
> > >                 list_del_init(&dev->links.defer_sync);
> > >
> > >                 if (dev !=3D dont_lock_dev)
> > > @@ -1175,6 +1188,25 @@ static void device_links_flush_sync_list(struc=
t list_head *list,
> > >
> > >                 put_device(dev);
> > >         }
> > > +
> > > +       if (!q_list)
> > > +               return;
> > > +
> > > +       list_for_each_entry_safe(dev, tmp, q_list, links.queue_sync) =
{
> > > +               list_del_init(&dev->links.queue_sync);
> > > +
> > > +               if (dev !=3D dont_lock_dev)
> > > +                       device_lock(dev);
> > > +
> > > +               device_links_write_lock();
> > > +               dev_queue_sync_state(dev);
> > > +               device_links_write_unlock();
> > > +
> > > +               if (dev !=3D dont_lock_dev)
> > > +                       device_unlock(dev);
> > > +
> > > +               put_device(dev);
> > > +       }
> > >  }
> > >
> > >  void device_links_supplier_sync_state_pause(void)
> > > @@ -1188,6 +1220,7 @@ void device_links_supplier_sync_state_resume(vo=
id)
> > >  {
> > >         struct device *dev, *tmp;
> > >         LIST_HEAD(sync_list);
> > > +       LIST_HEAD(queue_list);
> > >
> > >         device_links_write_lock();
> > >         if (!defer_sync_state_count) {
> > > @@ -1204,12 +1237,12 @@ void device_links_supplier_sync_state_resume(=
void)
> > >                  * sync_list because defer_sync is used for both list=
s.
> > >                  */
> > >                 list_del_init(&dev->links.defer_sync);
> > > -               __device_links_queue_sync_state(dev, &sync_list);
> > > +               __device_links_queue_sync_state(dev, &sync_list, &que=
ue_list);
> > >         }
> > >  out:
> > >         device_links_write_unlock();
> > >
> > > -       device_links_flush_sync_list(&sync_list, NULL);
> > > +       device_links_flush_sync_list(&sync_list, &queue_list, NULL);
> > >  }
> > >
> > >  static int sync_state_resume_initcall(void)
> > > @@ -1296,6 +1329,7 @@ void device_links_driver_bound(struct device *d=
ev)
> > >  {
> > >         struct device_link *link, *ln;
> > >         LIST_HEAD(sync_list);
> > > +       LIST_HEAD(queue_list);
> > >
> > >         /*
> > >          * If a device binds successfully, it's expected to have crea=
ted all
> > > @@ -1351,7 +1385,7 @@ void device_links_driver_bound(struct device *d=
ev)
> > >         if (defer_sync_state_count)
> > >                 __device_links_supplier_defer_sync(dev);
> > >         else
> > > -               __device_links_queue_sync_state(dev, &sync_list);
> > > +               __device_links_queue_sync_state(dev, &sync_list, &que=
ue_list);
> >
> > This path is really meant only for situations when the device has no
> > consumers. So, I don't think fine grained control is relevant.
>
> Okay, makes sense!
>
> >
> > >
> > >         list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_n=
ode) {
> > >                 struct device *supplier;
> > > @@ -1393,14 +1427,15 @@ void device_links_driver_bound(struct device =
*dev)
> > >                 if (defer_sync_state_count)
> > >                         __device_links_supplier_defer_sync(supplier);
> > >                 else
> > > -                       __device_links_queue_sync_state(supplier, &sy=
nc_list);
> > > +                       __device_links_queue_sync_state(supplier, &sy=
nc_list,
> > > +                                                       &queue_list);
> > >         }
> > >
> > >         dev->links.status =3D DL_DEV_DRIVER_BOUND;
> > >
> > >         device_links_write_unlock();
> > >
> > > -       device_links_flush_sync_list(&sync_list, dev);
> > > +       device_links_flush_sync_list(&sync_list, &queue_list, dev);
> > >  }
> > >
> > >  /**
> > > @@ -1516,6 +1551,7 @@ void device_links_driver_cleanup(struct device =
*dev)
> > >         }
> > >
> > >         list_del_init(&dev->links.defer_sync);
> > > +       list_del_init(&dev->links.queue_sync);
> > >         __device_links_no_driver(dev);
> > >
> > >         device_links_write_unlock();
> > > @@ -1808,7 +1844,7 @@ void fw_devlink_probing_done(void)
> > >         class_for_each_device(&devlink_class, NULL, &sync_list,
> > >                               fw_devlink_dev_sync_state);
> > >         device_links_write_unlock();
> > > -       device_links_flush_sync_list(&sync_list, NULL);
> > > +       device_links_flush_sync_list(&sync_list, NULL, NULL);
> > >  }
> > >
> > >  /**
> > > @@ -3169,6 +3205,7 @@ void device_initialize(struct device *dev)
> > >         INIT_LIST_HEAD(&dev->links.consumers);
> > >         INIT_LIST_HEAD(&dev->links.suppliers);
> > >         INIT_LIST_HEAD(&dev->links.defer_sync);
> > > +       INIT_LIST_HEAD(&dev->links.queue_sync);
> > >         dev->links.status =3D DL_DEV_NO_DRIVER;
> > >         dev_assign_dma_coherent(dev, dma_default_coherent);
> > >         swiotlb_dev_init(dev);
> > > diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> > > index 8ab010ddf709..b8f4d08bbd58 100644
> > > --- a/drivers/base/driver.c
> > > +++ b/drivers/base/driver.c
> > > @@ -239,6 +239,13 @@ int driver_register(struct device_driver *drv)
> > >                 pr_warn("Driver '%s' needs updating - please use "
> > >                         "bus_type methods\n", drv->name);
> > >
> > > +       if (drv->queue_sync_state && !drv->sync_state &&
> > > +           !drv->bus->sync_state) {
> > > +               pr_err("Driver '%s' or its bus_type needs ->sync_stat=
e()",
> > > +                      drv->name);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > >         other =3D driver_find(drv->name, drv->bus);
> > >         if (other) {
> > >                 pr_err("Error: Driver '%s' is already registered, "
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 56a96e41d2c9..6848b0a2c2d9 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -414,12 +414,14 @@ enum device_removable {
> > >   * @suppliers: List of links to supplier devices.
> > >   * @consumers: List of links to consumer devices.
> > >   * @defer_sync: Hook to global list of devices that have deferred sy=
nc_state.
> > > + * @defer_sync: Hook to global list of devices scheduled for queue_s=
ync_state.
> > >   * @status: Driver status information.
> > >   */
> > >  struct dev_links_info {
> > >         struct list_head suppliers;
> > >         struct list_head consumers;
> > >         struct list_head defer_sync;
> > > +       struct list_head queue_sync;
> > >         enum dl_dev_state status;
> > >  };
> > >
> > > diff --git a/include/linux/device/driver.h b/include/linux/device/dri=
ver.h
> > > index bbc67ec513ed..bc9ae1cbe03c 100644
> > > --- a/include/linux/device/driver.h
> > > +++ b/include/linux/device/driver.h
> > > @@ -68,6 +68,12 @@ enum probe_type {
> > >   *             be called at late_initcall_sync level. If the device =
has
> > >   *             consumers that are never bound to a driver, this func=
tion
> > >   *             will never get called until they do.
> > > + * @queue_sync_state: Similar to the ->sync_state() callback, but ca=
lled to
> > > + *             allow syncing device state to software state in a mor=
e fine
> > > + *             grained way. It is called when there is an updated st=
ate that
> > > + *             may be worth to consider for any of the consumers lin=
ked to
> > > + *             this device. If implemented, the ->sync_state() callb=
ack is
> > > + *             required too.
> >
> > Let's make it clear that if a device gets sync_state() callback, it
> > needs to sync the state independent of whether it has received any/all
> > "consumer_probed()".
>
> Right, good point! Let me clarify that!
>

Thanks,
Saravana

> >
> > Thanks,
> > Saravana
> >
> >
> > >   * @remove:    Called when the device is removed from the system to
> > >   *             unbind a device from this driver.
> > >   * @shutdown:  Called at shut-down time to quiesce the device.
> > > @@ -110,6 +116,7 @@ struct device_driver {
> > >
> > >         int (*probe) (struct device *dev);
> > >         void (*sync_state)(struct device *dev);
> > > +       void (*queue_sync_state)(struct device *dev);
> > >         int (*remove) (struct device *dev);
> > >         void (*shutdown) (struct device *dev);
> > >         int (*suspend) (struct device *dev, pm_message_t state);
> > > --
> > > 2.43.0
> > >
>
> Kind regards
> Uffe
