Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486E3DEFEB
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250692; cv=pass; b=qHeunDtxGzL5coHSRi2NoOnYgoFkqOT+59RqNA6TPcl5F0BcYtQwhsvIHrYGLsrq+sDGXDAiLib2ez+4IkVTdKosX48SoNBjFT3Ixly8LCLG2epbYbh4aswVl90/3xpbxoPbAQrQfOLKTSh0ARZ/wmTrt2DX1kFIC76EsoRcpGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250692; c=relaxed/simple;
	bh=AAW7Bc+70pQhpUTfJT214lM/e5AbzwxyHZSFmCFPS7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M56IpLpEL3hUjVYCVPOP8QDUkBqxmv7r01C0BrkOTUdMPRjow2ZPbwP3Tk/BKf8vzOQmvHY1if7KY+kq1G4BxlUGeXn0s9yCIPAgpoHJatoYT2+QUS+VS26EQxJsT5ooMsGRYdI467kp6cTiCnIx5QAruTSpsHvQ+TKxJi5xrwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FOExL29O; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOExL29O"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e16f05fd79so7549127b3.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 00:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781250684; cv=none;
        d=google.com; s=arc-20240605;
        b=hoKGXyU2pKCNG9eEJyplsEzjGmV7JbOOGZe601Vn3o9yI+/CyyTb2qMtDJedQLCdvg
         6jtghEmxYEqHD3/p3msD1sRALeceWJWNO85w56lSOymBi9i4eIb978iXI8mvSG6qlkYe
         Ed1621x7dhq3yBzxCY9qjjo/EXlerPdte54P2+pcW0L2sQBxitS6uJzODh6AzfOabuZ4
         U+S8aXpKY+jNbMaMHVSTPpWdMjyGJpJglsaMLYCvA5wodOoMynmH72QRFfuc8G75OokW
         705F21NqGTryWeud9SJ4c3MBGAa5IVPCoBi2mPHzV/ETaizvrBJJqduM7O80vN8RKQ/+
         ZCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SR0MIdclzqLJ5NMQX/zWd9Yh3H6pzRPWDeVIlwB7J0g=;
        fh=so+OssRZP+ebXdRuF4qtxrmnphmyaDyIp90V4786i8U=;
        b=bAEJX5x6D2Nxn0Xt6sBVtm7FnGK/2Hs2vnE/KtpGV5fTtp98MiSHomUa1F3jB4eO9/
         6UZ0GXi66w7hdOx/HHZM0V43q97TB5prfwOeznV/GLVonIJnV585bgE+NzUb7BPqs3gT
         f7Scgshgzn4mby2V37mcFazqVpAucCiNA9F5WsYVp55da/aO6qxvYglG9B+yVjPVmh1M
         YB65e8mIRMB7zkeLXRbhxwFsO89drBSpQfCPZZwoV8gWjrsDUNrOxeqTQJ7i0sBiNgWA
         8IIJtoTaQ0HcqlXwXszoIX13zCZ7hnZ52MqviMNJnxmQ09bH9gteSXNDeNOt7IpR17Nv
         KYhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781250684; x=1781855484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR0MIdclzqLJ5NMQX/zWd9Yh3H6pzRPWDeVIlwB7J0g=;
        b=FOExL29OPYXtRjr1jFVeFa7zcPsHHFHr6diu6VMqNotYkNZv7Wjo3syPc4R8ExctZp
         dRfHQrQ1QbppC5ogpXbF12ugxXsiKvzABW9lOoaQg9awzs4dNN/NYp20PF5wDlT8hpjJ
         1S1xuuiqMchZQ6nCjXW2tI+NMR/LrTS+SDRC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250684; x=1781855484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SR0MIdclzqLJ5NMQX/zWd9Yh3H6pzRPWDeVIlwB7J0g=;
        b=WMsaduIzHSLcAnSeTWr4SvOy45Ze5L0+su7MWM69wunCIvIDjhsp+0dkqhnsXya+xj
         FSw6eehxp8t09U9auEQpuOKgwRFnqu+ohkLFM5Cb5Pgg6stfg+UVIXbTFPUqetY2SSkf
         4VIQdSkY36p249YKf80youJKVyRp5WvR6wUALpjnjc489eEVg0YLruvac5Cc825dgSsE
         IxmlJtTs880+yxozLz69azJbu3SMvts4Ti1O+6bwy5vJCsNdjpheaVcp/txiJ+fI7Um+
         63wjYbgVpG8WrVIazkYmi4sioJBvmHvtzp/Grdut+srBbQ/kMH/zV6ijgfRVigUjPbYg
         uAng==
