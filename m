Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E803BF692
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852504; cv=pass; b=o8HDwZ27PrI56jZ39oHTQeb/D0nwzavW1VJq9qh67OeOfn2qQlBBMPiBVsvkQkzRjipKMWc0ReTedz9EyLqUGi7FFruwBUw8KztmwXs5gXVGCZuehYoBI3Sxtwy8yXw/3rwCBqnFWXuQ1L334hE3sb1eFAgZhmXFhZYms9H5Q0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852504; c=relaxed/simple;
	bh=nCoV49HVym5KpFJq669SmgOv4OUFBlE42Ax7zUUgrZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PN9umJuV9FMSgFYqVhnwYVwhH7X0X4xWfoom02oQ36guAudjeeJf+W4xxh17t74uEvezGzgoJGpBlPk4n3okmS9CsVgbsqWOHtsmp6+fNu0rohWLlHHylUk+JBDhDBzOoBwxY37rxWF8ELnFqnW5tQqnyGnnO/vljvYzFM0qLI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYg/c4Bf; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYg/c4Bf"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dcdf60427so4676342e87.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 03:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776852501; cv=none;
        d=google.com; s=arc-20240605;
        b=OM3t6ppXC11rBZ+ieC5I0/ay1n8iEThR+k7+TWVI87K6L1sFo4u+VUwcCo6+QHLaAN
         s4sJ45XI3Z87OMsdCznJ9jp9X7hmwdDsZqyuDxIrs4TvQoIP+ij/jlCrr+O9iZ16BQZM
         TTzrmppzEDnKo4K59O239VmA3rwRvkvJcxHwDFWuSZAG4NA6jEjixChexmaHfE0LSq9g
         ldXkreRW/mLU1jBinAJAd7vT0THrO+bL0EirveWIKV0Tj9eUgvRG9IDL9DXWv/u1TMJk
         VcoMCN2cUh6TWA8EpExpy2MwboW3/vymoDCRUgIterI4J1BU3uxKx/DTwJi9arwBZFRx
         B1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uTyCSfRMVmFA3LOz4cC7W7FYlOyU1Jx/xl8KZgNvmJM=;
        fh=fUVaRWf8jFdaM/gZJRBiKtc5Wr5RBoz1x+DliBwiwUg=;
        b=ek/i/HryrzveSBc6wARl2dsz5lvGdkhxOTdOwrSgtw6pWAxqQpTZaCWRVCF5EKB1/B
         kHwvn4mAz7bPjy3eWrg/hW0HaT1jSEOMs9zpJILETCJd1QZqc6wxtLwSVWvMmVv0prSU
         4O5jspF+k93lYSICRF7ZNF3cM8PJ6b92J3FOIe7CCFJLdZuR3V/nAp/XpUt2cpMAI3Z6
         iclZt8WBKSdjvR8bw1Izq2v4swSQYOvxKiP8fmxVd5Vv5k3gKtovCvZrht006c5V7MWi
         0xHJEpzeLhF4bPrwTqn/eYxhbF4ErOcVPM+TtBcLNSRllM3fc52NQ3id/Wuxf3myQFqK
         9VKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852501; x=1777457301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uTyCSfRMVmFA3LOz4cC7W7FYlOyU1Jx/xl8KZgNvmJM=;
        b=DYg/c4Bf/NZB+OU155r8SPB4D6p9r92si9X+lYZgnwDmMwEXQFoMmr4HF7OhY/4TtH
         hUrr9fI0Kezdf3tm5mxlwIcxefekH+XhjKxtbdgk1zwIYiOtHS64sMy6P++aHDJz9ml+
         fcbdVcJfMJiLgqva2O3d1tcFrj3aNA8+sDbYgYjrEGwa39OdnNpq+gJQlSx/GRWY0mFd
         do5Q6rRX8ccCbx3v2pLm8+C+fxwdBdvRxrzgprTQEsxEnpzhaZk44dGAXtq3Txy/69Pn
         cnhhn9sdTprnRfYlgwX1iKPFlyqs+XwqxH0FFnuLEz3LMcLJ/dg0fkEFhFHRCN/raZ8f
         Tc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852501; x=1777457301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTyCSfRMVmFA3LOz4cC7W7FYlOyU1Jx/xl8KZgNvmJM=;
        b=Dpcox0/ZHcRVqEDmaRN9tXiO/Dtuol1196iQfD1EuDh57mfx95wiptOP2o5FJg12MB
         YvhnJma6eiKdEtQQ3C48Z5mA/03iiACT9Jhxy1EZE/7vLoZw4CXfJQ7hHeW9shxzZfC6
         mu6AakesE6E62c9NJ0KMeIOYxrW8ljO8S//xu6eojCGufYFMSYgpPKJB1x2bEb5Y7y7X
         0lBTP8Lggtd70SVrMS0LdM94JTsjTxXxCOacDdaeYQ3XXMbM62d9wqXsd70ATHuR7KHv
         h5TTRGKLOg3FkPwFfJjEBsRUhKpSL4G9EUH0XO6pO3ZTB3qWwdtxYMtXpw0XEgZzYqod
         yeVw==
