Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D95184540
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176309; cv=pass; b=mNrsnkX+Mp8DD5GrapY+4LvGhHiNUVLFIBilxEmd1qjpnvcQp2q5i6/t17V7Np2pO8eLupjI+siis213ZP7kylwlr5W7KdRgTK2lgMmOgi9Sb3jeFMOZDuPC3Z5qfFjYWKrig4jBwBYst/P1qPIq2qHqFZ3q/byBk+3hgWg6GIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176309; c=relaxed/simple;
	bh=nhYyNn6r73D9XtB76IT5BMo5NhG30UFFcOOZMpuXDho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6pyQr0cyLioqIJixavDVqIcKD+pm9LtdiqrTrwuC3Xnkgf8JbKf1/ETweNcPT3dkn80koXUrQy/5VNBkzsy/fyUJEp3ICkZ6g4m9CUFf6zsNArLoTfAHVuERM7M3OL4FMRN+e6Nnv809MrfiZB0EwtFfFfLPzyuhvBNG2qm7B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BbIlmPiT; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BbIlmPiT"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e86df8987so85654017b3.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 21:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784176307; cv=none;
        d=google.com; s=arc-20260327;
        b=LiBr3zB4qD1ov4e8wifoi0H8seoTC+RfKDOgbzAbkHNmOSoBf9UtVJukN7vDmIGAff
         U0lDLQb0IbYGmGP9Ox0DK9DSLy5yWBlH7dkJ27hC8bRZLXsSVMhn2t8LOfmz9rEH/6AM
         9PCvoY03/BRgicpGnlpCPvostk7OnFilC1x0bDahts0F9mEbD6Qi2AObzH1IY1V5JW1Q
         sUHDFoxj5J4qPYn1Ab4lqj73wVjsHp8DkMFoRIgvlkldayMKPlu9CVbwOTejsKdel+Uj
         VNvGtWNoentYIFXqLHtvR5VdzJ1XsJaJPeSM7Q84zGrf20Nqcd7yI/977GPIjyQRi5J3
         Vvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWTekTqlq1/95QNv5fW/dcyHl3msvMXWSc0NTUyJpNA=;
        fh=TRCmTAbbtq12M9pQfFxbhiTIBiDVcDEUn0ysHe9bCv0=;
        b=S211SU2CMgB/WldakmBd/Vq1rej4dGmvkf1CfWLbuDPisTbprOXHYcd9430ne+Smy8
         SH4YoEGeVhvRToxeeIJZ99sSDwFQDl+bRvEBuKwKcE39KXbXZpEYUW8VnExt2ITSKQR/
         6ZxaHINzCbbPkoUntd2Uo25w9M4BzS/u3tav9hVvGoVo4HajAp7VPDPMQIpxwRnU76Jp
         BM7vXr1dXxZ+/2+xVfqDWKq9iIiGdabBHF3GBoNbS0HqpVuY4AoR5KylqfhdBMjxKSNW
         gKEVGZAxin81IIkoPw1st0lG7qg/XklmX7a5FZylOaqR7v2x7Lyn4xfEnlhZkIsy2LNC
         rnog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784176307; x=1784781107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWTekTqlq1/95QNv5fW/dcyHl3msvMXWSc0NTUyJpNA=;
        b=BbIlmPiThl4qtC2ZN7JQZl+L2ZooPvu5YEwEDvQfZB+ebI+hS/c29Vq0ahKfNxgu3H
         Y2dKQR08UIvbW04KcyCZxX8NOGetwY5g3XdreHta5FewJNT1+6IGkqv4QqXcQKnXrya3
         CREYMhgoOS0wLEmkqgUzYoB3Kjlg3MA3uZjMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176307; x=1784781107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWTekTqlq1/95QNv5fW/dcyHl3msvMXWSc0NTUyJpNA=;
        b=lHOVz3nf+nufo91no5hcE7rWbWlTe2GwdMSsvLVWlLkd/LW3Itkdfn/SF1nIqVDvQV
         JnD9h53HQ1hnc6+0borGvL5k+PiUAnGXC66nvQwhc1zB4Y3VbUWlAAFaycC8TtRXwOZ0
         CvldiBpXw5LfNr/MaRwNsAnEwGZNyPdz8ugvPgOuHCmDARDgkeaCRdsQXKdDfcxTGyv6
         upkzcovIpcrzI8C+0eSr9vMY3Obr/WN2Hhn1LyTnJzOKqJSsTOV0bHlhFZ4LVw9hVm/O
         96+dwy6z0LJFXdnqBfrqyJaTLlh2QAYXtV5bSSivmCdBRpeCd0LIpcTOJek6KCXjryt1
         NJsA==
