Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF9380FC2
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957229; cv=none; b=jOU1ZbrlGjFPDkbczPtfh6m2u4rCJAX+SB3521ZjInY7cPhIg/yFe+wJgGKYh8NJpLjTDWrNSu3vkus/yWXD+t/Zqm6GUJcmaeXOxjOSogDj/vqbLDUAoPLTMgnizfGJJw9Ltz8JaDfKYtI5VgQaLymm1Tg5sqg0DIlbHC38Wko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957229; c=relaxed/simple;
	bh=3UE1ukep6rVlGvZk5YzSNt1eDdxkKrWNxxGuKxbk0mA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enCUm6Wxgg+7ksZOmi7JnWTgX+yIu/YQ73vKUkyWv3jaAVeq8PV5tF8eedvCaD2jrI4+G5Xms4vBzyV6qHrwkk+YEJg0ciTqma1ew6sG+EHfy2OOgSp1RFBHJrYlper35iwStqtKoCtE8DS+74VLnHo8y2lIBfhSkEHYIzgrMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTt3A5I5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTt3A5I5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54F21F00ACF
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 08:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779957227;
	bh=3UE1ukep6rVlGvZk5YzSNt1eDdxkKrWNxxGuKxbk0mA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=BTt3A5I5n0ay2ZpJFPy9zqNZYf0SojnpzrK4eah8mJc1JrtcSKBdyXfYnZKqB7v+1
	 cJLNn4UDEiXORzdYWVSkX4eeLYPzPhaNMqjEvax1BVzK7L1cz0DqXz/UOa8EV+Z6rN
	 yTdE4+WdcYo+gaOQOmxVVacAmQ5q9Gp+5uix2RG02SVi7+pp6OgsiNhZA1+rK74r33
	 JTqMlW5PU0iF2M+895YI9bhzwpqDxkIHY+ZUpczOuSVAnAER159bipf1NKIRzHLe0y
	 fdJJU2LIm6esC8gOEkfQ5MEqX3JovcoLJRyklBoj+9Gg3BWdgsJaGszzzrB4YZ2s97
	 5Ha7lPil6GKPw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39378db197aso125536871fa.3
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 01:33:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/TBzZo9TfRSvJ30NbqrMGWUdXvtvqVoMj1N4uIMqH0h4GM5AucFVqA2FECblAcPtYBSXVKXM3beA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxreNy2nTKlfJfzuFYhPPmwI/E3uMc9NhITQbYiMYdMvAoWzV9+
	I/xG8zOVosODpshBk6LAm87juFqLAx6tVR6mBJahBF8w18+3+9mqzgwLTW3OjGhtmo6K+dc8VSr
	lZCMaeh9Hh4EcAHJKmcXVmdnaIWmpQQ4an0e+9zxrsQ==
X-Received: by 2002:a2e:8957:0:b0:38d:e220:8dc2 with SMTP id
 38308e7fff4ca-395d8cef4abmr68081351fa.20.1779957226354; Thu, 28 May 2026
 01:33:46 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 04:33:44 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 04:33:44 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAGXv+5GbW0bx3nKdZt2+tHuHyQ-J-1-Z79nMzHAwjmEPGKT02A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515090149.3169406-1-wenst@chromium.org> <CAMRc=MdnjRRMVzxPkkrPhQ4dz7rsK8-HKUp9cQ0z11apL3escQ@mail.gmail.com>
 <CAGXv+5HC3dqgcE3KnKzakHHWFHB6m_X42orOkNUvZvp=SL_O8g@mail.gmail.com>
 <CAMRc=Med-_0GSYzoFBRiwFzBCK0DZqJD8_SEBxi+zwR20GS-HA@mail.gmail.com> <CAGXv+5GbW0bx3nKdZt2+tHuHyQ-J-1-Z79nMzHAwjmEPGKT02A@mail.gmail.com>
