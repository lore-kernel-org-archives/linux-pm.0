Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA63EBF2D
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898877; cv=pass; b=nVJJOdf6WPu92q+6nQnaCJ6FvUfQDHgPb99mofbfZs/2wDomM8qTmFYTEyduoDC07NXRHJ0UERvKJb8gHMMZcacxdGC2vCWNfu9EOluQuIZFg+2YFTzrRdDT6xSzKqbt/KmftEAeUyHpIOBL/fUUBhpt2GdFyGgr9IAuLjKCxFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898877; c=relaxed/simple;
	bh=3dxrqcdNnKYVhdfP7nh0R/VHpio1dU95MRkKy/vXfjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIkj7rh55lPT4+B0lLWZClJmlaibiw++uCqca0/VjaystU62fOEHXkTNMZPzIJ+TSM40oszEqXxc2lVPoOODIugmx8Dbtgo+ihChwB+/ENANcjKTA/KwKpQ5lZuPPL1uF9IhaNNXd0Kd/YUVIUGO+/vV47nG73A0/a+wS5fCQxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MtsCw/0k; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MtsCw/0k"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38be5e86918so10582171fa.3
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 09:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779898874; cv=none;
        d=google.com; s=arc-20240605;
        b=IoS8Czuv5O0P8Aj0xKn2g0OZaF7i5JQYVqXoCBQskxznAmMojiz1eF9F5I4Jb7i9dr
         YkzL9YNLBHh0oT5U+O03z4CmFVoZKeTK7qdDgNXG3N8Q7K1/Bnr3cahfv/eJMmeN/pNg
         y6pPDAlLFCmri7Ul5l/H+PjbiAm11CyuHsOzrRLkpzIvKFz+GAky/z8YDWF+Ex4HJJ4S
         8RtEscbRKgmBdG2FDpwU2oG5RP9R86fcR2UCP3qHSH+cM1AT8WB16RCQ7ndCrRS1tEZz
         geJ+7FplVCBrxCAgnhRFydmIKabIv6Wp+gIBE36omsLxD2Tq6vHykOelOaAva/BMTCNl
         iWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3dxrqcdNnKYVhdfP7nh0R/VHpio1dU95MRkKy/vXfjQ=;
        fh=OI2UJ0eqMzTe/Q3X3FDgudha5U/YmZ3JvMY9jDlhCc8=;
        b=ekbp23wZB2OEJdoChrl46+OdPbpeXA6M/Y9Fl7YI2oZ7Hiwg5ybDiIoYrXWrb1U35k
         Ii8s1tF9CnWMWFaUgwtv6r4ghrdbTdTT5DDu2q08l3iPw2PJkyMzRF+bMSRAjBhdtJyV
         SGU8aaOpN85Rnwk3X2mf9yqUKlwxal/bwhRhIcjyxpsv3SbnsgvuodLieQ+4qSZGRS//
         W+okzJJf+dWWKyqxRspQ0FPKbfSaUVzXXIbDxSJm43yBvLmPL7PiQiBq7wqQFmJ9uhfH
         Ii0raqk/D4TEKNi72T44hka60aj3JLxydj5IpZOKM8K/6O1sGH/k3cJh6k6zhKV5d7BN
         VD+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779898874; x=1780503674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dxrqcdNnKYVhdfP7nh0R/VHpio1dU95MRkKy/vXfjQ=;
        b=MtsCw/0k4OTSh4B9Pxdh8daiLEm1A4poAtaF365+vNmdjmNuioPQE6g8HcgmwrknBF
         f1Q3Jm83/Zr6u9mhgKmWMxNGSPRXmiv1g6vEKggOtJJgd2yttYR/1v+gVAIoNokSeBof
         G5Lj2vyr9uNlDENkRHcJphLP7MfjDoFs3NgvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898874; x=1780503674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dxrqcdNnKYVhdfP7nh0R/VHpio1dU95MRkKy/vXfjQ=;
        b=RUOGVd8Quq/X4nXAOXGm2e+2P6n3MfjAhCQSO52avjILMLmPd1nAclD1/peX92flzQ
         gV0qNkKb8WmrJVNsoddveOPBa6H/E5QngEW6sWAmFTNwBhIX9CFVhNgP7KhXMmVKDc7A
         ASj1HB9dpoahPy3b++I6gMQUfwyVKCvUMwFnsjTlUIPyOknjW5v+A/kHaSDKw1Cr34eX
         7j8fYfO8aXmr2dqAD+TZ2iFg6J01rYN//b4Xxii1YDKlQi0bFwjbfderfUaBEXuMi/zF
         yUIrMIGe/vRhGxZ3CZ8ePhV87IUHD35/HuR1GOF1nN58AaaGYdU0psgCsWMLs2Os5g7E
         5Hqw==
