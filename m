Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB2339705
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492612; cv=pass; b=HEkfo6qwJKh4i5x/ZqhGaENaKWbSlqXEUkIhnKooXvCUV49mxOxccO71GpXCa6szrEWg54IWBWcN65nwIvCo4eTSnhZucN7i78SgIvRizXtV2xQp0YUJosculoARnqTm/XTPv6ltovt+xCV4k8FdUtuZCNPKXficgAcoI8SR8d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492612; c=relaxed/simple;
	bh=PYGhSGFc4xeRoHpnWMOgoENudzXTN4E+9vHYPjT7edA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTIQrveEX9kbc1O+aUCWd22BZX6Dk91qifxgucYtaORH8fyxih1JntZY40+Q38GRIPJDn6TXhx8TNu5lCJe/8USBu4VwrYi5ln2lcyYRVIVBOomA27U4m4WKKeZWsm9RHCK/Rv9PfwjSGbSToRJwgQqczOKIBFffkfmYUWUIeWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D8o36ys2; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8o36ys2"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a4113ab355so3776237e87.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 02:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778492608; cv=none;
        d=google.com; s=arc-20240605;
        b=g0WFL4zW3WuTtjxTRHt07Kij96ijLVoZUlWe2O4fNv/hONOP7TuBkCmd8MoyTP8YqP
         rTR4XCu4hd/yyXp5nLt0DYbLY++kbrCjHBjvoP5h0d/fsq2bEn7hY1ZNb9dKWLuY6Gar
         OCTmMihnyXWMzfeYyKFHz0dOH/WLbfpNEwvzTluvFb177fjylloyUl1GJog6th/1buGo
         E+Ok1hZPthIkNR3Wq/9oSdEYJZhoSlRiNrZLlIbJrPjOvng9msJFHTLTOpDX5kHGdcxG
         hZK2rs97/3UOnoc7mmNhvXMIOA3e2YhwcyNx4k+PIpfIYYVF1JeGOvd6MByD9Cm3UhoM
         4Haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbmZ+eqccnWtG+CQ3VasipDd7HkDp6oeIP2UmZOr3rc=;
        fh=Z98r1I00ZOzF1WOJgIFKZA5mdRuHOckeUUn0DYxokFs=;
        b=Pq9/qS5Cq7toYtwJ1dZGQAu1kItxz2wcbHTHxnRnMy32rCtq2NrpSkKoy10d0bEIU2
         cusjbhUixRSWM9F58V0R00sen94O8M4/1ymCPTxD4hhluxI7UkeBPmXdTR3GTSnLOn6R
         QeTd1ofbCVGv5L42V+NsCQDmpset27sbuE8NuhAYec0FBxgviKz0+vrgKlpfqPC4j+9Q
         WHItgeyQ6JiGIgKvuvVeTy7jtv9pqXtm6Dz9bOh78WPZoqRWkOk+WOV6BvNXUIO76hGO
         HgnE6jLaG6Q5lnJpWtXOzMUUvK0aU+0Z45uPzcgF1JS+VTnsnBHrqSG/swUEzMvLzxCO
         xP+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778492608; x=1779097408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbmZ+eqccnWtG+CQ3VasipDd7HkDp6oeIP2UmZOr3rc=;
        b=D8o36ys2lmbvw2cF6ZvNI8RR0TeoEZVPbuPXJjz9WaaYWm4wzoVOpM+8M1gBx8rt1W
         bf97FG50yCreuWH/vvHcjThOLTsTeTBG07KAFt7fHUpC/6OTUB2mkKUHNn3RDtMQLvTz
         lbj6jS3KgHRxJ4GMrMx7GyRsqmzYFntcQMzqf9p1YQALAh6Wz8q2I933oKQBYe10iZci
         ijhnnD5RqK76isiOVHe7FiI4F7cRr0lVYSZJh6mYPyaS6Epor0Oah2qaTK/rT4ZsEbFK
         S79/RddIz/UE+RbrASae4FkPVadZZ8cN3yqZw68yRq/kIQvMyyH4VJlChllxsJHnyrtY
         7waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778492608; x=1779097408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbmZ+eqccnWtG+CQ3VasipDd7HkDp6oeIP2UmZOr3rc=;
        b=R3lQjBnpLSQtDoXhI8pH4Q/jjXirinRtXwo/zaJESKtJBu7XKz17Y0U1EUAxukBm1q
         KhMsSfN3jF7XZJMtGYo7nTeao8C8B7PaCwRH4i6EkDP9inD0eICIhtMByAoDIXR3kcgl
         5nmSk4kQWjSeK0LSbK0vs16SGM6hGWuraKiXATtfqiUjjGi2HZKVcMdMg7KCEVHeBGAI
         /uqqETZuLGUAW0tBptxKIm9ko8Ojix6BjRSFlCUhRQ9YwQM1UHkRKgF/lqFbEhhmaxxK
         xy3ghChzenGeLbFSKoFBgONW+xDu3rf+T1CFwLtasTK2G8smN2CEK5uGcG7OwEVUzNAD
         DJ4A==