X-Forwarded-Encrypted: i=1; AHgh+Rop+krfVyXr6vp3uWtNV4gW/dFq3aGUoQsZcaBqvRWTxD4VQ3Z271YvNBYqWnXcQpstEyt2uD0A9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyahHgK1AMeVD5idm1M4Z5u+SG7rEpzO8gv5kSGD/I6z+XYc+Pf
	QcLNjTA3KqJ4jK0LLlOzzSaBWNDDDw/QLtd6NWnmgJoObn8Gq2S36jDK3YP8UnuAqZQ/YMP7RCi
	LPrX2qlQF8IStoifDlyq5dDYwS8lto0uNmyvBmxtM
X-Gm-Gg: AfdE7cmGhNyllq/0V59uLqkRSt8Bb7iu3bmK2pcjGirqq6opVnqyuydETdBgP9esI9F
	x5FeDLptlGHHDrx+mG3k3k6TDh3X8HFQwaW9IEsPPgMlooJNfNVT+iRvhahb4LLqyeZri3oAroU
	Xg/KV5xSlskLLIpTkiGXDOyvWLZsmJSaMv17deg2JmkgxKObcVxrPEpu3zldDIgpkiRFizzuXXr
	VosyzPiYWSy4Vi2+TDqBTpBohvsEe5PcD1da6tx+ImkMP4uw+nsyhsgzxDwU5RoSl9qR/YiYh6k
	myj5+zVksgMvC8eK
X-Received: by 2002:a05:690e:1c0d:b0:668:19ff:7eff with SMTP id
 956f58d0204a3-66819ff937dmr2943635d50.38.1784176307120; Wed, 15 Jul 2026
 21:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-7-wenst@chromium.org>
 <aldQ5odptfmK5aCw@ashevche-desk.local>
In-Reply-To: <aldQ5odptfmK5aCw@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 16 Jul 2026 12:31:36 +0800
X-Gm-Features: AUfX_mzQbv55XMQ4uR8jO2hQgRvrbYnVnLlttvP6FASpWrSMQxMLCCNzy4VYT9I
Message-ID: <CAGXv+5FAHZP-u1ZyWSUkUrOx7R5-YgBs5y9V4mGTycyrJG3UKA@mail.gmail.com>
Subject: Re: [PATCH v5 06/16] usb: hub: Associate port@ fwnode with USB port device
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

On Wed, Jul 15, 2026 at 5:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 15, 2026 at 04:53:36PM +0800, Chen-Yu Tsai wrote:
> > When a USB hub port is connected to a connector in a firmware node
> > graph, the port itself has a node in the graph.
> >
> > Associate the port's firmware node with the USB port's device,
> > usb_port::dev. This is used in later changes for the M.2 slot power
> > sequencing provider to match against the requesting port.
> >
> > To avoid potential conflicts with ACPI firmware nodes and then causing
> > power management issues, only assign the firmware node if the hub's
> > firmware node is not an ACPI firmware node.
>
> ...
>
> > int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>
> What about adding
>
>         struct fwnode_handle *fwnode =3D dev_fwnode(&hdev->dev);
>
> to the top of the function, and...
>
> >       port_dev->dev.driver =3D &usb_port_driver;
> >       dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->de=
v),
> >                       port1);
> > +     /*
> > +      * ACPI FW nodes are associated later when device_register() happ=
ens.
> > +      * Skip assigning one here to avoid potential conflicts.
> > +      */
> > +     if (!is_acpi_node(dev_fwnode(&hdev->dev)))
> > +             device_set_node(&port_dev->dev,
> > +                             fwnode_graph_get_port_by_id(dev_fwnode(&h=
dev->dev), port1,
> > +                                                         FWNODE_GRAPH_=
DEVICE_DISABLED));
>
> ...shorten this a bit to

Makes sense.

>         if (!is_acpi_node(fwnode)) {
>                 struct fwnode_handle *ep;
>
>                 ep =3D fwnode_graph_get_port_by_id(fwnode, port1, FWNODE_=
GRAPH_DEVICE_DISABLED);
>
> // Is NULL or error pointer is fine here to be set as fwnode in port devi=
ce?
> // Perhaps add a comment?

fwnode_graph_get_port_by_id returns NULL, but not error pointers.
And passing NULL to device_set_node() basically erases the current
associated node (which is NULL anyway, since we just created the
device) so it's a no-op. I'll add a comment.

ChenYu

>                 device_set_node(&port_dev->dev, ep);
>         }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