X-Forwarded-Encrypted: i=1; AFNElJ+pNU2hN7eau8VdA9Nx62lNkSd7xwX24GwSPVmUQ0lOYlMJYn4Rsp/IWXYi9Qox7fBipqWWec+ELA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzewaJ0rPLCoesuvh4TM0+me8M0QEuBoA0J9xcznjVJfNSWwCXQ
	FuAnTQKAZe8gwLU+W/niYsUM+Blv2pu1t/8t8GWB+cgaZjrRoC6jeF4yf7VkFqLjRm6IHePZZtf
	k63MSs8gHsIDfOQKsVAs+QjAPgctLw4jmfq1EHdpC
X-Gm-Gg: Acq92OEaHeZZDs/dirVsQehCRl5vFYFO1QQOhSMz16AS3/puGKM2wC/4sgb7EAGbcHT
	5YgrVmQz1HfyazFtZQjC/3LI2yk1//0CMhy+l5giFjUWFvfyQ90++Qd/dISrwVPdRwVVD0rgZnj
	ijoCymPUxVd01aq28o2iXUPHJ+LviNyJ6VQG2q825/9txKI+8sk+BFm4AaBL/6EYYUDxomoq1JP
	A/RIcH5s+AzPQPDe83dRcZy/vlMsWsEck/QwyDhVMbTj77QJksVdzQt3VcmAjHYHHhYqCTsuXi+
	bIMny27OCvJHubszFw==
X-Received: by 2002:a05:6512:2204:b0:5aa:b6a:9257 with SMTP id
 2adb3069b0e04-5aa32393ff6mr7614476e87.44.1779898874134; Wed, 27 May 2026
 09:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515090149.3169406-1-wenst@chromium.org> <CAMRc=MdnjRRMVzxPkkrPhQ4dz7rsK8-HKUp9cQ0z11apL3escQ@mail.gmail.com>
 <CAGXv+5HC3dqgcE3KnKzakHHWFHB6m_X42orOkNUvZvp=SL_O8g@mail.gmail.com> <CAMRc=Med-_0GSYzoFBRiwFzBCK0DZqJD8_SEBxi+zwR20GS-HA@mail.gmail.com>
In-Reply-To: <CAMRc=Med-_0GSYzoFBRiwFzBCK0DZqJD8_SEBxi+zwR20GS-HA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 27 May 2026 18:21:00 +0200
X-Gm-Features: AVHnY4LzsI5n_9iqirzC_of7SGIfiJw_kQ6vIsCvh5Qe5puVB03Deb7QvAn9uiw
Message-ID: <CAGXv+5GbW0bx3nKdZt2+tHuHyQ-J-1-Z79nMzHAwjmEPGKT02A@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 11:48=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Sun, May 24, 2026 at 10:06=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org=
> wrote:
> >
> > > >
> > > > I expect some discussion on this patch, because a) it adds some
> > > > OF-specific code into an otherwise generic (core) driver, and
> > > > b) it doesn't yet handle USB 2.0 / 3.x shared ports; it ends up pow=
ering
> > > > on the port twice, which negates the port reset part.
> > > >
> > >
> > > I understand that you do this because the port device has no OF node
> > > assigned. If we wanted to call pwrseq_get() for the port device, is
> > > there really no other way to associate it with the correct pwrseq
> > > provider?
> >
> > I suppose we could tie the "port@X" node to the usb port device, but
> > AFAIK no other subsystem does this so we would be introducing a new
> > pattern.
> >
> > In the M.2 pwrseq driver, we would have to match by port node instead
> > of its parent device node. We may end up with different behavior for
> > the USB target vs the other targets.
> >
>
> I imagine, we can check the bus type of the parent device to know if
> this is USB?

The "bus type" type is probably not exported. However since the DT binding
explicitly says which port on the M.2 slot is for which connection type,
I think the matching can do a special case check for the USB port.
The next obstacle is that the target string is not given to the provider
match function.

> > Also, the "port@X" nodes only exist for the OF graph connections to
> > connectors and/or muxes (this series doesn't deal with the latter).
> > For directly connected devices, there is a "device@X" child node
> > directly under the USB hub node. That node is what gets tied to the
> > the USB device.
> >
>
> Is this a problem? I don't think I understand what you're saying here.

It shouldn't be. I'm just saying there would be different behavior on
the USB side for connectors vs onboard devices (like hubs) device nodes.

I talked to Greg earlier, and he said not to touch the hub driver; the
hub driver should only deal with features from the USB spec. The
"onboard USB devices" driver is what should be used. And this would
be a proper case of adding an auxiliary device to the M.2 slot driver.

However this seems to completely decouple the power sequencing from the
USB core. Take the USB A connector for example, it was recently added to
the onboard USB devices driver. However the connector has a device node
that is not a child node of any USB host controller or hub; it is connected
through OF graph. At the same time, since it typically sits at the top
level of the device tree, a platform device is directly created and the
driver subsequently binds to that device. This is totally different from
how the hub and other directly connected onboard USB devices work. In
the onboard device case, the device node is a child node of the USB hub
or controller, and the corresponding platform device only gets created
when the USB hub driver probes, thereby sort of tying it into the USB
device topology.

If the power sequencing ends up not connected to the USB subsystem, then
maybe the M.2 slot driver could just check if the USB port (port@3) was
used, and just enable the USB / BT pwrseq target at probe time? That
would mean less changes needed.


Thanks
ChenYu
