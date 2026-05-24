Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE52BB1D
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779610000; cv=pass; b=XAv8NN8GQKGw/JYVPqxsDGfhXZq8YLUWl4pcZ9ipMjLhQCxBp2eswU+Lpep5WTtdYW9/qQjBgomiX9tp4sFGs0hnl5BPgDD6nFeUBCyqDq9mWzr6mf/x+HhG+BxqxC6RwVM+Cmz+cF0vXOJFf989P4Ntuj0po9X0kOlg49hOW34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779610000; c=relaxed/simple;
	bh=4WMpRmGDV6X/z1OH5zMJ111/X3tKN2AtCzBErEW3G/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDKMV6TnqjDz6E2UzpHxr5185kQLQYJkS8dNzbhLcOC4czvnuEqXojkfOINvENcF8fxoyZ3STzMbY+1IMWTqX+HvwoImlfL0wp7LfJ0vj1nikjDzt5OQbXTOzaR87uBcpbxTP0FX2DlywL+IBS9GiayszpF94/pxK77Zd5dVYls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HCF50kvM; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HCF50kvM"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa2691db86so7297751e87.3
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 01:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779609997; cv=none;
        d=google.com; s=arc-20240605;
        b=D47grwnXXHRLlPgBEmZl5eHobfI0pNMaUh56srgoi+M8qTAEWVSuyaovsgoXuTFaAR
         ocvxB2X+NO9unvHd3gIYOy+pCHZFiWwvQfSDljV3rpoBFh3sHdNM8KIaLF3OXOyqNKus
         6Uy/3cGju/gm2XoRgyagaNkwj5U8ZTGWJR36HBOXQDgCVLOLeTRMCZd0MaTI0WKOektw
         ES91X+kAxaQL82RTTt24tWlmBa7ssYbeYBh8tohZ593wuCAuR6eWjdRRm7cibL8SyRiY
         kcY3kT3AG8jDP8xsCJAZ5FbdZ8+gbnbPUvfYmQ1vSGF+zKqm7FBO0bhU+Im/V6LOQcqU
         ibMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WMpRmGDV6X/z1OH5zMJ111/X3tKN2AtCzBErEW3G/E=;
        fh=bp91f4IZpP1hm9WWPpHrgG3wvMY5ZW6otaFWrDpkBwA=;
        b=DalVcYm9vxGaFXkRFIs4SWgyeV4FACH7GgFlSibxLu9Yqdh+I7w550oqsmszZ3IucI
         QmI1vZDmtzyidnUi/CgQGL6VGNjSO63lQfkPXyQWztmbVp/zKFxPb9QK5mT0h30E1KQk
         hhkoY9vzJMt07ElO9W7vS5KIa01eGxU63s1XnT22sW0GpSdM8CGopcTl5p8LRnsh60nW
         OpYVsTqYY3Wj19ikiKbCGzjpp5lE6Rf+evDRXhPP8uNAUIHD9hmOM6SjRzPtnga8UfOP
         7+CnaXnsC4wUhrgN1A8XmLRteT+HYUJX6P4i+mtTBVRlP+j0Bi0eyiB0HlTOzSznL/0z
         yY9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779609997; x=1780214797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WMpRmGDV6X/z1OH5zMJ111/X3tKN2AtCzBErEW3G/E=;
        b=HCF50kvMwRvyV6XJTP+4HauBdJ+E3X9+mYqzAHDfbAVErJ0oknBtGt2eG9+goD9yJo
         3QOD0ZMjWkrylDZztf34rcgw76ey5KQqYQcq9l14e70LLH1fpEz/3gj8lcYbe4wymUo4
         8IiucWp7tXP28mCk+v49wdgh+yz/BFHIN6wIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779609997; x=1780214797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WMpRmGDV6X/z1OH5zMJ111/X3tKN2AtCzBErEW3G/E=;
        b=LKei/ho931WZeNfFJmKKYwsgvZq+iBrNsEWk/Omww3MsXOYIc3TRgPKQtxVtGCiZs0
         z87SQlx0yXVPlaoNpbD4JJ7xHUMw/MCsnoFwflQBGi99aBxUnQ5X4MC5Pq7v56aX4rrh
         luL+J9vh3L2PRZVucuHqS7jpLmXBtmuW+Ag8nTfnPwTOCKYH2ScQLtc8W2fLP2HGCj+m
         kBprwFlV+2301oAc9bZ7XEsx5FQOcGi60R6T7Hh33WBU2MQ/WXs0A4VFNTEaG43aB+y0
         0jTPrA0BNsAsCrXkVZ+pLpqAwpDdkrcmJ7wbsXtp+xxPkXrl3Wq2Zn8GNFPcP5L52ozD
         TE4g==
X-Forwarded-Encrypted: i=1; AFNElJ9bGKYHSGOvLpO2vbTGtLb7IlHjDHXed/tSzWjpziqkWqTY0hk8Eck/fPA03U9l+HSbNgSJsMk5Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuthNLfLsYsiXnAfNDQVw7/c3D+shN+rBuFoxKm2x8VdEBkC0
	vVL3iTnBwv8Pxsr+8VRvSxVaW71Ma+jvt7sKqjvzN/NF5VV8LYSsG+TrP+0hIMrstrlssnIa4Ih
	R20GyAElkEol9NFUnVkuzFKrRh0SXIMAXgR6wJBZ6
