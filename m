Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9F399018
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917057; cv=pass; b=UVaJG/TvN4x2Bx7vcFmOmoQ/L2J+U0OSyDU3qWNmKvi0N22tlTtrfaqntZcu30tMrt2I0knGWijRTkcBqYUGvvQxv+puvaDVs29jHsiAXOpmZvxF77rbwHTd05gKXhrBfEQsXT/vW/rd+YxI/C0omtEXpBOC2zJT3Gq8TJyJvYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917057; c=relaxed/simple;
	bh=c5Jc2Curx+hrKXgScOBcK42cc4R5Gw14VE5X6Khiqxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjshTGes2K6zv1/V4/41h9MpCaSS28Af+Ji+JXkIlAbQeGK5XQ0ahwrLbVgSuajFPFIsmISoPn++VAV6I4mz9GBjHEA58kPrbNau0NJbfUpUI2RJrqLztC/rgj3EYLt76IsB8EN0yTzgRj8GsXsqnZ8SHHgJo8zH+vhaU9a1H6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NSPlKI7b; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NSPlKI7b"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa4bb157c6so1336115e87.3
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 14:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779917054; cv=none;
        d=google.com; s=arc-20240605;
        b=hA89mfDodMCUOFibJCAG0+4gyjx34jq8zcPta1CCAN98clQ+2FyYvNSY9zrcBIWTzu
         TAGt8x4p6/q8z6BE7Oa8erpIAwl/aQV4qTvpYEWh2c7sWwOQYLOMwf9+0cq5l7vYSnY/
         +Gm/RwJK3ZgfsBWELnzO2xMC8Pa/tOYL4SR5Jwc5HyD5cy2f+p0SszC3fIUuD5Kn9oPa
         fE1haH916R+pw9dboNJjtSB98MztsJDt+qJOJwUTaB5JJA7qqif5DdGILqbngIaRNrt5
         1XUwHHCenqTB5FRxxDa5iXypObiULugVDHGi+Czwco1zbi8GmpYEIqXb20OMgURdu5N4
         0jQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UNa7dgr+T6R1ukhKHHLy6CJqrOmDsV/gnRDcoFC7IoM=;
        fh=2H31ZsibcZMTs5h5yK0/WJ5RE5osGgzIPhIxkQam3AE=;
        b=EGt96EZIsFbhiInemPKEtqLhZxROr+2203+jvTDKfnqOETZTxKQTkIw25pX7Li2013
         JgXgygl1T1WGgswJ1ChlDaW8UUxK2uQyA9GqOrsdNT7degG/6GU7A1xiagJT+XXP5FrW
         BW4BVBwf7nwB/cQj6RBwXn56K9vzkMdDsx2A3wXBOVACsNBdYqD4CO0ZhwFYtH+pBzHb
         r7h5p5tu/lLpz9NKwfaW0D6zcLHbPkUkRoQzzXljUat84ilHYTIDNlv3sOkGtnuSNx4U
         CNBQpkt5UhJGoyA5hAT7CEGbCPmT8tTWds9st12nZxnYZd5AOh1EhFCLUN0OfmEeaets
         b8jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779917054; x=1780521854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNa7dgr+T6R1ukhKHHLy6CJqrOmDsV/gnRDcoFC7IoM=;
        b=NSPlKI7bCiybkA7NZQEXKfT95r2jQgQlFICBKaVjauyaCL2d72SRvEqwJc6AQcWHp0
         22pKsGgJ670pGIG4quBx3lRUCM5iiyPiADKLIKuuGjaZ0FElq/m1ZPaIU+D0hSR0VEAK
         p5fhex9bnEjkKf6QVnebXorrqnwOpyErVmGkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779917054; x=1780521854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNa7dgr+T6R1ukhKHHLy6CJqrOmDsV/gnRDcoFC7IoM=;
        b=qrWwOk8P285HNh4NZN0gpWyBZuLMkMOdXZrNIWNvOZf1cQHo7fWzxNSA8qtB6uKURh
         zl12NFtcaVZ4SfrzrIw3X6sfTsHodfj4Ep/uRs14cjscgmmODsU6Hi8LJjsl6Bo4YRKj
         BvVJTYmwNBPId4oA1gvvaXf6YbrEngWst1LFbDjO9IC8QGVFg09YpW8fCYFox2H/g26i
         OrcETdzMZw9lW9Co4vIHpQ+JTxjhTCwNF7ywu6vaBIF2Lo0QL8lCW1z8gJyEP5Nubgv9
         GxBCvVajHM7B/J8vwNmbOmTj6O/A1sbHBJQk1GJEnFFFBdCK+BsTahu9v+GytSZV4CPL
         SOdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bEy8UX9vzPem9kPMeBNS8yS5mzJpcrLbQ0maqKOPQXAca0QTmGGPm1d+F2F+2Y9roZaBnvF5D0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCF3tzo/II+EZ/gowk3TDY4Df7HiQ0dW/3DTbRJssq/BZ+H184
	w3h/oWuaoTaPV+GLE3maZOfiWopLxDc4OAtMJiAiUh10/yEsf+02Z48YbC7WL3sOU1BcgoWms+z
	vlMY5l1WN7QJv5b9HWnq2DwDAoUaftDr+hGEz774t
