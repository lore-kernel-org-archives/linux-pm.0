Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7263A7584
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336102; cv=pass; b=Y+Ennf2YbaA9ecb9oBre5cXayK6fcUPshFiTy991ObUTB3BY3zZO2AQkVIMStSoCeBM8pDiLDzzswNZK4WRMNyCpgE04SjPkAJKBnTOjQF2n786YwBvuNy0xJnxRt2Nb7e0PeORMhz+Bv01k7nsoCcyz1jOX8VAOOLyaP1/6fPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336102; c=relaxed/simple;
	bh=4F/mamksgE6M36asyjHLz+r3WuYlAy4EjSD04V58GmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkadgPpFOslO06UEN8Nv2svMW0HSiZ9HVyVzAnJhQOo06X+sCZevQujYJSenZDvxPcSFYYyXUyRZJvwi77x1+FBFmJZF/CNBMpFqBUo/TvKs+ogX0E9sgCt2tNUOlX7vJ9g8+OJyT9IH+JsvgA0PsgiSZyksNsB4oj86TiuK6EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VK26Hj31; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VK26Hj31"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664ce3000e6so2247321d50.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 04:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783336099; cv=none;
        d=google.com; s=arc-20260327;
        b=YthAD+8TT4W+fpA8kZAryMtAwawAD8dv2GANa4p1ojjGDi2+mIbsIp4rc8E7AFT8OB
         tEAS0spdMHhHi7tQfOU45QIWiNRM6mtpPDORAn3Jp4vaaFHKYFHY/ZzyKXwuqHsASLTJ
         lZKTBCOy1E2ymoOCaoHwikFk4Hvr/yNjn5TNTzSR1Nmky6UOc/xcwN9E/riW1+NG42mr
         +cLZNRI/PXIIDpTwRz90azPkYwJVbs2ecgM3iYlW1ocavVWFhlnH5ksaTN+KV2rclEy1
         yduDVNL9bLnXgYrkOmm9tMjC8/UxyKsSQ2kc9INSHgWs7glEwomvMu36/Pad6xNmLJRa
         DWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SIs5mr1YlXuHrRAWD0Cvvhp1KPf82E28pNtyAHr0i7A=;
        fh=53Lqzu9+oM+V14m2bBLnw9VztsZLvbJNYwi9+H07Ykc=;
        b=WVi7gYz/RJrrm6RidDXVDpR7bP+S168AWoOWVFRYjkM+ABcdPBACfIEDBpoI2SYw2P
         /E2/fsF5XBGjbxgBBgxTWif4DvV5PY2F1S+jfJ+8YzCkrj90qvHPkRtbjJWHNNHb9KzC
         kXEw0CuGwDVbjfgix8I0dOTY6mtxaqDjUXTe5UhvUQzDC13AE6l5qa55XBlVPQ/4hQGD
         91tP9N10mSIq6mk3QlHtQfu9NgDEPnfePn2pFPdZlmsOqJbcwBoAPJGfqGNSerFzMk4g
         hO9gQEZB1hUGq/zLCabmeOO2pcFsXXvCqmIremCBHIcyuEhqgX2wwpaA6G40m7FNTwIU
         f9lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783336099; x=1783940899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIs5mr1YlXuHrRAWD0Cvvhp1KPf82E28pNtyAHr0i7A=;
        b=VK26Hj31UayrVs/4ulgCbhVpWYBWmOwQVZ1cZulYxavWOit5dV5tCoKEG/g9vtbHcq
         jhq50FZ57MBVX950hnpmnOE0FU+iWtFgnmz5tmrHk7jVAY81/sx7woV1a6TxIltEifKE
         kYm0CCbgjBlkFhMAdJOKvmmF1T8y4EHhE9Dcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336099; x=1783940899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SIs5mr1YlXuHrRAWD0Cvvhp1KPf82E28pNtyAHr0i7A=;
        b=KpL+CcVeBcfw8v8H/TwlxmW83hSY5q9VGXcSnzUOZCySAjtOw3QX7676II+wDbOHr0
         Bs8vbl7d9F6eWmJnbpGZbBkg2mElw8r3KKgd2bdxRo2L/sXcBwEleXrQxFPKgvKs3IFA
         skC8Q2C9KvL2ipOfw8EMDAERU4WpfDtMyjNFeK5UwbvmDjUVCM6+bpZ5YPkLAj2CBGcv
         b/C5BmXI5NtQbMJEvi075fDhwf8RebWBbyS6HRo+ic495zlt1Xp3TdY2DGhxoGsW74MU
         MKejyEtJ1xhY/TM0rjSoXe8G3djpPgttYrPvrK+0i7XcGSL1ZNa+7doO7+6TPUl8JjpO
         xSxw==