X-Gm-Gg: Acq92OFuHOjy15wD1PPYDleovzML8T+m6x5uDw8A6f5r8YndNHfvWZkpJJU+gXcD0FQ
	zRPEE2C6iK8T75VtN5G4/Sj8lVBmd6ZPbcschC11F7PcqrAglvP1XqAF7dfnPn+RiM71WrDXKU1
	07uxG/dqbxC1YBfqpuTOQyz/bGYtgFVcCK30TOdNYjP6Nv1vLcWrmdZkZZuHqsfE2hr3+0Z7Rqz
	VuC2fsFpZwHmXxA5OvhofvpwRxDIj0YPmHT8i36sBZMFctoRjgx5NzNhTuQRLeAsb7EEMXoYeun
	Ybo/QTlkm6r3ICwJ
X-Received: by 2002:a05:6512:1548:b0:5a4:52e:5933 with SMTP id
 2adb3069b0e04-5aa3235c913mr2060405e87.5.1779609997332; Sun, 24 May 2026
 01:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515090149.3169406-1-wenst@chromium.org> <CAMRc=MdnjRRMVzxPkkrPhQ4dz7rsK8-HKUp9cQ0z11apL3escQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdnjRRMVzxPkkrPhQ4dz7rsK8-HKUp9cQ0z11apL3escQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Sun, 24 May 2026 11:06:26 +0300
X-Gm-Features: AVHnY4KQQKvEna3YmFG3JiRUMuMCSWWGPOX7GZHTMr-aA0Q2R8PaQnONHyygdDE
Message-ID: <CAGXv+5HC3dqgcE3KnKzakHHWFHB6m_X42orOkNUvZvp=SL_O8g@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 7:01=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Fri, May 15, 2026 at 11:02=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org=
> wrote:
> >
> > Hi everyone,
> >
> > This series is my attempt at enabling power sequencing for USB to suppo=
rt
> > the USB connection on M.2 E-key slots. M.2 E-key was enabled in v7.1-rc=
1
> > with just PCIe and UART supported [1].
> >
> > Most of the series is based on next-20260508, while the DT changes also
> > depend on some other DT cleanup patches I sent [2][3].
> >
> >
> > Patch 1 reworks the power sequencing framework to allow matching agains=
t
> > different USB ports. The consumer API gains an "index" parameter (which
> > is the USB port number on the hub), while the provider API is reworked
> > to pass the index to the matching function of the providing driver.
> >
>
> Sigh... I would really prefer to avoid going in this direction. IMO
> it's not very clear what this index actually refers to in generic
> terms, given that pwrseq is flexible on purpose and there's no
> specific, well-defined DT property which could have an "index".
>
> > Patch 2 implements the index matching in the pcie-m2 driver. Matching
> > only happens when a valid (>=3D 0) index is given.
> >
> > Patch 3 reworks the power sequencing targets for the E-key connector in
> > the pcie-m2 driver to add targets for USB and SDIO. The former is used
> > later on in this series.
> >
> > Patch 4 reworks the USB hub driver to return the actual error code from
> > hub_configure() in hub_probe(). This is needed in the next patch to
> > correctly return -EPROBE_DEFER.
> >
> > Patch 5 lets the USB hub driver look for power sequencers for each port=
.
> > Currently this only works for M.2 E-key connections, but it could be
> > extended to cover other cases. It should also make port reset via turni=
ng
> > off the port VBUS work, even when VBUS is not directly controlled by th=
e
> > hub.
> >
> > I expect some discussion on this patch, because a) it adds some
> > OF-specific code into an otherwise generic (core) driver, and
> > b) it doesn't yet handle USB 2.0 / 3.x shared ports; it ends up powerin=
g
> > on the port twice, which negates the port reset part.
> >
>
> I understand that you do this because the port device has no OF node
> assigned. If we wanted to call pwrseq_get() for the port device, is
> there really no other way to associate it with the correct pwrseq
> provider?

I suppose we could tie the "port@X" node to the usb port device, but
AFAIK no other subsystem does this so we would be introducing a new
pattern.

In the M.2 pwrseq driver, we would have to match by port node instead
of its parent device node. We may end up with different behavior for
the USB target vs the other targets.

Also, the "port@X" nodes only exist for the OF graph connections to
connectors and/or muxes (this series doesn't deal with the latter).
For directly connected devices, there is a "device@X" child node
directly under the USB hub node. That node is what gets tied to the
the USB device.

> Does the child index in hub_configure() relate to the port index as
> defined by the unit address of the port DT node? I'm talking about the
> X in port@X?

Yes. The downstream port numbers start at 1. I believe 0 corresponds
to the upstream port.

> > Patch 6 reverts an incorrectly modeled OF graph connection for the
> > MediaTek XHCI controller.
> >
> > Patch 7 then adds a proper representation.
> >
> > Patches 8 through 12 enable the M.2 E-key slots (used for WiFi/BT) and
> > USB type-A connectors found on MediaTek-based Chromebooks. These are
> > provided in this series for reference. The USB type-A connector changes=
,
> > while not directly related, have overlapping context, and was easier to
> > include. They were also used to test some extra local changes I tried
> > to convert the USB A connector from an onboard USB device to a power
> > sequencing provider.
> >
> >
> > As this series changes existing power sequencing API, and also uses the
> > changed API in subsequent patches, I think the best way to merge this
> > is for Bartosz to take the power sequencing patches and provide an
> > immutable tag for Greg to merge and then merge the USB patches.
> >
> > The DT patches can go through the soc tree once all the driver and DT
> > binding changes are merged.
> >
> >
> > Thanks
> > ChenYu
> >
> > P.S. I'll be at Embedded Recipes if anyone wants to discuss details.
> >
>
> I'll be there too! Or should i say "here"? I live here after all. :) Let'=
s talk!

Sure!


Thanks
ChenYu
