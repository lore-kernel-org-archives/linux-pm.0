Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B5944C659
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852032; cv=pass; b=uF1a3u7cle+uWAJOWdohCUQGkna1YJy9yOam9TnaKdN4yYBwaIS3wp1lCMdcc0tXHnc2Dv8Zk1DGRb05QIAUcbZp6z0xHxrA2Sh/agxTahFj/Vf8zXx473j+ZDWfYAzS1s3BelGSc1jeTOXOm3fmOfjkVv6cJFytzEeWi3ODD4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852032; c=relaxed/simple;
	bh=Fs1edfuHx1in4X4WdK3upBMt8kh7e3INqc862LZOi+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIcptElLpMaimJsswJqWUTtF1EdwAoRNS9JgB233HUSeRPJDBbY/5RPkiUUR6pY1QkBFdv0O92+0vrBpP2m6ihITNndviafhGscx3E6SBgVNOYKSQIWiR1ZnQgntGJN/zIfIMyxGDZd2nbw/THAUutRCrvRAOkvw607Nmj/8e+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FAbj7CJM; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FAbj7CJM"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-6756a6320f6so2404705d50.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 03:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790852028; cv=none;
        d=google.com; s=arc-20260327;
        b=e0/cH6LBpl8r/Cc7YeZWvJ78NNfRVQBbHpL18etvXT89NWYT8cwW5AwBz9L8sPdl4I
         guyMbdTfr2O7uTtV/7jEFFnFBEOdJgjqm6NujFCSIjQC8uxCKmuu0SXdCTw1U8qdQXOa
         iDFy0Wbi6jdrPLTdtol1ZUx7WlURr79lrdC1ach2/SufU2c2XNy/q+ABjovsN5zZVv/D
         J8o7Usb6MAzg0gSX4yqc4M+eqvrGNiCI8LhTg3Fq6i2+vyz9gMr8ek3snqUnCxohYKBS
         5/hkMWRWau5IPvhlWjG+FG1/3CO7/NGJFLC8RrCja2zwC8tUzMl0Zf+Io4aPFjin1qEb
         T/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vEbjjiBAb1Gv1/q3JktK2vYVX0s4JpnfBYopaxaaLpw=;
        fh=z0tc/nDlyOe8Hjq1ZFBMIVkFZr8DXtwDmJ/acfFNcWg=;
        b=kAUA8faKNK/bzyANb/BtqKEHYcWWLTBgynW3rC9HJMbpV3E1mpxKpvwc+YZjtg/Bu3
         ChcEiOIN+Q+ufSe+728Zk8JWHBgFQVJ60GNOzVVKSLRSLGVWC21twoW2gV8gaKTrLzap
         fq4A/rRTAC4ut2vxd+k4tfNWKfclmfFZbix6GV2L3CZIO1ByPB38XUcidqmMti2OM+Fl
         +8bT47Xy8EXAyIUhzJGhdY8KQ/jcplR84T9wV77tfVOyupn3BruJXjTbbyuUxXZ9alME
         b5QEOhn5jHVbzPiU97/bwMjPXbuZNQM9uwXFUPV26WEsqf/o9eChK99KCPFAQ7woS3/c
         sp4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790852028; x=1791456828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vEbjjiBAb1Gv1/q3JktK2vYVX0s4JpnfBYopaxaaLpw=;
        b=FAbj7CJMgab72MHHmfF2iW2O3xqNR2anisVVFAtjFiL8Qh2Pe5qy3EyOrrPogoYZG0
         bHFeHvcH710U1lLtLuR3jI9u641NZFI/ayhqFd8MJYamxB6t0hvhIGtP6038fE2n9VNh
         aGUR74pT+Qqo5mbpidnVPdUTQ8clM7IBi2Ymc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852028; x=1791456828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vEbjjiBAb1Gv1/q3JktK2vYVX0s4JpnfBYopaxaaLpw=;
        b=DyQ3PkpCCmnWogCCqki6jQ7wn2MjLwPigaHkhDxzvwdmJkHTEfmGlN+kMNSTEI9DUF
         HfEYHFb8ZqaSrgqZqQpy2k2jq2guqLR0bUwLz4uVjlnOz4D/HNfiirRPMpw4t/YV6UDw
         aXYwIY2QeRFtTG90O0OxJNIuKPBnXuBYRwkdKHquotfTlpcTXMlJpINC+U/Eya72cepe
         WJePD3gfZPiQ7HsUsNe6V/6cMNsVyVQk9UhhpZ7egphIYouAByqfd/kHyWryrRagufzz
         CmMXEm40ymNH7Tac6y1efEU0kZzT8/EHrbZpdYIKpWH790rSJsAA/AX7QygZBfB8dPcR
         L6Dg==
X-Forwarded-Encrypted: i=1; AKwUvBx4WAsbyZV0m+RR1pTBLphnU1wF3Rjqg/cDDNfWqAAIRykPC/OlfGVktLot76R++DgPwMl8aVx5FA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKngORhzNVxJHdJYPiofEAEgY0+MXGz/fS7or0MSAGlO5u78Is
	y2Ls+mIghme9VxYLHu9KdR1egR+tfORT1kGcwGNRy65v7cmB3V51/QImxU+g58UzXQ+7L3wAweY
	mJDbx8zVDVohgwmhFoM0S/gUFpb2JPMxOL4WjwObo