X-Gm-Gg: Acq92OFPsrlQ1oRazAZijyk7ucQ4pN2BseVZQsyC+hK27A9xZi5veiFlD5wBuJg1xjV
	YOVAb320MBCR7X+dQi5UyF8xIuJPoLGdxzbsNrzgN9l/lTgqOy7dVEaF8MGrN5bkuaF5LO4CBIF
	N1knmP16klaWP7MEzJOLteX58vuVRgLDGxImpORoQrcKhYKxk8+Kn6FxIz10rvNFimWaOlKVY6H
	ysHU1Ah1oYiUCRLr+Bn6lmqaPTKQ7Gb2tQnfhuBrDYJVO9UiNbdfkZ7f1gjgp4IS7OcGz5yFZMN
	3O29tKXiBx0p845Mzw==
X-Received: by 2002:ac2:4c50:0:b0:5a8:65ce:e83b with SMTP id
 2adb3069b0e04-5aa3238bcc6mr8479844e87.7.1779917054041; Wed, 27 May 2026
 14:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515090149.3169406-1-wenst@chromium.org> <CAMRc=MdnjRRMVzxPkkrPhQ4dz7rsK8-HKUp9cQ0z11apL3escQ@mail.gmail.com>
 <CAGXv+5HC3dqgcE3KnKzakHHWFHB6m_X42orOkNUvZvp=SL_O8g@mail.gmail.com>
 <CAMRc=Med-_0GSYzoFBRiwFzBCK0DZqJD8_SEBxi+zwR20GS-HA@mail.gmail.com>
 <CAGXv+5GbW0bx3nKdZt2+tHuHyQ-J-1-Z79nMzHAwjmEPGKT02A@mail.gmail.com> <2026052710-flagship-unsmooth-ce82@gregkh>
In-Reply-To: <2026052710-flagship-unsmooth-ce82@gregkh>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 27 May 2026 23:24:02 +0200
X-Gm-Features: AVHnY4LeDHWwGMjgnhSmei9PL68DdRKYxFo5lLp-irYNZJy9WYHdf0RaNUwFV18
Message-ID: <CAGXv+5HdrKjFe=jZFYQzanmHOgCNOXRydLCvsM6o=DGhoO1HBA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 7:42=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 27, 2026 at 06:21:00PM +0200, Chen-Yu Tsai wrote:
> > On Tue, May 26, 2026 at 11:48=E2=80=AFAM Bartosz Golaszewski <brgl@kern=
el.org> wrote:
> > >
> > > On Sun, May 24, 2026 at 10:06=E2=80=AFAM Chen-Yu Tsai <wenst@chromium=
.org> wrote:
> > > >
> > > > > >
> > > > > > I expect some discussion on this patch, because a) it adds some
> > > > > > OF-specific code into an otherwise generic (core) driver, and
> > > > > > b) it doesn't yet handle USB 2.0 / 3.x shared ports; it ends up=
 powering
