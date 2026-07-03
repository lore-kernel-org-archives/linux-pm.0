Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062303D47A0
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083552; cv=pass; b=cwH15SVQeMz7LUQJwwivag6/GEFw1ToFxLUhxBkpGI+otse8sp6a8f2lrFl5NwRn0SoRFpCTJMj1Rlg/08yj3BTnfPH8ZrktiIZ3IA62Kjz0sQ0nuHuUYVOEyX7ns3vkF2DJsKxYyEAHSTKq4smkSXRH42yKgJ/oK/iTY0YlFDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083552; c=relaxed/simple;
	bh=5nft3AHBmBM/Bxl3hydeIyKsjDil7snVnqIN4LBKVNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTXzSk4nuwllhVgyLjUjwRmKRs2qG4NWYtOWUqufaq/1IQ+vCXXqmbXzY/E2papwhHHReDW/lgttqby4v8LEevFDQlBlyRvm1HQgzfI24srWl2TJKOOpPQidYFOH3HxPScqDLhgF4QnCOD6LAzzyqhY/4o08tGgbU+RKFTAaW3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Extu2FZq; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Extu2FZq"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664cdeab266so736665d50.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783083549; cv=none;
        d=google.com; s=arc-20260327;
        b=fkvT0TuBB301ILb39DoSPvk8wCB1qu1sOap/FvqGtYCWNW9OAq4POnUVLQRHPcHGRO
         qaENFLIO2hrn5jH4EknDy9hQ5SFjZk+w6Npck+tTzoPmUBS9XxGnBL4uvZP8MOrUbldp
         pTnF2Vg1LfuQHoXzGUxT74LzEVmrxgzjM3gCGgS92SHfrNvnTjUOt8xJB+3Rmw7orOo1
         ulVqfVwjsmE7DRTU1RAzWR+DRnxymxUYgwMmpnNjIRXqXin0Q33mtLkH/dA2HJ92dlH/
         8N77ZEkOI1gJGDnpSi+WLIdcdmChGz8TrcWfs5HUcUsfacbeST2IcSZcZswsFAvW2/Ud
         VFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZpEgYLnkdRe+6URxXdbXlH7fdAucEfU8965vZ1JNkpE=;
        fh=5+NsNSuC1NF7UY6XW/DQzKtxzXf9+PrRUMfnBbBacmw=;
        b=WoIy/VfazWuNcFeB95ZzyW5ak4tToCSfybKQxxYaYQWrssLxWywzl3OdmlpJ1Ac0OD
         vwNMA9gvjSJDKHgpaTee9pMBmrL0vFstdyCsQhi4Hf/yrR8SpDPyQc16ggz/r3ysRGLT
         a1IRGd4cxCyHdevjEuC/iFGi/BZcO0BLAiXEg6F/OvNYr+koiWI4uhSVoxGKZuXJrjGT
         0zawtabPQCXwEGdL2vYEZRE1EbT/lcq7hK6lJbA0pysQA9aEQlKkK/ssS+orKvvFG1iP
         3L+ynR/7gAx9+n3jagiK2UMyW+tIZyDaeD3fVpgq83b/wXfYjrgPn5Br4z84o56ieZ2z
         Mhpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783083549; x=1783688349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpEgYLnkdRe+6URxXdbXlH7fdAucEfU8965vZ1JNkpE=;
        b=Extu2FZqzn4ClU8L4NNnO2llwM4UFE3ZM7uCH0/92mwMN0NbafecLi6Cy7/2SomdWB
         t+OCEV29btprJClH+4XsA/eUkIFuP5vCd3XNe4+K/k92/v4PEI/kVAL8Jq/sjRwO4MWO
         5x/O5nV5L/0p5pQe9AomnMHEjuUZk5UoSL+0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783083549; x=1783688349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZpEgYLnkdRe+6URxXdbXlH7fdAucEfU8965vZ1JNkpE=;
        b=GI52SNLtwrSIsQMRP8uMGnw7RTTbTa2sTu0YUik5cO2J7UvfrebVf0177wgSmLM47Y
         GGhhHKhWbaLSDeYaHbcRHCJ4N4dBjNF25uSOKTZssXcv5joUXy/Kb54Fwge+n0N6kC4r
         pmZNelxE+c11FamYycqsdsLQgpLZvOnov9wSZLeEfmH0tWnDR3qUOu1JUPqdnBH4p+Ny
         JmNEEhxElX0Wgx78oHozoa5pJ4L1TjCm5cdbwWAgOeetvRnaLs7DITHh1r3zMCEHUSzP
         Zi1xtZBu6/cEJXHuoAQ79dzws+t2Q5/hAvJu2DbKHGSHL/XUsHylCGnMhb0VmXpCfhL6
         zqpg==
X-Forwarded-Encrypted: i=1; AHgh+Roj4ClSNJA7HtRJuPpLXFFwml2ryWu/fMqiID/KDivDB75f5GWNk26GbXUHCgHSQORPUFboeStzzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4s7khMi6jPq+HjEpLT4FfLHEEctHeBOkDjzn4m27keoUCSzaC
	HJEN5J4poHDIj69gyfkbRaZg/AsOTvJSs/Tbzp3JFeWUIVVmmFfHT7gwobFo41KOfOMLWjcI8h3
	SCD4xoGZJ5r1fWnWVCkfOfCJkPdEY6VVjzVqv9BBA