X-Forwarded-Encrypted: i=1; AFNElJ/MGJj5F3hM0IwgQSVqLYV0qmlwEMylXAJDbNBR4Krr0X6PhH+WbK3a11aoXJR96hdm4KpO5krxxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU42FaieTAO17c95poBTCYjWAO93lURyFu1HMnSlaprUVC6S+s
	6C6hnVvvlsYrFkVKm0piME+wJAx8Tow1sUGwB4QbDZclSn0dgb3YxOhAgqFXo8oB6fDNX4ik9uu
	khDwhY2RggfNwxKrDosgj1q8+M3jHqBu/5v0tvxBnuQ==
X-Gm-Gg: AeBDieu7HUiDLx6738nJaFmbuBp7dPfeFl7O9P+7KX0uW63GcfSAwyNBXVDunZht7s5
	bTZPYiPDUkC1QyPHLBILFg6MRfFsgE3W02k1ajiIP0qh/55o6vcV2c2uZAYZDuMZ/8PDASGXmbN
	ILd+l+yHKGeMEPrLImvCbkLp3yWQ1qzTe9g2sdvEB69hXmrWrNptn/ugJcPz0wdNBQ2HvQ95mq0
	f8Y3BUGx+qaJiUd7Ai3d7k9Wbw7VruxfqWKWNn1dFl8LDgFIOWb14N9lUSnSvGCXk5PTmQBZj3p
	8w/Bmw4oQgUmtz3ml0U=
X-Received: by 2002:ac2:4c4b:0:b0:5a4:b0:a072 with SMTP id 2adb3069b0e04-5a4172ca655mr6734556e87.4.1776852500411;
 Wed, 22 Apr 2026 03:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <20260410104058.83748-2-ulf.hansson@linaro.org> <DHW8QPU1VU1F.3P6PH69HLFBYC@kernel.org>
