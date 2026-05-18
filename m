Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBED3E3178
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095622; cv=pass; b=CJGEKLj4r0E1FoxkOdl3ZxtLe13VQIY934UonHjsksezHAHhCmDunnGIDORRw3z/T27RRPzDkwfbFpQmw1kEkGhSflXUAwvOyeh+kq3C9wRCLxvVoECYeY3lQEuaoG09R+YZ9OeLmU/CKEd5IpPQzVA0D1/7hy7eKbuKX1+LHqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095622; c=relaxed/simple;
	bh=kw2FaFkRYggKmHsD3zbceTzDrnmQSt6sP83wo4d+5i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5cR9DulLuVehItHVjwYGfzF72dK5QXeC6NFGzN1FtpT4ZkpOXSzFV20eYK65zb5OgcD0U+3dMgWd9ZZc/+hc4M7UsqUFX3/IvugJ6OEeBrVZeV3OwktB7RennOWcU/4r4s1unjhQuxsNIHfd5m8W7286D+itnDmMdrlmnrndDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lb8gyKoT; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lb8gyKoT"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39389398838so21618971fa.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 02:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779095617; cv=none;
        d=google.com; s=arc-20240605;
        b=GRKVkz0v0XorN1VS5wY4PJNWzocdcv4GcBvGoW4TipJZnpDK7H9uKYJ7k3G3Ojc+W8
         7wHPHx/aAYrogDXB6BkcRambMuvGGluVkoq5vFtjwtiQ3HRuK8S7eNzIXQOHrDzAYj2c
         DFfrwQSIsSjdpCZzFy6EUd+/q02N4pUkJpghlDXZf536vNquomwrq+WpbpDQNzHi0qgg
         5BcM4yDFZAIiDWWqg2Nlu3N9m93Yb0BmjkxQZh8kJCDZPzxanGY0Dyt+K02h3vFj5TU8
         FXtzBlkDBAKXJmBTy4pcv1c8SlKx5SAFkcJ44cSznad5/J3DbOOn83HpHw+l3r7PnyHZ
         CvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Amh+bVXjDqTRNawRkZLKL9MlUJaoVw2UfnFqXJanPVg=;
        fh=gY7e2AlkF90DByxUzb5hqWs7N9eTiOzlrfF1cCWbYVE=;
        b=GuD2flDNb8G7tzD0O2C/rXKESKiiNiS/x5wj2h/9UxkFC+u1QPvOv+Uo/ZbjvMgU/j
         bNyAKI2mFkH7p6KzV1wKMrhftAESyf3Ad7NXFNYw5DMtv/jaWWvfIIOca+eLlG1T2WSM
         rwAAY/9hEyqidW5gO8PvY9sWCa8P686OZHxbvotsfiumpbC9iPLoDUmZHam3LsZvgdtu
         tP9fje5rDxn/qCcfEVYdvBqn7wI/JeamNiocGSxEprgkYGg8y1/tY4GO0h3FGhWmIAcM
         4z++qg4If3KjcQnp8tCGIaqWiQDj3BydudmSkzngPxwt1Vn+BehQDOAD7z27k16JZH0E
         sGZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779095617; x=1779700417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Amh+bVXjDqTRNawRkZLKL9MlUJaoVw2UfnFqXJanPVg=;
        b=lb8gyKoTz8xgS7Qazjy5aUwN2O4ArUjZLFFTjz51Zxa+HqpxkgdWCuQcWDT3CV7kz0
         /0Ab7DqWd0KBtaDVkhXsrRNCUMd2Wn2P1Iz/9IhNFDmxayZt+qPXICrhD2/GWMcu+YGL
         H8o9Ze1FKuf1Y6xRu2C5AI0oRUhdC9Emk5CwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095617; x=1779700417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Amh+bVXjDqTRNawRkZLKL9MlUJaoVw2UfnFqXJanPVg=;
        b=hxRlvAsq304+M2oELlyF/1VyPXJd6j0Ag3cB/+wqNVtyaLYCQh37hIWDdrRkOKaAFy
         6dksyaRooFAuHJxFPQ9G8JfZBXBefi2WcTDW+1eneC/kG9j1k4o8q/bIWRKpdzDgwnrf
         OInNdb/00QhfGCRbNpHLPdDPwV58wR3hmFlS05xUYosA1jaCcwROUbbJ3sJdAOQA0BfF
         pxvJ/aigv0BxnOlldTwu0BXE0gLBx/UgB+1x53raa3uk9LqtEMStBpMHmA0ieta5MiFS
         R6k+P/mwqAIjzX1yk4SaseQah0AusAmjFimVGRIE0fK9t3oX3PuZe8ebcgFSBISIrknY
         wPnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ojDaGXdFWlM6iZ2wNXS/QM/0OnVRhyA4w5qtViz2gQEhM3zASH7UhegZjNx0qOpp65+PS3GUoyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyHg6yuup0aclgSpLWGB1ByNHHNk1YC4JXrvKsOMtf1/G6di5
	+zt3w9EPQoT54ePtEp5DUq++3IlwEE71h+tn6rAlKaTaQ2qgA4o9Ga2rNBLKqFmCWei07/Znidb
	HOwOsHDMPKtp4NJfDg4BxUMdDqfnmAJMjFUOzeWTR