X-Gm-Gg: AfdE7cn4rNF/DNZuBnnL7st9qN6lfhppuay0VwiVfsgcCmai2NmCy6pEWqY/I8q6ye2
	fQCToQJFbfk5v+i0eihOkxmjElNFRQRVNq506QjnhP6clf7tm9CSLJ7F5W8aNzgRQy9p8fWs7a0
	V7zZSPuewvaz1+5fl4NRufvBB//KidNwXniv6wQZGFqjrYFPl8vnAbbiu3ADFG2Tj9dd9MTQ54q
	5A4Yc+s8yu5gDAvocqDcUIBtmbDb0lEPCO9yp20UiMMumfkDqAjfFpAnu8JOj9WxXDTQxufJRRD
	QB6ae3/daFjKtCx6ZyFgg+1zsRs=
X-Received: by 2002:a05:690e:1908:b0:664:ef34:33 with SMTP id
 956f58d0204a3-66521d1c65emr9453570d50.74.1783083548882; Fri, 03 Jul 2026
 05:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-9-wenst@chromium.org>
 <CAMRc=MdMhr6qAnAtUePbuBbsH=3MzRC+BrL5GssbNTwGjp_ayA@mail.gmail.com>
In-Reply-To: <CAMRc=MdMhr6qAnAtUePbuBbsH=3MzRC+BrL5GssbNTwGjp_ayA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 20:58:56 +0800
X-Gm-Features: AVVi8CeKAFgvldQwkCHupVnLS-0_fUDpMC-9BOMhYWR8u-1abjmchaeDfiY7p3M
Message-ID: <CAGXv+5GHFnMj3qr5BcpLCQk25rWYOgnMKUX079ScELs4uqEdVg@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 8:41=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, 3 Jul 2026 13:03:09 +0200, Chen-Yu Tsai <wenst@chromium.org> said=
:
> > The new M.2 E-key connector can have a USB connection. For the USB devi=
ce
> > on this connector to work, its power must be enabled and the W_DISABLE2=
#
> > signal deasserted. The connector driver handles this and provides a
> > toggle over the power sequencing API.
> >
> > This feature currently only supports a directly connected (no mux in
> > between) M.2 E-key connector. Existing USB connector types are not
> > covered. The USB A connector was recently added to the onboard devices
> > driver. USB B connectors have historically been managed by the USB
> > gadget or dual-role device controller drivers. USB C connectors are
> > handled by TCPM drivers.
> >
> > The power sequencing API does not know whether a power sequence provide=
r
> > is not needed or not available yet, so we only request it for connector=
s
> > that we know need it, which at this time is just the E-key connector.
> >
> > On the USB side, the port firmware node (if present) is tied to the
> > usb_port device. This device is used to acquire the power sequencing
> > descriptor. This allows the provider to tell the different ports on one
> > hub apart.
> >
> > This feature is not implemented in the onboard USB devices driver. The
> > power sequencing API expects the consumer device to make the request,
> > but there is no device node to instantiate a platform device to tie
> > the driver to. The connector is not a child node of the USB host or
> > hub, and the graph connection is from a USB port to the connector.
> > And the connector itself already has a driver.
> >
> > Power sequencing is not directly enabled in the connector driver as
> > that would completely decouple the timing of it from the USB subsystem.
> > It would not be possible for the USB subsystem to toggle the power
> > for a power cycle or to disable the port.
> >
> > Also rewrite the existing set_bit() and clear_bit() branches with
> > assign_bit() to make it cleaner.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Expanded subject to mention power sequencing API
> > - Dropped commit message bit about power sequencing Kconfig symbol chan=
ge
> >   to bool
> > - Added optional dependency on POWER_SEQUENCING to USB
> > - Split out pwrseq_power_*() calls into separate helpers
> > - Rewrote set_bit() and clear_bit() branches with assign_bit()
> > - Dropped the pwrseq_power_off() before pwrseq_put(): pwrseq_put() does=
 it