> > > > > > on the port twice, which negates the port reset part.
> > > > > >
> > > > >
> > > > > I understand that you do this because the port device has no OF n=
ode
> > > > > assigned. If we wanted to call pwrseq_get() for the port device, =
is
> > > > > there really no other way to associate it with the correct pwrseq
> > > > > provider?
> > > >
> > > > I suppose we could tie the "port@X" node to the usb port device, bu=
t
> > > > AFAIK no other subsystem does this so we would be introducing a new
> > > > pattern.
> > > >
> > > > In the M.2 pwrseq driver, we would have to match by port node inste=
ad
> > > > of its parent device node. We may end up with different behavior fo=
r
> > > > the USB target vs the other targets.
> > > >
> > >
> > > I imagine, we can check the bus type of the parent device to know if
> > > this is USB?
> >
> > The "bus type" type is probably not exported. However since the DT bind=
ing
> > explicitly says which port on the M.2 slot is for which connection type=
,
> > I think the matching can do a special case check for the USB port.
> > The next obstacle is that the target string is not given to the provide=
r
> > match function.
> >
> > > > Also, the "port@X" nodes only exist for the OF graph connections to
> > > > connectors and/or muxes (this series doesn't deal with the latter).
> > > > For directly connected devices, there is a "device@X" child node
> > > > directly under the USB hub node. That node is what gets tied to the
> > > > the USB device.
> > > >
> > >
> > > Is this a problem? I don't think I understand what you're saying here=
.
> >
> > It shouldn't be. I'm just saying there would be different behavior on
> > the USB side for connectors vs onboard devices (like hubs) device nodes=
.
> >
> > I talked to Greg earlier, and he said not to touch the hub driver; the
> > hub driver should only deal with features from the USB spec. The
> > "onboard USB devices" driver is what should be used. And this would
> > be a proper case of adding an auxiliary device to the M.2 slot driver.
> >
> > However this seems to completely decouple the power sequencing from the
> > USB core. Take the USB A connector for example, it was recently added t=
o
> > the onboard USB devices driver. However the connector has a device node
> > that is not a child node of any USB host controller or hub; it is conne=
cted
> > through OF graph. At the same time, since it typically sits at the top
> > level of the device tree, a platform device is directly created and the
> > driver subsequently binds to that device. This is totally different fro=
m
> > how the hub and other directly connected onboard USB devices work. In
> > the onboard device case, the device node is a child node of the USB hub
> > or controller, and the corresponding platform device only gets created
> > when the USB hub driver probes, thereby sort of tying it into the USB
> > device topology.
>
> Hm, did we mess this up?  If so, we can always change it if you think
> this should be done differently.
>
> Hubs should be dealing with the power issues for their ports, so maybe
> rethinking this might be wise.  I'm just loath to add hardware-specific
> hacks to the hub common code for obvious reasons.  Anything we can do to
> pull it out to a separate driver is best so it doesn't affect the 99% of
> the users that don't have that crazy hardware :)

I understand. The way I have it in this series is that besides having
the port powered up initially, usb_hub_set_port_power() port power
control also extends to the pwrseq target for the M.2 slot or USB A
connector, just like if VBUS was controlled by the hub itself.

M.2 slots might be somewhat rarer, but I think many embedded devices
have USB A ports with VBUS that are controlled via GPIO, not wired
to the USB hub's (if any) port VBUS control pin. This is also present
on Chromebooks.

I think wiring up pwrseq to the USB port and using it for VBUS control
on these USB A ports is an improvement over the recent addition of USB
A connectors to the onboard device driver, which just turns on VBUS.
It would make the power cycle loop in hub_port_connect() actually work
on these devices.

Is it code for stuff outside of the hub itself? Yes. Is it crazy hardware?
Maybe not.


Thanks
ChenYu
