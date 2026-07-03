Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12723B8139
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085038; cv=pass; b=U12SozoYhYGRGY4kCrSzDfoQDFVxDSoUtG186DNos5aGRwFTsQ52GnD2RfhaGljpCGkm41sUVW2Yokps+U4/qk5WKeT16BAVQlBZ1AjKCY6bwQOTTyq+0bAGAxugqhhHjTpa+VJWyQX5LxDBEZ9gEY2seq6rMrpz4Fd5UOxJn+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085038; c=relaxed/simple;
	bh=3AQ8P2Il+2wWlMlJMTJ9+9roF3hePCnmEzgS9nHgr5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fawaCd5d+2AxTWauQSL1eCRQYkkfqf2K8Sb3AF486ztpkTqHoQ6JZJu0r1K+zbtmmfU1p5fmsHSlwND7TCDySslcF9YJsFJeINaEIz5yEF9rsKntQRbmX0re0aOduVXqB5OYPqxc4padlvHvraBjgZNzQy42XOfDblGrbLRQbqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GoADlfeB; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GoADlfeB"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80e46c00f3bso5687747b3.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 06:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783085036; cv=none;
        d=google.com; s=arc-20260327;
        b=M5KJCkqQyAGazwPOHoWutUEOyzbPUUxWviPG+0ebguSmoB05BSGjEnPWmL5/gyALBn
         Lp0v6Scavmx1S/GEfeOO7MwK8YupiyaotshILb74BgHfNGK6zS8OXF8Vk2kOBm71qeXH
         nFl2zeYUirOIbyyz9cxNf/2Z/kfTl0LtEZHHGs+oNoZYDTueVm/Pm1XsLg+yZN0x90fc
         zlkuKQNCYYI9QFcdCIuYqcCTouiFHAqy5YGeXfXsPMyK0ZFTXKZrFOyqqro6QGpxo4sd
         CFkdCtA7YhFrSV5jTOnZvk9DLGjDaE6SGausPlxyJ7lZrDStY03oJLWPW7OXS6iKPuAS
         HPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nyHYQJiH0grz6FfspPAI6IMD2L9btQY/X/z4yRA/W0Q=;
        fh=TFz5A16uLGNkPUYnjyCBqGJqc5aD5Cgm5pBioxHNfR8=;
        b=Uq7t7hcHUEq+EGOas87geAYN9w3dCSuMQ8j5xNw7g+nKroJIoZMiaU0zYGD59A3DBh
         hQ/CUnl5ncm/fMZ5jirbPqCHZ1k1dcM21GKT7Mv/qkqtLyb9fOpgs43Bb5EsmpuuX46g
         juehHJQ73dwwskGcOESeGME43yq/eADpZkrYxpsd3gOgWiZ5+Jxvqga7t9/tp2Av2xpp
         TJ/WHg16cuuPOY1qo7lj+qLuG2JZrufUZLHvb4j2Vtoy7Gj4DfkYgJlR0urGoyXUAClG
         oKoGsT8A/qqtaO+n5bGNVgI2F13k3kV+PRWCoFl3ZR4mkczrVsveYGfzbj/iZLEKD/gS
         HIhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783085036; x=1783689836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyHYQJiH0grz6FfspPAI6IMD2L9btQY/X/z4yRA/W0Q=;
        b=GoADlfeB4Hv03q5mN+g+LfR2Y11//vyMTpH8Ax53DxrAr97PrXyBM9IMvFBwZ1uGRn
         dN/6qn1FPpmokdj4d+3esz+gzcOSuAzDAiLEw1imODvxp69fjbzR4EMceumX4JeVCoXr
         PJ4wTb+e8Zgf0DZROuCpNE+b/s720Wuwi3W3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783085036; x=1783689836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nyHYQJiH0grz6FfspPAI6IMD2L9btQY/X/z4yRA/W0Q=;
        b=ZhSOTJKbtdH5BbpJl5i/4/goClap8LjIy2mvnLVkQGMBfVLRua4tMI1hktdFkNdLZ7
         yIaWO/QKFq5Jx+Hr49FRo/LbIWJEQFysPTKohohqc3kMlI8XQqR7Mh+SANxMPtYe41G4
         WiTiiNr7vruSKHabCPWcKJ20+E9Y6ZKEX8BpGvZi8Zbs0FI1fkK6oxkDOLBOZMDSZqLt
         N9KPE2AMjrE0Ii8IY+jhOSbOY0vKT8xiffIlnaliOyeyksrHIUWIIoTeuU0xCkDEC3un
         peXBq4AAj1RPAN6tYER9uetmOagX1+457c/9qAUfQc6cN0QiZ0S6j+dFmosunz0/7mYX
         WWow==