X-Gm-Gg: Acq92OHPvORn3XO5Zf2EyYFCD1SrHRSSobRdioi6s5YRYs1HFKxqOIY4HYnLnmNBq4x
	umgrwK+wAUVIyHDcarsTXPGSeFGf7gal8c3RQn6RQO9e85mdv3PMKL9CSwC0v5qi8fhLJcDo3aL
	vOdnJgJ9sM7Emrn4BDJqOyzkeAqUv6pMklDCDnZO8ZUyj1/G1MZ3ODNwaauYjM9RAwl6VmWLO9E
	2uuvIQ7f+H2wE28Y37YHNzBPvDJlMmfcdm7ftZyUA0QqydKWguL2oZ5FuSzi3BF1kWtH0CgxUUE
	TTu4/l51wD+wsUIS4j0VNQa3RRNXRfQrfcWnGtv6KusyIgZi
X-Received: by 2002:a05:6512:3e14:b0:5a8:9f6f:3212 with SMTP id
 2adb3069b0e04-5aa0e741fd0mr3969603e87.34.1779095617441; Mon, 18 May 2026
 02:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515090149.3169406-1-wenst@chromium.org> <20260515090149.3169406-6-wenst@chromium.org>
 <41260a6d-46fa-4a45-9906-e1bc5e5dd83a@rowland.harvard.edu>