X-Gm-Gg: AYBFou1Eu3nms8+eBTN3BXEqxkGJeq9xz1Fv4PJLLBuafaT1jkSBosUCGBTlxJeeh8l
	HDNXzaoP6FZ4vE+IebIT34caFbARq6+vI+sTGZRxIOtoqAe0ZeQlTQ0/huhz9Kl5a3SY8HD8LxD
	tPhc3f5oJx239pEtngvyLHG5wSTUhZscRbYcyTEhSuO9yOLIPL5dYSB7fcDVR/cSV4N8PftvXVM
	XP17ilIWgPE6WSEaRjNNveagAz6ShJwl//uxGZXrzVJ/WzHr4lvgox2mI1eyGUcXpzIMbD6d7/A
	4yi6BhmeSM1bdFn3y0dbk8M2dWf0A4UwTwZve67iHJbVgHttFv/4YvBOJpkHX/Mvt/jlT/KliQt
	paYrI1CCdyA==
X-Received: by 2002:a05:690e:4105:b0:676:9954:81ef with SMTP id
 956f58d0204a3-676995489a9mr323421d50.14.1790852028003; Thu, 01 Oct 2026
 03:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916075745.3549953-1-wenst@chromium.org> <20260916075745.3549953-7-wenst@chromium.org>
In-Reply-To: <20260916075745.3549953-7-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 1 Oct 2026 18:53:36 +0800
X-Gm-Features: AclHuK_wafiRDk696txMZ3q8q7Qaz4NsP-wYkipLMPcHq1r5tW6zotnKrD-_NRc
Message-ID: <CAGXv+5GdBUafk6niG-UMDx=z6LJQ6iHAWhDpm1Ly2ce6CQDaxg@mail.gmail.com>
Subject: Re: [PATCH v9 06/15] usb: hub: Associate port@ fwnode with USB port device
To: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 3:58=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> When a USB hub port is connected to a connector in a firmware node
> graph, the port itself has a node in the graph.
>
> Associate the port's firmware node with the USB port's device,
> usb_port::dev. This is used in later changes for the M.2 slot power
> sequencing provider to match against the requesting port.
>
> To avoid potential conflicts with ACPI firmware nodes and then causing
> power management issues, only assign the firmware node if the hub's
> firmware node is not an ACPI firmware node.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v5:
> - Added extra |struct fwnode_handle *| local variables to shorten lines
>   (Andy)
> - Added comment about passing fwnode_graph_get_port_by_id() return value
>   directly to device_set_node() (Andy)
>
> Changes since v4:
> - Dropped unused |hdev| variable
> - Added flags for fwnode_graph_get_port_by_id() with
>   FWNODE_GRAPH_DEVICE_DISABLED so that even incomplete
>   ports can be connected
>
> Changes since v3:
> - Added missing fwnode_handle_put()
>
> Changes since v2:
> - Skip assignment if hub firmware node is ACPI node
> ---
>  drivers/usb/core/port.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index b4452b665f59..c0a51d9b06a6 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -7,6 +7,7 @@
>   * Author: Lan Tianyu <tianyu.lan@intel.com>
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/kstrtox.h>
>  #include <linux/slab.h>
>  #include <linux/string_choices.h>
> @@ -358,6 +359,11 @@ static void usb_port_device_release(struct device *d=
ev)
>  {
>         struct usb_port *port_dev =3D to_usb_port(dev);
>
> +       /*
> +        * At this point ACPI nodes and swnodes have been removed by
> +        * device_platform_notify_remove() in device_del().
> +        */
> +       fwnode_handle_put(dev_fwnode(dev));
>         kfree(port_dev->req);
>         kfree(port_dev);
>  }
> @@ -754,6 +760,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, i=
nt port1)
>  {
>         struct usb_port *port_dev;
>         struct usb_device *hdev =3D hub->hdev;
> +       struct fwnode_handle *fwnode =3D dev_fwnode(&hdev->dev);
>         int retval;
>
>         port_dev =3D kzalloc_obj(*port_dev);
> @@ -782,6 +789,24 @@ int usb_hub_create_port_device(struct usb_hub *hub, =
int port1)
>         port_dev->dev.driver =3D &usb_port_driver;
>         dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->de=
v),
>                         port1);
> +
> +       /*
> +        * ACPI FW nodes are associated later when device_register() happ=
ens.
> +        * Skip assigning one here to avoid potential conflicts.
> +        */
> +       if (!is_acpi_node(fwnode)) {
> +               struct fwnode_handle *port;
> +
> +               /*
> +                * fwnode_graph_get_port_by_id() returns either a valid f=
wnode handle
> +                * or NULL. Passing NULL to device_set_node() clears any =
associated
> +                * fwnode. It is effectively a no-op here, since no fwnod=
e has been
> +                * assigned to the newly created device yet.
> +                */
> +               port =3D fwnode_graph_get_port_by_id(fwnode, port1, FWNOD=
E_GRAPH_DEVICE_DISABLED);

After AI hinted, I found some dwc3 hardware to test this on.

"port1" needs to be remapped using usb_hcd_find_raw_port_number() when the
hub is the root hub. Otherwise both HS and SS ports end up getting the
same port node, which is incorrect.

Same needs to be done for "usb_of_get_connect_type(hdev, port1)" some
lines above the diff context.

This mapping is currently only done in usb_acpi_get_companion_for_port()
and usb_alloc_dev().


> +               device_set_node(&port_dev->dev, port);
> +       }
> +
>         mutex_init(&port_dev->status_lock);
>         retval =3D device_register(&port_dev->dev);
>         if (retval) {
> --
> 2.55.0.1032.g73a4cd73de-goog
>