X-Forwarded-Encrypted: i=1; AHgh+RrdPpGUbZyC67t3zV5GUnDUxGRQss5ayBnKnPb9NvOrkSVYO7+WcT3Sn1/0dV9WWed40CC0o3hb0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ToPqgt9DdL7fD0NxxQO6ACoSfnoJGAgWh9/OyggXcoLw48kd
	MuRzfk2wHHLfJtv094ONDlrdRpI8E/XHGjaaCW4Zc2uFRcl6+4BxWIFRSwS8Mjtr52VQttRM0wW
	coTVA5p9lliTXPTQs/b8o6YsuoIYg6wKZk52gCPoTNVbaaV2z5I606g==
X-Gm-Gg: AfdE7cnffiD2SwBgQkzFpssiHVM0qRlhAqXLWxsnMWJI3AE0o28dO3N/+BoxHOUy8vA
	/pUFQy/qBdevCH9FyRxGzcOKRH1N0XqUMj4zUrfQATn5clBylOClz1Yby8WRnfAGQbgJnh1Tyo2
	9hitQVUje7K+C7fgH6nnDVcclI9siUZWxqm77p01C3PwVXgzwU75ttRFJ7DefmmiQ8yrz4PQalB
	HjgJ3PtGKUuquRrRJfxRygZdlPhgHBnpPkqnSbDzjX1ZZcgqCkZafBoHyjXxe9Mym3H2kHs+KWc
	D/9pxjm8id86O7O0bKNrIrnT0iU=
X-Received: by 2002:a05:690e:4805:b0:664:de7a:a014 with SMTP id
 956f58d0204a3-66521a07484mr6637877d50.34.1783084648062; Fri, 03 Jul 2026
 06:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local>
In-Reply-To: <ake09vk4fEv1D9QC@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 21:17:16 +0800
X-Gm-Features: AVVi8CfejZEcwq-X4tSLhB9B5zlOpwIE7AknFvssi26xknUZgb1hl9QfxXck8os
Message-ID: <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
> > usb_port_is_power_on() currently takes |struct usb_hub*|, but only need=
s
> > it to tell if the hub/port is SuperSpeed or not.
> >
> > In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
> > state tracking field in |struct usb_port|. Either structure can be used
> > to identify whether a port/hub is SuperSpeed or not, as the field in
> > |struct usb_port| is inherited from the hub:
> >
> >     port->is_superspeed =3D hub_is_superspeed(hub)
> >
> > Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> > |struct usb_port*| so a subsequent change can use it.
>
> At a brief look this will be the only function that takes usb_port
> instead of usb_hub in the entire hub.h (I don't count container_of()
> as a function). With that being said I would rather see it to be moved
> to port.c altogether (yes, it's more invasive change, but looks more
> consistent).  I would even dare to move struct usb_port (and container_of=
()
> accompanied with that) and this function to port.h. This might require
> a separate patch, though.

I agree with the reasoning, especially given the function name. However
I wonder if it would cause problems given the linking order. I'll give
it a try nevertheless and report back.

ChenYu

> Perhaps something like: 1) "move struct usb_port and associated APIs to p=
ort.h";
> 2) "...this patch...".
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>
