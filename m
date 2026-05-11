Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C723BD62F
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490695; cv=pass; b=Qb9IoGb3ygplfOFkIp4NEUSFbTQbMClN3MS3Bwly9f5PMAtymMXTuhBq6qI/zBQacHMdFx7BAGUJgtqaeR8kn9ZU+B+Ykojkfhq7puvp8OsK/qDXPOOA4IPdFDaweFUkOsJpgDWcj/ODBjYidM0aGRCr60kad4yYZNJBypVnVCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490695; c=relaxed/simple;
	bh=MRJbumH1Qj2PiCHvDxYaH3WtUhljSOS/HFExYbHcY30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnN8quGy6F/xYjshKv1I7lE36LAihNy1clS07H4MSOXHfoznsqP9Kqnhx75tJV7rKFcetiCJOfkOXsKKCPgVEG9qwFnXWgTA/4jMgCmGdkuDUkviSc6uqqXhHGDIej7t21WxUTxMdI0VWPXYo0dLRjVrRnziWIdEDxSR77Ugc54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qEPDLbDw; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEPDLbDw"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a858881ad2so4237108e87.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 02:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778490691; cv=none;
        d=google.com; s=arc-20240605;
        b=S5TBk0A9DSBTKs5t1H6XwuLacZACyyYlLCMpDkIY01sLdjpJHP0uyDV1yJoiOklDCq
         39yOHY4GctzUR4wDlx7OKcJF7dh1Jx0e7tSzl5IkT73IIVv+6+mLVvqyk9BpVBTN5TEp
         A9OYMGY3snzKW371F/cxYdE4rb2qerIG8d/IrFXVBe3Lu8CPw07d8bS2WnusepWvrt/2
         pNPVNlExIiJrDpgNOl4KgzK0BhJgnL7LnBWE2S2wgOQyzspXz+wiE9KIOW1fkO/ttQk1
         ebPoE6JkBU+hgw5Ds7M21XjofHdGII8+0kj4fCKbHsy10tR+ng6+27swMZkRszmJFkC2
         8XTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+uAedvwPnfb2fItLrrMcsYtMN0ti5L4NDxTX7XDN5FA=;
        fh=8J2pXTGUQ/7e4pa0vxDJMtgppdoHLE7HNCc/W1st6y4=;
        b=WdJD1j1lbuZWuVy7e3FquzDqph8ktyHKwg8t88W4yO584TTZoRJ/ZvFAVYDJWJyHu9
         3jJNKK1TBVGtlujTdW1KAvAn98vpwpgiFJcLbtPEcsJpKFVC0Dk7qBi/7tXdhH3r3asB
         cCKPUy69hjJFcmHUIONfX1UnPGcRzfHVahd9wUpdpgWfTKu3avYfAC/Om4jofOa/gK6D
         W2h3BfgtekF55ZG5jdmS6AA2UDgCBQ7Y0jCBH3tX2NYkAXQ7ntFS46OGYg/ITKeZo0W3
         8HLDU06eO6opl5dbJ4T5O6RrvKhxnLZ7TJrqH76zXjkOORkhoS+6uwL2NNENOCMA7676
         vopA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778490691; x=1779095491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+uAedvwPnfb2fItLrrMcsYtMN0ti5L4NDxTX7XDN5FA=;
        b=qEPDLbDwDtHnyylhbXCZ8WjXq1eW/uN+6EVcoyQZlTUGINaHW4DPADybVlx75EKqau
         k/E7TadYIj/QDA27YNCZa9ahCfLWBJ79q3pSb/nZ8avO+/aGUaWACPsHPASExpZyrN7b
         FUoxga6a1KEhkjkeeipKPDQUIHpQban7dFD4qLDv3e9sa0umwJsE2OjQmgykZksePpih
         M5TsyJUQAWNITIh0GqjVH7QlDITSImD2ik0MRgiidcPVC0tBbQeW7v3zS9VAIG4C9mnF
         hAUB2qixxSD6V2MVVyNyKElgSWK0sOQQNrVxHNUGVZX1AMw1s332Wb7r6QwFasIqZVox
         R6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490691; x=1779095491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uAedvwPnfb2fItLrrMcsYtMN0ti5L4NDxTX7XDN5FA=;
        b=dPJWQ/R0V5PssyhQrdc04JfNDQ5PTqhfy+486cykqnYV5wv4gSFtPS/+d7C1Fz14b5
         S84sN4sxF8Zx9Ad/ZdLRKDOJfhQj8W9fA3ypr5CQQ+ycDcbZ8MfZwJkTg2myWs/15PAs
         GudAFSJP/I6xBEIrX4u5aGjhvFGDEARef5UdBOQKncpvbqEtKcB+Cm9qF2t6dtCSfErZ
         dAcMpPnnieCl31XJziGi7Hc1TD2DPVKW5LWurD/8IgLwxsZRUA9qoAqQRCn45wBlJM8x
         TMQda4zRdIxnt+mP3HGem9OzhfW+EnSUomcY22XoHa014p91rAiFRugmLWsla0wUBxrv
         pz4A==