X-Forwarded-Encrypted: i=1; AHgh+RqsDsro5w7rsPCXwnqAB8dyGdkqKakn08gVDIrq1Y1r1qs0jFL6xiV4S8w7fDM7WEtsjVhm5YSY/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+n9RZ/knDuyRHWRaM7V/wD0m36GvfJOwSD7iWssHY8gi9MYG8
	z5Sv74Rsvu/STWIIOGmvc1wLzGdUraRBJ+UV//VVBf81gZtFo+/Z9WTAtRG0ez6dTc4OrmiIf2H
	h9dIDnTZ8eEww3eCRB11DV71Arnwhk8+ea5QMsedc
X-Gm-Gg: AfdE7clZ6TohMwZrKqQJ2j2nF1WIloBxbXQVmulh3bFyI4zLPGeJyoG/N6CPIuqRMxw
	rdFYFz9D01iOzqtklHkshQr73XZjS2smj4Xj7DIFk+S1CKN2smoOD06/Z4En2wtDo2OUo0LDSqF
	gQzvFCPxA+3X0VJWm+ZUa7u0L8z9bETdtTgcGNzajQz65qPPgvuzE7lo/JVcGZvOPxhx39vrA8D
	4d3YybL+sJHtVGWhl5LfhM5g4I/031c4/+BrRgKyM/1hmFLbZSpEOuWXbSAIC5sfZeB9D5WUndX
	EiIXF8eA6UpmL8EoJvv6hkFvP0g=
X-Received: by 2002:a53:d016:0:b0:664:c436:e525 with SMTP id
 956f58d0204a3-6677fd49ec4mr103596d50.58.1783336099517; Mon, 06 Jul 2026
 04:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local> <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
 <ake6FNy83LLtCs3b@ashevche-desk.local>
In-Reply-To: <ake6FNy83LLtCs3b@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 6 Jul 2026 19:08:07 +0800
X-Gm-Features: AVVi8CcaHXwr5vK-Mk50Hl5ytWXCTbNUaYqO2byI6p2Q5_6clKTL9yyyDNsH5MY
Message-ID: <CAGXv+5EgpizA3Pc8ScNuChPhvFKWd5F6dxB-wT4-7EwabE-9dQ@mail.gmail.com>
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

On Fri, Jul 3, 2026 at 9:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 09:17:16PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Jul 3, 2026 at 9:11=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
> > > > usb_port_is_power_on() currently takes |struct usb_hub*|, but only =
needs
> > > > it to tell if the hub/port is SuperSpeed or not.
> > > >
> > > > In a subsequent change, usb_port_is_power_on() needs access to a pw=
rseq
> > > > state tracking field in |struct usb_port|. Either structure can be =
used
> > > > to identify whether a port/hub is SuperSpeed or not, as the field i=
n
> > > > |struct usb_port| is inherited from the hub:
> > > >
> > > >     port->is_superspeed =3D hub_is_superspeed(hub)
> > > >
> > > > Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> > > > |struct usb_port*| so a subsequent change can use it.
> > >
> > > At a brief look this will be the only function that takes usb_port
> > > instead of usb_hub in the entire hub.h (I don't count container_of()
> > > as a function). With that being said I would rather see it to be move=
d
> > > to port.c altogether (yes, it's more invasive change, but looks more
> > > consistent).  I would even dare to move struct usb_port (and containe=
r_of()
> > > accompanied with that) and this function to port.h. This might requir=
e
> > > a separate patch, though.
> >
> > I agree with the reasoning, especially given the function name. However
> > I wonder if it would cause problems given the linking order. I'll give
> > it a try nevertheless and report back.
>
> Thanks!
>
> In case it won't fly (but I still think it's better to split), can you at=
 least
> group usb_port APIs and struct? Means moving the proto closer to that str=
uct
> usb_port followed by container_of().

Looks like it works out fine. port.o is linked in after hub.o, so moving
the function from the latter to the former doesn't cause issues. One might
even say that it is the correct thing to do.

> > > Perhaps something like: 1) "move struct usb_port and associated APIs =
to port.h";
> > > 2) "...this patch...".

There are still some left in hub.c:

static void usb_lock_port(struct usb_port *port_dev)
static void usb_unlock_port(struct usb_port *port_dev)
static void port_over_current_notify(struct usb_port *port_dev)
static void hub_usb3_port_prepare_disable(struct usb_hub *hub,
                                          struct usb_port *port_dev)

These are used only in hub.c and moving them probably makes things
messier?

OOTH, the following bits are in port.c but declared in hub.h:

int usb_hub_create_port_device(struct usb_hub *hub,
         int port1);
void usb_hub_remove_port_device(struct usb_hub *hub,
         int port1);

Any preferences for these while we're reorganizing the code?


ChenYu
