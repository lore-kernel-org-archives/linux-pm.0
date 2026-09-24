Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C82C3757
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235001; cv=none; b=cAWbmrpdM0ht663GUG9oRY4pAsU8h5GLc0tU0npnACFtVzTTjti1K8A6OrY/56j2w/lEIIKpIqcymKPiCSQzd2k4gcsJtjesTfzc7Rv28LjCOQQWzueszCnntyOXMIirl07VS3u6X42OljMWu2el+XS8iiAKJePAKzkDRamjS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235001; c=relaxed/simple;
	bh=CMvlXvQYKT+sEUJAuGnvK2SuGOnVwIle5gvPOXA8pbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dp4SU+viSJNYpbstn9FjfbpYjTbax2SBjW5DU03TQh2U1BR0w7gUui7x5f9qVYW8xnkIN2vEj80MLqG/wNafX6Z2K3Tn56mwVvuE+FxvG0SzAndGBIxS7r8bNHJjMqdO+u7x4Vypa90+aosMAadcLJ/2UwZ7q7QEs5opd7m21Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCIcLM0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCIcLM0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9931F0089A
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790234998;
	bh=o6e4OwppNAvQffTq3Mizz05+V9H4+0j9jUd7tnJWyV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LCIcLM0N99+Hbop+wqdHdOkenjitA5y/3608MdBzkOzFotLGp6gVNHaSFVDWw0R5p
	 aF01uR+29naehlScZFBv5fnawbZg5H9xR4NOcv0D43X6Z47e2HhzZ+0OLenR3Mbgr+
	 qZgvMTTC+VLE1zySrodN36DdX7fRUxq2jU8uVNwZk1/WLcIkLvqiCnLQqWJ8h9GdTO
	 DGy3Ox7GEfYF64dQZtvL6cRwI2FmliT+l9xrBZcwk5Zwaq1ecQ1D1cm4NHu7i+ycC1
	 B3f2YKA3eNBuxabLGwJ6GapVklHVMMN7mQiLYK9PS+gPWBlOoy5l9GWERgZY6cDzMh
	 bGWLEtDSHTJKA==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a985e8fcddso2380589a12.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 00:29:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByV28tFh1+05SBM+QJPEOJ/o9JGXM3k7ImXgW4izK8xCYv8puHfq7RI2ekIrgGt98Y6k9Oua0jZXg==@vger.kernel.org
X-Gm-Message-State: AFuF++lXB956cAspFdkOLGYdqTERxWCjFm7U03gKbThphB+NWYaUSQD3
	xwbkfUJRlgyI4u0KHIsLXucXaNqgglAGm4K2cwgrrzOqXLP5V9rOmbwXhfcjxN06kF6Cygpg3Uc
	M4v7C5uw07yPZTX5K+gDObfkq/HPAPYY=
X-Received: by 2002:a05:6402:454c:b0:6a9:a362:4646 with SMTP id
 4fb4d7f45d1cf-6aac8f6a1cfmr1047631a12.14.1790234997231; Thu, 24 Sep 2026
 00:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com> <20260626-clk-sync-state-v1-1-4156d8196dc8@redhat.com>
In-Reply-To: <20260626-clk-sync-state-v1-1-4156d8196dc8@redhat.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Thu, 24 Sep 2026 00:29:45 -0700
X-Gmail-Original-Message-ID: <CACRMN=dAxriWU7Age3g9o_d6zyz8hj2p76vHXJSs7sCFxSwuWw@mail.gmail.com>
X-Gm-Features: AclHuK-NBcm4IMn1oaE4L5Cw3_gYXDaNTrtvMEQJ9SGgnBgHjAAixNmXtLBSKIk
Message-ID: <CACRMN=dAxriWU7Age3g9o_d6zyz8hj2p76vHXJSs7sCFxSwuWw@mail.gmail.com>
Subject: Re: [PATCH 1/4] driver: core: introduce dev_add_sync_state()
To: Brian Masney <bmasney@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Xuyang Dong <dongxuyang@eswincomputing.com>, 
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, Maxime Ripard <mripard@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Abel Vesa <abelvesa@kernel.org>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 9:33=E2=80=AFAM Brian Masney <bmasney@redhat.com> w=
rote:
>
> We have cases where a device node represents a provider for multiple
> types of resources, like clocks, power-domains, resets, etc. We
> currently have dev_set_drv_sync_state() where a framework or driver
> can set the sync_state callback for a device node, however it currently
> only supports a single sync_state callback.
>
> The pmdomain subsystem currently sets up a sync_state callback in the
> core framework, and the clk subsystem will setup it's own separate
> sync_state callback in the core framework. These can collide with each
> other on some types of devices that have multiple types of resources.
> Additionally, some clk drivers already have their own separate
> sync_state callback already defined.
>
> Let's introduce support for allowing drivers and frameworks to add their
> own sync_state callback via a new function dev_add_sync_state() so that
> multiple sync_state callbacks can coexist.

I had already thought about this scenario when I implemented the
framework. Your driver should just set its sync_state() callback and
that my_drv_sync_state() will simply call the sync state helper
functions provided by the relevant frameworks.

