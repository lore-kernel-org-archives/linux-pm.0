Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211053E4C61
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277180; cv=pass; b=Z8OHZSYsrOst9w1l8eWMIWyPgTS1cQRipFgU68XupnZvHUT1P9A28vHcr16PII7Do8E6oTvCLRJ73ZtfGXTIbABgzyspE4c0xJirMjapNt/guDI+oeg2mNJzA3rcQnFbXWqiEbDSsw+oL8ExieVtrhloAbrZ1QngRtw9l2WUfoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277180; c=relaxed/simple;
	bh=K1k6G6+5zpiLdWHibg60JQFt+WiCSRiOFiAgjC0rwxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GysQWkhr2ZxzaSdk3PNd/+qRLhE49c1depQvtz7g4pwYZ6M24WkILQJrUtfZMf5r4pukt3JTABUfosekg8dDsI+xRldbynzDgnGn7IgYtJrgSIpP7aiujHls9gj1UFcffeyoWD+Wkc2OdQ5wE7NIGo6I140RC+5UA5qzgob6LmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l2kCj847; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2kCj847"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-667bae10ba3so4053135d50.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 01:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784277177; cv=none;
        d=google.com; s=arc-20260327;
        b=ExJB3bJzaYgcfeMNcEja7q1nEquEd0WdIgQa4WzfEytByTQlTVJ11L9VUJAOcAUkSm
         DtapGIZLRKB5u5iEsGlc48MqHqHCFSHaiJ8BPt/Z80KV3hrXPO1ezOizQcki+m6vC4pT
         NHcZm4utBbrdN271HgZj2VcDwwZdC5UZ3UwqSw0dCqQRUy4JfqxUwbv+m0jZ+L9oFN7+
         x1Stsx1SrP23JH4Olpgq4ioJ9nAQr4XPOj5E+bFqum10g/Ctdj4xFPSZPUgR04IHNsHd
         eJQ2Yu52KtT77PIOG1vcqfV/SbnI+DyomOk2sldTdI7F0r6/d8NJRY7JJEGps/PK6hgW
         FFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1UhkOJ+I5quk7xrKkpQoT029NfPFJUjtkpwNCEPA8Ig=;
        fh=e74KoTsDB5tWv/DQEDRjfuuiOKWW85fIn3GFJLJI/bE=;
        b=fzxUKpQ7QvE6qIUMxBwD+wQzaq12o+5Uzho99NlMFzRcVuRixmGzvMPf0Ffxz0C47+
         F76yXNv/yvSHp1J+COmbRryyB1435pGpOxrsed1hBDObsGUYyTE/9i26sQDUQZlibrNn
         +CAl8+yDZefJBllqQjhjJ2z8LnFGRzqYAeWgnXJA+IX3YuJ5IuSVG6kX7ZRhXPGo4HPk
         p8CVTMYgL0X3LG7IAJWew95QNJphjoXS8rzG9GpHRT2cKHR2rj+338TeqeIKd5s/kpqB
         bIMf658dHJ69p8UzuWQHWMZ68P0ToMkxFALdSQM/idw0JXs/zHICzcioYNxhgugTawM2
         HJiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784277177; x=1784881977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1UhkOJ+I5quk7xrKkpQoT029NfPFJUjtkpwNCEPA8Ig=;
        b=l2kCj847J02c+DpoVjLzUfMi5eK3O+d8hOmWkSba4h1OeBWn02zqqnCMEZfsFR5NnQ
         6uZVDWY9PNLRBlnnAmmS6gLMB0U8yjYxTt+730Xfts+gWiaiJKGEVNhsD8oG+Br5IV/K
         S4Vwq0BI0f/o8pRRZ4vw9ouPi0UFxLlEPUi5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784277177; x=1784881977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UhkOJ+I5quk7xrKkpQoT029NfPFJUjtkpwNCEPA8Ig=;
        b=c8wzkdnM/T8VQFYHJb00ZGV+ukrbLTo6OAWNr8Uk9yw6SyYyih/JRjKoEt+jkv/Ok/
         sMdBgaNpz+Jv6UxB75OlGlUrdmMinEw2n6MbUkhKhxg+3D/uLBkgobmqA6Bi77Q0ba7A
         W2lMrApTqI+iCrNjftbKu8z4mR+YHuyYOWmR5I70/f2wZOCzXQjabRaGUAnK3psCErZw
         0r49gAynvPAQI9qlTeQzptRthTvQlzeFFlCllRAt/zjGu0S5AqPQI8+uXV9mDYbYqgLn
         wQ232JyuISIfmRftBsVXRA6naoYRMu3cim0VBQY+TrUpHefTrRMEBKDsFPYiYxhwMsAI
         bZcA==