X-Forwarded-Encrypted: i=1; AFNElJ/QigGT4kdvLf7FPjVmCG+BBa1iQzSZJfpuIW3jXBKYzx8O8h+HsQYPob9tzzyIkxexol3ziZGVfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Nzu7O7Rl7ueiEImBXXimNSJfqzjWcveWE8bFKdRsAQXLztqh
	Jo+6gF+RDNoD0OnVEOXuWjYrbvYQdDX1dZBJ/xJdz+5wwB9CeNLt6vsSX24kDZTRlZ9JQK6h824
	KOdvbat+ue3t/AtD+7KjtGzrY0T7jW5cEVMfSgDWV1Q==
X-Gm-Gg: Acq92OH8+6UjaXUhJkNURokLqyLIAXl3PGacR7V+pt6Q70A/oYVx1TqwmxqYX2z1K0X
	K7iQxNMbkEPYXY+Q+6Z6PmN52y28NmthydPkLBeM5cElGPMe4WuaLMYw2VqnVo69dj82nKt9H3a
	l7yVE0LMnfteafkZFjAHXAbcb49218zCX5NZJZoOn1/O1fsHgqYSGIJy43xyHQ/ytkW6ElfcSS9
	NcBmPrHOzTHS3NWsvFw8ZObyTfnxYzzqfjMwf/VwD1vdQ7HtfftZlA0LHs1nWHw3bK3OxGeI3CL
	fB1ilUUN
X-Received: by 2002:a05:6512:2386:b0:5a4:194c:d897 with SMTP id
 2adb3069b0e04-5a887ae2025mr7537077e87.12.1778490691163; Mon, 11 May 2026
 02:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-3-ulf.hansson@linaro.org> <DIDI6UCUFTWA.3GANQE923DAP9@kernel.org>
In-Reply-To: <DIDI6UCUFTWA.3GANQE923DAP9@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 11:10:54 +0200
X-Gm-Features: AVHnY4LZfAVNtlYlp8J8g6MEIDVkGfD08Ggh7z8GEXqctAp9-Wl133JAWYXxmAE
Message-ID: <CAPDyKFrju3R1t9-a=N6j6qmWoULFq07bfkWhg5g6ZdOvYD3MOA@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
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

On Fri, 8 May 2026 at 20:23, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Fri May 8, 2026 at 2:38 PM CEST, Ulf Hansson wrote:
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 30b416588617..c8be24af92c3 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -196,6 +196,24 @@ static inline void dev_sync_state(struct device *dev)
> >               dev->driver->sync_state(dev);
> >  }
> >
> > +static inline bool dev_has_queue_sync_state(struct device *dev)
> > +{
> > +     struct device_driver *drv;
> > +
> > +     if (!dev)
> > +             return false;
> > +     drv = READ_ONCE(dev->driver);
> > +     if (drv && drv->queue_sync_state)
> > +             return true;
> > +     return false;
> > +}
> > +
> > +static inline void dev_queue_sync_state(struct device *dev)
> > +{
>
> Let's add device_lock_assert(dev), as this function requires it to be held.
>
> > +     if (dev->driver && dev->driver->queue_sync_state)
> > +             dev->driver->queue_sync_state(dev);
> > +}
>
> <snip>
>
> > @@ -1175,6 +1188,25 @@ static void device_links_flush_sync_list(struct list_head *list,
> >
> >               put_device(dev);
> >       }
> > +
> > +     if (!q_list)
> > +             return;
> > +
> > +     list_for_each_entry_safe(dev, tmp, q_list, links.queue_sync) {
> > +             list_del_init(&dev->links.queue_sync);
>
> Hm...this is called without the device_links_write_lock() held, so this looks
> like this could this race with the list_del_init() from
> device_links_driver_cleanup() and create an infinite loop.
>
> (The other list iterator above might have the same issue.)

Yes, you are right!

I was trying to follow the existing implementation for the regular
sync_state, but it certainly looks like we need a separate lock to
protect the lists.

Let me fold in a patch that fixes this for the regular ->sync_state()
code first.

>
> > +
> > +             if (dev != dont_lock_dev)
>
> This is pre-existing, but I think it would be good to add a device_lock_assert()
> call for this as well.

Makes perfect sense.

Again, I will fold in a patch that start by adding this for the
regular ->sync_state().

>
> > +                     device_lock(dev);
> > +
> > +             device_links_write_lock();
> > +             dev_queue_sync_state(dev);
> > +             device_links_write_unlock();
> > +
> > +             if (dev != dont_lock_dev)
> > +                     device_unlock(dev);
> > +
> > +             put_device(dev);
> > +     }
> >  }

Thanks for reviewing!

Kind regards
Uffe