In-Reply-To: <41260a6d-46fa-4a45-9906-e1bc5e5dd83a@rowland.harvard.edu>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 18 May 2026 17:13:25 +0800
X-Gm-Features: AVHnY4KWMoq2C1egFaF2o_wZ2pbZmcxOkUhi_AoDtPCF3Cwz3jQrR0zfOzxPPG4
Message-ID: <CAGXv+5GT8vS87owuNJvMxWBnwCELCV28SbwsUXFr-Ne5O3EgsQ@mail.gmail.com>
Subject: Re: [PATCH RFC 05/12] usb: hub: Power on connected M.2 E-key connectors
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:39=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, May 15, 2026 at 05:01:41PM +0800, Chen-Yu Tsai wrote:
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 90ea597d42ae..4165f71e212b 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -31,7 +31,9 @@
> >  #include <linux/minmax.h>
> >  #include <linux/mutex.h>
> >  #include <linux/random.h>
> > +#include <linux/of_graph.h>
> >  #include <linux/pm_qos.h>
> > +#include <linux/pwrseq/consumer.h>
> >  #include <linux/kobject.h>
> >
> >  #include <linux/bitfield.h>
> > @@ -888,13 +890,25 @@ int usb_hub_set_port_power(struct usb_device *hde=
v, struct usb_hub *hub,
> >  {
> >       int ret;
> >
> > +     if (set)
> > +             ret =3D pwrseq_power_on(hub->ports[port1 - 1]->pwrseq);
> > +     else
> > +             ret =3D pwrseq_power_off(hub->ports[port1 - 1]->pwrseq);
> > +     if (ret)
> > +             return ret;
> > +
> >       if (set)
> >               ret =3D set_port_feature(hdev, port1, USB_PORT_FEAT_POWER=
);
> >       else
> >               ret =3D usb_clear_port_feature(hdev, port1, USB_PORT_FEAT=
_POWER);
> >
> > -     if (ret)
> > +     if (ret) {
> > +             if (set)
> > +                     pwrseq_power_off(hub->ports[port1 - 1]->pwrseq);
> > +             else
> > +                     pwrseq_power_on(hub->ports[port1 - 1]->pwrseq);
> >               return ret;
> > +     }
> >
> >       if (set)
> >               set_bit(port1, hub->power_bits);
> > @@ -1867,6 +1881,7 @@ static int hub_probe(struct usb_interface *intf, =
const struct usb_device_id *id)
> >       struct usb_host_interface *desc;
> >       struct usb_device *hdev;
> >       struct usb_hub *hub;
> > +     int ret;
> >
> >       desc =3D intf->cur_altsetting;
> >       hdev =3D interface_to_usbdev(intf);
>
> This change is totally useless.  Didn't you get a warning from the
> compiler when you built it?

Apologies. This should have been part of the previous patch.

> > diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> > index 9ebc5ef54a32..6039e5f5dcd7 100644
> > --- a/drivers/usb/core/hub.h
> > +++ b/drivers/usb/core/hub.h
> > @@ -85,6 +85,7 @@ struct usb_hub {
> >   * @port_owner: port's owner
> >   * @peer: related usb2 and usb3 ports (share the same connector)
> >   * @connector: USB Type-C connector
> > + * @pwrseq: power sequencing descriptor for the port
> >   * @req: default pm qos request for hubs without port power control
> >   * @connect_type: port's connect type
> >   * @state: device state of the usb device attached to the port
> > @@ -104,6 +105,7 @@ struct usb_port {
> >       struct usb_dev_state *port_owner;
> >       struct usb_port *peer;
> >       struct typec_connector *connector;
> > +     struct pwrseq_desc *pwrseq;
> >       struct dev_pm_qos_request *req;
> >       enum usb_port_connect_type connect_type;
> >       enum usb_device_state state;
>
> The fact that hub.h uses struct pwrseq_desc indicates that it ought to
> #include <linux/pwrseq/consumer.h>, instead of making the .c files do
> so themselves.  Then you wouldn't have to add the #include lines to
> hub.c and port.c.

I couldn't tell if the existing pattern in this file was to include
the headers or not, as it's missing a whole bunch.

Regardless of whether this header file includes linux/pwrseq/consumer.h
or has a forward declaration or nothing, I think that if the .c files
use the API, then they should include the corresponding header file
directly.

> > diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> > index b1364f0c384c..2d09037fee93 100644
> > --- a/drivers/usb/core/port.c
> > +++ b/drivers/usb/core/port.c
> > @@ -7,11 +7,14 @@
> >   * Author: Lan Tianyu <tianyu.lan@intel.com>
> >   */
> >
> > +#include <linux/cleanup.h>
>
> Why is this needed?

For the __free() in usb_hub_port_pwrseq_get() below:

    struct device_node *np __free(device_node) =3D NULL;


Thanks
ChenYu


> >  #include <linux/kstrtox.h>
> >  #include <linux/slab.h>
> >  #include <linux/string_choices.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/of_graph.h>
> >  #include <linux/pm_qos.h>
> > +#include <linux/pwrseq/consumer.h>
> >  #include <linux/component.h>
> >  #include <linux/usb/of.h>
> >
>
> Alan Stern