X-Forwarded-Encrypted: i=1; AFNElJ9ZD7iYqeFUlGYQlLRI/nzQM2iXabgFYCvcq1LR5TQwHkvFvzXkvPG46pQPYRkSVdvt0bw3dCZP5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzv7T6IhaGrka2NZZZRFoGE14Tx1WpbRwIbbaCCZPauJgEiRBo
	NTT5DnGq73annW7Z4AlUwzAuVb/w4zoeYaCrQDrq1yF1otxrmBYzKNzJZQQ8kCP3nECL+6Ta4/l
	0+5wXFgleC6Xp7UoFLbnbzZUQxXnZLRp0+fRc7ZtLwA==
X-Gm-Gg: Acq92OHP5jc9HSuecbLjdp3CCxz438fO0dQxQ78PzcVKpQfqH6wyqJqZOcSl9K7h9UZ
	4WkBI/W5BTZEClA6jVdEERWV3w2ESDFCZGhS7d0WZ1nuMeFEJHylOBlGTjXR2AC1cX+2TrhqZgq
	LtgPW45Ib06zXiK8+1F3RlbY60X3inuxFCczthrSH8wgSJQRyL2LeblRY8R+V+HRLkUzLWAP/2C
	p6I+eyHWB+nVCLgiio6R4zZ3ei1z1iu5+Bbvz6dyLrjg88dtbhVblDFIr4imRiLGp5awPJiY0em
	aOX6xc+C
X-Received: by 2002:a05:6512:124c:b0:5a8:6747:b053 with SMTP id
 2adb3069b0e04-5a8a94c1fcemr3898167e87.27.1778492607818; Mon, 11 May 2026
 02:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-3-ulf.hansson@linaro.org> <CACRMN=fseD6-ODYnOEE42S9VKAb2F33kRv_VPYBGyPsitG2how@mail.gmail.com>
In-Reply-To: <CACRMN=fseD6-ODYnOEE42S9VKAb2F33kRv_VPYBGyPsitG2how@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 11:42:51 +0200
X-Gm-Features: AVHnY4J_ttWzrEuWuwteFabwVb29vcgy3RU9tdBAvYwb2cFb-EfkO4zeO_ONwPQ
Message-ID: <CAPDyKFq+F=zn_Coicb9LzyMtQ=b2Lrd+3Czx6r4ReY-DNyb9eg@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Saravana Kannan <saravanak@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 at 07:09, Saravana Kannan <saravanak@kernel.org> wrote:
>
> On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > The common sync_state support isn't fine grained enough for some types =
of
> > suppliers, like power domains for example. Especially when a supplier
> > provides multiple independent power domains, each with their own set of
> > consumers. In these cases we need to wait for all consumers for all the
> > provided power domains before invoking the supplier's ->sync_state().
> >
> > To allow a more fine grained sync_state support to be implemented on pe=
r
> > supplier's driver basis, let's add a new optional callback. As soon as
> > there is an update worth to consider in regards to managing sync_state =
for
> > a supplier device, __device_links_queue_sync_state() queues the device =
in a
> > list, allowing the new callback to be invoked when flushing the list in
> > device_links_flush_sync_list().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v3:
> >         - Re-worked the approach to use a list to queue/flush devices f=
or
> >         ->queue_sync_state(). This should make sure the device lock is =
being
> >         held when it's needed, as pointed out by Danilo.
> >
>
> Hi Ulf,
>
> Thanks for working on this!
>
> And please bear with my slow replies.