> >   automatically.
> > - Removed pwrseq_power_on() from usb_hub_create_port_device(); it will
> >   get called through usb_hub_set_port_power() in hub_activate().
> > - Added checks for port->pwrseq in hub_is_port_power_switchable()
> >
> > - Use separate pwrseq descriptors for HighSpeed and SuperSpeed ports.
> >   This makes things simpler. On the other hand to power cycle a port
> >   userspace needs to toggle it on both the HS and SS ports together.
> > - Dropped pwrseq state tracking again
> >   The power sequencing consumer API already tracks the state internally=
;
> >   doing it again in |struct usb_port| is not necessary especially now
> >   that the descriptors aren't shared.
> >
> > It's unclear to me how actual hubs reconcile USB_PORT_FEAT_POWER settin=
gs
> > from the HS side and SS side. One hub chip vendor said that VBUS_EN for
> > a port is on if the flag is set on either side; however actually testin=
g
> > on one of their hubs showed that VBUS was cut as soon as the flag is
> > cleared on the HS port. Maybe it could be different if a SS device was
> > connected? That scenario was not tested. Testing on another retail
> > bought hub seemed to work exactly as described though: USB_PORT_FEAT_PO=
WER
> > needed to be clear on both HS and SS ports to turn off VBUS.
> >
> > Under this scheme, I'm not sure how the power cycle in hub_port_connect=
()
> > would work correctly.
> >
> > - Link to v2:
> >   https://lore.kernel.org/all/20260610084053.2059858-1-wenst@chromium.o=
rg/
> >
> > Changes since v1:
> > - Switch to fwnode instead of OF
> > - Tie port@ fwnode to usb_port device
> > - Move remote node compatible checking to separate helper
> > - Use usb_port device to request power sequencing descriptor
> > - Drop "index" parameter from pwrseq_get()
> > - Do not get pwrseq descriptor for SuperSpeed port; share one for one
> >   physical port
> > - Add pwrseq state tracking
> > - Link to v1:
> >   https://lore.kernel.org/all/20260515090149.3169406-1-wenst@chromium.o=
rg/
> > ---
> >  drivers/usb/Kconfig     |  1 +
> >  drivers/usb/core/hub.c  | 44 +++++++++++++++++++++++++++++-----
> >  drivers/usb/core/hub.h  | 10 +++++++-
> >  drivers/usb/core/port.c | 52 ++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 99 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index abf8c6cdea9e..ef1959363fb1 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -44,6 +44,7 @@ config USB_ARCH_HAS_HCD
> >  config USB
> >       tristate "Support for Host-side USB"
> >       depends on USB_ARCH_HAS_HCD
> > +     depends on POWER_SEQUENCING if POWER_SEQUENCING
> >       select GENERIC_ALLOCATOR
> >       select USB_COMMON
> >       select NLS  # for UTF-8 strings
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 8ae97e8c26aa..dfa0f5dd75e8 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/random.h>
> >  #include <linux/pm_qos.h>
> > +#include <linux/pwrseq/consumer.h>
> >  #include <linux/kobject.h>
> >
> >  #include <linux/bitfield.h>
> > @@ -871,6 +872,30 @@ static void hub_tt_work(struct work_struct *work)
> >       spin_unlock_irqrestore(&hub->tt.lock, flags);
> >  }
> >
> > +static int usb_hub_set_port_pwrseq(struct usb_port *port, bool set)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (set)
> > +             ret =3D pwrseq_power_on(port->pwrseq);
> > +     else
> > +             ret =3D pwrseq_power_off(port->pwrseq);
> > +
> > +     return ret;
> > +}
> > +
> > +static int usb_hub_restore_port_pwrseq(struct usb_port *port, bool set=
)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (set)
> > +             ret =3D pwrseq_power_off(port->pwrseq);
> > +     else
> > +             ret =3D pwrseq_power_on(port->pwrseq);
> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * usb_hub_set_port_power - control hub port's power state
> >   * @hdev: USB device belonging to the usb hub
> > @@ -886,20 +911,24 @@ static void hub_tt_work(struct work_struct *work)
> >  int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hu=
b,
> >                          int port1, bool set)
> >  {
> > +     struct usb_port *pwrseq_port =3D hub->ports[port1 - 1];
> >       int ret;
> >
> > +     ret =3D usb_hub_set_port_pwrseq(pwrseq_port, set);
> > +     if (ret)
> > +             return ret;
> > +

As Sashiko pointed out, the stub function returns -ENOSYS. I need to add
something to handle that case properly in the helper functions above.

    if (!IS_ENABLED(POWER_SEQUENCING))
        return 0;

seems to be more straightforward.

> >       if (set)
> >               ret =3D set_port_feature(hdev, port1, USB_PORT_FEAT_POWER=
);
> >       else
> >               ret =3D usb_clear_port_feature(hdev, port1, USB_PORT_FEAT=
_POWER);
> >
> > -     if (ret)
> > +     if (ret) {
> > +             usb_hub_restore_port_pwrseq(pwrseq_port, set);
> >               return ret;
> > +     }
> >
> > -     if (set)
> > -             set_bit(port1, hub->power_bits);
> > -     else
> > -             clear_bit(port1, hub->power_bits);
> > +     assign_bit(port1, hub->power_bits, set);
> >       return 0;
> >  }
> >
> > @@ -3249,7 +3278,10 @@ int usb_port_is_power_on(struct usb_port *port, =
unsigned int portstatus)
> >                       ret =3D 1;
> >       }
> >
> > -     return ret;
> > +     if (!port->pwrseq)
> > +             return ret;
> > +
> > +     return ret && pwrseq_power_is_on(port->pwrseq);
>
> So this is only needed to not have to track the state in a separate field=
?

Correct. Reading the field is not the problem. Updating it is, as the
fields are packed bitfields, and Sashiko suggested that locking would
be needed, though it may have been for the peer port, which has since
been removed.

[...]

> Looks good to me.
>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks
ChenYu