Date: Thu, 28 May 2026 04:33:44 -0400
X-Gmail-Original-Message-ID: <CAMRc=McADm0F4bwhj5qoigfUT-AV6CVpo+FAaqoBnZ3PrjBc7Q@mail.gmail.com>
X-Gm-Features: AVHnY4JaLBmctUhYgIAJpJojKGEMDv_BBPh6vAfJvyQAFJsp1fEnomeZ5fRkbMM
Message-ID: <CAMRc=McADm0F4bwhj5qoigfUT-AV6CVpo+FAaqoBnZ3PrjBc7Q@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 18:21:00 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> On Tue, May 26, 2026 at 11:48=E2=80=AFAM Bartosz Golaszewski <brgl@kernel=
.org> wrote:
>>
>> On Sun, May 24, 2026 at 10:06=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
>> >
>> > > >
>> > > > I expect some discussion on this patch, because a) it adds some
>> > > > OF-specific code into an otherwise generic (core) driver, and
>> > > > b) it doesn't yet handle USB 2.0 / 3.x shared ports; it ends up po=
wering
>> > > > on the port twice, which negates the port reset part.
>> > > >
>> > >
>> > > I understand that you do this because the port device has no OF node
>> > > assigned. If we wanted to call pwrseq_get() for the port device, is
>> > > there really no other way to associate it with the correct pwrseq
>> > > provider?
>> >
>> > I suppose we could tie the "port@X" node to the usb port device, but
>> > AFAIK no other subsystem does this so we would be introducing a new
>> > pattern.
>> >
>> > In the M.2 pwrseq driver, we would have to match by port node instead
>> > of its parent device node. We may end up with different behavior for
>> > the USB target vs the other targets.
>> >
>>
>> I imagine, we can check the bus type of the parent device to know if
>> this is USB?
>
> The "bus type" type is probably not exported. However since the DT bindin=
g
> explicitly says which port on the M.2 slot is for which connection type,
> I think the matching can do a special case check for the USB port.
> The next obstacle is that the target string is not given to the provider
> match function.
>
>> > Also, the "port@X" nodes only exist for the OF graph connections to
>> > connectors and/or muxes (this series doesn't deal with the latter).
>> > For directly connected devices, there is a "device@X" child node
>> > directly under the USB hub node. That node is what gets tied to the
>> > the USB device.
>> >
>>
>> Is this a problem? I don't think I understand what you're saying here.
>
> It shouldn't be. I'm just saying there would be different behavior on
> the USB side for connectors vs onboard devices (like hubs) device nodes.
>
> I talked to Greg earlier, and he said not to touch the hub driver; the
> hub driver should only deal with features from the USB spec. The
> "onboard USB devices" driver is what should be used. And this would
> be a proper case of adding an auxiliary device to the M.2 slot driver.
>

The onboard USB device is what initially inspired the PCI pwrctl code so it
doesn't surprise me we circle back to it.

> However this seems to completely decouple the power sequencing from the
> USB core. Take the USB A connector for example, it was recently added to
> the onboard USB devices driver. However the connector has a device node
> that is not a child node of any USB host controller or hub; it is connect=
ed
> through OF graph. At the same time, since it typically sits at the top
> level of the device tree, a platform device is directly created and the
> driver subsequently binds to that device. This is totally different from
> how the hub and other directly connected onboard USB devices work. In
> the onboard device case, the device node is a child node of the USB hub
> or controller, and the corresponding platform device only gets created
> when the USB hub driver probes, thereby sort of tying it into the USB
> device topology.
>

Which is precisely what we do for PCI pwrctl. Though I'm not sure how we co=
uld
replicate this behavior without touching the hub driver.

> If the power sequencing ends up not connected to the USB subsystem, then
> maybe the M.2 slot driver could just check if the USB port (port@3) was
> used, and just enable the USB / BT pwrseq target at probe time? That
> would mean less changes needed.
>

That sounds sane to me.

Bartosz