In-Reply-To: <DHW8QPU1VU1F.3P6PH69HLFBYC@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Apr 2026 12:07:44 +0200
X-Gm-Features: AQROBzC5eJAyDlpSocEWC79YWE17Iafg8A3OHcUQDEnYvf-zjcf7j-wZjMNN0Zk
Message-ID: <CAPDyKFqMDPiqvqJrq5Qs6Tw4Sc7szG4G-=y0NFkNSPoNd9kdVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Apr 2026 at 13:23, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Fri Apr 10, 2026 at 12:40 PM CEST, Ulf Hansson wrote:
> > The common sync_state support isn't fine grained enough for some types of
> > suppliers, like power domains for example. Especially when a supplier
> > provides multiple independent power domains, each with their own set of
> > consumers. In these cases we need to wait for all consumers for all the
> > provided power domains before invoking the supplier's ->sync_state().
> >
> > To allow a more fine grained sync_state support to be implemented on per
> > supplier's driver basis, let's add a new optional callback. As soon as
> > there is an update worth to consider in regards to managing sync_state for
> > a supplier device, __device_links_queue_sync_state() invokes the callback.
> >
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/core.c           | 7 ++++++-
> >  include/linux/device/driver.h | 7 +++++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 09b98f02f559..4085a011d8ca 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1106,7 +1106,9 @@ int device_links_check_suppliers(struct device *dev)
> >   * Queues a device for a sync_state() callback when the device links write lock
> >   * isn't held. This allows the sync_state() execution flow to use device links
> >   * APIs.  The caller must ensure this function is called with
> > - * device_links_write_lock() held.
> > + * device_links_write_lock() held.  Note, if the optional queue_sync_state()
> > + * callback has been assigned too, it gets called for every update to allowing a
>
> s/allowing/allow/
>
> > + * more fine grained support to be implemented on per supplier basis.
> >   *
> >   * This function does a get_device() to make sure the device is not freed while
> >   * on this list.
> > @@ -1126,6 +1128,9 @@ static void __device_links_queue_sync_state(struct device *dev,
> >       if (dev->state_synced)
> >               return;
> >
> > +     if (dev->driver && dev->driver->queue_sync_state)
> > +             dev->driver->queue_sync_state(dev);
>
> This seems to be called without the device lock being held, which seems to allow
> the queue_sync_state() callback to execute concurrently with remove(). This
> opens the door for all kinds of UAF conditions in drivers.

If that were the case, this whole function would be unsafe even before
this change. I assume this isn't because of how the function is being
called, but I may be wrong.

Anyway, let me add a get/put_device() here somewhere, to ensure we
prevent this from happening. I assume that is what you are proposing?

>
> This also made me aware that the above dev_has_sync_state() is probably broken,
> as it also performs the following check without the device lock being held.
>
>         dev->driver && dev->driver->sync_state
>
> I think nothing prevents dev->driver to become NULL concurrently; in this case
> READ_ONCE() should be sufficient though as it doesn't execute the callback.
>
> I will send a patch for this.

Okay, thanks!

>
> > +
> >       list_for_each_entry(link, &dev->links.consumers, s_node) {
> >               if (!device_link_test(link, DL_FLAG_MANAGED))
> >                       continue;
> > diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> > index bbc67ec513ed..bc9ae1cbe03c 100644
> > --- a/include/linux/device/driver.h
> > +++ b/include/linux/device/driver.h
> > @@ -68,6 +68,12 @@ enum probe_type {
> >   *           be called at late_initcall_sync level. If the device has
> >   *           consumers that are never bound to a driver, this function
> >   *           will never get called until they do.
> > + * @queue_sync_state: Similar to the ->sync_state() callback, but called to
> > + *           allow syncing device state to software state in a more fine
> > + *           grained way. It is called when there is an updated state that
> > + *           may be worth to consider for any of the consumers linked to
> > + *           this device. If implemented, the ->sync_state() callback is
> > + *           required too.
>
> What happens if this is not the case? Maybe worth to check and warn about this
> in driver_register().

Good point!

I believe I should also add a check in dev_set_drv_queue_sync_state()
that is added in patch2.

>
> >   * @remove:  Called when the device is removed from the system to
> >   *           unbind a device from this driver.
> >   * @shutdown:        Called at shut-down time to quiesce the device.
> > @@ -110,6 +116,7 @@ struct device_driver {
> >
> >       int (*probe) (struct device *dev);
> >       void (*sync_state)(struct device *dev);
> > +     void (*queue_sync_state)(struct device *dev);
> >       int (*remove) (struct device *dev);
> >       void (*shutdown) (struct device *dev);
> >       int (*suspend) (struct device *dev, pm_message_t state);
> > --
> > 2.43.0
>

Thanks for reviewing!

Kind regards
Uffe