I will try, but taking more than 2 months to reply isn't sustainable,
I think. Let's hope you can get some more bandwidth for reviews when
moving forward.

>
> > ---
> >  drivers/base/base.h           | 18 ++++++++
> >  drivers/base/core.c           | 77 ++++++++++++++++++++++++++---------
> >  drivers/base/driver.c         |  7 ++++
> >  include/linux/device.h        |  2 +
> >  include/linux/device/driver.h |  7 ++++
> >  5 files changed, 91 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 30b416588617..c8be24af92c3 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -196,6 +196,24 @@ static inline void dev_sync_state(struct device *d=
ev)
> >                 dev->driver->sync_state(dev);
> >  }
> >
> > +static inline bool dev_has_queue_sync_state(struct device *dev)
>
> Let's please pick a better name. This is too similar to the actual
> queue function you call __device_links_queue_sync_state() and is very
> confusing. Maybe something that has a meaning along the lines of
> "another consumer probed". So, maybe:
> * consumer_probed()
> * change_of_active_consumers()

The whole point of naming it "queue_sync_state" was exactly to refer
to __device_links_queue_sync_state(). The point is, the callback can't
be invoked unless __device_links_queue_sync_state() has been called
for the device first.

Not sure why you think that is confusing? To me, that is rather the
opposite. :-)

Before deciding on another name, note also that
__device_links_queue_sync_state() is called when resuming sync_state
from device_links_supplier_sync_state_resume() and from
device_links_driver_bound(). I am not sure "consumer_probed" a good
name that covers both of these cases; what do you think?