X-Forwarded-Encrypted: i=1; AHgh+RpMRwKaPbjL5VBMUa44w0HGWixzYU5Nr+U04tfufu5Y0WT9FypQyNV7EzS29eZhR4Pu+bTMxj6dnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJlCcEseV0olTDDm5+TM0ttfOscMvAj67eX+ZTChqi9LDmvi/
	0g7aU494vAqfTs4XarktKCmp95NIVjSlHLm9pEnH/XusYBndA0zeVaLUWKsxvXdX1jVJtaPSpbG
	lsBCpAUHN1tW4jdJK7yKSDOJEyj1EcpRx4Ic/eS0f
X-Gm-Gg: AfdE7cmgKGGJ8WHKQXNa3Il5EpPzmuG3kQAPO7tN2xIceiAKaOGuTZfu/qNfoodN5au
	y1lcSThbFUHe5zm6qEg8lAnPV2H0MGZPC9l27XnjM0iOUGRa3UHkYrI9n1rlVeBkJR35QOcTvZv
	xhyH9pQ+rbkRPoR5/lYAB9vOz4x5LRiy8B5RJ1+RXXc0ewGy8a2/J3Cgw3DaYfyiN7DjSjEP212
	VTnNbYZT6yh5gpK/2CFmjn7ZQuiXbJ7uW2Io3KWnQzkE7omMIplrzX5wpyM2zmOeWtkiT+HxuFP
	vPqyHXdE4jJI
X-Received: by 2002:a05:690e:1644:b0:667:af05:2e8d with SMTP id
 956f58d0204a3-6683bde30b0mr341998d50.79.1784277176987; Fri, 17 Jul 2026
 01:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-11-wenst@chromium.org>
 <aleKQKH2V-ck-SX6@ashevche-desk.local> <CAGXv+5Ed9Cn-NeHiXJ58er7NJs1P2ZUMrjqYac-gSky-TNV8Lw@mail.gmail.com>
 <alkWE-bQ9gGIXIJj@ashevche-desk.local>
In-Reply-To: <alkWE-bQ9gGIXIJj@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 17 Jul 2026 16:32:46 +0800
X-Gm-Features: AUfX_mzoGIeMcv7EV_g3RqR3VRvLvguofP9ZSODwjiLGO0JAlL2g0unPo14vZls
Message-ID: <CAGXv+5FJkmOJgpwRBp4nAea6_moF=gH6wGmNpP+g8URNd--jbQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:34=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 06:02:38PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Jul 15, 2026 at 9:25=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Jul 15, 2026 at 04:53:40PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
>
> > > >       fwnode_handle_put(dev_fwnode(dev));
> > > > +     /* usb_hub_create_port_device() could leave an error value */
> > > > +     if (!IS_ERR(port_dev->pwrseq))
> > > > +             pwrseq_put(port_dev->pwrseq);
> > >
> > > Hmm... I would rather make pwrseq_put() NULL and error pointer-aware,=
 so
> > > it will be no-op in such cases. But I think Bart has his own opinion =
about
> > > this.
> > >
> > > >       kfree(port_dev->req);
> > > >       kfree(port_dev);
> > > >  }
> > >
> > > >               put_device(&port_dev->dev);
> > > > +             hub->ports[port1 - 1] =3D NULL;
> > > >               return retval;
> > > >       }
>
> ...
>
> > > > int usb_hub_create_port_device(struct usb_hub *hub, int port1)
> > >
> > > > +     port_dev->pwrseq =3D usb_hub_port_pwrseq_get(port_dev);
> > > > +     if (IS_ERR(port_dev->pwrseq)) {
> > > > +             retval =3D dev_err_probe(&port_dev->dev, PTR_ERR(port=
_dev->pwrseq),
> > > > +                                    "failed to get power sequencin=
g descriptor\n");
> > > > +             goto err_put_kn;
> > >
> > > OTOH, how pwrseq can be non-NULL and at the same time port be created=
?
> >
> > I assume by non-NULL you mean returning an error?
> >
> > device_register(&port_dev->dev) is called some lines above this.
> >
> > usb_port is weird in that usb_hub_create_port_device() does a bunch
> > of stuff that is normally done in a driver's probe function. However
> > usb_port's driver is just a stub driver add for userspace compatibility
> > reasons. See commit d99f6b4130877 ("usb: rename usb_port device objects=
").
> >
> > So at this point the usb_port device has been added to the driver model=
.
> > Or we can just zero out port_dev->pwrseq instead? I guess that is clean=
er
> > than having some weird check in the release function.
>
> So, why do we need to assign the error pointer to the field directly then=
?
> Make a local variable and assign it if and only if there is no error poin=
ter
> in it. Would it work?

That's the next thing to do on my list. :)


ChenYu