This link list is adding a lot of code without any clear benefit. And
it also doesn't work for drivers that might care for a particular
sequence of framework sync_state() callbacks. Instead your are forced
to follow whatever order in which the frameworks are adding the sync
state callbacks to your device.

I don't think this patch is a good idea.

-Saravana

>
> Link: https://lore.kernel.org/linux-clk/CAPx+jO9JiV16ePLk59hTQzEMnA96Va6N=
s4jqJbwyZ6oTT0AjXA@mail.gmail.com/
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  drivers/base/base.h    |  7 +++++++
>  drivers/base/core.c    | 29 +++++++++++++++++++++++++++++
>  include/linux/device.h | 11 +++++++++++
>  3 files changed, 47 insertions(+)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index a5b7abc10ff0..339db4afbeb4 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -178,6 +178,8 @@ static inline bool dev_has_sync_state(struct device *=
dev)
>
>         if (!dev)
>                 return false;
> +       if (!list_empty(&dev->sync_state_list))
> +               return true;
>         drv =3D READ_ONCE(dev->driver);
>         if (drv && drv->sync_state)
>                 return true;
> @@ -188,10 +190,15 @@ static inline bool dev_has_sync_state(struct device=
 *dev)
>
>  static inline void dev_sync_state(struct device *dev)
>  {
> +       struct sync_state_entry *entry;
> +
>         if (dev->bus->sync_state)
>                 dev->bus->sync_state(dev);
>         else if (dev->driver && dev->driver->sync_state)
>                 dev->driver->sync_state(dev);
> +
> +       list_for_each_entry(entry, &dev->sync_state_list, node)
> +               entry->fn(dev);
>  }
>
>  int driver_add_groups(const struct device_driver *drv,
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4d026682944f..acc12f402dd3 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2612,6 +2612,7 @@ EXPORT_SYMBOL_GPL(device_show_string);
>  static void device_release(struct kobject *kobj)
>  {
>         struct device *dev =3D kobj_to_dev(kobj);
> +       struct sync_state_entry *entry, *tmp;
>         struct device_private *p =3D dev->p;
>
>         /*
> @@ -2625,6 +2626,11 @@ static void device_release(struct kobject *kobj)
>          */
>         devres_release_all(dev);
>
> +       list_for_each_entry_safe(entry, tmp, &dev->sync_state_list, node)=
 {
> +               list_del(&entry->node);
> +               kfree(entry);
> +       }
> +
>         kfree(dev->dma_range_map);
>         kfree(dev->driver_override.name);
>
> @@ -3239,12 +3245,35 @@ void device_initialize(struct device *dev)
>         INIT_LIST_HEAD(&dev->links.consumers);
>         INIT_LIST_HEAD(&dev->links.suppliers);
>         INIT_LIST_HEAD(&dev->links.defer_sync);
> +       INIT_LIST_HEAD(&dev->sync_state_list);
>         dev->links.status =3D DL_DEV_NO_DRIVER;
>         dev_assign_dma_coherent(dev, dma_default_coherent);
>         swiotlb_dev_init(dev);
>  }
>  EXPORT_SYMBOL_GPL(device_initialize);
>
> +int dev_add_sync_state(struct device *dev,
> +                          void (*fn)(struct device *dev))
> +{
> +       struct sync_state_entry *entry;
> +
> +       if (!dev || !dev->driver)
> +               return 0;
> +
> +       list_for_each_entry(entry, &dev->sync_state_list, node)
> +               if (entry->fn =3D=3D fn)
> +                       return 0;
> +
> +       entry =3D kmalloc_obj(*entry);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       entry->fn =3D fn;
> +       list_add_tail(&entry->node, &dev->sync_state_list);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_add_sync_state);
> +
>  struct kobject *virtual_device_parent(void)
>  {
>         static struct kobject *virtual_dir =3D NULL;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 7b2baffdd2f5..b7a3dd4b56ed 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -642,6 +642,8 @@ enum struct_device_flags {
>   * @driver_override: Driver name to force a match.  Do not touch directl=
y; use
>   *                  device_set_driver_override() instead.
>   * @links:     Links to suppliers and consumers of this device.
> + * @sync_state_list: List of sync_state callbacks added by subsystem
> + *             frameworks (e.g. clk, genpd) via dev_add_sync_state().
>   * @power:     For device power management.
>   *             See Documentation/driver-api/pm/devices.rst for details.
>   * @pm_domain: Provide callbacks that are executed during system suspend=
,
> @@ -723,6 +725,7 @@ struct device {
>                                          */
>
>         struct dev_links_info   links;
> +       struct list_head        sync_state_list;
>         struct dev_pm_info      power;
>         struct dev_pm_domain    *pm_domain;
>
> @@ -1137,6 +1140,14 @@ static inline int dev_set_drv_sync_state(struct de=
vice *dev,
>         return 0;
>  }
>
> +struct sync_state_entry {
> +       struct list_head        node;
> +       void                    (*fn)(struct device *dev);
> +};
> +
> +int dev_add_sync_state(struct device *dev,
> +                          void (*fn)(struct device *dev));
> +
>  static inline void dev_set_removable(struct device *dev,
>                                      enum device_removable removable)
>  {
>
> --
> 2.54.0
>