>
> I'm going to refer to this new callback as "consumer_probed()" in the
> rest of my replies so I can keep it straight in my head.
>
> > +{
> > +       struct device_driver *drv;
> > +
> > +       if (!dev)
> > +               return false;
> > +       drv =3D READ_ONCE(dev->driver);
> > +       if (drv && drv->queue_sync_state)
> > +               return true;
> > +       return false;
> > +}
> > +
> > +static inline void dev_queue_sync_state(struct device *dev)
> > +{
> > +       if (dev->driver && dev->driver->queue_sync_state)
> > +               dev->driver->queue_sync_state(dev);
> > +}
> > +
> >  int driver_add_groups(const struct device_driver *drv, const struct at=
tribute_group **groups);
> >  void driver_remove_groups(const struct device_driver *drv, const struc=
t attribute_group **groups);
> >  void device_driver_detach(struct device *dev);
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d49420e066de..f1f95b3c81e5 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1101,15 +1101,18 @@ int device_links_check_suppliers(struct device =
*dev)
> >  /**
> >   * __device_links_queue_sync_state - Queue a device for sync_state() c=
allback
> >   * @dev: Device to call sync_state() on
> > - * @list: List head to queue the @dev on
> > + * @s_list: List head for the sync_state to queue the @dev on
> > + * @q_list: List head for the queue_sync_state to queue the @dev on
> >   *
> >   * Queues a device for a sync_state() callback when the device links w=
rite lock
> >   * isn't held. This allows the sync_state() execution flow to use devi=
ce links
> >   * APIs.  The caller must ensure this function is called with
> > - * device_links_write_lock() held.
> > + * device_links_write_lock() held.  Note, if the optional queue_sync_s=
tate()
> > + * callback has been assigned too, the device is queued for that list =
to allow a
> > + * more fine grained support to be implemented on per supplier basis.
>
> Why not keep this in the same format as the existing doc? Something like:
> If option list xxx is provided, queues the device for the
> consumer_probed() callback.

Okay, let me clarify this.

>
> >   *
> >   * This function does a get_device() to make sure the device is not fr=
eed while
> > - * on this list.
> > + * on the corresponding list.
> >   *
> >   * So the caller must also ensure that device_links_flush_sync_list() =
is called
> >   * as soon as the caller releases device_links_write_lock().  This is =
necessary
> > @@ -1117,7 +1120,8 @@ int device_links_check_suppliers(struct device *d=
ev)
> >   * put_device() is called on this device.
> >   */
> >  static void __device_links_queue_sync_state(struct device *dev,
> > -                                           struct list_head *list)
> > +                                           struct list_head *s_list,
> > +                                           struct list_head *q_list)
> >  {
> >         struct device_link *link;
> >
> > @@ -1129,8 +1133,14 @@ static void __device_links_queue_sync_state(stru=
ct device *dev,
> >         list_for_each_entry(link, &dev->links.consumers, s_node) {
> >                 if (!device_link_test(link, DL_FLAG_MANAGED))
> >                         continue;
> > -               if (link->status !=3D DL_STATE_ACTIVE)
> > +               if (link->status !=3D DL_STATE_ACTIVE) {
> > +                       if (dev_has_queue_sync_state(dev) &&
> > +                           list_empty(&dev->links.queue_sync)) {
> > +                               get_device(dev);
> > +                               list_add_tail(&dev->links.queue_sync, q=
_list);
> > +                       }
> >                         return;
> > +               }
> >         }
> >
> >         /*
> > @@ -1144,25 +1154,28 @@ static void __device_links_queue_sync_state(str=
uct device *dev,
> >                 return;
> >
> >         get_device(dev);
> > -       list_add_tail(&dev->links.defer_sync, list);
> > +       list_add_tail(&dev->links.defer_sync, s_list);
> >  }
> >
> >  /**
> > - * device_links_flush_sync_list - Call sync_state() on a list of devic=
es
> > - * @list: List of devices to call sync_state() on
> > + * device_links_flush_sync_list - Call sync_state callbacks for the de=
vices
> > + * @s_list: List of devices to call sync_state() on
> > + * @q_list: List of devices to call queue_sync_state() on
> >   * @dont_lock_dev: Device for which lock is already held by the caller
> >   *
> > - * Calls sync_state() on all the devices that have been queued for it.=
 This
> > - * function is used in conjunction with __device_links_queue_sync_stat=
e(). The
> > - * @dont_lock_dev parameter is useful when this function is called fro=
m a
> > - * context where a device lock is already held.
> > + * Calls sync_state() and queue_sync_state() on all the devices that h=
ave been
> > + * queued for it. This function is used in conjunction with
> > + * __device_links_queue_sync_state(). The @dont_lock_dev parameter is =
useful
> > + * when this function is called from a context where a device lock is =
already
> > + * held.
> >   */
> > -static void device_links_flush_sync_list(struct list_head *list,
> > +static void device_links_flush_sync_list(struct list_head *s_list,
> > +                                        struct list_head *q_list,
> >                                          struct device *dont_lock_dev)
> >  {
> >         struct device *dev, *tmp;
> >
> > -       list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
> > +       list_for_each_entry_safe(dev, tmp, s_list, links.defer_sync) {
> >                 list_del_init(&dev->links.defer_sync);
> >
> >                 if (dev !=3D dont_lock_dev)
> > @@ -1175,6 +1188,25 @@ static void device_links_flush_sync_list(struct =
list_head *list,
> >
> >                 put_device(dev);
> >         }
> > +
> > +       if (!q_list)
> > +               return;
> > +
> > +       list_for_each_entry_safe(dev, tmp, q_list, links.queue_sync) {
> > +               list_del_init(&dev->links.queue_sync);
> > +
> > +               if (dev !=3D dont_lock_dev)
> > +                       device_lock(dev);
> > +
> > +               device_links_write_lock();
> > +               dev_queue_sync_state(dev);
> > +               device_links_write_unlock();
> > +
> > +               if (dev !=3D dont_lock_dev)
> > +                       device_unlock(dev);
> > +
> > +               put_device(dev);
> > +       }
> >  }
> >
> >  void device_links_supplier_sync_state_pause(void)
> > @@ -1188,6 +1220,7 @@ void device_links_supplier_sync_state_resume(void=
)
> >  {
> >         struct device *dev, *tmp;
> >         LIST_HEAD(sync_list);
> > +       LIST_HEAD(queue_list);
> >
> >         device_links_write_lock();
> >         if (!defer_sync_state_count) {
> > @@ -1204,12 +1237,12 @@ void device_links_supplier_sync_state_resume(vo=
id)
> >                  * sync_list because defer_sync is used for both lists.
> >                  */
> >                 list_del_init(&dev->links.defer_sync);
> > -               __device_links_queue_sync_state(dev, &sync_list);
> > +               __device_links_queue_sync_state(dev, &sync_list, &queue=
_list);
> >         }
> >  out:
> >         device_links_write_unlock();
> >
> > -       device_links_flush_sync_list(&sync_list, NULL);
> > +       device_links_flush_sync_list(&sync_list, &queue_list, NULL);
> >  }
> >
> >  static int sync_state_resume_initcall(void)
> > @@ -1296,6 +1329,7 @@ void device_links_driver_bound(struct device *dev=
)
> >  {
> >         struct device_link *link, *ln;
> >         LIST_HEAD(sync_list);
> > +       LIST_HEAD(queue_list);
> >
> >         /*
> >          * If a device binds successfully, it's expected to have create=
d all
> > @@ -1351,7 +1385,7 @@ void device_links_driver_bound(struct device *dev=
)
> >         if (defer_sync_state_count)
> >                 __device_links_supplier_defer_sync(dev);
> >         else
> > -               __device_links_queue_sync_state(dev, &sync_list);
> > +               __device_links_queue_sync_state(dev, &sync_list, &queue=
_list);
>
> This path is really meant only for situations when the device has no
> consumers. So, I don't think fine grained control is relevant.

Okay, makes sense!

>
> >
> >         list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_nod=
e) {
> >                 struct device *supplier;
> > @@ -1393,14 +1427,15 @@ void device_links_driver_bound(struct device *d=
ev)
> >                 if (defer_sync_state_count)
> >                         __device_links_supplier_defer_sync(supplier);
> >                 else
> > -                       __device_links_queue_sync_state(supplier, &sync=
_list);
> > +                       __device_links_queue_sync_state(supplier, &sync=
_list,
> > +                                                       &queue_list);
> >         }
> >
> >         dev->links.status =3D DL_DEV_DRIVER_BOUND;
> >
> >         device_links_write_unlock();
> >
> > -       device_links_flush_sync_list(&sync_list, dev);
> > +       device_links_flush_sync_list(&sync_list, &queue_list, dev);
> >  }
> >
> >  /**
> > @@ -1516,6 +1551,7 @@ void device_links_driver_cleanup(struct device *d=
ev)
> >         }
> >
> >         list_del_init(&dev->links.defer_sync);
> > +       list_del_init(&dev->links.queue_sync);
> >         __device_links_no_driver(dev);
> >
> >         device_links_write_unlock();
> > @@ -1808,7 +1844,7 @@ void fw_devlink_probing_done(void)
> >         class_for_each_device(&devlink_class, NULL, &sync_list,
> >                               fw_devlink_dev_sync_state);
> >         device_links_write_unlock();
> > -       device_links_flush_sync_list(&sync_list, NULL);
> > +       device_links_flush_sync_list(&sync_list, NULL, NULL);
> >  }
> >
> >  /**
> > @@ -3169,6 +3205,7 @@ void device_initialize(struct device *dev)
> >         INIT_LIST_HEAD(&dev->links.consumers);
> >         INIT_LIST_HEAD(&dev->links.suppliers);
> >         INIT_LIST_HEAD(&dev->links.defer_sync);
> > +       INIT_LIST_HEAD(&dev->links.queue_sync);
> >         dev->links.status =3D DL_DEV_NO_DRIVER;
> >         dev_assign_dma_coherent(dev, dma_default_coherent);
> >         swiotlb_dev_init(dev);
> > diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> > index 8ab010ddf709..b8f4d08bbd58 100644
> > --- a/drivers/base/driver.c
> > +++ b/drivers/base/driver.c
> > @@ -239,6 +239,13 @@ int driver_register(struct device_driver *drv)
> >                 pr_warn("Driver '%s' needs updating - please use "
> >                         "bus_type methods\n", drv->name);
> >
> > +       if (drv->queue_sync_state && !drv->sync_state &&
> > +           !drv->bus->sync_state) {
> > +               pr_err("Driver '%s' or its bus_type needs ->sync_state(=
)",
> > +                      drv->name);
> > +               return -EINVAL;
> > +       }
> > +
> >         other =3D driver_find(drv->name, drv->bus);
> >         if (other) {
> >                 pr_err("Error: Driver '%s' is already registered, "
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 56a96e41d2c9..6848b0a2c2d9 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -414,12 +414,14 @@ enum device_removable {
> >   * @suppliers: List of links to supplier devices.
> >   * @consumers: List of links to consumer devices.
> >   * @defer_sync: Hook to global list of devices that have deferred sync=
_state.
> > + * @defer_sync: Hook to global list of devices scheduled for queue_syn=
c_state.
> >   * @status: Driver status information.
> >   */
> >  struct dev_links_info {
> >         struct list_head suppliers;
> >         struct list_head consumers;
> >         struct list_head defer_sync;
> > +       struct list_head queue_sync;
> >         enum dl_dev_state status;
> >  };
> >
> > diff --git a/include/linux/device/driver.h b/include/linux/device/drive=
r.h
> > index bbc67ec513ed..bc9ae1cbe03c 100644
> > --- a/include/linux/device/driver.h
> > +++ b/include/linux/device/driver.h
> > @@ -68,6 +68,12 @@ enum probe_type {
> >   *             be called at late_initcall_sync level. If the device ha=
s
> >   *             consumers that are never bound to a driver, this functi=
on
> >   *             will never get called until they do.
> > + * @queue_sync_state: Similar to the ->sync_state() callback, but call=
ed to
> > + *             allow syncing device state to software state in a more =
fine
> > + *             grained way. It is called when there is an updated stat=
e that
> > + *             may be worth to consider for any of the consumers linke=
d to
> > + *             this device. If implemented, the ->sync_state() callbac=
k is
> > + *             required too.
>
> Let's make it clear that if a device gets sync_state() callback, it
> needs to sync the state independent of whether it has received any/all
> "consumer_probed()".

Right, good point! Let me clarify that!

>
> Thanks,
> Saravana
>
>
> >   * @remove:    Called when the device is removed from the system to
> >   *             unbind a device from this driver.
> >   * @shutdown:  Called at shut-down time to quiesce the device.
> > @@ -110,6 +116,7 @@ struct device_driver {
> >
> >         int (*probe) (struct device *dev);
> >         void (*sync_state)(struct device *dev);
> > +       void (*queue_sync_state)(struct device *dev);
> >         int (*remove) (struct device *dev);
> >         void (*shutdown) (struct device *dev);
> >         int (*suspend) (struct device *dev, pm_message_t state);
> > --
> > 2.43.0
> >

Kind regards
Uffe