X-Forwarded-Encrypted: i=1; AFNElJ8KS5t6UT9HD7EWOSy6dVhyoyY690xq8ZmrqnSzop92R+K1eoP5fWL7tTJFlD3IOXAha7Wwxyzj0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztlm2ivsSOqyaTmLdmjK/3O/kWOpfESrLWrNF62EcmI87WQL87
	UAUPSOjTQKUCXM7MXAIuiclXbkou4lz5Y2hXy0shLQkEovSCUjHr+1XxA5GyKxnZi91ZFkHf3Mo
	N71GvoxLq6SR559QpMU3lrr9sKQpV7xHsNxW46HJU
X-Gm-Gg: Acq92OFXJz1Zqvvwh0/1Pb19TGxOB+fOklDOGOppyFMXFKqi1SUgaSb55C8A9Yct3PH
	Kdf9Ru9ufnw7g0L7dpMUjetst6Jw6Lv9VByUH8TOabd6ESlMJND39f2pSo7/GfogVA8mlliEfda
	WOWqoVbc9CTs4FuPWLHXEZ8BN8xdUewh04MuasfE2mANT4rO2DQEmsLDRjjBdLGErlJipo3VmNV
	SsbpWfoZRYtLOjAYBZcgwYT2p3CPWmBi+EpbmVignvjEjUwoiMbpUzAzFvcAOFhn2OHNFwSxElg
	rB9V2hwt
X-Received: by 2002:a05:690c:ec7:b0:7bd:73f3:7a70 with SMTP id
 00721157ae682-7f7b8523999mr14898787b3.32.1781250684397; Fri, 12 Jun 2026
 00:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-5-wenst@chromium.org>
 <ailytpKQcvYTUH7j@ashevche-desk.local>
In-Reply-To: <ailytpKQcvYTUH7j@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 16:51:13 +0900
X-Gm-Features: AVVi8CeA8ndBvqsmj_bBdEg4mr2h2E0R3_zPJJzKBFEx0mTdugBDzHIodwmMGm4
Message-ID: <CAGXv+5FrD7abUvw5JgZECcGBvtOOpezDtmUrCRmVAbDx0ApxhA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] usb: hub: Return actual error from
 hub_configure() in hub_probe()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:38PM +0800, Chen-Yu Tsai wrote:
> > The addition of power sequencing descriptor handling in the USB hub cod=
e
> > requires dealing with deferred probing from pwrseq_get(). The power
> > sequencing provider may not yet be available when the USB hub probes.
> >
> > Return the actual error code from hub_configure() when it fails, so tha=
t
> > the driver core can notice the deferred probe request.
>
> Makes sense to me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> One nit-pick, though.
>
> ...
>
> > -     if (hub_configure(hub, &desc->endpoint[0].desc) >=3D 0) {
> > +     ret =3D hub_configure(hub, &desc->endpoint[0].desc);
> > +     if (ret >=3D 0) {
> >               onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
> >
> >               return 0;
> >       }
> >
> >       hub_disconnect(intf);
> > -     return -ENODEV;
> > +     return ret;
>
> Can we convert to regular pattern, id est checking for errors first?

Sure. Will do it together in the next version.


ChenYu

>         ret =3D hub_configure(hub, &desc->endpoint[0].desc);
>         if (ret < 0) {
>                 hub_disconnect(intf);
>                 return ret;
>         }
>
>         onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
>
>         return 0;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
